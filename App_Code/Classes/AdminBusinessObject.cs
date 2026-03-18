using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
//**************************************************************************************************************
//      Rev         By          Date            Description
//
//      1.0         JG          09/02/2009      Business Object class Initiative Upload Template Functionality
//
//**************************************************************************************************************


namespace ProjectPortfolio.Classes
{
    /////   ERW 15 Mar 2009
    ///     I don't think this is necessary any more.
    ///
    ///////////////////////
    ///////// <summary>
    ///////// Summary description for AdminBusinessObject
    ///////// </summary>
    //////public class AdminBusinessObject
    //////{
    //////    DataAccess m_dataAccess;

    //////    #region Member Variables
        
    //////    // Upload member variables
    //////    // Global
    //////    int m_UserID;
    //////    string m_LoginDescription;
    //////    string m_Name;
    //////    int m_UploadID;

    //////    // Initiative Worksheet member variables
    //////    string m_PrimarySponsoringArea; 
    //////    string m_OtherSponsoringAreas; 
    //////    string m_BusinessSponsorName;
    //////    string m_BusinessInitiativeManager;
    //////    string m_Region;
    //////    string m_GTOManagingBusinessArea;
    //////    string m_GTOInitiativeManager; 
    //////    string m_FunctionalDomain; 
    //////    string m_MajorApplicationName;
    //////    string m_InitiativeBusinessDrivers;
    //////    string m_InitiativeScopeAndObjectives;
    //////    string m_InitiativeBenefitCalculation;
    //////    string m_StrategicInitiativeInterfaces;
    //////    string m_SmartsourcingComponent;
    //////    string m_ArchitecturalComplianceType;
    //////    string m_ArchitecturalCompliance;
    //////    string m_PaybackPeriod;
    //////    string m_CompletionDate;
    //////    string m_RowCommand; 

    //////    // Initiative Financial Worksheet member variables
    //////    string m_financialCategory;
    //////    string m_catgoryType;
    //////    string m_InitiativeDescription;
    //////    string m_detail;
    //////    string m_owner;
    //////    DateTime m_startDate;
    //////    string m_level9UBR;
    //////    string m_level10UBR;
    //////    decimal m_previousYear;
    //////    decimal m_q1CurrentYear;
    //////    decimal m_q2CurrentYear;
    //////    decimal m_q3CurrentYear;
    //////    decimal m_q4CurrentYear;
    //////    decimal m_q1SubsequentYear;
    //////    decimal m_q2SubsequentYear;
    //////    decimal m_q3SubsequentYear;
    //////    decimal m_q4SubsequentYear;
    //////    decimal m_currentYearPlus2;
    //////    decimal m_currentYearPlus3;
    //////    decimal m_currentYearPlus4;
    //////    decimal m_Total;
    //////    int m_initiativeFinancialID;
    //////    int m_categoryID;
    //////    int m_typeID;
    //////    int m_descriptionID;
    //////    int m_ownerID;
    //////    string m_level9UBRCode;
    //////    string m_level10UBRCode;
    //////    string m_rowType;

    //////    // 
    //////    #endregion

    //////    #region Properties
        
    //////    // Global
    //////    public int UserID
    //////    {
    //////        get { return m_UserID; }
    //////        set
    //////        {
    //////            m_UserID = value;
    //////        }
    //////    }
    //////    public string LoginDescription
    //////    {
    //////        get { return m_LoginDescription; }
    //////        set
    //////        {
    //////            m_LoginDescription = value;
    //////        }
    //////    }
    //////    public string Name
    //////    {
    //////        get { return m_Name; }
    //////        set
    //////        {
    //////            m_Name = value;
    //////        }
    //////    }
    //////    public int UploadID
    //////    {
    //////        get { return m_UploadID; }
    //////        set
    //////        {
    //////            m_UploadID = value;
    //////        }
    //////    }

