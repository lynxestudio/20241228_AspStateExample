using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Oracle.ManagedDataAccess.Client;

namespace Examples.ManagingStates
{
    internal class OracleDataBaseCommand
    {

        internal static OracleDataReader GetReader(string commandText,
                Dictionary<string,object> parameters, System.Data.CommandType cmdtype)
        {
            OracleDataReader reader = null;
            OracleConnection conn = OracleDataBase.GetConnection();
            using (OracleCommand cmd = new OracleCommand(commandText, conn))
            {
                if (parameters != null)
                {
                    foreach (KeyValuePair<string,object> pair in parameters)
                    {
                        cmd.Parameters.Add(new OracleParameter(pair.Key, pair.Value));
                    }
                }
                reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            }
            return reader;
        }


    }
}
