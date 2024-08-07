using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class CDCliente
    {
        public int Registrar(Cliente obj, out string Mensaje)
        {
            int IdIdentity = 0;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarCliente", conexionn);
                    cmd.Parameters.AddWithValue("Nombre", obj.Nombre);
                    cmd.Parameters.AddWithValue("Apellido", obj.Apellido);
                    cmd.Parameters.AddWithValue("Correo", obj.Correo);
                    cmd.Parameters.AddWithValue("Clave", obj.Clave);
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

        public List<Cliente> Listar()
        {
            List<Cliente> lista = new List<Cliente>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "select IdCliente,Nombre,Apellido,Correo,Clave,Restablecer from CLIENTE";

                    SqlCommand cmd = new SqlCommand(query, conexionn)
                    {
                        CommandType = CommandType.Text
                    };

                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lista.Add(
                                new Cliente
                                {
                                    IdCliente = Convert.ToInt32(reader["IdCliente"]),
                                    Nombre = reader["Nombre"].ToString(),
                                    Apellido = reader["Apellido"].ToString(),
                                    Correo = reader["Correo"].ToString(),
                                    Clave = reader["Clave"].ToString(),
                                    Restablecer = Convert.ToBoolean(reader["Restablecer"])
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<Cliente>();
                Console.WriteLine(ex);
            }

            return lista;
        }

        public bool CambiarContra(int idCliente, string nuevaContra, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("update CLIENTE set Clave = @nuevaContra, Restablecer = 0 where IdCliente = @Id", conexionn);
                    cmd.Parameters.AddWithValue("@Id", idCliente);
                    cmd.Parameters.AddWithValue("@nuevaContra", nuevaContra);
                    cmd.CommandType = CommandType.Text;

                    conexionn.Open();

                    resultado = cmd.ExecuteNonQuery() > 0 ? true : false;
                }
            }
            catch (Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;
            }
            return resultado;
        }

        public bool RestablecerContra(int idCliente, string contra, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("update CLIENTE set Clave = @contra, Restablecer = 1 where IdCliente = @Id", conexionn);
                    cmd.Parameters.AddWithValue("@Id", idCliente);
                    cmd.Parameters.AddWithValue("@contra", contra);
                    cmd.CommandType = CommandType.Text;

                    conexionn.Open();

                    resultado = cmd.ExecuteNonQuery() > 0 ? true : false;
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
