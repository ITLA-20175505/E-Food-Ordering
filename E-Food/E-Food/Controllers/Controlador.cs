using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Firebase.Database;
using Firebase.Database.Query;
using System.Threading.Tasks;

namespace E_Food.Controllers
{
    public class Controlador : Controller
    {
        // GET: Controlador
        public ActionResult Index()
        {
            return View();
        }


    }
}