    //////    // Initiative Tab
    //////    public string PrimarySponsoringArea
    //////    {
    //////        get { return m_PrimarySponsoringArea; }
    //////        set
    //////        {
    //////            m_PrimarySponsoringArea = value;
    //////        }
    //////    }
    //////    public string OtherSponsoringAreas
    //////    {
    //////        get { return m_OtherSponsoringAreas; }
    //////        set
    //////        {
    //////            m_OtherSponsoringAreas = value;
    //////        }
    //////    }
    //////    public string BusinessSponsorName
    //////    {
    //////        get { return m_BusinessSponsorName; }
    //////        set
    //////        {
    //////            m_BusinessSponsorName = value;
    //////        }
    //////    }
    //////    public string BusinessInitiativeManager
    //////    {
    //////        get { return m_BusinessInitiativeManager; }
    //////        set
    //////        {
    //////            m_BusinessInitiativeManager = value;
    //////        }
    //////    }
    //////    public string Region
    //////    {
    //////        get { return m_Region; }
    //////        set
    //////        {
    //////            m_Region = value;
    //////        }
    //////    }
    //////    public string GTOManagingBusinessArea
    //////    {
    //////        get { return m_GTOManagingBusinessArea; }
    //////        set
    //////        {
    //////            m_GTOManagingBusinessArea = value;
    //////        }
    //////    }
    //////    public string GTOInitiativeManager
    //////    {
    //////        get { return m_GTOInitiativeManager; }
    //////        set
    //////        {
    //////            m_GTOInitiativeManager = value;
    //////        }
    //////    }
    //////    public string FunctionalDomain
    //////    {
    //////        get { return m_FunctionalDomain; }
    //////        set
    //////        {
    //////            m_FunctionalDomain = value;
    //////        }
    //////    }
    //////    public string MajorApplicationName
    //////    {
    //////        get { return m_MajorApplicationName; }
    //////        set
    //////        {
    //////            m_MajorApplicationName = value;
    //////        }
    //////    }
    //////    public string InitiativeBusinessDrivers
    //////    {
    //////        get { return m_InitiativeBusinessDrivers; }
    //////        set
    //////        {
    //////            m_InitiativeBusinessDrivers = value;
    //////        }
    //////    }
    //////    public string InitiativeScopeAndObjectives
    //////     {
    //////        get { return m_InitiativeScopeAndObjectives; }
    //////        set
    //////        {
    //////            m_InitiativeScopeAndObjectives = value;
    //////        }
    //////    }
    //////    public string InitiativeBenefitCalculation
    //////    {
    //////        get { return m_InitiativeBenefitCalculation; }
    //////        set
    //////        {
    //////            m_InitiativeBenefitCalculation = value;
    //////        }
    //////    }
    //////    public string StrategicInitiativeInterfaces
    //////    {
    //////        get { return m_StrategicInitiativeInterfaces; }
    //////        set
    //////        {
    //////            m_StrategicInitiativeInterfaces = value;
    //////        }
    //////    }
    //////    public string SmartsourcingComponent
    //////    {
    //////        get { return m_SmartsourcingComponent; }
    //////        set
    //////        {
    //////            m_SmartsourcingComponent = value;
    //////        }
    //////    }
    //////    public string ArchitecturalComplianceType
    //////    {
    //////        get { return m_ArchitecturalComplianceType; }
    //////        set
    //////        {
    //////            m_ArchitecturalComplianceType = value;
    //////        }
    //////    }
    //////    public string ArchitecturalCompliance
    //////    {
    //////        get { return m_ArchitecturalCompliance; }
    //////        set
    //////        {
    //////            m_ArchitecturalCompliance = value;
    //////        }
    //////    }
    //////    public string PaybackPeriod
    //////    {
    //////        get { return m_PaybackPeriod; }
    //////        set
    //////        {
    //////            m_PaybackPeriod = value;
    //////        }
    //////    }
    //////    public string CompletionDate
    //////    {
    //////        get { return m_CompletionDate; }
    //////        set
    //////        {
    //////            m_CompletionDate = value;
    //////        }
    //////    }
    //////    public string RowCommand
    //////    {
    //////        get { return m_RowCommand; }
    //////        set
    //////        {
    //////            m_RowCommand = value;
    //////        }
    //////    }

