using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CapaNegocio;
using System.Web.Security;

namespace CapaPresentacionAdmin.Controllers
{
    public class AccesoController : Controller
    {
        // GET: Acceso
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CambiarClave()
        {
            return View();
        }

        public ActionResult Restablecer()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(string correo, string contra)
        {
            Usuario user = new Usuario();
            user = new CNUsuarios().Listar().Where(u => u.Correo == correo && u.Clave == CNRecursos.ConvertirSHA256(contra)).FirstOrDefault();

            if (user == null)
            {
                ViewBag.Error = "Correo y/o contraseña incorrecta";
                return View();
            }
            else
            {
                if (user.Restablecer)
                {
                    Session["IdUsuario"] = user.IdUsuario;
                    return RedirectToAction("CambiarClave");
                }

                Session["Correo"] = user.Correo;
                Session["Usuario"] = user.Nombre;

                FormsAuthentication.SetAuthCookie(user.Correo, false);

                ViewBag.Error = null;
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost]
        public ActionResult CambiarClave(string idUsuario, string contraActual, string nuevaContra, string confirmarContra)
        {
            Usuario user = new Usuario();
            user = new CNUsuarios().Listar().Where(u => u.IdUsuario == int.Parse(idUsuario)).FirstOrDefault();

            if (user.Clave != CNRecursos.ConvertirSHA256(contraActual))
            {
                Session["IdUsuario"] = idUsuario;
                ViewData["vClave"] = "";

                ViewBag.Error = "La contraseña actual no es correcta";
                return View();
            }
            else if(nuevaContra != confirmarContra)
            {
                Session["IdUsuario"] = idUsuario;
                ViewData["vClave"] = contraActual;

                ViewBag.Error = "Las contraseñas no coinciden. Por favor, asegúrate de que ambas contraseñas sean iguales.";
                return View();
            }
            else if (contraActual == confirmarContra)
            {
                Session["IdUsuario"] = idUsuario;
                ViewData["vClave"] = contraActual;

                ViewBag.Error = "La nueva contraseña no puede ser la misma que la actual.";
                return View();
            }
            else if (nuevaContra == "")
            {
                Session["IdUsuario"] = idUsuario;
                ViewData["vClave"] = contraActual;

                ViewBag.Error = "La nueva contraseña no puede estar vacia.";
                return View();
            }
            ViewData["vClave"] = "";

            nuevaContra = CNRecursos.ConvertirSHA256(nuevaContra);

            string mensaje = string.Empty;
            bool respuesta = new CNUsuarios().CambiarContra(int.Parse(idUsuario), nuevaContra, out mensaje);

            if (respuesta)
            {
                return RedirectToAction("Index");
            }
            else
            {
                Session["IdUsuario"] = idUsuario;
                ViewBag.Error = mensaje;

                return View();
            }
        }

        [HttpPost]
        public ActionResult Restablecer(string correo)
        {
            Usuario user = new Usuario();
            user = new CNUsuarios().Listar().Where(c => c.Correo == correo).FirstOrDefault();

            if (user == null)
            {
                ViewBag.Error = "No se encontró un usuario con este correo electrónico.";
                return View();
            }

            string mensaje = string.Empty;
            bool respuesta = new CNUsuarios().RestablecerContra(user.IdUsuario, correo, out mensaje);

            if(respuesta)
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

        public ActionResult CerrarSesion()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Acceso");
        }
    }
}