using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;
using CapaEntidad;
using CapaNegocio;
using ClosedXML.Excel;

namespace CapaPresentacionAdmin.Controllers
{
    [Authorize]

    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Usuarios()
        {
            return View();
        }

        [HttpGet]
        public JsonResult ListarUsuarios() 
        { 
            List<Usuario> olista = new List<Usuario>();
            olista = new CNUsuarios().Listar();

            return Json(new { data = olista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GuardarUsuarios(Usuario obj)
        {
            object resultado;
            string mensaje = string.Empty;

            if (obj.IdUsuario == 0)
            {
                resultado = new CNUsuarios().Registrar(obj, out mensaje);
            }
            else
            {
                resultado = new CNUsuarios().Editar(obj, out mensaje);
            }
            return Json(new { resultado = resultado, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EliminarUsuarios(int id)
        { 
            bool resultado = false;
            string mensaje = string.Empty;  

            resultado = new CNUsuarios().Eliminar(id, out mensaje);

            return Json(new { resultado = resultado, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult verDashBoard()
        {
            Dashboard obj = new CNReporte().VerDashboard();

            return Json(new { resultado = obj }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult ListaReporte(string fechaInicio, string fechaFin, string idTransaccion)
        {
            List<Reporte> reportes = new List<Reporte>();

            reportes = new CNReporte().Ventas(fechaInicio, fechaFin, idTransaccion);

            return Json(new { data = reportes }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public FileResult ExportarVenta(string fechaInicio, string fechaFin, string idTransaccion)
        {
            List<Reporte> rLista = new List<Reporte>();

            rLista = new CNReporte().Ventas(fechaInicio, fechaFin, idTransaccion);

            DataTable dt = new DataTable();
            dt.Locale = new System.Globalization.CultureInfo("es-DO");

            dt.Columns.Add("Fecha venta", typeof(string)); 
            dt.Columns.Add("Cliente", typeof(string));
            dt.Columns.Add("Producto", typeof(string));
            dt.Columns.Add("Precio", typeof(decimal));
            dt.Columns.Add("Cantidad", typeof(int));
            dt.Columns.Add("Total", typeof(decimal));
            dt.Columns.Add("Id Transaccion", typeof(string));

            foreach(Reporte rp in rLista)
            {
                dt.Rows.Add(new object[] {
                    rp.FechaVenta,
                    rp.Cliente,
                    rp.Producto,
                    rp.Precio,
                    rp.Cantidad,
                    rp.Total,
                    rp.IdTransaccion
                });
            }

            dt.TableName = "Datos";

            using (XLWorkbook wb = new XLWorkbook()){
                wb.Worksheets.Add(dt);
                
                using(MemoryStream ms = new MemoryStream())
                {
                    wb.SaveAs(ms);
                    return File(ms.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "ReporteVenta" + DateTime.Now.ToString() + ".xlsx");
                }
            }
        }
    }
}