    //////    // Financial Tabs
    //////    public string FinancialCategory
    //////    {
    //////        get { return m_financialCategory; }
    //////        set
    //////        {
    //////            m_financialCategory = value;
    //////        }
    //////    }
    //////    public string CatgoryType
    //////    {
    //////        get { return m_catgoryType; }
    //////        set
    //////        {
    //////            m_catgoryType = value;
    //////        }
    //////    }
    //////    public string InitiativeDescription
    //////    {
    //////        get { return m_InitiativeDescription; }
    //////        set
    //////        {
    //////            m_InitiativeDescription = value;
    //////        }
    //////    }
    //////    public string Detail
    //////    {
    //////        get { return m_detail; }
    //////        set
    //////        {
    //////            m_detail = value;
    //////        }
    //////    }
    //////    public string Owner
    //////    {
    //////        get { return m_owner; }
    //////        set
    //////        {
    //////            m_owner = value;
    //////        }
    //////    }
    //////    public DateTime StartDate
    //////    {
    //////        get { return m_startDate; }
    //////        set { m_startDate = value; }
    //////    }
    //////    public string Level9UBR
    //////    {
    //////        get { return m_level9UBR; }
    //////        set
    //////        {
    //////            m_level9UBR = value;
    //////        }
    //////    }
    //////    public string Level10UBR
    //////    {
    //////        get { return m_level10UBR; }
    //////        set
    //////        {
    //////            m_level10UBR = value;
    //////        }
    //////    }
    //////    public decimal PreviousYear
    //////    {
    //////        get { return m_previousYear; }
    //////        set
    //////        {
    //////            m_previousYear = value;
    //////        }
    //////    }
    //////    public decimal Q1CurrentYear
    //////    {
    //////        get { return m_q1CurrentYear; }
    //////        set
    //////        {
    //////            m_q1CurrentYear = value;
    //////        }
    //////    }
    //////    public decimal Q2CurrentYear
    //////    {
    //////        get { return m_q2CurrentYear; }
    //////        set
    //////        {
    //////            m_q2CurrentYear = value;
    //////        }
    //////    }
    //////    public decimal Q3CurrentYear
    //////    {
    //////        get { return m_q3CurrentYear; }
    //////        set
    //////        {
    //////            m_q3CurrentYear = value;
    //////        }
    //////    }
    //////    public decimal Q4CurrentYear
    //////    {
    //////        get { return m_q4CurrentYear; }
    //////        set
    //////        {
    //////            m_q4CurrentYear = value;
    //////        }
    //////    }
    //////    public decimal Q1SubsequentYear
    //////    {
    //////        get { return m_q1SubsequentYear; }
    //////        set
    //////        {
    //////            m_q1SubsequentYear = value;
    //////        }
    //////    }
    //////    public decimal Q2SubsequentYear
    //////    {
    //////        get { return m_q2SubsequentYear; }
    //////        set
    //////        {
    //////            m_q2SubsequentYear = value;
    //////        }
    //////    }
    //////    public decimal Q3SubsequentYear
    //////    {
    //////        get { return m_q3SubsequentYear; }
    //////        set
    //////        {
    //////            m_q3SubsequentYear = value;
    //////        }
    //////    }
    //////    public decimal Q4SubsequentYear
    //////    {
    //////        get { return m_q4SubsequentYear; }
    //////        set
    //////        {
    //////            m_q4SubsequentYear = value;
    //////        }
    //////    }
    //////    public decimal CurrentYearPlus2
    //////    {
    //////        get { return m_currentYearPlus2; }
    //////        set
    //////        {
    //////            m_currentYearPlus2 = value;
    //////        }
    //////    }
    //////    public decimal CurrentYearPlus3
    //////    {
    //////        get { return m_currentYearPlus3; }
    //////        set
    //////        {
    //////            m_currentYearPlus3 = value;
    //////        }
    //////    }
    //////    public decimal CurrentYearPlus4
    //////    {
    //////        get { return m_currentYearPlus4; }
    //////        set
    //////        {
    //////            m_currentYearPlus4 = value;
    //////        }
    //////    }
    //////    public decimal Total
    //////    {
    //////        get { return m_Total; }
    //////        set
    //////        {
    //////            m_Total = value;
    //////        }
    //////    }
    //////    public int InitiativeFinancialID
    //////    {
    //////        get { return m_initiativeFinancialID; }
    //////        set
    //////        {
    //////            m_initiativeFinancialID = value;
    //////        }
    //////    }
    //////    public int CategoryID
    //////    {
    //////        get { return m_categoryID; }
    //////        set
    //////        {
    //////            m_categoryID = value;
    //////        }
    //////    }
    //////    public int TypeID
    //////    {
    //////        get { return m_typeID; }
    //////        set
    //////        {
    //////            m_typeID = value;
    //////        }
    //////    }
    //////    public int DescriptionID
    //////    {
    //////        get { return m_descriptionID; }
    //////        set
    //////        {
    //////            m_descriptionID = value;
    //////        }
    //////    }
    //////    public int OwnerID
    //////    {
    //////        get { return m_ownerID; }
    //////        set
    //////        {
    //////            m_ownerID = value;
    //////        }
    //////    }
    //////    public string Level9UBRCode
    //////    {
    //////        get { return m_level9UBRCode; }
    //////        set
    //////        {
    //////            m_level9UBRCode = value;
    //////        }
    //////    }
    //////    public string Level10UBRCode
    //////    {
    //////        get { return m_level10UBRCode; }
    //////        set
    //////        {
    //////            m_level10UBRCode = value;
    //////        }
    //////    }
    //////    public string RowType
    //////    {
    //////        get { return m_rowType; }
    //////        set
    //////        {
    //////            m_rowType = value;
    //////        }
    //////    }
    //////    #endregion


