using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace E_Food.Models
{
    public class Conexion
    {
        private static SqlConnection con;
        public Conexion()
        {
            string constr = ConfigurationManager.ConnectionStrings["E-FoodDB"].ToString();
            try
            {
                con = new SqlConnection(constr);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }
        public static SqlConnection getConnection()
        {
            if(con == null)
            {
                new Conexion();
            }
            return con;
        }
    }
}