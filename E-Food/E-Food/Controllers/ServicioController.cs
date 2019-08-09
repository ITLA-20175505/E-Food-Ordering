using E_Food.Models;
using E_Food.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace E_Food.Controllers
{
    public class ServicioController : Controller
    {
        // GET: Servicio
        private List<Servicio> listaServicio;
        private Servicio servicio;
        private EFood bd = new EFood();
        private void listadoFiltro(int idTipoAB)
        {
            listaServicio = new List<Servicio>();
            using (EFood bd = new EFood())
            {
                //Execute stored procedure as a function
                var result = bd.filtroServicioAB(idTipoAB).ToList<Servicio>();
                listaServicio = result;
            }
        }
            public ActionResult Entradas()
        {
            listadoFiltro(1);
                return View(listaServicio);
            }
        public ActionResult Bebidas()
        {

            listadoFiltro(1);
            return View(listaServicio);
        }
        public ActionResult PlatosFuerte()
        {
            listadoFiltro(1);
            return View(listaServicio);
        }
        public ActionResult Carnes()
        {
            listadoFiltro(1);
            return View(listaServicio);
        }
        public ActionResult Pastas()
        {
            listadoFiltro(1);
            return View(listaServicio);
        }
        public ActionResult Aves()
        {
            listadoFiltro(1);
            return View(listaServicio);
        }
        public ActionResult Mariscos()
        {
            listadoFiltro(1);
            return View(listaServicio);
        }
        public ActionResult Postres()
        {

            listadoFiltro(1);

            //Execute stored procedure as a function
            var result = bd.filtroServicioAB(2).ToList<Servicio>();
            listaServicio = result;


            return View(listaServicio);
        }
        public ActionResult Ensaladas()
        {
            listadoFiltro(1);
            return View(listaServicio);
        }
        // GET: Crear Nuevo Servicio
        public ActionResult CrearServicio()
        {

            return View();
        }
        //POSTEAR: Servicio/Create
        [HttpPost]
        public ActionResult CrearServicio(Servicio servicio)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    using (EFood bd = new EFood())
                    {
                        bd.Servicios.Add(servicio);
                        bd.SaveChanges();
                    }
                }
                return Redirect(Request.UrlReferrer.ToString());
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        [HttpGet]
        public ActionResult EliminarServicio(int idServicio)
        {

            using (EFood bd = new EFood())
            {
                /*  var result = bd.buscarServicio(idServicio);
                  servicio = new Servicio();
                  servicio = result.First();
      */
                var result = bd.Servicios.Find(idServicio);

                bd.Servicios.Remove(result);
                bd.SaveChanges();
            }
            return Redirect("~/ListaProductos/");
        }
    }

}