    //////    public AdminBusinessObject()
    //////    {
    //////        m_dataAccess = new DataAccess();
    //////        m_dataAccess.Initialise("GlobalConnectionString");

    //////        m_UserID = 0;
    //////        m_LoginDescription = "";
    //////    }

    //////    public AdminBusinessObject( int userID, string loginDescription)
    //////    {
    //////        m_dataAccess = new DataAccess();
    //////        m_dataAccess.Initialise("GlobalConnectionString");

    //////        m_UserID = userID;
    //////        m_LoginDescription = loginDescription;
    //////    }

    //////    public int InitialiseUpload()
    //////    {
    //////        return InitialiseUpload( m_LoginDescription );
    //////    }

    //////    public int InitialiseUpload( string description )
    //////    {
    //////        try
    //////        {
    //////            int val1 = 0, val2 = 0;
    //////            m_dataAccess.ClearParameters();

    //////            m_dataAccess.AddInParameter("@UserID", DbType.Int32, m_UserID);
    //////            m_dataAccess.AddInParameter("@Description", DbType.String, description);
    //////            m_dataAccess.AddInOutParameter("@_UploadID", SqlDbType.Int, val1, 4);

    //////            val1 = m_dataAccess.ExecuteNonQuery("IU_Initialise");
    //////            val2 = Convert.ToInt32(m_dataAccess.GetParameterValue("@_UploadID"));

    //////            // ERW 12 Feb 2009
    //////            // store the upload ID
    //////            m_UploadID = val2;

    //////            return val2;
    //////        }
    //////        catch (Exception ex)
    //////        {
    //////            throw new Exception(ex.Message, ex);
    //////        }
    //////    }

    //////    public bool UploadInitiativeFinancial()
    //////    {
    //////        return UploadInitiativeFinancial(m_Name, m_financialCategory, m_catgoryType, m_InitiativeDescription, m_detail, m_owner,
    //////                                m_startDate, m_level9UBR, m_level10UBR, m_previousYear, m_q1CurrentYear, m_q2CurrentYear, m_q3CurrentYear,
    //////                                m_q4CurrentYear, m_q1SubsequentYear, m_q2SubsequentYear, m_q3SubsequentYear, m_q4SubsequentYear,
    //////                                m_currentYearPlus2, m_currentYearPlus3, m_currentYearPlus4, m_Total, m_initiativeFinancialID, m_categoryID,
    //////                                m_typeID, m_descriptionID, m_ownerID, m_level9UBRCode, m_level10UBRCode, m_rowType, m_UploadID);
    //////    }

