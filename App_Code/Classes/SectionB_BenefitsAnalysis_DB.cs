using System;
using System.Data;
using System.Data.SqlClient;
namespace ProjectPortfolio.Classes
{
	/// <summary>
	/// Summary description for SectionB_BenefitsAnalysis_DB.
	/// </summary>
	public class SectionB_BenefitsAnalysis_DB
	{
        public static int UpdateInitiative(int intInitiativeID,
                                        string strPayPackPeriod, int intPayBackPeriodID,
                                        string strCompletionDate, int intCompletionDateID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative = new SqlCommand();
            cmdUpdateInitiative.Connection = dbConnection;

            cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionB_FinancialsAnalysis";

            cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateInitiative.Parameters.Add("@PayBackPeriod", strPayPackPeriod);
            cmdUpdateInitiative.Parameters.Add("@PayBackPeriodID", intPayBackPeriodID);
            cmdUpdateInitiative.Parameters.Add("@CompletionDate", strCompletionDate);
            cmdUpdateInitiative.Parameters.Add("@CompletionDateID", intCompletionDateID);

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
