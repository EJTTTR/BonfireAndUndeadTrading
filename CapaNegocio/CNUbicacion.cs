using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CNUbicacion
    {
        private CDUbicacion objCapadato = new CDUbicacion();

        public List<Provincia> ObtenerProvincia()
        {
            return objCapadato.ObtenerProvincia();
        }

        public List<Municipio> ObtenerMunicipio(string idProvincia)
        {
            return objCapadato.ObtenerMunicipio(idProvincia);
        }

        public List<Distrito> ObtenerDistrito(string idProvincia, string idMunicipio)
        {
            return objCapadato.ObtenerDistrito(idProvincia, idMunicipio);
        }
    }
}
