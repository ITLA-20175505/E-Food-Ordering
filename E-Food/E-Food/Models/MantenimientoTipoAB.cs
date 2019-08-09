using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
namespace E_Food.Models
{
    public class MantenimientoTipoAB
    {
        private SqlCommand cmd;
        public int crearTipoAB(TipoAB tipoAB)
        {
            cmd = new SqlCommand("CrearTipoAB", Conexion.getConnection());
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Add(new SqlParameter("@Nombre", tipoAB.nombre));
            int i = cmd.ExecuteNonQuery();
            return i;
        }
    }
}