using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace E_Food.Models.ViewModels
{
    public class ViewTipoAB
    {
        [Display(Name ="ID Tipo AB")]
        public int idTipoAB { get; set; }
        [Required]
        [StringLength(25)]
        [Display(Name ="Nombre")]
        public string Nombre { get; set; } 
  
    }
}