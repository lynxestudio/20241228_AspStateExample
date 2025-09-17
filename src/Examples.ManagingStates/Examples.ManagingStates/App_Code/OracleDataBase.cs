using Oracle.ManagedDataAccess.Client;
using System.Configuration;
using System.Data;

namespace Examples.ManagingStates
{
    internal  sealed class OracleDataBase {
        static OracleConnection connection = null;
        internal static OracleConnection GetConnection() {
            string connectionString = ConfigurationManager.ConnectionStrings["xe"].ConnectionString;
            connection = new OracleConnection(connectionString);
            connection.Open();
            return connection;
        }
        internal static void CloseConnection() {
            if (connection != null) {
                if (connection.State == ConnectionState.Open) {
                    connection.Close();
                    connection = null;
                }
            }
        }
    }
}