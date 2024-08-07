using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CNReporte
    {
        private CDReporte objCapaDato = new CDReporte();

        public Dashboard VerDashboard()
        {
            return objCapaDato.VerDashboard();
        }

        public List<Reporte> Ventas(string fechaInicio, string fechaFin, string idTransaccion)
        {
            return objCapaDato.Ventas(fechaInicio, fechaFin, idTransaccion);
        }
    }
}
