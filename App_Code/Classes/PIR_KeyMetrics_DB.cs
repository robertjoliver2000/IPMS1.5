using System;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{
    public class PIR_KeyMetrics_DB
    {
        public static int UpdateInitiative(
                            int intInitiativeID,
                            string strSpendStatus, int intSpendStatusID, string strSpendComments,
                            string strDeliveryStatus, int intDeliveryStatusID, string strDeliveryComments,
                            string strTimeStatus, int intTimeStatusID, string strTimeComments,
                            string strImpactStatus, int intImpactStatusID, string strImpactComments,
                            string strScopeStatus, int intScopeStatusID, string strScopeComments,
                            string strProjManStatus, int intProjManStatusID, string strProjManComments,
                            string strRiskManStatus, int intRiskManStatusID, string strRiskManComments,
                            string strAlphaStatus, int intAlphaStatusID, string strAlphaComments
                            ,
                            // Rev 2.1.7, GMcF, 2008-05-20, for Phase 2.1, Deliverable 7 - Performance Status capture - Overall status now done at same time as Key Metrics
                            string strOverallStatus, int intOverallStatusID
                        )
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative = new SqlCommand();
            cmdUpdateInitiative.Connection = dbConnection;

            cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiative.CommandText = "spUpdateInitiative_PIR_KeyMetrics";

            cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

            cmdUpdateInitiative.Parameters.Add("@SpendStatus", strSpendStatus);
            cmdUpdateInitiative.Parameters.Add("@SpendStatusID", intSpendStatusID);
            cmdUpdateInitiative.Parameters.Add("@SpendComments", strSpendComments);

            cmdUpdateInitiative.Parameters.Add("@DeliveryStatus", strDeliveryStatus);
            cmdUpdateInitiative.Parameters.Add("@DeliveryStatusID", intDeliveryStatusID);
            cmdUpdateInitiative.Parameters.Add("@DeliveryComments", strDeliveryComments);

            cmdUpdateInitiative.Parameters.Add("@TimeStatus", strTimeStatus);
            cmdUpdateInitiative.Parameters.Add("@TimeStatusID", intTimeStatusID);
            cmdUpdateInitiative.Parameters.Add("@TimeComments", strTimeComments);

            cmdUpdateInitiative.Parameters.Add("@ImpactStatus", strImpactStatus);
            cmdUpdateInitiative.Parameters.Add("@ImpactStatusID", intImpactStatusID);
            cmdUpdateInitiative.Parameters.Add("@ImpactComments", strImpactComments);

            cmdUpdateInitiative.Parameters.Add("@ScopeStatus", strScopeStatus);
            cmdUpdateInitiative.Parameters.Add("@ScopeStatusID", intScopeStatusID);
            cmdUpdateInitiative.Parameters.Add("@ScopeComments", strScopeComments);

            cmdUpdateInitiative.Parameters.Add("@ProjManStatus", strProjManStatus);
            cmdUpdateInitiative.Parameters.Add("@ProjManStatusID", intProjManStatusID);
            cmdUpdateInitiative.Parameters.Add("@ProjManComments", strProjManComments);

            cmdUpdateInitiative.Parameters.Add("@RiskManStatus", strRiskManStatus);
            cmdUpdateInitiative.Parameters.Add("@RiskManStatusID", intRiskManStatusID);
            cmdUpdateInitiative.Parameters.Add("@RiskManComments", strRiskManComments);

            cmdUpdateInitiative.Parameters.Add("@AlphaStatus", strAlphaStatus);
            cmdUpdateInitiative.Parameters.Add("@AlphaStatusID", intAlphaStatusID);
            cmdUpdateInitiative.Parameters.Add("@AlphaComments", strAlphaComments);

            cmdUpdateInitiative.Parameters.Add("@OverallStatus", strOverallStatus);
            cmdUpdateInitiative.Parameters.Add("@OverallStatusID", intOverallStatusID);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdUpdateInitiative.ExecuteNonQuery();
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


        public static DataRow GetInitiativeDetails(int intInitiativeID)
        {
            DataRow drInitiative = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            cmdGetInitiative.CommandType = CommandType.StoredProcedure;
            cmdGetInitiative.CommandText = "dbo.spGetInitiativePIR_KeyMetrics";

            cmdGetInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

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

    }

}