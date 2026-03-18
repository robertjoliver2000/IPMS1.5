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
/// Summary description for SectionG_DB
/// </summary>
public class SectionG_DB
{
    public static DataSet GetImpacts(int nInitiativeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT InitiativeImpactID, InitiativeID, NonComplianceType," 
                +"AgreedAlternative, CTB_RTB,CIO_CTO,"
                + "Remediation,NonComplianceTypeID,CTB_RTBID,CIO_CTOID FROM InitiativeImpact "
                +"WHERE InitiativeID = @InitiativeID";


        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Impact");


        return ds;
    }

    public static DataSet GetImpact(int nInitiativeID,int nInitiativeImpactID,int nTypeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT * FROM InitiativeImpact "
                    +"JOIN InitiativeValue ON InitiativeImpact.InitiativeID = InitiativeValue.InitiativeID "
                    +"WHERE InitiativeImpact.InitiativeID = @InitiativeID " 
                    +"AND InitiativeImpactID = @InitiativeImpactID AND InitiativeValue.TypeID=@TypeID";



        cmdGetDS.Parameters.Add("@InitiativeImpactID", nInitiativeImpactID);
        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdGetDS.Parameters.Add("@TypeID", nTypeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Impact");

        

        return ds;
    }

    public static int InsertInitiativeImpact(int nInitiativeID,
                                string strNonComplianceType,string strAgreedAlternative,
                                string strCTB_RTB,string strCIO_CTO,string strRemediation,
                                int nNonComplianceTypeID,int nCTB_RTBID,int nCIO_CTOID)
    {

        int nInitiativeImpactID;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdInsertInitiativeImpact = new SqlCommand();
        cmdInsertInitiativeImpact.Connection = dbConnection;

        cmdInsertInitiativeImpact.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeImpact.CommandText = "spInsertInitiative_SectionG_Impact";

           
        cmdInsertInitiativeImpact.Parameters.Add("@InitiativeID", nInitiativeID);       
        cmdInsertInitiativeImpact.Parameters.Add("@NonComplianceType", strNonComplianceType);
        cmdInsertInitiativeImpact.Parameters.Add("@AgreedAlternative", strAgreedAlternative);
        cmdInsertInitiativeImpact.Parameters.Add("@CTB_RTB", strCTB_RTB);
        cmdInsertInitiativeImpact.Parameters.Add("@CIO_CTO", strCIO_CTO);
        cmdInsertInitiativeImpact.Parameters.Add("@Remediation", strRemediation);
        cmdInsertInitiativeImpact.Parameters.Add("@NonComplianceTypeID", nNonComplianceTypeID);
        cmdInsertInitiativeImpact.Parameters.Add("@CTB_RTBID", nCTB_RTBID);
        cmdInsertInitiativeImpact.Parameters.Add("@CIO_CTOID", nCIO_CTOID);



        SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
        parmReturnValue.Direction = ParameterDirection.ReturnValue;

        cmdInsertInitiativeImpact.Parameters.Add(parmReturnValue);


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

        if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
        {
            nInitiativeImpactID = Convert.ToInt32(parmReturnValue.Value);
        }
        else
        {
            nInitiativeImpactID = -1;
        }

        return nInitiativeImpactID;
    }


    public static void InsertInitiativeValue(int nInitiativeID,int nInitiativeImpactID,
                                int nPeriodID,int nTypeID,decimal dcAmount)
                                
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdInsertInitiativeImpact = new SqlCommand();
        cmdInsertInitiativeImpact.Connection = dbConnection;

        cmdInsertInitiativeImpact.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeImpact.CommandText = "spInsertInitiative_SectionG_ImpactValue";


        cmdInsertInitiativeImpact.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdInsertInitiativeImpact.Parameters.Add("@ReferenceID", nInitiativeImpactID);
        cmdInsertInitiativeImpact.Parameters.Add("@PeriodID", nPeriodID);
        cmdInsertInitiativeImpact.Parameters.Add("@TypeID", nTypeID);
        cmdInsertInitiativeImpact.Parameters.Add("@Amount", dcAmount);


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



    public static void UpdateInitiativeImpact(int nInitiativeImpactID,
                                int nInitiativeID, string strNonComplianceType, string strAgreedAlternative,
                                string strCTB_RTB, string strCIO_CTO, string strRemediation,
                                int nNonComplianceTypeID, int nCTB_RTBID, int nCIO_CTOID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiativeImpact = new SqlCommand();
        cmdUpdateInitiativeImpact.Connection = dbConnection;

        cmdUpdateInitiativeImpact.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiativeImpact.CommandText = "spUpdateInitiative_SectionG_Impact";

        cmdUpdateInitiativeImpact.Parameters.Add("@InitiativeImpactID", nInitiativeImpactID);

        cmdUpdateInitiativeImpact.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdUpdateInitiativeImpact.Parameters.Add("@NonComplianceType", strNonComplianceType);
        cmdUpdateInitiativeImpact.Parameters.Add("@AgreedAlternative", strAgreedAlternative);
        cmdUpdateInitiativeImpact.Parameters.Add("@CTB_RTB", strCTB_RTB);
        cmdUpdateInitiativeImpact.Parameters.Add("@CIO_CTO", strCIO_CTO);
        cmdUpdateInitiativeImpact.Parameters.Add("@Remediation", strRemediation);

        cmdUpdateInitiativeImpact.Parameters.Add("@NonComplianceTypeID", nNonComplianceTypeID);
        cmdUpdateInitiativeImpact.Parameters.Add("@CTB_RTBID", nCTB_RTBID);
        cmdUpdateInitiativeImpact.Parameters.Add("@CIO_CTOID", nCIO_CTOID);


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

    public static int UpdateInitiative_CIOConformity(int nInitiativeID,
            int nCIOArchitectureApproverID,
            string strCIOArchitectureApprover,    
            object dtCIOArchitectureApprovalDate,
            int nUsesApproved3rdPartySoftwareID,
            string strUsesApproved3rdPartySoftware,
            int nTechnicalArchitectureCompliantID,
            string strTechnicalArchitectureCompliant,
            int nBusinessArchitectureInfoProvidedID,
            string strBusinessArchitectureInfoProvided,
            int nApplicationArchitetureCompliantID,
            string strApplicationArchitetureCompliant,
            int nTechnicalArchitectureSatisfiedID,
            string strTechnicalArchitectureSatisfied,
            int nDevelopmentArchitectureCompliantID,
            string strDevelopmentArchitectureCompliant,
            string strGTOJustification4Deviation)
    {
        int nRecordsAffected;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiative = new SqlCommand();
        cmdUpdateInitiative.Connection = dbConnection;

        cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionG";

        cmdUpdateInitiative.Parameters.Add("@InitiativeID", nInitiativeID);

        cmdUpdateInitiative.Parameters.Add("@CIOArchitectureApproverID", nCIOArchitectureApproverID);
        cmdUpdateInitiative.Parameters.Add("@CIOArchitectureApprover", strCIOArchitectureApprover);
        cmdUpdateInitiative.Parameters.Add("@CIOArchitectureApprovalDate", dtCIOArchitectureApprovalDate);
        cmdUpdateInitiative.Parameters.Add("@UsesApproved3rdPartySoftwareID", nUsesApproved3rdPartySoftwareID);
        cmdUpdateInitiative.Parameters.Add("@UsesApproved3rdPartySoftware", strUsesApproved3rdPartySoftware);
        cmdUpdateInitiative.Parameters.Add("@TechnicalArchitectureCompliantID", nTechnicalArchitectureCompliantID);
        cmdUpdateInitiative.Parameters.Add("@TechnicalArchitectureCompliant", strTechnicalArchitectureCompliant);
        cmdUpdateInitiative.Parameters.Add("@BusinessArchitectureInfoProvidedID", nBusinessArchitectureInfoProvidedID);
        cmdUpdateInitiative.Parameters.Add("@BusinessArchitectureInfoProvided", strBusinessArchitectureInfoProvided);
        cmdUpdateInitiative.Parameters.Add("@ApplicationArchitetureCompliantID", nApplicationArchitetureCompliantID);
        cmdUpdateInitiative.Parameters.Add("@ApplicationArchitetureCompliant", strApplicationArchitetureCompliant);
        cmdUpdateInitiative.Parameters.Add("@TechnicalArchitectureSatisfiedID", nTechnicalArchitectureSatisfiedID);
        cmdUpdateInitiative.Parameters.Add("@TechnicalArchitectureSatisfied", strTechnicalArchitectureSatisfied);
        cmdUpdateInitiative.Parameters.Add("@DevelopmentArchitectureCompliantID", nDevelopmentArchitectureCompliantID);
        cmdUpdateInitiative.Parameters.Add("@DevelopmentArchitectureCompliant",strDevelopmentArchitectureCompliant );
        cmdUpdateInitiative.Parameters.Add("@GTOJustification4Deviation", strGTOJustification4Deviation);


        try
        {
            dbConnection.Open();
            nRecordsAffected = cmdUpdateInitiative.ExecuteNonQuery();
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


    public static DataSet GetImpactValues(int nInitiativeID,int nTypeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;



        cmdGetDS.CommandText = "SELECT * FROM InitiativeValue "
                    + "WHERE InitiativeID = @InitiativeID AND TypeID=@TypeID";


        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdGetDS.Parameters.Add("@TypeID", nTypeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "ImpactValue");

       

        return ds;
    }

    public static int DeleteInitiativeImpact(int nInitiativeID,int nInitiativeImpactID,int nTypeID)
            
    {
        int nRecordsAffected;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdDel = new SqlCommand();
        cmdDel.Connection = dbConnection;

        cmdDel.CommandType = CommandType.StoredProcedure;
        cmdDel.CommandText = "spDeleteInitiative_Impact";

        cmdDel.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdDel.Parameters.Add("@InitiativeImpactID", nInitiativeImpactID);
        cmdDel.Parameters.Add("@TypeID", nTypeID);

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

