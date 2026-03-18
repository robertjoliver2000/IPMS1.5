using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Data;
using System.Data.SqlClient;

using ProjectPortfolio.Classes;


public class PIR_FinancialComments_DB
{
    public static DataRow GetInitiativeDetails(int intInitiativeID)
    {
        DataRow drInitiative = null;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetInitiative = new SqlCommand();
        cmdGetInitiative.Connection = dbConnection;

        cmdGetInitiative.CommandType = CommandType.Text;
        cmdGetInitiative.CommandText = "select InitiativeID, PIRFinancialComments from Initiative where InitiativeID = @InitiativeID";

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


	public static int UpdateInitiative(int intInitiativeID,  string strPIRFinancialComments)
	{
		int intRecordsAffected;

		SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

		SqlCommand cmdUpdateInitiative = new SqlCommand();
		cmdUpdateInitiative.Connection = dbConnection;

		cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
		cmdUpdateInitiative.CommandText = "spUpdateInitiative_PIR_FinancialComments";

		cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

        cmdUpdateInitiative.Parameters.Add("@PIRFinancialComments", strPIRFinancialComments);

		try
		{
			dbConnection.Open();
			intRecordsAffected = cmdUpdateInitiative.ExecuteNonQuery();			
		}
		catch(SqlException ex)
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
