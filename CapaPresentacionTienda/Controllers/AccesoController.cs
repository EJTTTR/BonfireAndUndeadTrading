using CapaEntidad;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace CapaPresentacionTienda.Controllers
{
    public class AccesoController : Controller
    {
        // GET: Acceso
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Registrar()
        {
            return View();
        }

        public ActionResult Restablecer()
        {
            return View();
        }

        public ActionResult CambiarContra()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Registrar(Cliente obj)
        {
            int resultado;
            string Mensaje = string.Empty;

            ViewData["Nombre"] = string.IsNullOrEmpty(obj.Nombre) ? "" : obj.Nombre;
            ViewData["Apellido"] = string.IsNullOrEmpty(obj.Apellido) ? "" : obj.Apellido;
            ViewData["Correo"] = string.IsNullOrEmpty(obj.Correo) ? "" : obj.Correo;

            if (obj.Clave != obj.ConfirmarClave)
            {
                ViewBag.Error = "Las contraseñas no coinciden. Por favor, asegúrate de que ambas contraseñas sean iguales.";
                return View();
            }

            resultado = new CNCliente().Registrar(obj, out Mensaje);

            if (resultado > 0)
            {
                ViewBag.Error = null;
                return RedirectToAction("Index", "Acceso");
            }
            else
            {
                ViewBag.Error = Mensaje;
                return View();
            }
        }

        [HttpPost]
        public ActionResult Index(string correo, string contra)
        {
            Cliente cli = null;
            cli = new CNCliente().Listar().Where(c => c.Correo == correo && c.Clave == CNRecursos.ConvertirSHA256(contra)).FirstOrDefault();
           
            if (cli == null)
            {
                ViewBag.Error = "Correo o contraseña son incorrectas";
                return View();
            }
            else
            {
                if (cli.Restablecer)
                {
                    Session["IdCliente"] = cli.IdCliente;
                    return RedirectToAction("CambiarContra");
                }
                else
                {
                    FormsAuthentication.SetAuthCookie(cli.Correo, false);
                    Session["Cliente"] = cli;

                    ViewBag.Error = null;
                    return RedirectToAction("Index", "Tienda");
                }
            }
        }

        [HttpPost]
        public ActionResult Restablecer(string correo)
        {
            Cliente cli = new Cliente();
            cli = new CNCliente().Listar().Where(c => c.Correo == correo).FirstOrDefault();

            if (cli == null)
            {
                ViewBag.Error = "No se encontró un cliente con este correo electrónico.";
                return View();
            }

            string mensaje = string.Empty;
            bool respuesta = new CNCliente().RestablecerContra(cli.IdCliente, correo, out mensaje);

            if (respuesta)
            {
                ViewBag.Error = null;
                return RedirectToAction("Index", "Acceso");
            }
            else
            {
                ViewBag.Error = mensaje;
                return View();
            }
        }

        [HttpPost]
        public ActionResult CambiarContra(string idCliente, string contraActual, string nuevaContra, string confirmarContra)
        {
            Cliente cli = new Cliente();
            cli = new CNCliente().Listar().Where(c => c.IdCliente == int.Parse(idCliente)).FirstOrDefault();

            if (cli.Clave != CNRecursos.ConvertirSHA256(contraActual))
            {
                Session["IdCliente"] = idCliente;
                ViewData["vClave"] = "";

                ViewBag.Error = "La contraseña actual no es correcta";
                return View();
            }
            else if (nuevaContra != confirmarContra)
            {
                Session["IdCliente"] = idCliente;
                ViewData["vClave"] = contraActual;

                ViewBag.Error = "Las contraseñas no coinciden. Por favor, asegúrate de que ambas contraseñas sean iguales.";
                return View();
            }
            else if (contraActual == confirmarContra)
            {
                Session["IdCliente"] = idCliente;
                ViewData["vClave"] = contraActual;

                ViewBag.Error = "La nueva contraseña no puede ser la misma que la actual.";
                return View();
            }
            else if (nuevaContra == "")
            {
                Session["IdCliente"] = idCliente;
                ViewData["vClave"] = contraActual;

                ViewBag.Error = "La nueva contraseña no puede estar vacia.";
                return View();
            }
            ViewData["vClave"] = "";

            nuevaContra = CNRecursos.ConvertirSHA256(nuevaContra);

            string mensaje = string.Empty;
            bool respuesta = new CNCliente().CambiarContra(int.Parse(idCliente), nuevaContra, out mensaje);

            if (respuesta)
            {
                return RedirectToAction("Index");
            }
            else
            {
                Session["IdCliente"] = idCliente;
                ViewBag.Error = mensaje;

                return View();
            }
        }

        public ActionResult CerrarSesion()
        {
            Session["Cliente"] = null;
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Acceso");
        }
    }
}