//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.4       CA          07/02/2007     New Dynamic Header for Date
//                                              
//
//*****************************************************************************************************

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

/// <summary>
/// Summary description for SectionJ_DB
/// </summary>
public class SectionJ_DB
{
   
    //rev 1.1.4 CA
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
    //end rev

    public static DataSet GetProjects(int nInitiativeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT InitiativeProjectID,InitiativeID, ExternalProjectID,ProjectName, ProjectDescription, ProgramName,"
                        + "ProjectType, ProjectTypeID, PercentRequired, TotalPlanLocalCurrency, BaseCurrency,BaseCurrencyID, FXRate, AmountRequested as IGAmountRequested "
                        + "FROM InitiativeProject WHERE InitiativeID = @InitiativeID";



        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Project");
  
        ds.Tables["Project"].Columns.Add("TotalPlanEUR",
            System.Type.GetType("System.Decimal"), "TotalPlanLocalCurrency * FXRate");
        
        //31.03.06 -> IGAmountRequested will be stored directlly in a database (new column added)
        //ds.Tables["Project"].Columns.Add("IGAmountRequested", System.Type.GetType("System.Decimal"), "TotalPlanEUR * PercentRequired/100");


        return ds;
    }

    public static DataSet GetProject(int nInitiativeProjectID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT InitiativeProjectID,InitiativeID, ExternalProjectID,ProjectName, ProjectDescription, ProgramName,"
                        + "ProjectType, ProjectTypeID, PercentRequired, TotalPlanLocalCurrency, BaseCurrency,BaseCurrencyID, FXRate,AmountRequested as IGAmountRequested "
                        + "FROM InitiativeProject WHERE InitiativeProjectID = @InitiativeProjectID";



        cmdGetDS.Parameters.Add("@InitiativeProjectID", nInitiativeProjectID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Project");
  

        return ds;
    }

    public static decimal GetProjecTotals(int nInitiativeID, string strTotal)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetTotal = new SqlCommand();
        cmdGetTotal.Connection = dbConnection;

        cmdGetTotal.CommandType = CommandType.Text;

        if(strTotal=="IGAmount")
            cmdGetTotal.CommandText = "SELECT SUM(AmountRequested)as SumTotalIG "
                        + "FROM InitiativeProject WHERE InitiativeID = @InitiativeID";
        else//TotalPlan
            cmdGetTotal.CommandText = "SELECT SUM(TotalPlanLocalCurrency * FXRate) as SumTotalPlanEUR "
                        + "FROM InitiativeProject WHERE InitiativeID = @InitiativeID";



        cmdGetTotal.Parameters.Add("@InitiativeID", nInitiativeID);


        object obj;

        dbConnection.Open();
        obj = cmdGetTotal.ExecuteScalar();
        dbConnection.Close();

        if (obj != DBNull.Value && obj != null)
                return Convert.ToDecimal(obj);

        return 0;

        
    }

    

    public static void InsertInitiativeProject(int nInitiativeID,
	                            string strExternalProjectID,string strProjectName,string strProjectDescription,string strProgramName,
	                            int nProjectTypeID, string strProjectType, 
                                decimal dcAmountRequestedEUROs,decimal dcPercentRequired,decimal dcTotalPlanLocalCurrency,
	                            int nBaseCurrencyID, string strBaseCurrency,decimal dcFXRate)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdInsertInitiativeProject = new SqlCommand();
        cmdInsertInitiativeProject.Connection = dbConnection;

        cmdInsertInitiativeProject.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeProject.CommandText = "spInsertInitiative_SectionJ_Project";

        cmdInsertInitiativeProject.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdInsertInitiativeProject.Parameters.Add("@ExternalProjectID", strExternalProjectID);
        cmdInsertInitiativeProject.Parameters.Add("@ProjectName", strProjectName);
        cmdInsertInitiativeProject.Parameters.Add("@ProjectDescription", strProjectDescription);
        cmdInsertInitiativeProject.Parameters.Add("@ProgramName", strProgramName);
        cmdInsertInitiativeProject.Parameters.Add("@ProjectTypeID", nProjectTypeID);
        cmdInsertInitiativeProject.Parameters.Add("@ProjectType", strProjectType);
        cmdInsertInitiativeProject.Parameters.Add("@AmountRequestedEUROs", dcAmountRequestedEUROs);
        cmdInsertInitiativeProject.Parameters.Add("@PercentRequired", dcPercentRequired);
        cmdInsertInitiativeProject.Parameters.Add("@TotalPlanLocalCurrency", dcTotalPlanLocalCurrency);
        cmdInsertInitiativeProject.Parameters.Add("@BaseCurrencyID", nBaseCurrencyID);
        cmdInsertInitiativeProject.Parameters.Add("@BaseCurrency", strBaseCurrency);
        cmdInsertInitiativeProject.Parameters.Add("@FXRate", dcFXRate);

	

        try
        {
            dbConnection.Open();
            cmdInsertInitiativeProject.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }

