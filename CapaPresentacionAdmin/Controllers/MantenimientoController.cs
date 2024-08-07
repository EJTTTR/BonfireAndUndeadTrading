using CapaEntidad;
using CapaNegocio;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CapaPresentacionAdmin.Controllers
{
    [Authorize]

    public class MantenimientoController : Controller
    {
        public ActionResult Categorias()
        {
            return View();
        }

        public ActionResult Productos()
        {
            return View();
        }

        public ActionResult Marcas()
        {
            return View();
        }

        //---------*-*-*-*-Categorias-*-*-*-*-*-*---------\\
        #region Categorias

        [HttpGet]
        public JsonResult ListarCategorias()
        {
            List<Categoria> olista = new List<Categoria>();
            olista = new CNCategorias().Listar();

            return Json(new { data = olista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GuardarCategorias(Categoria obj)
        {
            object resultado;
            string mensaje = string.Empty;

            if (obj.IdCategoria == 0)
            {
                resultado = new CNCategorias().Registrar(obj, out mensaje);
            }
            else
            {
                resultado = new CNCategorias().Editar(obj, out mensaje);
            }
            return Json(new { resultado = resultado, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EliminarCategoria(int id)
        {
            bool resultado = false;
            string mensaje = string.Empty;

            resultado = new CNCategorias().Eliminar(id, out mensaje);

            return Json(new { resultado = resultado, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        #endregion
        //---------*-*-*-*-Marca-*-*-*-*-*-*---------\\
        #region Marca

        [HttpGet]
        public JsonResult ListarMarcas()
        {
            List<Marca> olista = new List<Marca>();
            olista = new CNMarca().Listar();

            return Json(new { data = olista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GuardarMarcas(Marca obj)
        {
            object resultado;
            string mensaje = string.Empty;

            if (obj.IdMarca == 0)
            {
                resultado = new CNMarca().Registrar(obj, out mensaje);
            }
            else
            {
                resultado = new CNMarca().Editar(obj, out mensaje);
            }
            return Json(new { resultado = resultado, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EliminarMarcas(int id)
        {
            bool resultado = false;
            string mensaje = string.Empty;

            resultado = new CNMarca().Eliminar(id, out mensaje);

            return Json(new { resultado = resultado, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }
        #endregion
        //---------*-*-*-*-Producto-*-*-*-*-*-*---------\\
        #region Producto
        [HttpGet]
        public JsonResult ListarProducto()
        {
            List<Producto> olista = new List<Producto>();
            olista = new CNProducto().Listar();

            return Json(new { data = olista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GuardarProducto(string obj, HttpPostedFileBase img)
        {
            string mensaje = string.Empty;
            bool exito = true;
            bool exitoImg = true;

            Producto productoss = new Producto();
            productoss = JsonConvert.DeserializeObject<Producto>(obj);

            decimal precio;
            if (decimal.TryParse(productoss.PrecioTexto, NumberStyles.AllowDecimalPoint, new CultureInfo("es-DO"), out precio))
            {
                productoss.Precio = precio;
            }
            else
            {
                return Json(new { exito = false, mensaje = "El formato del precio debe ser ##.##" }, JsonRequestBehavior.AllowGet);
            }

            if (productoss.IdProducto == 0)
            {
                int idProductoGen = new CNProducto().Registrar(productoss, out mensaje);
                if(idProductoGen != 0)
                {
                    productoss.IdProducto = idProductoGen;
                }else
                {
                    exito = false;
                }
            }
            else
            {
                exito = new CNProducto().Editar(productoss, out mensaje);
            }

            if (exito)
            {
                if(img != null)
                {
                    string rutaGuarda = ConfigurationManager.AppSettings["ServidorFotos"];
                    string extension = Path.GetExtension(img.FileName);
                    string nombreIMG = string.Concat(productoss.IdProducto.ToString(), extension);

                    try
                    {
                        img.SaveAs(Path.Combine(rutaGuarda, nombreIMG));
                    }
                    catch (Exception ex)
                    {
                        string msg = ex.Message;
                        exitoImg = false;
                    }

                    if (exitoImg)
                    {
                        productoss.RutaImagen = rutaGuarda;
                        productoss.NombreImagen = nombreIMG;
                        bool respuesta = new CNProducto().GuardarInfoImg(productoss, out mensaje);
                    }
                    else
                    {
                        mensaje = "Se guardo el producto, pero la imagen no se pudo guardar";
                    }
                }
            }

            return Json(new { exitos = exito, idGen = productoss.IdProducto, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult imgProducto(int id)
        {
            bool conversion;
            Producto producto = new CNProducto().Listar().Where(p => p.IdProducto == id).FirstOrDefault();

            string textBase64 = CNRecursos.ConversionBase64(Path.Combine(producto.RutaImagen, producto.NombreImagen), out conversion);

            return Json(new
            {
                conversion = conversion,
                textBase64 = textBase64,
                extension = Path.GetExtension(producto.NombreImagen)
            },  
             JsonRequestBehavior.AllowGet
            );
        }

        [HttpPost]
        public JsonResult EliminarProducto(int id)
        {
            bool resultado = false;
            string mensaje = string.Empty;

            // para obtener la img del producto cuando se borra borrar tambien la imagen
            Producto producto = new CNProducto().Listar().Where(p => p.IdProducto == id).FirstOrDefault();
            string rutaImagen = Path.Combine(producto.RutaImagen, producto.NombreImagen);
            if (System.IO.File.Exists(rutaImagen))
            {
                try
                {
                    System.IO.File.Delete(rutaImagen);
                }
                catch (Exception ex)
                {
                    mensaje = $"Error al borrar imagen: {ex.Message}";
                    return Json(new { resultado = false, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
                }
            }

            resultado = new CNProducto().Eliminar(id, out mensaje);

            return Json(new { resultado = resultado, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}