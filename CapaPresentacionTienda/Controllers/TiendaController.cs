using CapaEntidad;
using CapaEntidad.Paypal;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;
using CapaPresentacionTienda.Filter;

namespace CapaPresentacionTienda.Controllers
{
    public class TiendaController : Controller
    {
        // GET: Tienda
        public ActionResult Index()
        {
            return View();
        }

        #region Producto mostrado de forma individual
        public ActionResult DetalleProducto(int idProducto = 0)
        {
            Producto producto = new Producto();
            bool conversion;

            producto = new CNProducto().Listar().Where(p => p.IdProducto == idProducto).FirstOrDefault();

            if (producto != null)
            {
                producto.Base64 = CNRecursos.ConversionBase64(Path.Combine(producto.RutaImagen, producto.NombreImagen), out conversion);
                producto.Extension = Path.GetExtension(producto.NombreImagen);
            }

            return View(producto);
        }
        #endregion

        #region Listar

        [HttpGet]
        public JsonResult ListarCategorias()
        {
            List<Categoria> lista = new List<Categoria>();
            lista = new CNCategorias().Listar();

            return Json(new { data = lista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ListarMarcaxCategoria(int idCategoria)
        {
            List<Marca> lista = new List<Marca>();
            lista = new CNMarca().ListarMarcaxCategoria(idCategoria);

            return Json(new { data = lista }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult ListarProducto(int idCategoria, int idMarca, int page = 1, int pageSize = 15)
        {
            bool conversion;

            var productos = new CNProducto().Listar()
                .Where(p =>
                    p.categoria.IdCategoria == (idCategoria == 0 ? p.categoria.IdCategoria : idCategoria) &&
                    p.marca.IdMarca == (idMarca == 0 ? p.marca.IdMarca : idMarca) &&
                    p.Stock > 0 && p.Activo == true
                )
                .Select(p => new
                {
                    IdProducto = p.IdProducto,
                    Nombre = p.Nombre,
                    Descripcion = p.Descripcion,
                    Marca = p.marca,
                    Categoria = p.categoria,
                    Precio = p.Precio,
                    Stock = p.Stock,
                    RutaImagen = p.RutaImagen,
                    Base64 = CNRecursos.ConversionBase64(Path.Combine(p.RutaImagen, p.NombreImagen), out conversion),
                    Extension = Path.GetExtension(p.NombreImagen),
                    Activo = p.Activo
                })
                .ToList();

            int totalItems = productos.Count();
            var productosPaginados = productos.Skip((page - 1) * pageSize).Take(pageSize).ToList();

            var result = new
            {
                data = productosPaginados,
                page = page,
                pageSize = pageSize,
                totalPages = (int)Math.Ceiling((double)totalItems / pageSize),
                totalItems = totalItems
            };

            return Json(result, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Sobre el carrito

        [HttpPost]
        public JsonResult AgregarCarrito(int idProducto)
        {
            int idCliente = ((Cliente)Session["Cliente"]).IdCliente;
            bool existe = new CNCarrito().ExisteCarrito(idCliente, idProducto);
            bool respuesta = false;
            string mensaje = string.Empty;

            if (existe)
            {
                mensaje = "El producto ya esta en el carrito";
            }
            else
            {
                respuesta = new CNCarrito().OperacionCarrito(idCliente, idProducto, true, out mensaje);
            }

            return Json(new { respuesta = respuesta, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult CantidadEnCarrito()
        {
            int idCliente = ((Cliente)Session["Cliente"]).IdCliente;
            int cantidad = new CNCarrito().CantidadEnCarrito(idCliente);

            return Json(new { cantidad = cantidad }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ListarProductoCarrito()
        {
            if (Session["Cliente"] == null)
            {
                return Json(new { redirectToUrl = Url.Action("Index", "Tienda") });
            }
            int idCliente = ((Cliente)Session["Cliente"]).IdCliente;


            List<Carrito> carrito = new List<Carrito>();
            bool conversion;

            carrito = new CNCarrito().ListarProducto(idCliente).Select(c => new Carrito()
            {
                producto = new Producto()
                {
                    IdProducto = c.producto.IdProducto,
                    Nombre = c.producto.Nombre,
                    marca = c.producto.marca,
                    Precio = c.producto.Precio,
                    RutaImagen = c.producto.RutaImagen,
                    Base64 = CNRecursos.ConversionBase64(Path.Combine(c.producto.RutaImagen, c.producto.NombreImagen), out conversion),
                    Extension = Path.GetExtension(c.producto.NombreImagen)
                },
                Cantidad = c.Cantidad
            }).ToList();

            return Json(new { data = carrito }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult OperacionCarrito(int idProducto, bool sumar)
        {
            int idCliente = ((Cliente)Session["Cliente"]).IdCliente;
            bool respuesta = false;
            string mensaje = string.Empty;

            respuesta = new CNCarrito().OperacionCarrito(idCliente, idProducto, sumar, out mensaje);

            return Json(new { respuesta = respuesta, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EliminarCarrito(int idProducto)
        {
            int idCliente = ((Cliente)Session["Cliente"]).IdCliente;
            bool respuesta = false;
            string mensaje = string.Empty;

            respuesta = new CNCarrito().EliminarCarrito(idCliente, idProducto);

            return Json(new { respuesta = respuesta, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [ValidarSession]
        [Authorize]
        public ActionResult Carrito()
        {
            if(Session["Cliente"] == null)
            {
                return RedirectToAction("Index");
            }
            return View();
        }

        #endregion

        #region Manejo de pagos Paypal

        [HttpPost]
        public async Task<JsonResult> ProcesarPago(List<Carrito> listaCarrito, Venta venta)
        {
            decimal total = 0;
            DataTable detalleVenta = new DataTable();
            detalleVenta.Locale = new CultureInfo("es-DO");
            detalleVenta.Columns.Add("IdProducto", typeof(string));//posible int
            detalleVenta.Columns.Add("Cantidad", typeof(int));
            detalleVenta.Columns.Add("Total", typeof(decimal));

            List<Item> listaItem = new List<Item>();

            foreach(Carrito carrito in listaCarrito)
            {
                decimal subtotal = Convert.ToDecimal(carrito.Cantidad.ToString()) * carrito.producto.Precio;
                total += subtotal;

                listaItem.Add(new Item()
                {
                    name = carrito.producto.Nombre,
                    quantity = carrito.Cantidad.ToString(),
                    unit_amount = new UnitAmount()
                    {
                        currency_code = "USD",
                        value = carrito.producto.Precio.ToString("G", new CultureInfo("es-DO"))
                    }
                });
                detalleVenta.Rows.Add(new object[]
                {
                    carrito.producto.IdProducto,
                    carrito.Cantidad,
                    subtotal
                });
            }

            PurchaseUnit purchaseUnit = new PurchaseUnit()
            {
                amount = new Amount()
                {
                    currency_code ="USD",
                    value = total.ToString("G", new CultureInfo("es-DO")),
                    breakdown = new Breakdown()
                    {
                        item_total = new ItemTotal()
                        {
                            currency_code = "USD",
                            value = total.ToString("G", new CultureInfo("es-DO"))
                        }
                    }
                },
                description = "Compra de articulos de Bonfire & Undead Trading",
                items = listaItem
            };

            Checkout_Order checkout_Order = new Checkout_Order()
            {
                intent = "CAPTURE",
                purchase_units = new List<PurchaseUnit> { purchaseUnit },
                application_context = new ApplicationContext()
                {
                    brand_name = "BonfireAndUndeadTrading.com",
                    landing_page = "NO_PREFERENCE",
                    user_action = "PAY_NOW",
                    return_url = "https://localhost:44331/Tienda/PagoRealizado",
                    cancel_url = "https://localhost:44331/Tienda/Carrito"
                }
            };


            venta.MontoTotal = total;
            venta.IdCliente = ((Cliente)Session["Cliente"]).IdCliente;
            TempData["Venta"] = venta;
            TempData["DetalleVenta"] = detalleVenta;

            CNPayPal payPal = new CNPayPal();
            Response_Paypal<Response_Checkout> response_Paypal = new Response_Paypal<Response_Checkout>();
            response_Paypal = await payPal.CrearSolicitud(checkout_Order);

            return Json(response_Paypal, JsonRequestBehavior.AllowGet);
        }

        [ValidarSession]
        [Authorize]
        public async Task<ActionResult> PagoRealizado()
        {
            if (Session["Cliente"] == null)
            {
                return Json(new { redirectToUrl = Url.Action("Index", "Tienda") });
            }
            string token = Request.QueryString["token"];

            CNPayPal payPal = new CNPayPal();
            Response_Paypal<Response_Capture> responsePaypal = new Response_Paypal<Response_Capture>();

            responsePaypal = await payPal.AprobarPago(token);

            ViewData["Status"] = responsePaypal.Status;

            if (responsePaypal.Status)
            {
                Venta venta = (Venta)TempData["Venta"];
                DataTable detalle_venta = (DataTable)TempData["DetalleVenta"];

                venta.IdTransaccion = responsePaypal.Response.purchase_units[0].payments.captures[0].id;
                string mensaje = string.Empty;
                bool respuesta = new CNVenta().Registrar(venta, detalle_venta, out mensaje);

                ViewData["IdTransaccion"] = venta.IdTransaccion;

            }
            return View();
        }

        #endregion

        #region compras del cliente

        [ValidarSession]
        [Authorize]
        public ActionResult MisCompras()
        {
            if (Session["Cliente"] == null)
            {
                return Json(new { redirectToUrl = Url.Action("Index", "Tienda") });
            }
            int idCliente = ((Cliente)Session["Cliente"]).IdCliente;


            List<DetalleVenta> listaCompras = new List<DetalleVenta>();
            bool conversion;

            listaCompras = new CNVenta().ListarCompras(idCliente).Select(c => new DetalleVenta()
            {
                producto = new Producto()
                {
                    Nombre = c.producto.Nombre,
                    Precio = c.producto.Precio,
                    Base64 = CNRecursos.ConversionBase64(Path.Combine(c.producto.RutaImagen, c.producto.NombreImagen), out conversion),
                    Extension = Path.GetExtension(c.producto.NombreImagen)
                },
                Cantidad = c.Cantidad,
                Total = c.Total,
                IdTransaccion = c.IdTransaccion
            }).ToList();

            return View(listaCompras);
        }
        #endregion

        #region Ubicacion

        [HttpPost]
        public JsonResult ObtenerProvincia()
        {
            List<Provincia> provincias = new List<Provincia>();
            provincias = new CNUbicacion().ObtenerProvincia();

            return Json(new { lista = provincias }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerMunicipio(string idProvincia)
        {
            List<Municipio> municipio = new List<Municipio>();
            municipio = new CNUbicacion().ObtenerMunicipio(idProvincia);

            return Json(new { lista = municipio }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerDistrito(string idProvincia, string idMunicipio)
        {
            List<Distrito> distrito = new List<Distrito>();
            distrito = new CNUbicacion().ObtenerDistrito(idProvincia, idMunicipio);

            return Json(new { lista = distrito }, JsonRequestBehavior.AllowGet);
        }

        #endregion
    }
}