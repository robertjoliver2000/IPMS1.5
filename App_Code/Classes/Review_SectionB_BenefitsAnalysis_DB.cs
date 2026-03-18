using System;
using System.Data;
using System.Data.SqlClient;

namespace ProjectPortfolio.Classes
{

    public class Review_SectionB_BenefitsAnalysis_DB
    {
        public static int UpdateInitiative(int intInitiativeID,
                                            string strComment_RG,
                                            string strComment_CR,
                                            string strComment_RR,
                                            string strComment_CA,
                                            string strComment_RLA,
                                            string strComment_RoI,
                                            string strComment_CTB, 
                                            string strComment_MAN,
                                            string strComment_RTB,
                                            string strComment_RTB_Existing)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative = new SqlCommand();
            cmdUpdateInitiative.Connection = dbConnection;

            cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiative.CommandText = "spUpdateInitiative_Review_SectionB_BenefitsAnalysis";

            cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateInitiative.Parameters.Add("@Comment_RG", strComment_RG);
            cmdUpdateInitiative.Parameters.Add("@Comment_CR", strComment_CR);
            cmdUpdateInitiative.Parameters.Add("@Comment_RR", strComment_RR);
            cmdUpdateInitiative.Parameters.Add("@Comment_CA", strComment_CA);
            cmdUpdateInitiative.Parameters.Add("@Comment_RLA", strComment_RLA);
            cmdUpdateInitiative.Parameters.Add("@Comment_RoI", strComment_RoI);
            cmdUpdateInitiative.Parameters.Add("@Comment_CTB", strComment_CTB);
            cmdUpdateInitiative.Parameters.Add("@Comment_MAN", strComment_MAN);
            cmdUpdateInitiative.Parameters.Add("@Comment_RTB", strComment_RTB);
            cmdUpdateInitiative.Parameters.Add("@Comment_RTB_Existing", strComment_RTB_Existing);

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


        public static DataRow GetInitiativeReviewDetails(int intInitiativeID)
        {
            DataRow drInitiative = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT * FROM InitiativeReview WHERE InitiativeID=@InitiativeID";

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
