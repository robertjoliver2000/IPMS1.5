using System;
using System.Data;
using System.Data.SqlClient;

using ProjectPortfolio.Classes;

public class Review_SectionF_DB
{
    public static DataSet GetRisks(int nInitiativeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;

        cmdGetDS.CommandText = "SELECT InitiativeRiskID, InitiativeID, RiskCategory, RiskCategoryID, " + 
                                    "CalculatedRisk, EurosAtRisk " + 
                                    "FROM InitiativeRisk " + 
                                    "WHERE InitiativeID = @InitiativeID";

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

        cmdGetDS.CommandText = "SELECT SUM(CalculatedRisk) AS TotalCalculated, " + 
                                    "SUM(EurosAtRisk) AS TotalEuros " + 
                                "FROM InitiativeRisk " + 
                                "WHERE InitiativeID = @InitiativeID";

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


        cmdGetDS.CommandText = "SELECT InitiativeRiskID, InitiativeID, RiskCategory, RiskCategoryID," + 
                                    "CalculatedRisk, EurosAtRisk " + 
                                "FROM InitiativeRisk " + 
                                "WHERE InitiativeRiskID = @InitiativeRiskID";


        cmdGetDS.Parameters.Add("@InitiativeRiskID", nInitiativeRiskID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Risk");


        return ds;
    }

    public static void InsertInitiativeRisk(int nInitiativeID,
                                int nRiskCategoryID, string strRiskCategory, decimal dcCalculatedRisk, decimal dcProjectedOverRun)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdInsertInitiativeImpact = new SqlCommand();
        cmdInsertInitiativeImpact.Connection = dbConnection;

        cmdInsertInitiativeImpact.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeImpact.CommandText = "spInsertInitiative_Review_SectionF_Risk";


        cmdInsertInitiativeImpact.Parameters.Add("@InitiativeID", nInitiativeID);

        cmdInsertInitiativeImpact.Parameters.Add("@RiskCategoryID", nRiskCategoryID);
        cmdInsertInitiativeImpact.Parameters.Add("@RiskCategory", strRiskCategory);
        cmdInsertInitiativeImpact.Parameters.Add("@CalculatedRisk", dcCalculatedRisk);
        cmdInsertInitiativeImpact.Parameters.Add("@ProjectedOverRun", dcProjectedOverRun);

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
                                string strRisksIssuesDeps, string strOverallIGComment)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiative = new SqlCommand();
        cmdUpdateInitiative.Connection = dbConnection;

        cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiative.CommandText = "spUpdateInitiative_Review_SectionF";

        cmdUpdateInitiative.Parameters.Add("@InitiativeID", nInitiativeID);

        cmdUpdateInitiative.Parameters.Add("@RisksIssuesDeps", strRisksIssuesDeps);
        cmdUpdateInitiative.Parameters.Add("@OverallIGComment", strOverallIGComment);


        int nRec = 0;
        try
        {
            dbConnection.Open();
            nRec = cmdUpdateInitiative.ExecuteNonQuery();
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
                                int nRiskCategoryID, string strRiskCategory, decimal dcCalculatedRisk, decimal dcProjectedOverRun)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiativeImpact = new SqlCommand();
        cmdUpdateInitiativeImpact.Connection = dbConnection;

        cmdUpdateInitiativeImpact.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiativeImpact.CommandText = "spUpdateInitiative_Review_SectionF_Risk";

        cmdUpdateInitiativeImpact.Parameters.Add("@InitiativeRiskID", nInitiativeRiskID);
        cmdUpdateInitiativeImpact.Parameters.Add("@InitiativeID", nInitiativeID);

        cmdUpdateInitiativeImpact.Parameters.Add("@RiskCategoryID", nRiskCategoryID);
        cmdUpdateInitiativeImpact.Parameters.Add("@RiskCategory", strRiskCategory);
        cmdUpdateInitiativeImpact.Parameters.Add("@CalculatedRisk", dcCalculatedRisk);
        cmdUpdateInitiativeImpact.Parameters.Add("@ProjectedOverRun", dcProjectedOverRun);

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
