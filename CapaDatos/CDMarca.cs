using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using System.Text.RegularExpressions;

namespace CapaDatos
{
    public class CDMarca
    {
        public List<Marca> Listar()
        {
            List<Marca> lista = new List<Marca>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "select IdMarca, Descripcion, Activo from MARCA";

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
                                new Marca
                                {
                                    IdMarca = Convert.ToInt32(reader["IdMarca"]),
                                    Descripcion = reader["Descripcion"].ToString(),
                                    Activo = Convert.ToBoolean(reader["Activo"])
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<Marca>();
                Console.WriteLine(ex);
            }

            return lista;
        }

        public int Registrar(Marca obj, out string Mensaje)
        {
            int IdIdentity = 0;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarMarca", conexionn);
                    cmd.Parameters.AddWithValue("Descripcion", obj.Descripcion);
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

        public bool Editar(Marca obj, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EditarMarca", conexionn);
                    cmd.Parameters.AddWithValue("IdMarca", obj.IdMarca);
                    cmd.Parameters.AddWithValue("Descripcion", obj.Descripcion);
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
                    SqlCommand cmd = new SqlCommand("sp_EliminarMarca", conexionn);
                    cmd.Parameters.AddWithValue("IdMarca", id);
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

        public List<Marca> ListarMarcaxCategoria(int idCategoria)
        {
            List<Marca> lista = new List<Marca>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    StringBuilder query = new StringBuilder();
                    query.AppendLine("select distinct m.IdMarca, m.Descripcion from Producto p");
                    query.AppendLine("inner join CATEGORIA c on c.IdCategoria = p.IdCategoria");
                    query.AppendLine("inner join MARCA m on m.IdMarca = p.IdMarca and m.Activo = 1");
                    query.AppendLine("where c.IdCategoria = iif(@idCategoria = 0, c.IdCategoria, @idCategoria)");

                    SqlCommand cmd = new SqlCommand(query.ToString(), conexionn)
                    {
                        CommandType = CommandType.Text
                    };
                    cmd.Parameters.AddWithValue("@idCategoria", idCategoria);

                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lista.Add(
                                new Marca
                                {
                                    IdMarca = Convert.ToInt32(reader["IdMarca"]),
                                    Descripcion = reader["Descripcion"].ToString()
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<Marca>();
                Console.WriteLine(ex);
            }

            return lista;
        }
    }
}
