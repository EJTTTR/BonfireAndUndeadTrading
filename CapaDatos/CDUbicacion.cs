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
    public class CDUbicacion
    {
        public List<Provincia> ObtenerProvincia()
        {
            List<Provincia> lista = new List<Provincia>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "select * from PROVINCIA";

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
                                new Provincia
                                {
                                    IdProvincia = reader["IdProvincia"].ToString(),
                                    Descripcion = reader["Descripcion"].ToString()
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<Provincia>();
                Console.WriteLine(ex);
            }

            return lista;
        }

        public List<Municipio> ObtenerMunicipio(string idProvincia)
        {
            List<Municipio> lista = new List<Municipio>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "select * from MUNICIPIO where IdProvincia = @IdProvincia";

                    SqlCommand cmd = new SqlCommand(query, conexionn);
                    cmd.Parameters.AddWithValue("@IdProvincia", idProvincia);
                    cmd.CommandType = CommandType.Text;


                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lista.Add(
                                new Municipio
                                {
                                    IdMunicipio = reader["IdMunicipio"].ToString(),
                                    Descripcion = reader["Descripcion"].ToString()
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<Municipio>();
                Console.WriteLine(ex);
            }

            return lista;
        }

        public List<Distrito> ObtenerDistrito(string idProvincia, string idMunicipio)
        {
            List<Distrito> lista = new List<Distrito>();

            try
            {
                using (SqlConnection conexionn = new SqlConnection(Conexion.cn))
                {
                    string query = "select * from DISTRITO where IdProvincia = @IdProvincia and IdMunicipio = @IdMunicipio";

                    SqlCommand cmd = new SqlCommand(query, conexionn);
                    cmd.Parameters.AddWithValue("@IdProvincia", idProvincia);
                    cmd.Parameters.AddWithValue("@IdMunicipio", idMunicipio);
                    cmd.CommandType = CommandType.Text;


                    conexionn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lista.Add(
                                new Distrito
                                {
                                    IdDistrito = reader["IdDistrito"].ToString(),
                                    Descripcion = reader["Descripcion"].ToString()
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lista = new List<Distrito>();
                Console.WriteLine(ex);
            }

            return lista;
        }

    }
}
