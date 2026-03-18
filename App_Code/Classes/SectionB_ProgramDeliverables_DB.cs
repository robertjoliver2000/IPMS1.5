using System;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{

    /// <summary>
    /// Summary description for SectionB_ProgramDeliverables_DB
    /// </summary>
    public class SectionB_ProgramDeliverables_DB
    {
        public static int InsertDeliverable(
                            int intInitiativeID,
                            string strName, 
                            object objDueDate,
                            decimal dCost,
                            string strAffectedApplications
                            )
        {
            int intDeliverableID;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertDeliverable = new SqlCommand();
            cmdInsertDeliverable.Connection = dbConnection;

            cmdInsertDeliverable.CommandType = CommandType.StoredProcedure;
            cmdInsertDeliverable.CommandText = "spInsertInitiative_SectionB_Deliverable";

            cmdInsertDeliverable.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdInsertDeliverable.Parameters.Add("@Name", strName);
            cmdInsertDeliverable.Parameters.Add("@DueDate", objDueDate);
            cmdInsertDeliverable.Parameters.Add("@Cost", dCost);
            cmdInsertDeliverable.Parameters.Add("@AffectedApplications", strAffectedApplications);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsertDeliverable.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                cmdInsertDeliverable.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intDeliverableID = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                intDeliverableID = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                intDeliverableID = -1;
            }

            return intDeliverableID;

        }


        public static int UpdateDeliverable(
                            int intDeliverableID, 
                            int intInitiativeID,
                            string strName,
                            object objDueDate,
                            decimal dCost,
                            string strAffectedApplications
                            )
 
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateDeliverable = new SqlCommand();
            cmdUpdateDeliverable.Connection = dbConnection;

            cmdUpdateDeliverable.CommandType = CommandType.StoredProcedure;
            cmdUpdateDeliverable.CommandText = "spUpdateInitiative_SectionB_Deliverable";

            cmdUpdateDeliverable.Parameters.Add("@DeliverableID", intDeliverableID);
            cmdUpdateDeliverable.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateDeliverable.Parameters.Add("@Name", strName);
            cmdUpdateDeliverable.Parameters.Add("@DueDate", objDueDate);
            cmdUpdateDeliverable.Parameters.Add("@Cost", dCost);
            cmdUpdateDeliverable.Parameters.Add("@AffectedApplications", strAffectedApplications);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdUpdateDeliverable.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdUpdateDeliverable.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;
        }


        public static DataRow GetDeliverableDetails(int intInitiativeID, int intDeliverableID)
        {
            DataRow drInitiative = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT * FROM InitiativeDeliverable " +
                                                " WHERE InitiativeDeliverable.InitiativeID=@InitiativeID AND InitiativeDeliverable.DeliverableID=@DeliverableID";

            cmdGetInitiative.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdGetInitiative.Parameters.Add("@DeliverableID", intDeliverableID);

            SqlDataAdapter daGetInitiative = new SqlDataAdapter(cmdGetInitiative);

            DataSet dsInitiative = new DataSet();

            try
            {
                daGetInitiative.Fill(dsInitiative, "Initiative");
            }
            catch (SqlException)
            {
                drInitiative = null;
            }

            if (dsInitiative.Tables["Initiative"] != null && dsInitiative.Tables["Initiative"].Rows.Count > 0)
            {
                drInitiative = dsInitiative.Tables["Initiative"].Rows[0];
            }

            return drInitiative;
        }


        public static DataSet GetProgramDeliverables(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetProgramDeliverables = new SqlCommand();
            cmdGetProgramDeliverables.Connection = dbConnection;

            cmdGetProgramDeliverables.CommandType = CommandType.Text;
            cmdGetProgramDeliverables.CommandText = "SELECT * " +
                                                    " FROM InitiativeDeliverable " +
                                                " WHERE InitiativeID=@InitiativeID";

            cmdGetProgramDeliverables.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter daGetProgramDeliverables = new SqlDataAdapter(cmdGetProgramDeliverables);

            DataSet dsProgramDeliverables = new DataSet();

            try
            {
                daGetProgramDeliverables.Fill(dsProgramDeliverables, "Deliverable");

                if (dsProgramDeliverables.Tables["Deliverable"].Rows.Count == 0)
                {
                    DataRow drNoRecords = dsProgramDeliverables.Tables["Deliverable"].NewRow();
                    drNoRecords["Name"] = "No records";

                    dsProgramDeliverables.Tables["Deliverable"].Rows.Add(drNoRecords);
                }
            }
            catch (SqlException)
            {
                dsProgramDeliverables = null;
            }

            return dsProgramDeliverables;
        }


        public static int DeleteDeliverable(int intInitiativeID, int intDeliverableID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDeleteDeliverable = new SqlCommand();
            cmdDeleteDeliverable.Connection = dbConnection;

            cmdDeleteDeliverable.CommandType = CommandType.StoredProcedure;
            cmdDeleteDeliverable.CommandText = "spDeleteInitiative_Deliverable";

            cmdDeleteDeliverable.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdDeleteDeliverable.Parameters.Add("@DeliverableID", intDeliverableID);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdDeleteDeliverable.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdDeleteDeliverable.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;
        }
        
    }

}
