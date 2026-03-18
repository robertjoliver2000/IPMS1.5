using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Data.SqlClient;

namespace ProjectPortfolio.Classes
{

    public class PIR_Deliverables_DB
    {
        public static int InsertPIRDeliverable(
                            int intInitiativeID,
                            string strName,
                            string strPIRCommentary,
                            string strPIRStatus,
                            int intPIRStatusID,
                            object objPIRPlanDate,
                            object objPIRActualDate
                            )
        {
            int intDeliverableID;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertPIRDeliverable = new SqlCommand();
            cmdInsertPIRDeliverable.Connection = dbConnection;

            cmdInsertPIRDeliverable.CommandType = CommandType.StoredProcedure;
            cmdInsertPIRDeliverable.CommandText = "spInsertInitiative_PIR_Deliverable";

            cmdInsertPIRDeliverable.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdInsertPIRDeliverable.Parameters.Add("@Name", strName);
            cmdInsertPIRDeliverable.Parameters.Add("@PIRCommentary", strPIRCommentary);
            cmdInsertPIRDeliverable.Parameters.Add("@PIRStatus", strPIRStatus);
            cmdInsertPIRDeliverable.Parameters.Add("@PIRStatusID", intPIRStatusID);
            cmdInsertPIRDeliverable.Parameters.Add("@PIRPlanDate", objPIRPlanDate);
            cmdInsertPIRDeliverable.Parameters.Add("@PIRActualDate", objPIRActualDate);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsertPIRDeliverable.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                cmdInsertPIRDeliverable.ExecuteNonQuery();
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


        public static int UpdatePIRDeliverable(
                            int intDeliverableID,
                            int intInitiativeID,
                            string strName,
                            string strPIRCommentary,
                            string strPIRStatus,
                            int intPIRStatusID,
                            object objPIRPlanDate,
                            object objPIRActualDate
                            )
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdatePIRDeliverable = new SqlCommand();
            cmdUpdatePIRDeliverable.Connection = dbConnection;

            cmdUpdatePIRDeliverable.CommandType = CommandType.StoredProcedure;
            cmdUpdatePIRDeliverable.CommandText = "spUpdateInitiative_PIR_Deliverable";

            cmdUpdatePIRDeliverable.Parameters.Add("@DeliverableID", intDeliverableID);
            cmdUpdatePIRDeliverable.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdatePIRDeliverable.Parameters.Add("@Name", strName);
            cmdUpdatePIRDeliverable.Parameters.Add("@PIRCommentary", strPIRCommentary);
            cmdUpdatePIRDeliverable.Parameters.Add("@PIRStatus", strPIRStatus);
            cmdUpdatePIRDeliverable.Parameters.Add("@PIRStatusID", intPIRStatusID);
            cmdUpdatePIRDeliverable.Parameters.Add("@PIRPlanDate", objPIRPlanDate);
            cmdUpdatePIRDeliverable.Parameters.Add("@PIRActualDate", objPIRActualDate);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdUpdatePIRDeliverable.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdUpdatePIRDeliverable.ExecuteNonQuery();
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


        public static DataSet GetPIRProgramDeliverables(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetPIRProgramDeliverables = new SqlCommand();
            cmdGetPIRProgramDeliverables.Connection = dbConnection;

            cmdGetPIRProgramDeliverables.CommandType = CommandType.StoredProcedure;
            cmdGetPIRProgramDeliverables.CommandText = "spGetInitiativePIR_Deliverables";

            cmdGetPIRProgramDeliverables.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter daGetPIRProgramDeliverables = new SqlDataAdapter(cmdGetPIRProgramDeliverables);

            DataSet dsGetPIRProgramDeliverables = new DataSet();

            try
            {
                daGetPIRProgramDeliverables.Fill(dsGetPIRProgramDeliverables, "Deliverable");

                if (dsGetPIRProgramDeliverables.Tables["Deliverable"].Rows.Count == 0)
                {
                    DataRow drNoRecords = dsGetPIRProgramDeliverables.Tables["Deliverable"].NewRow();
                    drNoRecords["Name"] = "No records";

                    dsGetPIRProgramDeliverables.Tables["Deliverable"].Rows.Add(drNoRecords);
                }
            }
            catch (SqlException)
            {
                dsGetPIRProgramDeliverables = null;
            }

            return dsGetPIRProgramDeliverables;
        }


        public static DataRow GetPIRDeliverableDetails(int intDeliverableID)
        {
            DataRow drInitiativeDeliverable = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetPIRDeliverableDetails = new SqlCommand();
            cmdGetPIRDeliverableDetails.Connection = dbConnection;

            cmdGetPIRDeliverableDetails.CommandType = CommandType.StoredProcedure;
            cmdGetPIRDeliverableDetails.CommandText = "spGetInitiativePIR_Deliverable";

            cmdGetPIRDeliverableDetails.Parameters.Add("@DeliverableID", intDeliverableID);

            SqlDataAdapter daGetPIRDeliverableDetails = new SqlDataAdapter(cmdGetPIRDeliverableDetails);

            DataSet dsPIRDeliverableDetails = new DataSet();

            try
            {
                daGetPIRDeliverableDetails.Fill(dsPIRDeliverableDetails, "InitiativeDeliverable");
            }
            catch (SqlException)
            {
                drInitiativeDeliverable = null;
            }

            if (dsPIRDeliverableDetails.Tables["InitiativeDeliverable"] != null && dsPIRDeliverableDetails.Tables["InitiativeDeliverable"].Rows.Count > 0)
            {
                drInitiativeDeliverable = dsPIRDeliverableDetails.Tables["InitiativeDeliverable"].Rows[0];
            }

            return drInitiativeDeliverable;
        }


        public static int DeletePIRDeliverable(int intInitiativeID, int intDeliverableID)
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