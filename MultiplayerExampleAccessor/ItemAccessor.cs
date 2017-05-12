using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MultiplayerExampleDataObjects;
using System.Data.SqlClient;
using System.Data;

namespace MultiplayerExampleAccess
{
    public class ItemAccessor
    {
        public static List<ItemType> SearchForItemTypes()
        {
            List<ItemType> items = new List<ItemType>();

            var conn = DBConnection.GetDBConnection();
            var cmdText = @"sp_retrieve_all_itemTypes";

            var cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = CommandType.StoredProcedure;


            try
            {
                conn.Open();
                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        reader.Read();
                        items.Add(new ItemType()
                        {
                            ItemTypeID = reader.GetInt32(0),
                            ItemTypeDescription = reader.GetString(1)

                        });
                    }
                }
                reader.Close();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                conn.Close();
            }
            return items;

        }

        public static int CreateItemList(ItemList itemList)
        {
            var count = 0;

            // need a connection
            var conn = DBConnection.GetDBConnection();

            // need command text
            var cmdText = @"sp_add_new_item";

            // we need a command object
            var cmd = new SqlCommand(cmdText, conn);

            //set command type
            cmd.CommandType = CommandType.StoredProcedure;

            // parameters?
            cmd.Parameters.Add("@ItemName", SqlDbType.VarChar, 50);
            cmd.Parameters.Add("@ItemDescription", SqlDbType.VarChar, 150);
            cmd.Parameters.Add("@ItemTypeID", SqlDbType.Int);
            cmd.Parameters.Add("@Damage", SqlDbType.Int);
           

            // parameter values?
            cmd.Parameters["@ItemName"].Value = itemList.ItemName;
            cmd.Parameters["@ItemDescription"].Value = itemList.ItemDescription;
            cmd.Parameters["@ItemTypeID"].Value = itemList.ItemTypeID;
            cmd.Parameters["@Damage"].Value = itemList.Damage;

            // try, catch, finally
            try
            {
                conn.Open();
                count = cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                conn.Close();
            }
            return count;
        }

        public static List<ItemList> SearchForItemList()
        {
            List<ItemList> items = new List<ItemList>();

            var conn = DBConnection.GetDBConnection();
            var cmdText = @"sp_retrieve_all_ItemList";
            var cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = CommandType.StoredProcedure;


            try
            {
                conn.Open();
                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        items.Add(new ItemList()
                        {
                            ItemListID = reader.GetInt32(0),
                            ItemName = reader.GetString(1),
                            ItemDescription = reader.GetString(2),
                            ItemTypeID = reader.GetInt32(3),
                            Damage = reader.GetInt32(4)

                        });
                    }
                    reader.Close();
                }
                
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                conn.Close();
            }
            return items;
        }
    }
}
