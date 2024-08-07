using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CNUsuarios
    {
        private CDUsuarios objCapaDato = new CDUsuarios();

        public List<Usuario> Listar()
        {
            return objCapaDato.Listar();
        }

        public int Registrar(Usuario obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if(string.IsNullOrEmpty(obj.Nombre) || string.IsNullOrWhiteSpace(obj.Nombre))
            {
                Mensaje = "El nombre del usuario no puede estar vacio o ser un espacio en blanco";
            } else if (string.IsNullOrEmpty(obj.Apellido) || string.IsNullOrWhiteSpace(obj.Apellido))
            {
                Mensaje = "El Apellido del usuario no puede estar vacio o ser un espacio en blanco";
            } else if (string.IsNullOrEmpty(obj.Correo) || string.IsNullOrWhiteSpace(obj.Correo))
            {
                Mensaje = "El Correo del usuario no puede estar vacio o ser un espacio en blanco";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                string clave = CNRecursos.GenerarContrasena();
                string asunto = "Creación de cuenta para \"Bonfire & Undead Trading\"";
                string mensaje = "<h3>Su cuenta fue creada exitosamente!</h3> <hr> <p>Su Contraseña para acceder a ella es la siguiente: <b>!clave!</b></p>";
                mensaje = mensaje.Replace("!clave!", clave);

                bool respuesta = CNRecursos.EnviarCorreo(obj.Correo,  asunto,  mensaje);

                if (respuesta)
                {
                    obj.Clave = CNRecursos.ConvertirSHA256(clave);
                    return objCapaDato.Registrar(obj, out Mensaje);
                }
                else
                {
                    Mensaje = "No se pudo enviar el correo, revise que este escrito correctamente e intentelo de nuevo";
                    return 0;
                }

            }
            else
            {
                return 0;
            }
        }

        public bool Editar(Usuario obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.Nombre) || string.IsNullOrWhiteSpace(obj.Nombre))
            {
                Mensaje = "El nombre del usuario no puede estar vacio o ser un espacio en blanco";
            } else if (string.IsNullOrEmpty(obj.Apellido) || string.IsNullOrWhiteSpace(obj.Apellido))
            {
                Mensaje = "El Apellido del usuario no puede estar vacio o ser un espacio en blanco";
            } else if (string.IsNullOrEmpty(obj.Correo) || string.IsNullOrWhiteSpace(obj.Correo))
            {
                Mensaje = "El Correo del usuario no puede estar vacio o ser un espacio en blanco";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                return objCapaDato.Editar(obj, out Mensaje);
            }
            else
            {
                return false;
            }
        }

        public bool Eliminar(int id, out string Mensaje)
        {
            return objCapaDato.Eliminar(id, out Mensaje);
        }

        public bool CambiarContra(int idUsuario, string contra, out string Mensaje)
        {
            return objCapaDato.CambiarContra(idUsuario, contra, out Mensaje);
        }

        public bool RestablecerContra(int idUsuario, string correo, out string Mensaje)
        {
            Mensaje = string.Empty;
            string nuevaClave = CNRecursos.GenerarContrasena();
            bool resultado = objCapaDato.RestablecerContra(idUsuario, CNRecursos.ConvertirSHA256(nuevaClave), out Mensaje);

            if(resultado)
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
                    Mensaje = "No se pudo enviar el correo";
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
