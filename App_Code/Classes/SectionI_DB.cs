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
/// Summary description for SectionI_DB
/// </summary>
public class SectionI_DB
{
    public static DataSet GetRisks(int nInitiativeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT InitiativeRiskID,InitiativeID,RiskCategory,RiskCategoryID,CalculatedRisk,AdjustedRisk, "
                + "EurosAtRisk,Probability "
                + "FROM InitiativeRisk "
                + "WHERE InitiativeID = @InitiativeID";


        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Risk");

        return ds;
    }

    public static DataSet GetTotalRisks(int nInitiativeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT SUM(CalculatedRisk) as TotalCalculated,SUM(AdjustedRisk) as TotalAdjusted, "
                + "SUM(EurosAtRisk) as TotalEuros,"
                +"'TotalProbability' = "
                +" CASE" 
                +" WHEN SUM(AdjustedRisk)<=10 THEN 'Low' "
                +" WHEN SUM(AdjustedRisk)<=20 THEN 'Moderate' "
                +" ELSE 'High' "
                +" END "
                +"FROM InitiativeRisk "
                +"WHERE InitiativeID = @InitiativeID";


        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Total");

        return ds;
    }


    public static DataSet GetRisk(int nInitiativeRiskID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT InitiativeRiskID,InitiativeID,RiskCategory,RiskCategoryID,CalculatedRisk,AdjustedRisk,"
                + "EurosAtRisk,Probability "    
                + "FROM InitiativeRisk "
                + "WHERE InitiativeRiskID = @InitiativeRiskID";


        cmdGetDS.Parameters.Add("@InitiativeRiskID", nInitiativeRiskID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Risk");

       
        return ds;
    }

    public static void InsertInitiativeRisk(int nInitiativeID,
                                int nRiskCategoryID,string strRiskCategory, decimal dcCalculatedRisk,decimal dcAdjustedRisk)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdInsertInitiativeImpact = new SqlCommand();
        cmdInsertInitiativeImpact.Connection = dbConnection;

        cmdInsertInitiativeImpact.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeImpact.CommandText = "spInsertInitiative_SectionI_Risk";


        cmdInsertInitiativeImpact.Parameters.Add("@InitiativeID", nInitiativeID);

        cmdInsertInitiativeImpact.Parameters.Add("@RiskCategoryID", nRiskCategoryID);
        cmdInsertInitiativeImpact.Parameters.Add("@RiskCategory", strRiskCategory);
        cmdInsertInitiativeImpact.Parameters.Add("@CalculatedRisk", dcCalculatedRisk);
        cmdInsertInitiativeImpact.Parameters.Add("@AdjustedRisk", dcAdjustedRisk);



        try
        {
            dbConnection.Open();
            cmdInsertInitiativeImpact.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }

    public static int UpdateInitiative(int nInitiativeID,
                                string strRisksIssuesDeps,string strOverallIGComment)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiative = new SqlCommand();
        cmdUpdateInitiative.Connection = dbConnection;

        cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionI";


        cmdUpdateInitiative.Parameters.Add("@InitiativeID", nInitiativeID);

        cmdUpdateInitiative.Parameters.Add("@RisksIssuesDeps", strRisksIssuesDeps);
        cmdUpdateInitiative.Parameters.Add("@OverallIGComment", strOverallIGComment);


        int nRec = 0;
        try
        {
            dbConnection.Open();
            nRec=cmdUpdateInitiative.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {
            nRec = 0;
        }
        finally
        {
            dbConnection.Close();
        }

        return nRec;
    }

    
    public static void UpdateInitiativeRisk(int nInitiativeRiskID, int nInitiativeID,
                                int nRiskCategoryID, string strRiskCategory, decimal dcCalculatedRisk, decimal dcAdjustedRisk)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiativeImpact = new SqlCommand();
        cmdUpdateInitiativeImpact.Connection = dbConnection;

        cmdUpdateInitiativeImpact.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiativeImpact.CommandText = "spUpdateInitiative_SectionI_Risk";


        cmdUpdateInitiativeImpact.Parameters.Add("@InitiativeRiskID", nInitiativeRiskID);
        cmdUpdateInitiativeImpact.Parameters.Add("@InitiativeID", nInitiativeID);

        cmdUpdateInitiativeImpact.Parameters.Add("@RiskCategoryID", nRiskCategoryID);
        cmdUpdateInitiativeImpact.Parameters.Add("@RiskCategory", strRiskCategory);
        cmdUpdateInitiativeImpact.Parameters.Add("@CalculatedRisk", dcCalculatedRisk);
        cmdUpdateInitiativeImpact.Parameters.Add("@AdjustedRisk", dcAdjustedRisk);



        try
        {
            dbConnection.Open();
            cmdUpdateInitiativeImpact.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }


    public static int DeleteInitiativeRisk(int nInitiativeRiskID)
    {
        int nRecordsAffected;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdDel = new SqlCommand();
        cmdDel.Connection = dbConnection;

        cmdDel.CommandType = CommandType.StoredProcedure;
        cmdDel.CommandText = "spDeleteInitiative_Risk";

        cmdDel.Parameters.Add("@InitiativeRiskID", nInitiativeRiskID);

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
}
