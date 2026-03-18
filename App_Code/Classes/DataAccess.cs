//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.0         JG          09/02/2009      Standard DataAccess wrapper class for ADO.NET
//
//*****************************************************************************************************

using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;


namespace ProjectPortfolio.Classes
{
    public class DataAccess
    {
        #region Private Member Variables

        private DbProviderFactory m_dbFactory;
        private DbConnection m_connection;
        private IDataReader m_dataReader;
        private DbDataAdapter m_dataAdapter;
        private DbCommand m_command;
        private DataSet m_dataSet;

        #endregion

        #region Constructor

        public DataAccess()
        {
        }

        #endregion

        #region Public Methods

        public void Initialise(string connectionStringName)
        {
            try
            {
                Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(null);
                ConnectionStringSettings connString;

                if (rootWebConfig.ConnectionStrings.ConnectionStrings.Count > 0)
                {
                    connString = WebConfigurationManager.ConnectionStrings[connectionStringName];

                    string dbProviderName = connString.ProviderName;
                    m_dbFactory = DbProviderFactories.GetFactory(dbProviderName);

                    //Create the connection object
                    m_connection = m_dbFactory.CreateConnection();
                    m_connection.ConnectionString = connString.ConnectionString;

                    //create the command object
                    m_command = (DbCommand)m_connection.CreateCommand();
                    m_command.Connection = m_connection;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IDataReader ExecuteDataReader(string commandText)
        {
            m_dataReader = null;

            if (m_connection != null)
            {
                m_command.CommandText = commandText;
                m_command.CommandType = CommandType.StoredProcedure;

                try
                {
                    m_connection.Open();
                    m_dataReader = m_command.ExecuteReader(CommandBehavior.CloseConnection);
                }
                catch (Exception ex)
                {
                    CloseConnection();
                    throw ex;
                }
                finally
                {
                    CloseConnection();
                }
            }

            return m_dataReader;
        }

        public DataSet ExecuteDataSet(string commandText)
        {
            return ExecuteDataSet(commandText, null);
        }

        public DataSet ExecuteDataSet(string commandText, string dataSetName)
        {
            m_dataSet = null;

            if (m_connection != null && m_command != null)
            {
                m_command.CommandText = commandText;
                m_command.CommandType = CommandType.StoredProcedure;

                try
                {
                    m_dataAdapter = m_dbFactory.CreateDataAdapter();
                    m_dataAdapter.SelectCommand = m_command;

                    m_dataSet = new DataSet();

                    m_connection.Open();
                    m_dataAdapter.Fill(m_dataSet);
                    m_connection.Close();

                    if (!string.IsNullOrEmpty(dataSetName))
                    {
                        m_dataSet.DataSetName = dataSetName;
                    }
                }
                catch (Exception ex)
                {
                    CloseConnection();
                    throw ex;
                }
                finally
                {
                    CloseConnection();
                }
            }

            return m_dataSet;
        }

        public int ExecuteNonQuery(string commandText)
        {
            int result = 0;

            if (m_connection != null)
            {
                m_command.CommandText = commandText;
                m_command.CommandType = CommandType.StoredProcedure;

                try
                {
                    m_connection.Open();
                    result = m_command.ExecuteNonQuery();
                    m_connection.Close();
                }
                catch (Exception ex)
                {
                    CloseConnection();
                    throw ex;
                }
                finally
                {
                    CloseConnection();
                }
            }

            return result;
        }

        public object ExecuteScalar(string commandText)
        {
            object result = null;

            if (m_connection != null)
            {
                m_command.CommandText = commandText;
                m_command.CommandType = CommandType.StoredProcedure;

                try
                {
                    m_connection.Open();
                    result = m_command.ExecuteScalar();
                    m_connection.Close();
                }
                catch (Exception ex)
                {
                    CloseConnection();
                    throw ex;
                }
                finally
                {
                    CloseConnection();
                }
            }

            return result;
        }

        public void AddInParameter(string paramName, DbType dbType, object value)
        {
            AddInParameter(paramName, dbType, value, -1);
        }

        public void AddInParameter(string paramName, DbType dbType, object value, int size)
        {
            if (m_command != null)
            {
                IDbDataParameter parameter = m_command.CreateParameter();
                parameter.DbType = dbType;
                if (size != -1)
                {
                    parameter.Size = size;
                }
                parameter.Direction = ParameterDirection.Input;
                parameter.ParameterName = paramName;
                parameter.Value = value;

                m_command.Parameters.Add(parameter);
            }
        }

        public void AddInParameter(string paramName, SqlDbType dbType, object value)
        {
            AddInParameter(paramName, dbType, value, -1);
        }

        public void AddInParameter(string paramName, SqlDbType dbType, object value, int size)
        {
            if (m_command != null)
            {
                SqlParameter parameter = (SqlParameter)m_command.CreateParameter();
                parameter.SqlDbType = dbType;
                if (size != -1)
                {
                    parameter.Size = size;
                }
                parameter.Direction = ParameterDirection.Input;
                parameter.ParameterName = paramName;
                parameter.Value = value;

                m_command.Parameters.Add(parameter);
            }
        }

        public void AddOutParameter(string paramName, DbType dbType, object value)
        {
            AddOutParameter(paramName, dbType, value, -1);
        }

        public void AddOutParameter(string paramName, DbType dbType, object value, int size)
        {
            if (m_command != null)
            {
                IDbDataParameter parameter = m_command.CreateParameter();
                parameter.DbType = dbType;
                if (size != -1)
                {
                    parameter.Size = size;
                }
                parameter.Direction = ParameterDirection.Output;
                parameter.ParameterName = paramName;
                parameter.Value = value;

                m_command.Parameters.Add(parameter);
            }
        }

        public void AddOutParameter(string paramName, SqlDbType dbType, object value)
        {
            AddOutParameter(paramName, dbType, value, -1);
        }

        public void AddOutParameter(string paramName, SqlDbType dbType, object value, int size)
        {
            if (m_command != null)
            {
                SqlParameter parameter = (SqlParameter)m_command.CreateParameter();
                parameter.SqlDbType = dbType;
                if (size != -1)
                {
                    parameter.Size = size;
                }
                parameter.Direction = ParameterDirection.Output;
                parameter.ParameterName = paramName;
                parameter.Value = value;

                m_command.Parameters.Add(parameter);
            }
        }

        public void AddInOutParameter(string paramName, SqlDbType dbType, object value, int size)
        {
            if (m_command != null)
            {
                SqlParameter parameter = (SqlParameter)m_command.CreateParameter();
                parameter.SqlDbType = dbType;
                if (size != -1)
                {
                    parameter.Size = size;
                }
                parameter.Direction = ParameterDirection.InputOutput;
                parameter.ParameterName = paramName;
                parameter.Value = value;

                m_command.Parameters.Add(parameter);
            }
        }
        
        public void ClearParameters()
        {
            if (m_command != null)
            {
                m_command.Parameters.Clear();
            }
        }

        public object GetParameterValue(string parameterName)
        {
            object result = null;

            if (m_command != null)
            {
                result = m_command.Parameters[parameterName].Value;
            }

            return result;
        }

        #endregion

        #region Private Methods

        private void CloseConnection()
        {
            if (m_connection != null && m_connection.State != ConnectionState.Closed)
            {
                m_connection.Close();
            }
        }

        #endregion

        #region PublicProperties
            //the time in seconds ... default is 30.
            public int CommandTimeout
            {
                get { return m_command.CommandTimeout; }
                set
                {
                    m_command.CommandTimeout = value;
                }
            }
        #endregion
    }
}
