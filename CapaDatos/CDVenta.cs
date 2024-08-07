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
    public class CDVenta
    {
        public bool Registrar(Venta obj, DataTable DetalleVenta, out string Mensaje)
        {
            bool respuesta = false;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("usp_RegistrarVenta", conexionn);
                    cmd.Parameters.AddWithValue("IdCliente", obj.IdCliente);
                    cmd.Parameters.AddWithValue("TotalProducto", obj.TotalProducto);
                    cmd.Parameters.AddWithValue("MontoTotal", obj.MontoTotal);
                    cmd.Parameters.AddWithValue("Contacto", obj.Contacto);
                    cmd.Parameters.AddWithValue("IdDistrito", obj.IdDistrito);
                    cmd.Parameters.AddWithValue("Telefono", obj.Telefono);
                    cmd.Parameters.AddWithValue("Direccion", obj.Direccion);
                    cmd.Parameters.AddWithValue("IdTransaccion", obj.IdTransaccion);
                    cmd.Parameters.AddWithValue("@DetellaVenta", DetalleVenta);
                    cmd.Parameters.Add("Resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("Mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    conexionn.Open();
                    cmd.ExecuteNonQuery();

                    respuesta = Convert.ToBoolean(cmd.Parameters["Resultado"].Value);
                    Mensaje = cmd.Parameters["Mensaje"].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                respuesta = false;
                Mensaje = ex.Message;
            }
            return respuesta;
        }

        public List<DetalleVenta> ListarCompras(int idCliente)
        {
            List<DetalleVenta> lista = new List<DetalleVenta>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "select * from fn_ListarCompra(@IdCliente)";

                    SqlCommand cmd = new SqlCommand(query, conexionn);
                    cmd.Parameters.AddWithValue("@IdCliente", idCliente);
                    cmd.CommandType = CommandType.Text;

                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lista.Add(
                                new DetalleVenta()
                                {
                                    producto = new Producto()
                                    {
                                        Nombre = reader["Nombre"].ToString(),
                                        Precio = Convert.ToDecimal(reader["Precio"], new CultureInfo("es-DO")),
                                        RutaImagen = reader["RutaImagen"].ToString(),
                                        NombreImagen = reader["NombreImagen"].ToString()
                                    },
                                    Cantidad = Convert.ToInt32(reader["Cantidad"]),
                                    Total = Convert.ToDecimal(reader["Total"], new CultureInfo("es-DO")),
                                    IdTransaccion = reader["IdTransaccion"].ToString()
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<DetalleVenta>();
                Console.WriteLine(ex);
            }

            return lista;
        }

    }
}