    //////    public bool UploadInitiativeFinancial(  string name, string financialCategory, string catgoryType, string description,
    //////                                   string detail, string owner, DateTime startDate, string level9UBR,
    //////                                   string level10UBR, decimal previousYear, decimal q1CurrentYear, decimal q2CurrentYear,
    //////                                   decimal q3CurrentYear, decimal q4CurrentYear, decimal q1SubsequentYear, decimal q2SubsequentYear,
    //////                                   decimal q3SubsequentYear, decimal q4SubsequentYear, decimal currentYearPlus2, decimal currentYearPlus3, 
    //////                                   decimal currentYearPlus4, decimal Total, int initiativeFinancialID, int categoryID, int typeID,
    //////                                   int descriptionID, int ownerID, string level9UBRCode, string level10UBRCode, string rowType,
    //////                                   int _uploadID
                                    
    //////        )
    //////    {
    //////        try
    //////        {
    //////            int val1 = 0, val2 = 0;
    //////            m_dataAccess.ClearParameters();

    //////            m_dataAccess.AddInParameter("@Name", DbType.String, name );
    //////            m_dataAccess.AddInParameter("@FinancialCategory", DbType.String, financialCategory);
    //////            m_dataAccess.AddInParameter("@CategoryType", DbType.String, catgoryType);
    //////            m_dataAccess.AddInParameter("@Description", DbType.String, description);
    //////            m_dataAccess.AddInParameter("@Detail", DbType.String, detail);
    //////            m_dataAccess.AddInParameter("@Owner", DbType.String, owner);
    //////            m_dataAccess.AddInParameter("@StartDate", DbType.DateTime, startDate);
    //////            m_dataAccess.AddInParameter("@Level9UBR", DbType.String, level9UBR);
    //////            m_dataAccess.AddInParameter("@Level10UBR", DbType.String, level10UBR);
    //////            m_dataAccess.AddInParameter("@PreviousYear", DbType.Decimal, previousYear);
    //////            m_dataAccess.AddInParameter("@Q1CurrentYear", DbType.Decimal, q1CurrentYear);
    //////            m_dataAccess.AddInParameter("@Q2CurrentYear", DbType.Decimal, q2CurrentYear);
    //////            m_dataAccess.AddInParameter("@Q3CurrentYear", DbType.Decimal, q3CurrentYear);
    //////            m_dataAccess.AddInParameter("@Q1SubsequentYear", DbType.Decimal, q1SubsequentYear);
    //////            m_dataAccess.AddInParameter("@Q2SubsequentYear", DbType.Decimal, q2SubsequentYear);
    //////            m_dataAccess.AddInParameter("@Q3SubsequentYear", DbType.Decimal, q3SubsequentYear);
    //////            m_dataAccess.AddInParameter("@Q4SubsequentYear", DbType.Decimal, q4SubsequentYear);
    //////            m_dataAccess.AddInParameter("@CurrentYearPlus2", DbType.Decimal, currentYearPlus2);
    //////            m_dataAccess.AddInParameter("@CurrentYearPlus3", DbType.Decimal, currentYearPlus3);
    //////            m_dataAccess.AddInParameter("@CurrentYearPlus4", DbType.Decimal, currentYearPlus4);
    //////            m_dataAccess.AddInParameter("@Total", DbType.Decimal, Total);
    //////            m_dataAccess.AddInParameter("@InitiativeFinancialID", DbType.Int32, initiativeFinancialID);
    //////            m_dataAccess.AddInParameter("@CategoryID", DbType.Int32, categoryID);
    //////            m_dataAccess.AddInParameter("@TypeD", DbType.Int32, typeID);
    //////            m_dataAccess.AddInParameter("@DescriptionID", DbType.Int32, descriptionID);
    //////            m_dataAccess.AddInParameter("@OwnerID", DbType.Int32, ownerID);
    //////            m_dataAccess.AddInParameter("@Level9UBRCode", DbType.String, level9UBRCode);
    //////            m_dataAccess.AddInParameter("@Level10UBRCode", DbType.String, level10UBRCode);
    //////            m_dataAccess.AddInParameter("@RowType", DbType.String, rowType );
    //////            m_dataAccess.AddInParameter("@_UploadID", DbType.Int32, _uploadID);

