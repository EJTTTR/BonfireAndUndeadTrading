using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;

namespace CapaDatos
{
    public class CDCarrito
    {
        public bool ExisteCarrito(int idCliente, int idProducto)
        {
            bool resultado = true;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_ExisteCarrito", conexionn);
                    cmd.Parameters.AddWithValue("IdCliente", idCliente);
                    cmd.Parameters.AddWithValue("IdProducto", idProducto);
                    cmd.Parameters.Add("Resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    conexionn.Open();
                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                }
            }
            catch
            {
                resultado = false;
            }
            return resultado;
        }

        public bool OperacionCarrito(int idCliente, int idProducto, bool sumar, out string Mensaje)
        {
            bool resultado = true;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_OperacionCarrito", conexionn);
                    cmd.Parameters.AddWithValue("IdCliente", idCliente);
                    cmd.Parameters.AddWithValue("IdProducto", idProducto);
                    cmd.Parameters.AddWithValue("Sumar", sumar);
                    cmd.Parameters.Add("Resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
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
                
        public int CantidadEnCarrito(int idCliente)
        {
            int resultado = 0;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("select count(*) from CARRITO where IdCliente = @IdCliente", conexionn);
                    cmd.Parameters.AddWithValue ("@IdCliente", idCliente);
                    cmd.CommandType= CommandType.Text;

                    conexionn.Open();

                    resultado = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            catch
            {
                resultado = 0;
            }
            return resultado;
        }

        public List<Carrito> ListarProducto(int idCliente)
        {
            List<Carrito> lista = new List<Carrito>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "select * from fn_obtenerCarritoCliente(@IdCliente)";

                    SqlCommand cmd = new SqlCommand(query, conexionn);
                    cmd.Parameters.AddWithValue("@IdCliente", idCliente);
                    cmd.CommandType = CommandType.Text;

                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lista.Add(
                                new Carrito()
                                {
                                    producto = new Producto()
                                    {
                                        IdProducto = Convert.ToInt32(reader["IdProducto"]),
                                        Nombre = reader["Nombre"].ToString(),
                                        marca = new Marca() { Descripcion = reader["Desmarca"].ToString() },
                                        Precio = Convert.ToDecimal(reader["Precio"], new CultureInfo("es-DO")),
                                        RutaImagen = reader["RutaImagen"].ToString(),
                                        NombreImagen = reader["NombreImagen"].ToString()
                                    },
                                    Cantidad = Convert.ToInt32(reader["Cantidad"])
                                } 
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<Carrito>();
                Console.WriteLine(ex);
            }

            return lista;
        }

        public bool EliminarCarrito(int idCliente, int idProducto)
        {
            bool resultado = true;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EliminarCarrito", conexionn);
                    cmd.Parameters.AddWithValue("IdCliente", idCliente);
                    cmd.Parameters.AddWithValue("IdProducto", idProducto);
                    cmd.Parameters.Add("Resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    conexionn.Open();
                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                }
            }
            catch
            {
                resultado = false;
            }
            return resultado;
        }
    }
}
