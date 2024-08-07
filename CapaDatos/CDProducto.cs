using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Security.Principal;

namespace CapaDatos
{
    public class CDProducto
    {
        public List<Producto> Listar()
        {
            List<Producto> lista = new List<Producto>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    StringBuilder query = new StringBuilder();
                    query.AppendLine("select p.IdProducto, p.Nombre, p.Descripcion,");
                    query.AppendLine("m.IdMarca, m.Descripcion[DesMarca],");
                    query.AppendLine("c.IdCategoria, c.Descripcion[DesCate],");
                    query.AppendLine("p.Precio, p.Stock,p.RutaImagen,p.NombreImagen, p.Activo");
                    query.AppendLine("from Producto p");
                    query.AppendLine("inner join MARCA m on m.IdMarca = p.IdMarca");
                    query.AppendLine("inner join CATEGORIA c on c.IdCategoria = p.IdCategoria");

                    SqlCommand cmd = new SqlCommand(query.ToString(), conexionn)
                    {
                        CommandType = CommandType.Text
                    };

                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lista.Add(
                                new Producto
                                {
                                    IdProducto = Convert.ToInt32(reader["IdProducto"]),
                                    Nombre = reader["Nombre"].ToString(),
                                    Descripcion = reader["Descripcion"].ToString(),
                                    marca = new Marca() { IdMarca = Convert.ToInt32(reader["IdMarca"]), Descripcion = reader["DesMarca"].ToString() },
                                    categoria = new Categoria() { IdCategoria = Convert.ToInt32(reader["IdCategoria"]), Descripcion = reader["DesCate"].ToString() },
                                    Precio = Convert.ToDecimal(reader["Precio"], new CultureInfo("es-DO")),
                                    Stock = Convert.ToInt32(reader["Stock"]),
                                    RutaImagen = reader["RutaImagen"].ToString(),
                                    NombreImagen = reader["NombreImagen"].ToString(),
                                    Activo = Convert.ToBoolean(reader["Activo"])
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<Producto>();
                Console.WriteLine(ex);
            }

            return lista;
        }

        public int Registrar(Producto obj, out string Mensaje)
        {
            int IdIdentity = 0;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarProducto", conexionn);
                    cmd.Parameters.AddWithValue("Nombre", obj.Nombre);
                    cmd.Parameters.AddWithValue("Descripcion", obj.Descripcion);
                    cmd.Parameters.AddWithValue("IdMarca", obj.marca.IdMarca);
                    cmd.Parameters.AddWithValue("IdCategoria", obj.categoria.IdCategoria);
                    cmd.Parameters.AddWithValue("Precio", obj.Precio);
                    cmd.Parameters.AddWithValue("Stock", obj.Stock);
                    cmd.Parameters.AddWithValue("Activo", obj.Activo);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 600).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    conexionn.Open();
                    cmd.ExecuteNonQuery();

                    IdIdentity = Convert.ToInt32(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                IdIdentity = 0;
                Mensaje = ex.Message;
            }
            return IdIdentity;
        }

        public bool Editar(Producto obj, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EditarProducto", conexionn);
                    cmd.Parameters.AddWithValue("IdProducto", obj.IdProducto);
                    cmd.Parameters.AddWithValue("Nombre", obj.Nombre);
                    cmd.Parameters.AddWithValue("Descripcion", obj.Descripcion);
                    cmd.Parameters.AddWithValue("IdMarca", obj.marca.IdMarca);
                    cmd.Parameters.AddWithValue("IdCategoria", obj.categoria.IdCategoria);
                    cmd.Parameters.AddWithValue("Precio", obj.Precio);
                    cmd.Parameters.AddWithValue("Stock", obj.Stock);
                    cmd.Parameters.AddWithValue("Activo", obj.Activo);
                    cmd.Parameters.Add("Resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 600).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    conexionn.Open();
                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;
            }
            return resultado;
        }

        public bool Eliminar(int id, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EliminarProducto", conexionn);
                    cmd.Parameters.AddWithValue("IdProducto", id);
                    cmd.Parameters.Add("Resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 600).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    conexionn.Open();
                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;
            }
            return resultado;
        }

        public bool GuardarInfoImg(Producto obj, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "update Producto set RutaImagen = @RutaImagen, NombreImagen = @NombreImagen where IdProducto = @IdProducto";

                    SqlCommand cmd = new SqlCommand(query, conexionn);
                    cmd.Parameters.AddWithValue("@RutaImagen", obj.RutaImagen);
                    cmd.Parameters.AddWithValue("@NombreImagen", obj.NombreImagen);
                    cmd.Parameters.AddWithValue("@IdProducto", obj.IdProducto);
                    cmd.Parameters.Add("Resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 600).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.Text;

                    conexionn.Open();
                    if (cmd.ExecuteNonQuery() > 0)
                    {
                        resultado = true;
                    }
                    else
                    {
                        Mensaje = "No se pudo cargar la imagen";
                    }

                }
            }
            catch (Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;
            }
            return resultado;
        }
    }
}