    //////            val1 = m_dataAccess.ExecuteNonQuery("IU_UploadFinancial");

    //////            return (val1 != -1);
    //////        }
    //////        catch (Exception ex)
    //////        {
    //////            throw new Exception(ex.Message, ex);
    //////        }        
    //////    }
        
    //////    public bool UploadInitiative()
    //////    {
    //////        return UploadInitiative(m_Name, m_PrimarySponsoringArea, m_OtherSponsoringAreas, m_BusinessSponsorName,
    //////                                m_BusinessInitiativeManager, m_Region, m_GTOManagingBusinessArea, m_GTOInitiativeManager, 
    //////                                m_FunctionalDomain, m_MajorApplicationName, m_InitiativeBusinessDrivers, m_InitiativeScopeAndObjectives,
    //////                                m_InitiativeBenefitCalculation, m_StrategicInitiativeInterfaces, m_SmartsourcingComponent,
    //////                                m_ArchitecturalComplianceType, m_ArchitecturalCompliance, m_PaybackPeriod, m_CompletionDate, 
    //////                                m_RowCommand, m_UploadID);
    //////    }

    //////    public bool UploadInitiative(string name, string primarySponsoringArea, string otherSponsoringAreas, string businessSponsorName,
    //////                                 string businessInitiativeManager, string region, string gtoManagingBusinessArea,
    //////                                 string gtoInitiativeManager, string functionalDomain, string MajorApplicationName,
    //////                                 string initiativeBusinessDrivers, string initiativeScopeAndObjectives, 
    //////                                 string initiativeBenefitCalculation, string StrategicInitiativeInterfaces, string smartsourcingComponent,
    //////                                 string architecturalComplianceType, string architecturalCompliance, string paybackPeriod,
    //////                                 string completionDate, string rowCommand, int _uploadID )
            
    //////    {
    //////        try
    //////        {
    //////            int val1 = 0, val2 = 0;
    //////            m_dataAccess.ClearParameters();

    //////            m_dataAccess.AddInParameter("@Name", DbType.String, name );
    //////            m_dataAccess.AddInParameter("@PrimarySponsoringArea", DbType.String, primarySponsoringArea);
    //////            m_dataAccess.AddInParameter("@OtherSponsoringAreas", DbType.String, otherSponsoringAreas);
    //////            m_dataAccess.AddInParameter("@BusinessSponsorName", DbType.String, businessSponsorName);
    //////            m_dataAccess.AddInParameter("@BusinessInitiativeManager", DbType.String, businessInitiativeManager);
    //////            m_dataAccess.AddInParameter("@Region", DbType.String, region);
    //////            m_dataAccess.AddInParameter("@GTOManagingBusinessArea", DbType.String, gtoManagingBusinessArea);
    //////            m_dataAccess.AddInParameter("@GTOInitiativeManager", DbType.String, gtoInitiativeManager);
    //////            m_dataAccess.AddInParameter("@FunctionalDomain", DbType.String, functionalDomain);
    //////            m_dataAccess.AddInParameter("@MajorApplicationName", DbType.String, MajorApplicationName);
    //////            m_dataAccess.AddInParameter("@InitiativeBusinessDrivers", DbType.String, initiativeBusinessDrivers);
    //////            m_dataAccess.AddInParameter("@InitiativeScopeAndObjectives", DbType.String, initiativeScopeAndObjectives);
    //////            m_dataAccess.AddInParameter("@InitiativeBenefitCalculation", DbType.String, initiativeBenefitCalculation);
    //////            m_dataAccess.AddInParameter("@StrategicInitiativeInterfaces", DbType.String, StrategicInitiativeInterfaces);
    //////            m_dataAccess.AddInParameter("@SmartsourcingComponent", DbType.String, smartsourcingComponent);
    //////            m_dataAccess.AddInParameter("@ArchitecturalComplianceType", DbType.String, architecturalComplianceType);
    //////            m_dataAccess.AddInParameter("@ArchitecturalCompliance", DbType.String, architecturalCompliance);
    //////            m_dataAccess.AddInParameter("@PayBackPeriod", DbType.String, paybackPeriod);
    //////            m_dataAccess.AddInParameter("@CompletionDate", DbType.String, completionDate);
    //////            m_dataAccess.AddInParameter("@RowCommand", DbType.String, rowCommand);
    //////            m_dataAccess.AddInParameter("@_UploadID", DbType.Int32, _uploadID);

