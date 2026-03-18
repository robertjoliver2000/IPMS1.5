using System;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{
    public class PIR_ExecutiveSummary_DB
    {
        public static int UpdateInitiative(int intInitiativeID,
                        string strBusinessSponsorName, int intBusinessSponsorID,
                        string strGTOInitiativeManager, int intGTOInitiativeManagerID,
                        string strImpactCategory, int intImpactCategoryID,
                        object objPIRStartDate,
                        object objPIREndDate,
                        // Rev 2.1.7, GMcF, 2008-05-20, for Phase 2.1, Deliverable 7 - Performance Status Capture - Overall Status save now being done at same time as PIR Key Metrics
                        //string strPIRStatus, int intPIRStatusID,
                        // End of Rev 2.1.7
                        string strInitiativeBusinessDrivers,
                        string strInitiativeScopeAndObjectives,
                        string strInitiativeBenefitCalculation,
                        string strPIRSuccesses,
                        string strPIRIssues,
                        string strPPRComments    // Added 2008-05-30, GMcF, for OTA 582 - PPR Comments
                        )
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative = new SqlCommand();
            cmdUpdateInitiative.Connection = dbConnection;

            cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiative.CommandText = "spUpdateInitiative_PIR_ExecutiveSummary";

            cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

            cmdUpdateInitiative.Parameters.Add("@BusinessSponsorName", strBusinessSponsorName);
            cmdUpdateInitiative.Parameters.Add("@BusinessSponsorID", intBusinessSponsorID);
            cmdUpdateInitiative.Parameters.Add("@GTOInitiativeManager", strGTOInitiativeManager);
            cmdUpdateInitiative.Parameters.Add("@GTOInitiativeManagerID", intGTOInitiativeManagerID);
            cmdUpdateInitiative.Parameters.Add("@InitiativeImpactCategory", strImpactCategory);
            cmdUpdateInitiative.Parameters.Add("@InitiativeImpactCategoryID", intImpactCategoryID);
            cmdUpdateInitiative.Parameters.Add("@PIRStartDate", objPIRStartDate);
            cmdUpdateInitiative.Parameters.Add("@PIREndDate", objPIREndDate);

            // Rev 2.1.7, GMcF, 2008-05-20, for Phase 2.1, Deliverable 7 - Performance Status Capture - Overall Status save now being done at same time as PIR Key Metrics
            //cmdUpdateInitiative.Parameters.Add("@PIRStatus", strPIRStatus);
            //cmdUpdateInitiative.Parameters.Add("@PIRStatusID", intPIRStatusID);
            // End of Rev 2.1.7

            cmdUpdateInitiative.Parameters.Add("@InitiativeBusinessDrivers", strInitiativeBusinessDrivers);
            cmdUpdateInitiative.Parameters.Add("@InitiativeScopeAndObjectives", strInitiativeScopeAndObjectives);
            cmdUpdateInitiative.Parameters.Add("@InitiativeBenefitCalculation", strInitiativeBenefitCalculation);
            cmdUpdateInitiative.Parameters.Add("@PIRSuccesses", strPIRSuccesses);
            cmdUpdateInitiative.Parameters.Add("@PIRIssues", strPIRIssues);

            cmdUpdateInitiative.Parameters.Add( "@PPR_Comments", strPPRComments );    // Added 2008-05-30, GMcF, for OTA 582 - PPR Comments

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
            cmdGetInitiative.CommandText = "dbo.spGetInitiativePIR_ExecutiveSummary";

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
