using System;
using System.Data;
using System.Data.SqlClient;

using ProjectPortfolio.Classes;

public class SectionF_DB
{

    public static DataSet GetProducts(int nInitiativeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT InitiativeProductID, InitiativeID,"
                    + "ProductName,TVendor,ProductTypeID,ProductType,"
                    + "CTB_RTBID, CTB_RTB, CIO_IESID, CIO_IES,Remediation FROM InitiativeProduct "
                    + "WHERE InitiativeID = @InitiativeID";


        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Product");


        return ds;
    }

    public static DataSet GetProduct(int nInitiativeID, int nInitiativeProductID, int nTypeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetDS = new SqlCommand();
        cmdGetDS.Connection = dbConnection;

        cmdGetDS.CommandType = CommandType.Text;


        cmdGetDS.CommandText = "SELECT * FROM InitiativeProduct "
                   + "JOIN InitiativeValue ON InitiativeProduct.InitiativeID = InitiativeValue.InitiativeID "
                   + "WHERE InitiativeProduct.InitiativeID = @InitiativeID "
                   + "AND InitiativeProductID = @InitiativeProductID AND InitiativeValue.TypeID=@TypeID";



        cmdGetDS.Parameters.Add("@InitiativeProductID", nInitiativeProductID);
        cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdGetDS.Parameters.Add("@TypeID", nTypeID);

        SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

        DataSet ds = new DataSet();
        da.Fill(ds, "Product");

        return ds;
    }


    public static int InsertInitiativeProduct(int nInitiativeID,
                                        string strProductName, string strTVendor, string strProductType,
                                        string strCTB_RTB, string strCIO_IES,
                                        string strRemediation,
                                        int nProductTypeID, int nCTB_RTBID, int nCIO_IESID)
    {
        int nInitiativeProductID;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdInsertInitiativeProduct = new SqlCommand();
        cmdInsertInitiativeProduct.Connection = dbConnection;

        cmdInsertInitiativeProduct.CommandType = CommandType.StoredProcedure;
        cmdInsertInitiativeProduct.CommandText = "spInsertInitiative_SectionF_Product";


        cmdInsertInitiativeProduct.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdInsertInitiativeProduct.Parameters.Add("@ProductName", strProductName);
        cmdInsertInitiativeProduct.Parameters.Add("@TVendor", strTVendor);
        cmdInsertInitiativeProduct.Parameters.Add("@ProductType", strProductType);
        cmdInsertInitiativeProduct.Parameters.Add("@CTB_RTB", strCTB_RTB);
        cmdInsertInitiativeProduct.Parameters.Add("@CIO_IES", strCIO_IES);
        cmdInsertInitiativeProduct.Parameters.Add("@Remediation", strRemediation);
        cmdInsertInitiativeProduct.Parameters.Add("@ProductTypeID", nProductTypeID);
        cmdInsertInitiativeProduct.Parameters.Add("@CTB_RTBID", nCTB_RTBID);
        cmdInsertInitiativeProduct.Parameters.Add("@CIO_IESID", nCIO_IESID);


        SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
        parmReturnValue.Direction = ParameterDirection.ReturnValue;

        cmdInsertInitiativeProduct.Parameters.Add(parmReturnValue);

        try
        {
            dbConnection.Open();
            cmdInsertInitiativeProduct.ExecuteNonQuery();
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
            nInitiativeProductID = Convert.ToInt32(parmReturnValue.Value);
        }
        else
        {
            nInitiativeProductID = -1;
        }

        return nInitiativeProductID;
    }

    public static void UpdateInitiativeProduct(int nInitiativeProductID, int nInitiativeID,
                                        string strProductName, string strTVendor, string strProductType,
                                        string strCTB_RTB, string strCIO_IES,
                                        string strRemediation,
                                        int nProductTypeID, int nCTB_RTBID, int nCIO_IESID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiativeProduct = new SqlCommand();
        cmdUpdateInitiativeProduct.Connection = dbConnection;

        cmdUpdateInitiativeProduct.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiativeProduct.CommandText = "spUpdateInitiative_SectionF_Product";

        cmdUpdateInitiativeProduct.Parameters.Add("@InitiativeProductID", nInitiativeProductID);

        cmdUpdateInitiativeProduct.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdUpdateInitiativeProduct.Parameters.Add("@ProductName", strProductName);
        cmdUpdateInitiativeProduct.Parameters.Add("@TVendor", strTVendor);
        cmdUpdateInitiativeProduct.Parameters.Add("@ProductType", strProductType);
        cmdUpdateInitiativeProduct.Parameters.Add("@CTB_RTB", strCTB_RTB);
        cmdUpdateInitiativeProduct.Parameters.Add("@CIO_IES", strCIO_IES);
        cmdUpdateInitiativeProduct.Parameters.Add("@Remediation", strRemediation);
        cmdUpdateInitiativeProduct.Parameters.Add("@ProductTypeID", nProductTypeID);
        cmdUpdateInitiativeProduct.Parameters.Add("@CTB_RTBID", nCTB_RTBID);
        cmdUpdateInitiativeProduct.Parameters.Add("@CIO_IESID", nCIO_IESID);



        try
        {
            dbConnection.Open();
            cmdUpdateInitiativeProduct.ExecuteNonQuery();
        }
        catch (SqlException sqlE)
        {

        }
        finally
        {
            dbConnection.Close();
        }
    }

    public static int UpdateInitiative_IESConformity(int nInitiativeID,
            int nIESArchitectureApproverID,
            string strIESArchitectureApprover,
            object dtIESArchitectureApprovalDate,
            int nIESFullyCompliantID,
            string strIESFullyCompliant,
            string strIESFinancialJustification)
    {
        int nRecordsAffected;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdUpdateInitiative = new SqlCommand();
        cmdUpdateInitiative.Connection = dbConnection;

        cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
        cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionF";

        cmdUpdateInitiative.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdUpdateInitiative.Parameters.Add("@IESArchitectureApproverID", nIESArchitectureApproverID);
        cmdUpdateInitiative.Parameters.Add("@IESArchitectureApprover", strIESArchitectureApprover);
        cmdUpdateInitiative.Parameters.Add("@IESArchitectureApprovalDate", dtIESArchitectureApprovalDate);
        cmdUpdateInitiative.Parameters.Add("@IESFullyCompliantID", nIESFullyCompliantID);
        cmdUpdateInitiative.Parameters.Add("@IESFullyCompliant", strIESFullyCompliant);
        cmdUpdateInitiative.Parameters.Add("@IESFinancialJustification", strIESFinancialJustification);


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


    public static DataSet GetImpactValues(int nInitiativeID, int nTypeID)
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


    public static void InsertInitiativeValue(int nInitiativeID, int nInitiativeImpactID,
                                int nPeriodID, int nTypeID, decimal dcAmount)
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
  

    public static int DeleteInitiativeProduct(int nInitiativeID, int nInitiativeProductID, int nTypeID)
    {
        int nRecordsAffected;

        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdDel = new SqlCommand();
        cmdDel.Connection = dbConnection;

        cmdDel.CommandType = CommandType.StoredProcedure;
        cmdDel.CommandText = "spDeleteInitiative_Product";

        cmdDel.Parameters.Add("@InitiativeID", nInitiativeID);
        cmdDel.Parameters.Add("@InitiativeProductID", nInitiativeProductID);
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

