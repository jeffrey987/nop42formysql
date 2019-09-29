using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Nop.Web.Controllers
{
    public partial class InstallController
    {
        protected virtual bool MySqlDatabaseExists(string connectionString)
        {
            try
            {
                //just try to connect
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }

        protected virtual string CreateMySqlDatabase(string connectionString, string collation, int triesToConnect = 10)
        {
            try
            {
                //parse database name
                var builder = new MySqlConnectionStringBuilder(connectionString);
                var databaseName = builder.Database;
                //now create connection string to 'master' dabatase. It always exists.
                builder.Database = "";
                var rootConnectionString = builder.ToString();
                var query = $"CREATE DATABASE IF NOT EXISTS {databaseName} DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;";
                using (var conn = new MySqlConnection(rootConnectionString))
                {
                    conn.Open();
                    using (var command = new MySqlCommand(query, conn))
                    {
                        command.ExecuteNonQuery();
                    }
                }

                //try connect
                if (triesToConnect > 0)
                {
                    //Sometimes on slow servers (hosting) there could be situations when database requires some time to be created.
                    //But we have already started creation of tables and sample data.
                    //As a result there is an exception thrown and the installation process cannot continue.
                    //That's why we are in a cycle of "triesToConnect" times trying to connect to a database with a delay of one second.
                    for (var i = 0; i <= triesToConnect; i++)
                    {
                        if (i == triesToConnect)
                            throw new Exception("Unable to connect to the new database. Please try one more time");

                        if (!MySqlDatabaseExists(connectionString))
                            Thread.Sleep(1000);
                        else
                            break;
                    }
                }

                return string.Empty;
            }
            catch (Exception ex)
            {
                return string.Format(_locService.GetResource("DatabaseCreationError"), ex.Message);
            }
        }
    }
}
