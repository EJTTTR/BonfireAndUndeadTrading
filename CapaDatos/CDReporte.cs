using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.Globalization;

namespace CapaDatos
{
    public class CDReporte
    {
        public Dashboard VerDashboard()
        {
            Dashboard obj = new Dashboard();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_ReporteDashboard", conexionn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };

                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            obj = new Dashboard()
                            {
                                TotalCliente = Convert.ToInt32(reader["TotalCliente"]),
                                TotalVenta = Convert.ToInt32(reader["TotalVenta"]),
                                TotalProducto = Convert.ToInt32(reader["TotalProducto"])
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                obj = new Dashboard();
                Console.WriteLine(ex);
            }

            return obj;
        }
        public List<Reporte> Ventas(string fechaInicio, string fechaFin, string idTransaccion)
        {
            List<Reporte> lista = new List<Reporte>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_ReporteVentas", conexionn);

                    cmd.Parameters.AddWithValue("fechaInicio", fechaInicio);
                    cmd.Parameters.AddWithValue("fechaFin", fechaFin);
                    cmd.Parameters.AddWithValue("idTransaccion", idTransaccion);
                    cmd.CommandType = CommandType.StoredProcedure;

                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lista.Add(
                                new Reporte()
                                {
                                    FechaVenta = reader["FechaVenta"].ToString(),
                                    Cliente = reader["Cliente"].ToString(),
                                    Producto = reader["Producto"].ToString(),
                                    Precio = Convert.ToDecimal(reader["Precio"], new CultureInfo("es-DO")),
                                    Cantidad = Convert.ToInt32(reader["Cantidad"].ToString()),
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
                lista = new List<Reporte>();
                Console.WriteLine(ex);
            }

            return lista;
        }
    }
}