    public static void UpdateInitiativeProject(int nProjectID,int nInitiativeID,
                                string strExternalProjectID, string strProjectName, string strProjectDescription, string strProgramName,
                                int nProjectTypeID, string strProjectType,
                                decimal dcAmountRequestedEUROs, decimal dcPercentRequired, decimal dcTotalPlanLocalCurrency,
                                int nBaseCurrencyID, string strBaseCurrency, decimal dcFXRate)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiativeProject = new SqlCommand();
        cmdUpdateInitiativeProject.Connection = dbConnection;

        cmdUpdateInitiativeProject.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiativeProject.CommandText = "spUpdateInitiative_SectionJ_Project";

        cmdUpdateInitiativeProject.Parameters.Add("@InitiativeProjectID", nProjectID);
        cmdUpdateInitiativeProject.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdUpdateInitiativeProject.Parameters.Add("@ExternalProjectID", strExternalProjectID);
        cmdUpdateInitiativeProject.Parameters.Add("@ProjectName", strProjectName);
        cmdUpdateInitiativeProject.Parameters.Add("@ProjectDescription", strProjectDescription);
        cmdUpdateInitiativeProject.Parameters.Add("@ProgramName", strProgramName);
        cmdUpdateInitiativeProject.Parameters.Add("@ProjectTypeID", nProjectTypeID);
        cmdUpdateInitiativeProject.Parameters.Add("@ProjectType", strProjectType);
        cmdUpdateInitiativeProject.Parameters.Add("@AmountRequestedEUROs", dcAmountRequestedEUROs);
        cmdUpdateInitiativeProject.Parameters.Add("@PercentRequired", dcPercentRequired);
        cmdUpdateInitiativeProject.Parameters.Add("@TotalPlanLocalCurrency", dcTotalPlanLocalCurrency);
        cmdUpdateInitiativeProject.Parameters.Add("@BaseCurrencyID", nBaseCurrencyID);
        cmdUpdateInitiativeProject.Parameters.Add("@BaseCurrency", strBaseCurrency);
        cmdUpdateInitiativeProject.Parameters.Add("@FXRate", dcFXRate);



        try
        {
            dbConnection.Open();
            cmdUpdateInitiativeProject.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }


    public static int DeleteInitiativeProject(int nInitiativeProjectID)
    {
        int nRecordsAffected;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdDel = new SqlCommand();
        cmdDel.Connection = dbConnection;

        cmdDel.CommandType = CommandType.StoredProcedure;
        cmdDel.CommandText = "spDeleteInitiative_Project";

        cmdDel.Parameters.Add("@InitiativeProjectID", nInitiativeProjectID);

        try
        {
            dbConnection.Open();
            nRecordsAffected = cmdDel.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {
            nRecordsAffected = -1;
        }
        finally
        {
            dbConnection.Close();
        }

        return nRecordsAffected;


    }

    public static int GetCurrencyNo(string sCurrency)
    {
        int iCurrencyNo;

        //start
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetCurrencyNo = new SqlCommand();
        cmdGetCurrencyNo.Connection = dbConnection;

        cmdGetCurrencyNo.CommandType = CommandType.Text;
        cmdGetCurrencyNo.CommandText = "SELECT ReferenceID as CurrencyNo from Reference where Description = '" + sCurrency + "' and CategoryID = 21 ";


        SqlDataAdapter daCurrencyNo = new SqlDataAdapter(cmdGetCurrencyNo);

        DataSet dsCurrencyNo = new DataSet();

        daCurrencyNo.Fill(dsCurrencyNo, "CurrencyNo");

        DataRow drCurrencyNo = (dsCurrencyNo.Tables["CurrencyNo"].Rows[0]);

        if (drCurrencyNo[0] != DBNull.Value)
        {
            iCurrencyNo = (int)drCurrencyNo[0];
        }
        else
        {
            iCurrencyNo = 0;
        }
        //finish
        return iCurrencyNo;

    }

    public static int GetProjectNo(string sProject)
    {
        int iProjectNo;
        
        //start
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetProjectNo = new SqlCommand();
        cmdGetProjectNo.Connection = dbConnection;

        cmdGetProjectNo.CommandType = CommandType.Text;
        cmdGetProjectNo.CommandText = "SELECT ReferenceID as ProjectNo from Reference where Description = '" + sProject + "' and CategoryID = 20 ";


        SqlDataAdapter daProjectNo = new SqlDataAdapter(cmdGetProjectNo);

        DataSet dsProjectNo = new DataSet();

        daProjectNo.Fill(dsProjectNo, "ProjectNo");

        DataRow drProjectNo = (dsProjectNo.Tables["ProjectNo"].Rows[0]);

        if (drProjectNo[0] != DBNull.Value)
        {
            iProjectNo = (int)drProjectNo[0];
        }
        else
        {
            iProjectNo = 0;
        }
        //finish

        return iProjectNo;
    }
}