    //////            val1 = m_dataAccess.ExecuteNonQuery("IU_UploadInitiative");

    //////            return (val1 != -1);
    //////        }
    //////        catch (Exception ex)
    //////        {
    //////            throw new Exception(ex.Message, ex);
    //////        }        
    //////    }
        
    //////    public bool ValidateInitiative()
    //////    {
    //////        return ValidateInitiative(m_UploadID);
    //////    }
    //////    public bool ValidateInitiative(int uploadID)
    //////    {
    //////        try
    //////        {
    //////            int val1 = 0, val2 = 0;
    //////            m_dataAccess.ClearParameters();

    //////            m_dataAccess.AddInParameter("@_UploadID", DbType.Int32, uploadID);

    //////            val1 = m_dataAccess.ExecuteNonQuery("IU_ValidateInitiative");
    //////     //       val2 = Convert.ToInt32(m_dataAccess.GetParameterValue("@_UploadID"));

    //////            return (val1 != -1);
    //////        }
    //////        catch (Exception ex)
    //////        {
    //////            throw new Exception(ex.Message, ex);
    //////        }
    //////    }
              


    //////    public int GetFaultStatus()
    //////    {
    //////        return GetFaultStatus(m_UploadID);
    //////    }
    //////    public int GetFaultStatus(int uploadID)
    //////    {
    //////        int val1 = 0, val2 = 0;
    //////        m_dataAccess.ClearParameters();

    //////        m_dataAccess.AddInParameter("@_UploadID", DbType.Int32, uploadID);
    //////        m_dataAccess.AddInOutParameter("@FaultStatus", SqlDbType.Int, val1, 4);

    //////        m_dataAccess.ExecuteNonQuery("IU_GetOverallFaultStatus");
    //////        val2 = Convert.ToInt32(m_dataAccess.GetParameterValue("@FaultStatus"));

    //////        return (val2);
    //////    }

    //////    public DataSet GetFaults()
    //////    {
    //////        return GetFaults(m_UploadID);
    //////    }

    //////    public DataSet GetFaults(int uploadID)
    //////    {
    //////        int val1 = 0, val2 = 0;
    //////        m_dataAccess.ClearParameters();

    //////        m_dataAccess.AddInParameter("@_UploadID", DbType.Int32, uploadID);
    //////        return m_dataAccess.ExecuteDataSet("IU_GetFaultsByUploadID");            
    //////    }


    //////    public bool ApplyInitiativeChanges()
    //////    { return ApplyInitiativeChanges(m_UploadID); }
    //////    public bool ApplyInitiativeChanges(int uploadID)
    //////    {
    //////        try
    //////        {
    //////            int val1 = 0, val2 = 0;
    //////            m_dataAccess.ClearParameters();

    //////            m_dataAccess.AddInParameter("@_UploadID", DbType.Int32, uploadID);

    //////            //ERW 24 Feb 2009
    //////            //val1 = m_dataAccess.ExecuteNonQuery("IU_ApplyChangesInitiative");
    //////            val1 = m_dataAccess.ExecuteNonQuery("IU_CommitInitiative");
                
    //////            //       val2 = Convert.ToInt32(m_dataAccess.GetParameterValue("@_UploadID"));

    //////            return (val1 != -1);
    //////        }
    //////        catch (Exception ex)
    //////        {
    //////            throw new Exception(ex.Message, ex);
    //////        }
    //////    }


    //////}

}
