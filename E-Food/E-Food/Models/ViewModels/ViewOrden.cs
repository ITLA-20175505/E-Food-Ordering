using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace E_Food.Models.ViewModels
{
    public class ViewOrden
    {
        [Display(Name = "ID Orden")]
        public int idOrden { get; set; }
        [Required]
        [Display(Name = "Mesa")]
        public Mesa mesa { get; set; }
        [Display(Name = "Descripcion")]
        public string descripcion { get; set; }
        [Required]
        [Display(Name = ("Fecha"))]
        [DataType(DataType.DateTime)]
        public DateTime fecha { get; set; }
    }
    
}