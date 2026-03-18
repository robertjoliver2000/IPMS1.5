using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{

    public class Header_DB
    {

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


        public static int UpdateInitiativeStatus(int intInitiativeID, string strIGApprovalStatus, int intIGApprovalStatusID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative = new SqlCommand();
            cmdUpdateInitiative.Connection = dbConnection;

            cmdUpdateInitiative.CommandType = CommandType.Text;
            cmdUpdateInitiative.CommandText = "UPDATE Initiative SET " + 
                                "IGApprovalStatus=@IGApprovalStatus, IGApprovalStatusID=@IGApprovalStatusID " + 
                                "WHERE InitiativeID=@InitiativeID ";

            cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateInitiative.Parameters.Add("@IGApprovalStatus", strIGApprovalStatus);
            cmdUpdateInitiative.Parameters.Add("@IGApprovalStatusID", intIGApprovalStatusID);

            int intRecordsAffected = 0;
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
    }
}
