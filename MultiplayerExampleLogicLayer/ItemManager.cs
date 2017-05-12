using MultiplayerExampleAccess;
using MultiplayerExampleDataObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MultiplayerExampleLogicLayer
{
    public class ItemManager
    {

        public static List<ItemType> RetrieveItemTypes()
        {
            return ItemAccessor.SearchForItemTypes();
        }
        public static List<ItemList> RetrieveItemList()
        {
            return ItemAccessor.SearchForItemList();
        }

        public static int CreateItemList(ItemList itemList)
        {
            return ItemAccessor.CreateItemList(itemList);
        }
    }
}
