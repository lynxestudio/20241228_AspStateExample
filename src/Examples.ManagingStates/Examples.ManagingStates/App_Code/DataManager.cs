using System.Collections.Generic;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using Examples.ManagingStates;

namespace Examples.ManagingStates
{
    public sealed class DataManager 
    {
        public List<Department> GetAll()
        {
            List<Department> departments = null;
            Department department = null;
            using (OracleDataReader reader = OracleDataBaseCommand.GetReader(CommandsText.SelectAllDepartments,
              null, CommandType.Text))
            {
                if (reader.HasRows)
                {
                    departments = new List<Department>();
                    while (reader.Read())
                    {
                        department = new Department();
                        department.Id = reader.GetInt32(0);
                        department.Name = reader.GetString(1);
                        departments.Add(department);
                    }
                }
            }
            return departments;
        }
    }
}