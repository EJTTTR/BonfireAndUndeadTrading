using CapaEntidad;
using CapaNegocio;
using CapaPresentacionTienda.Filter;
using Stripe;
using Stripe.Forwarding;
using System.Collections.Generic;
using System.Data;
using System;
using System.Globalization;
using System.Security.Policy;
using System.Threading.Tasks;
using System.Web.Mvc;

public class PagosController : Controller
{
    public ActionResult Index()
    {
        if (Session["Cliente"] == null)
        {
            return Json(new { redirectToUrl = Url.Action("Index", "Tienda") });
        }

        ViewBag.StripePublishableKey = System.Configuration.ConfigurationManager.AppSettings["StripePublishableKey"];
        return View();
    }

    [HttpPost]
    public async Task<JsonResult> ProcesarPago(List<Carrito> listaCarrito, Venta venta)
    {
        decimal total = 0;
        DataTable detalleVenta = new DataTable();
        detalleVenta.Locale = new CultureInfo("es-DO");
        detalleVenta.Columns.Add("IdProducto", typeof(string));
        detalleVenta.Columns.Add("Cantidad", typeof(int));
        detalleVenta.Columns.Add("Total", typeof(decimal));

        foreach (Carrito carrito in listaCarrito)
        {
            decimal subtotal = Convert.ToDecimal(carrito.Cantidad.ToString()) * carrito.producto.Precio;
            total += subtotal;

            detalleVenta.Rows.Add(new object[]
            {
            carrito.producto.IdProducto,
            carrito.Cantidad,
            subtotal
            });
        }

        venta.MontoTotal = total;
        venta.IdCliente = ((Cliente)Session["Cliente"]).IdCliente;
        TempData["Correo"] = ((Cliente)Session["Cliente"]).Correo;
        TempData["Total"] = venta.MontoTotal;
        TempData["Venta"] = venta;
        TempData["DetalleVenta"] = detalleVenta;

        var stripeSecretKey = System.Configuration.ConfigurationManager.AppSettings["StripeSecretKey"];
        StripeConfiguration.ApiKey = stripeSecretKey;

        var options = new PaymentIntentCreateOptions
        {
            // Stripe maneja los montos en centavos
            Amount = (long)(total * 100),
            Currency = "usd",
            PaymentMethodTypes = new List<string> { "card" },
            Description = "Compra de artículos de Bonfire & Undead Trading",
            ReceiptEmail = ((Cliente)Session["Cliente"]).Correo,
            Metadata = new Dictionary<string, string>
        {
            { "VentaId", venta.IdVenta.ToString() }
        }
        };

        var service = new PaymentIntentService();
        var paymentIntent = await service.CreateAsync(options);

        return Json(new { clientSecret = paymentIntent.ClientSecret, total, email = ((Cliente)Session["Cliente"]).Correo }, JsonRequestBehavior.AllowGet);
    }


    [ValidarSession]
    [Authorize]
    public ActionResult PagoRealizado()
    {
        if (Session["Cliente"] == null)
        {
            return Json(new { redirectToUrl = Url.Action("Index", "Tienda") });
        }

        Venta venta = (Venta)TempData["Venta"];
        DataTable detalleVenta = (DataTable)TempData["DetalleVenta"];

        string paymentIntentId = Request.QueryString["payment_intent"];

        var stripeSecretKey = System.Configuration.ConfigurationManager.AppSettings["StripeSecretKey"];
        StripeConfiguration.ApiKey = stripeSecretKey;

        var service = new PaymentIntentService();
        var paymentIntent = service.Get(paymentIntentId);

        if (paymentIntent.Status == "succeeded")
        {
            venta.IdTransaccion = paymentIntent.Id;
            string mensaje = string.Empty;
            bool respuesta = new CNVenta().Registrar(venta, detalleVenta, out mensaje);

            ViewData["IdTransaccion"] = venta.IdTransaccion;
            ViewData["Status"] = true;
        }
        else
        {
            ViewData["Status"] = false;
        }

        return View();
    }

}
