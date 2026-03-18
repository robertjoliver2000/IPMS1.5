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
using ProjectPortfolio.Classes;

/// <summary>
/// Summary description for SectionH_DB
/// </summary>
public class SectionH_DB
{
    public static DataSet GetITPolicies(int nInitiativeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT InitiativeITPolicyID, InitiativeID," 
                    +"InitiativeITPolicy.ITPolicyID, ITPolicyValue,ITPolicyValueID," 
                    +"ITPolicyText, CategoryID,ControlID "
                    +"FROM   InitiativeITPolicy " 
                    +"INNER JOIN ITPolicy ON InitiativeITPolicy.ITPolicyID = ITPolicy.ITPolicyID "
                    + "WHERE InitiativeID = @InitiativeID ORDER BY ITPolicy.ITPolicyID";


        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "ITPolicy");

        return ds;
    }

    public static DataSet GetITPoliciesControls()
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT * FROM ITPolicy WHERE CategoryID>0";
        
        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "ITPolicyControl");

        return ds;
    }

    public static void UpdateITPolicy(int nInitiativeID,string strControlID,
                int nITPolicyValueID, int nCategoryID)
        
    {

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiativeITPolicy = new SqlCommand();
        cmdUpdateInitiativeITPolicy.Connection = dbConnection;

        cmdUpdateInitiativeITPolicy.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiativeITPolicy.CommandText = "spUpdateInitiative_SectionH_ITPolicy";

        cmdUpdateInitiativeITPolicy.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdUpdateInitiativeITPolicy.Parameters.Add("@ControlID", strControlID);
        cmdUpdateInitiativeITPolicy.Parameters.Add("@ITPolicyValueID",nITPolicyValueID);
        cmdUpdateInitiativeITPolicy.Parameters.Add("@CategoryID", nCategoryID);


        try
        {
            dbConnection.Open();
            cmdUpdateInitiativeITPolicy.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }

    }

    

}
