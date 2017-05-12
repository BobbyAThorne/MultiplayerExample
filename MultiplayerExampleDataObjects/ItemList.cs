using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MultiplayerExampleDataObjects
{
    public class ItemList
    {
        public int ItemListID { get; set; }
        [StringLength(50),Required]
        public string ItemName { get; set; }
        [StringLength(150), Required]
        public string ItemDescription { get; set; }
        [Required]
        public int ItemTypeID { get; set; }
        [Required]
        public int Damage { get; set; }

        public string ItemTypeName { get; set; }

    }
}
