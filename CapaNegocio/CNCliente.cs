using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CNCliente
    {
        private CDCliente objCapaDato = new CDCliente();

        public int Registrar(Cliente obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.Nombre) || string.IsNullOrWhiteSpace(obj.Nombre))
            {
                Mensaje = "El nombre no puede estar vacio o ser un espacio en blanco";
            }
            else if (string.IsNullOrEmpty(obj.Apellido) || string.IsNullOrWhiteSpace(obj.Apellido))
            {
                Mensaje = "El Apellido no puede estar vacio o ser un espacio en blanco";
            }
            else if (string.IsNullOrEmpty(obj.Correo) || string.IsNullOrWhiteSpace(obj.Correo))
            {
                Mensaje = "El Correo no puede estar vacio o ser un espacio en blanco";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                string asunto = "Creación de cuenta en \"Bonfire & Undead Trading\"";
                string msg = "<h3><b>¡Su cuenta ha sido creada exitosamente!</b></h3><hr><p>Gracias por registrarse. Ahora puede iniciar sesión y disfrutar de todas nuestras funcionalidades.</p>";
                bool respuesta = CNRecursos.EnviarCorreo(obj.Correo, asunto, msg);

                if (respuesta)
                {
                    obj.Clave = CNRecursos.ConvertirSHA256(obj.Clave);
                    return objCapaDato.Registrar(obj, out Mensaje);
                }
                else
                {
                   Mensaje = "No se pudo enviar el correo. Por favor, verifique que la dirección de correo electrónico es correcta.";
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }

        public List<Cliente> Listar()
        {
            return objCapaDato.Listar();
        }

        public bool CambiarContra(int idCliente, string contra, out string Mensaje)
        {
            return objCapaDato.CambiarContra(idCliente, contra, out Mensaje);
        }

        public bool RestablecerContra(int idCliente, string correo, out string Mensaje)
        {
            Mensaje = string.Empty;
            string nuevaClave = CNRecursos.GenerarContrasena();
            bool resultado = objCapaDato.RestablecerContra(idCliente, CNRecursos.ConvertirSHA256(nuevaClave), out Mensaje);

            if (resultado)
            {
                string asunto = "Contraseña restablecida \"Bonfire & Undead Trading\"";
                string mensajeCorreo = "<h3>Su contraseña ha sido restablecida con exito!</h3> <hr> <p>Su nueva contraseña para acceder es: <b>!clave!</b></p>";
                mensajeCorreo = mensajeCorreo.Replace("!clave!", nuevaClave);

                bool respuesta = CNRecursos.EnviarCorreo(correo, asunto, mensajeCorreo);

                if (respuesta)
                {
                    return true;
                }
                else
                {
                    Mensaje = "No se pudo enviar el correo. Por favor, verifique que la dirección de correo electrónico es correcta.";
                    return false;
                }
            }
            else
            {
                Mensaje = "No se pudo restablecer la contraseña";
                return false;
            }
        }

    }
}
