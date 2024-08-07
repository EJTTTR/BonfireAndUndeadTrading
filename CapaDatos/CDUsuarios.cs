using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace CapaDatos
{
    public class CDUsuarios
    {
        public List<Usuario> Listar()
        {
            List<Usuario> lista = new List<Usuario>();

            try
            {
                using(SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "select IdUsuario,Nombre,Apellido,Correo,Clave,Restablecer,Activo from USUARIOS";

                    SqlCommand cmd = new SqlCommand(query, conexionn)
                    {
                        CommandType = CommandType.Text
                    };

                    conexionn.Open();

                    using(SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while(reader.Read())
                        {
                            lista.Add(
                                new Usuario
                                { 
                                    IdUsuario = Convert.ToInt32(reader["IdUsuario"]),
                                    Nombre = reader["Nombre"].ToString(),
                                    Apellido = reader["Apellido"].ToString(),
                                    Correo = reader["Correo"].ToString(),
                                    Clave = reader["Clave"].ToString(),
                                    Restablecer = Convert.ToBoolean(reader["Restablecer"]),
                                    Activo = Convert.ToBoolean(reader["Activo"])
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            { 
                lista = new List<Usuario>();
                Console.WriteLine(ex);
            }

            return lista;
        }

        public int Registrar(Usuario obj, out string Mensaje)
        {
            int IdIdentity = 0;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarUsuario", conexionn);
                    cmd.Parameters.AddWithValue("Nombre", obj.Nombre);
                    cmd.Parameters.AddWithValue("Apellido", obj.Apellido);
                    cmd.Parameters.AddWithValue("Correo", obj.Correo);
                    cmd.Parameters.AddWithValue("Clave", obj.Clave);
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

        public bool Editar(Usuario obj, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;
            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EditarUsuario", conexionn);
                    cmd.Parameters.AddWithValue("IdUsuario", obj.IdUsuario);
                    cmd.Parameters.AddWithValue("Nombre", obj.Nombre);
                    cmd.Parameters.AddWithValue("Apellido", obj.Apellido);
                    cmd.Parameters.AddWithValue("Correo", obj.Correo);
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
            Mensaje =string.Empty;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("delete top (1) from USUARIOS where IdUsuario = @Id", conexionn);
                    cmd.Parameters.AddWithValue ("@Id", id);
                    cmd.CommandType= CommandType.Text;

                    conexionn.Open();

                    resultado = cmd.ExecuteNonQuery() > 0 ? true: false;
                }
            }
            catch(Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;
            }
            return resultado;
        }

        public bool CambiarContra(int idUsuario, string nuevaContra, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("update USUARIOS set Clave = @nuevaContra, Restablecer = 0 where IdUsuario = @Id", conexionn);
                    cmd.Parameters.AddWithValue("@Id", idUsuario);
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

        public bool RestablecerContra(int idUsuario, string contra, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("update USUARIOS set Clave = @contra, Restablecer = 1 where IdUsuario = @Id", conexionn);
                    cmd.Parameters.AddWithValue("@Id", idUsuario);
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
