using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{
    /// <summary>
    /// Summary description for MyProjects_DB
    /// </summary>
    public class MyProjects_DB
    {
        
        public static DataSet GetMyInitiatives()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetInitiatives";

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Initiative");
          
            if ((ds.Tables["Initiative"].Rows.Count == 0) || (ds.Tables["Initiative"].Rows.Count == null))
            {
                DataRow drNoRecords = ds.Tables["Initiative"].NewRow();
                drNoRecords["Name"] = "No records";

                /* RJO ds.Tables["Initiatives"].Rows.Add(drNoRecords); */
            }

            return ds;
        }


        public static DataSet GetInitiativeHistory(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetInitiativeHistory";

            cmdGetDS.Parameters.Add("InitiativeID", intInitiativeID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Initiative");

            if (ds.Tables["Initiative"].Rows.Count == 0)
            {
                DataRow drNoRecords = ds.Tables["Initiative"].NewRow();
                drNoRecords["Name"] = "No records";

                ds.Tables["Initiatives"].Rows.Add(drNoRecords);
            }

            return ds;
        }

	public static int InsertInitiative_CreateNewVersion(int intCurrentInitiativeID, 
                                                            int intContactID,
                                                            DateTime dt)
        {
            int intInitiativeID;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsert = new SqlCommand();
            cmdInsert.Connection = dbConnection;

            cmdInsert.CommandType = CommandType.StoredProcedure;
            cmdInsert.CommandText = "spInsertInitiative_CreateNewVersion";
            cmdInsert.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdInsert.Parameters.Add("InitiativeID", intCurrentInitiativeID);
            cmdInsert.Parameters.Add("ContactID", intContactID);
            cmdInsert.Parameters.Add("SubmissionDate", dt);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsert.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                cmdInsert.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intInitiativeID = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                intInitiativeID = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                intInitiativeID = -1;
            }

            return intInitiativeID;
        }


        public static int InsertInitiative_CreateNewVersionForPIR(  int intCurrentInitiativeID,
                                                                    int intContactID,
                                                                    DateTime dt)
        {
            int intInitiativeID;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsert = new SqlCommand();
            cmdInsert.Connection = dbConnection;

            cmdInsert.CommandType = CommandType.StoredProcedure;
            cmdInsert.CommandText = "spInsertInitiative_CreateNewVersionForPIR";
            cmdInsert.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdInsert.Parameters.Add("InitiativeID", intCurrentInitiativeID);
            cmdInsert.Parameters.Add("ContactID", intContactID);
            cmdInsert.Parameters.Add("SubmissionDate", dt);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsert.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                cmdInsert.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intInitiativeID = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                intInitiativeID = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                intInitiativeID = -1;
            }

            return intInitiativeID;
        }


    
    }
}

