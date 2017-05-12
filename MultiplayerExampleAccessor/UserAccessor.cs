using MultiplayerExampleDataObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MultiplayerExampleAccess
{
    public class UserAccessor
    {
        public static int VerifyUsernameAndPassword(string username, string passwordHash)
        {
            var result = 0;

            // need a connection
            var conn = DBConnection.GetDBConnection();

            // need command text
            var cmdText = @"sp_authenticate_player";

            // we need a command object
            var cmd = new SqlCommand(cmdText, conn);

            // set the command type
            cmd.CommandType = CommandType.StoredProcedure;

            // parameters?
            cmd.Parameters.Add("@Username", SqlDbType.VarChar, 20);
            cmd.Parameters.Add("@PasswordHash", SqlDbType.VarChar, 100);

            // parameter values?
            cmd.Parameters["@Username"].Value = username;
            cmd.Parameters["@PasswordHash"].Value = passwordHash;

            // try, catch, finally
            try
            {
                conn.Open();
                result = (int)cmd.ExecuteScalar();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                conn.Close();
            }
            return result;
        }

        public static User RetrieveUserByUsername(string username)
        {
            User user = null;

            var conn = DBConnection.GetDBConnection();
            var cmdText = @"sp_retrieve_player_by_username";

            var cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Username", SqlDbType.VarChar, 20);
            cmd.Parameters["@Username"].Value = username;

            try
            {
                conn.Open();
                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    reader.Read();
                    user = new User()
                    {
                        PlayerID = reader.GetInt32(0),
                        UserName = reader.GetString(1),
                        Email = reader.GetString(2),
                        RoleID = reader.GetInt32(3),
                        SavedLocationX = reader.GetInt32(4),
                        SavedLocationY = reader.GetInt32(5),
                        SavedLocationZ = reader.GetInt32(6),
                        SavedHealth = reader.GetInt32(7),
                        SavedImage = reader.GetInt32(8),
                        SavedItem = reader.GetInt32(9),
                        Ban = reader.GetBoolean(10)    
                    };
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
            return user;
        }

        public static List<Player> SearchByPlayerUsername(string username)
        {
            var players = new List<Player>();

            var conn = DBConnection.GetDBConnection();
            var cmdText = @"sp_retrieve_player_by_similar_username";
            var cmd = new SqlCommand(cmdText, conn);

            cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 20);
            cmd.Parameters["@UserName"].Value = username;

            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                conn.Open();
                var reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        players.Add(new Player()
                        {
                            PlayerID = reader.GetInt32(0),
                            UserName = reader.GetString(1),
                            Email = reader.GetString(2),
                            RoleID = reader.GetInt32(3),
                            SavedLocationX = reader.GetInt32(4),
                            SavedLocationY = reader.GetInt32(5),
                            SavedLocationZ = reader.GetInt32(6),
                            SavedHealth = reader.GetInt32(7),
                            SavedImage = reader.GetInt32(8),
                            SavedItem = reader.GetInt32(9),
                            Ban = reader.GetBoolean(10)

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
            return players;

        }

        public static int EditPlayer(Player oldPlayer, Player player)
        {
            var count = 0;

            // need a connection
            var conn = DBConnection.GetDBConnection();

            // need command text
            var cmdText = @"sp_change_player_role";

            // we need a command object
            var cmd = new SqlCommand(cmdText, conn);

            //set command type
            cmd.CommandType = CommandType.StoredProcedure;

            // parameters?
            cmd.Parameters.Add("@PlayerID", SqlDbType.Int);
            cmd.Parameters.Add("@RoleID", SqlDbType.Int);

            // parameter values?
            cmd.Parameters["@PlayerID"].Value = player.PlayerID;
            cmd.Parameters["@RoleID"].Value = player.RoleID;
            

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

        public static List<Role> RetrievePlayerRoles(int playerId)
        {
            var roles = new List<Role>();
            var conn = DBConnection.GetDBConnection();
            var cmdText = @"sp_retrieve_player_role";

            var cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PlayerID", SqlDbType.Int);
            cmd.Parameters["@PlayerID"].Value = playerId;

            try
            {
                conn.Open();
                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        roles.Add(new Role()
                        {
                            RoleID = reader.GetInt32(0),
                            RoleDescription = reader.GetString(1)
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
            return roles;
        }

        public static int BanPlayer(int playerID)
        {
            var count = 0;

            // need a connection
            var conn = DBConnection.GetDBConnection();

            // need command text
            var cmdText = @"sp_update_to_ban";

            // we need a command object
            var cmd = new SqlCommand(cmdText, conn);

            //set command type
            cmd.CommandType = CommandType.StoredProcedure;

            // parameters?
            cmd.Parameters.Add("@PlayerID", SqlDbType.Int);

            // parameter values?
            cmd.Parameters["@PlayerID"].Value = playerID;


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

        public static int UnbanPlayer(int playerID)
        {
            var count = 0;

            // need a connection
            var conn = DBConnection.GetDBConnection();

            // need command text
            var cmdText = @"sp_update_to_unban";

            // we need a command object
            var cmd = new SqlCommand(cmdText, conn);

            //set command type
            cmd.CommandType = CommandType.StoredProcedure;

            // parameters?
            cmd.Parameters.Add("@PlayerID", SqlDbType.Int);

            // parameter values?
            cmd.Parameters["@PlayerID"].Value = playerID;


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

        public static Player RetrievePlayerByID(int i)
        {
            User user = null;

            var conn = DBConnection.GetDBConnection();
            var cmdText = @"sp_retrieve_player_by_id";

            var cmd = new SqlCommand(cmdText, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@id", SqlDbType.Int);
            cmd.Parameters["@id"].Value = i;

            try
            {
                conn.Open();
                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    reader.Read();
                    user = new User()
                    {
                        PlayerID = reader.GetInt32(0),
                        UserName = reader.GetString(1),
                        Email = reader.GetString(2),
                        RoleID = reader.GetInt32(3),
                        SavedLocationX = reader.GetInt32(4),
                        SavedLocationY = reader.GetInt32(5),
                        SavedLocationZ = reader.GetInt32(6),
                        SavedHealth = reader.GetInt32(7),
                        SavedImage = reader.GetInt32(8),
                        SavedItem = reader.GetInt32(9),
                        Ban = reader.GetBoolean(10)
                    };
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
            return user;
        }

        public static int UpdatePasswordHash(int playerId, string oldPasswordHash, string newPasswordHash)
        {
            var count = 0;

            // need a connection
            var conn = DBConnection.GetDBConnection();

            // need command text
            var cmdText = @"sp_update_passwordHash";

            // we need a command object
            var cmd = new SqlCommand(cmdText, conn);

            //set command type
            cmd.CommandType = CommandType.StoredProcedure;

            // parameters?
            cmd.Parameters.Add("@PlayerID", SqlDbType.Int);
            cmd.Parameters.Add("@OldPasswordHash", SqlDbType.VarChar, 100);
            cmd.Parameters.Add("@NewPasswordHash", SqlDbType.VarChar, 100);

            // parameter values?
            cmd.Parameters["@PlayerID"].Value = playerId;
            cmd.Parameters["@OldPasswordHash"].Value = oldPasswordHash;
            cmd.Parameters["@NewPasswordHash"].Value = newPasswordHash;

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

        public static int AddNewPlayer(string username, string email, string password)
        {
            var count = 0;

            // need a connection
            var conn = DBConnection.GetDBConnection();

            // need command text
            var cmdText = @"sp_add_new_player";

            // we need a command object
            var cmd = new SqlCommand(cmdText, conn);

            //set command type
            cmd.CommandType = CommandType.StoredProcedure;

            // parameters?
            cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 20);
            cmd.Parameters.Add("@Email", SqlDbType.VarChar, 100);
            cmd.Parameters.Add("@PasswordHash", SqlDbType.VarChar, 100);

            // parameter values?
            cmd.Parameters["@UserName"].Value = username;
            cmd.Parameters["@Email"].Value = email;
            cmd.Parameters["@PasswordHash"].Value = password;

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

        public static int UpdatePasswordHashByUsername(string username, string oldPasswordHash, string newPasswordHash)
        {
            var count = 0;

            // need a connection
            var conn = DBConnection.GetDBConnection();

            // need command text
            var cmdText = @"sp_update_passwordHash_by_username";

            // we need a command object
            var cmd = new SqlCommand(cmdText, conn);

            //set command type
            cmd.CommandType = CommandType.StoredProcedure;

            // parameters?
            cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 20);
            cmd.Parameters.Add("@OldPasswordHash", SqlDbType.VarChar, 100);
            cmd.Parameters.Add("@NewPasswordHash", SqlDbType.VarChar, 100);

            // parameter values?
            cmd.Parameters["@UserName"].Value = username;
            cmd.Parameters["@OldPasswordHash"].Value = oldPasswordHash;
            cmd.Parameters["@NewPasswordHash"].Value = newPasswordHash;

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

        public static List<Player> RetrievePlayers()
        {
            var players = new List<Player>();

            var conn = DBConnection.GetDBConnection();
            var cmdText = @"sp_retrieve_players";
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
                        players.Add(new Player()
                        {
                            PlayerID = reader.GetInt32(0),
                            UserName = reader.GetString(1),
                            Email = reader.GetString(2),
                            RoleID = reader.GetInt32(3),
                            SavedLocationX = reader.GetInt32(4),
                            SavedLocationY = reader.GetInt32(5),
                            SavedLocationZ = reader.GetInt32(6),
                            SavedHealth = reader.GetInt32(7),
                            SavedImage = reader.GetInt32(8),
                            SavedItem = reader.GetInt32(9),
                            Ban = reader.GetBoolean(10)
                            
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
            return players;
        
        }
    }
}
