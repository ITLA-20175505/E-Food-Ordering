using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
namespace E_Food.Models.ViewModels
{
    public class ViewDetalleOrden
    {
        public ViewDetalleOrden()
        {

        }
        public ViewDetalleOrden(int idorden, Servicio servicio, int cantidad)
        {
            this.orden = orden;
            this.servicio = servicio;
            this.Cantidad = cantidad;
        }
        [Required]
        [Display(Name = "Orden")]
        public ViewOrden orden { get; set; }
        [Required]
        [Display(Name ="Servicio")]
        public Servicio servicio { get; set; }
        [Required]
        [Display(Name ="Cantidad")]
        public int Cantidad { get; set; }
    }
}