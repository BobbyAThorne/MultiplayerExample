using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MultiplayerExampleDataObjects
{
    public class User : Player
    {
        public List<Role> Roles { get; set; }
    }
}
