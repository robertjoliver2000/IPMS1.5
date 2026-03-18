using System;
using System.Data;
using System.Data.SqlClient;

namespace ProjectPortfolio.Classes
{
	/// <summary>
	/// Summary description for SectionD_DB.
	/// </summary>
	public class SectionD_DB
	{

        public static int UpdateInitiative(int intInitiativeID,
                                    string strIGApprovalCommittee, int intIGApprovalCommitteeID, 
                                    object objIGApprovalDate,
                                    string strImpactCategory, int intImpactCategoryID,
                                    string strGTOReviewLevel, int intGTOReviewLevelID,
                                    string strAlignedToBusinessStrategy, int intAlignedToBusinessStrategyID,
                                    string strFirstTimeInitiative, int intFirstTimeInitiativeID,
                                    string strNonDuplication, int intNonDuplicationID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative = new SqlCommand();
            cmdUpdateInitiative.Connection = dbConnection;

            cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionD";

            cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

            cmdUpdateInitiative.Parameters.Add("@IGApprovalCommittee", strIGApprovalCommittee);
            cmdUpdateInitiative.Parameters.Add("@IGApprovalCommitteeID", intIGApprovalCommitteeID);

            cmdUpdateInitiative.Parameters.Add("@IGApprovalDate", objIGApprovalDate);

            cmdUpdateInitiative.Parameters.Add("@InitiativeImpactCategory", strImpactCategory);
            cmdUpdateInitiative.Parameters.Add("@InitiativeImpactCategoryID", intImpactCategoryID);
            cmdUpdateInitiative.Parameters.Add("@InitiativeGTOReviewLevel", strGTOReviewLevel);
            cmdUpdateInitiative.Parameters.Add("@InitiativeGTOReviewLevelID", intGTOReviewLevelID);

            cmdUpdateInitiative.Parameters.Add("@AlignedToBusinessStrategy", strAlignedToBusinessStrategy);
            cmdUpdateInitiative.Parameters.Add("@AlignedToBusinessStrategyID", intAlignedToBusinessStrategyID);
            cmdUpdateInitiative.Parameters.Add("@FirstTimeInitiative", strFirstTimeInitiative);
            cmdUpdateInitiative.Parameters.Add("@FirstTimeInitiativeID", intFirstTimeInitiativeID);
            cmdUpdateInitiative.Parameters.Add("@NonDuplication", strNonDuplication);
            cmdUpdateInitiative.Parameters.Add("@NonDuplicationID", intNonDuplicationID);

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

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT * FROM Initiative WHERE InitiativeID=@InitiativeID";

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
