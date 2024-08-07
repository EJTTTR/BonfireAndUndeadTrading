using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CNProducto
    {
        private CDProducto objCapaDato = new CDProducto();

        public List<Producto> Listar()
        {
            return objCapaDato.Listar();
        }

        public int Registrar(Producto obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.Nombre) || string.IsNullOrWhiteSpace(obj.Nombre))
            {
                Mensaje = "El nombre de una producto no puede estar vacio o ser un espacio en blanco";
            }
            else if (string.IsNullOrEmpty(obj.Descripcion) || string.IsNullOrWhiteSpace(obj.Descripcion))
            {
                Mensaje = "La descripcion de una producto no puede estar vacio o ser un espacio en blanco";
            }
            else if (obj.marca.IdMarca == 0)
            {
                Mensaje = "Se debe seleccionar una marca";
            }
            else if (obj.categoria.IdCategoria == 0)
            {
                Mensaje = "Se debe seleccionar una categoria";
            }
            else if (obj.Precio == 0)
            {
                Mensaje = "Se debe ingresar el precio del prodcuto";
            }
            else if (obj.Stock == 0)
            {
                Mensaje = "Se debe ingresar el stock del producto";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                return objCapaDato.Registrar(obj, out Mensaje);
            }
            else
            {
                return 0;
            }
        }

        public bool Editar(Producto obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.Nombre) || string.IsNullOrWhiteSpace(obj.Nombre))
            {
                Mensaje = "El nombre de una producto no puede estar vacio o ser un espacio en blanco";
            }
            else if (string.IsNullOrEmpty(obj.Descripcion) || string.IsNullOrWhiteSpace(obj.Descripcion))
            {
                Mensaje = "La descripcion de una producto no puede estar vacio o ser un espacio en blanco";
            }
            else if (obj.marca.IdMarca == 0)
            {
                Mensaje = "Se debe seleccionar una marca";
            }
            else if (obj.categoria.IdCategoria == 0)
            {
                Mensaje = "Se debe seleccionar una categoria";
            }
            else if (obj.Precio == 0)
            {
                Mensaje = "Se debe ingresar el precio del prodcuto";
            }
            else if (obj.Stock == 0)
            {
                Mensaje = "Se debe ingresar el stock del prodcuto";
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

        public bool GuardarInfoImg(Producto obj, out string Mensaje)
        {
            return objCapaDato.GuardarInfoImg(obj, out Mensaje);
        }
    }
}
