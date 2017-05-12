using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MultiplayerExampleDataObjects
{
    public class Server
    {
        public int ServerID { get; set; }
        public string UserName { get; set; }
        public int LocationX { get; set; }
        public int LocationY { get; set; }
        public int LocationZ { get; set; }
        public int Health { get; set; }
        public int Image { get; set; }
        public bool Active { get; set; }
        public int Size { get; set; }
        public int SizeMultiplier { get; set; }
        public int EquiptItem { get; set; }

        //public int EquiptItem { get; set; }

        //public int Size  { get; set; }
        //public int SizeMultiplier { get; set; }
    }
}
