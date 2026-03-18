/*
	Generated  Mar  3 2009  9:16PM
	©Suthco 2009
*/

using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


namespace ProjectPortfolio.Classes
{


    /// <summary>
    /// SummaryDescription 
    /// </summary>
    public class IUInitiative : aIUObject
    {


        #region  MemberVariables

        string m_Name;
        string m_PrimarySponsoringArea;
        string m_OtherSponsoringAreas;
        string m_BusinessSponsorName;
        string m_BusinessInitiativeManager;
        string m_Region;
        string m_GTOManagingBusinessArea;
        string m_GTOInitiativeManager;
        string m_FunctionalDomain;
        string m_MajorApplicationName;
        string m_InitiativeBusinessDrivers;
        string m_InitiativeScopeAndObjectives;
        string m_InitiativeBenefitCalculation;
        string m_StrategicInitiativeInterfaces;
        string m_SmartsourcingComponent;
        string m_ArchitecturalComplianceType;
        string m_ArchitecturalCompliance;
        string m_PayBackPeriod;
        string m_CompletionDate;
        string m_RowCommand;
        int m_UploadID;

        #endregion // MemberVariables

        #region  Properties

        public string Name
        {
            get { return m_Name; }
            set
            {
                m_Dirty = true;
                m_Name = value;
            }
        }
        public string PrimarySponsoringArea
        {
            get { return m_PrimarySponsoringArea; }
            set
            {
                m_Dirty = true;
                m_PrimarySponsoringArea = value;
            }
        }
        public string OtherSponsoringAreas
        {
            get { return m_OtherSponsoringAreas; }
            set
            {
                m_Dirty = true;
                m_OtherSponsoringAreas = value;
            }
        }
        public string BusinessSponsorName
        {
            get { return m_BusinessSponsorName; }
            set
            {
                m_Dirty = true;
                m_BusinessSponsorName = value;
            }
        }
        public string BusinessInitiativeManager
        {
            get { return m_BusinessInitiativeManager; }
            set
            {
                m_Dirty = true;
                m_BusinessInitiativeManager = value;
            }
        }
        public string Region
        {
            get { return m_Region; }
            set
            {
                m_Dirty = true;
                m_Region = value;
            }
        }
        public string GTOManagingBusinessArea
        {
            get { return m_GTOManagingBusinessArea; }
            set
            {
                m_Dirty = true;
                m_GTOManagingBusinessArea = value;
            }
        }
        public string GTOInitiativeManager
        {
            get { return m_GTOInitiativeManager; }
            set
            {
                m_Dirty = true;
                m_GTOInitiativeManager = value;
            }
        }
        public string FunctionalDomain
        {
            get { return m_FunctionalDomain; }
            set
            {
                m_Dirty = true;
                m_FunctionalDomain = value;
            }
        }
        public string MajorApplicationName
        {
            get { return m_MajorApplicationName; }
            set
            {
                m_Dirty = true;
                m_MajorApplicationName = value;
            }
        }
        public string InitiativeBusinessDrivers
        {
            get { return m_InitiativeBusinessDrivers; }
            set
            {
                m_Dirty = true;
                m_InitiativeBusinessDrivers = value;
            }
        }
        public string InitiativeScopeAndObjectives
        {
            get { return m_InitiativeScopeAndObjectives; }
            set
            {
                m_Dirty = true;
                m_InitiativeScopeAndObjectives = value;
            }
        }
        public string InitiativeBenefitCalculation
        {
            get { return m_InitiativeBenefitCalculation; }
            set
            {
                m_Dirty = true;
                m_InitiativeBenefitCalculation = value;
            }
        }
        public string StrategicInitiativeInterfaces
        {
            get { return m_StrategicInitiativeInterfaces; }
            set
            {
                m_Dirty = true;
                m_StrategicInitiativeInterfaces = value;
            }
        }
        public string SmartsourcingComponent
        {
            get { return m_SmartsourcingComponent; }
            set
            {
                m_Dirty = true;
                m_SmartsourcingComponent = value;
            }
        }
        public string ArchitecturalComplianceType
        {
            get { return m_ArchitecturalComplianceType; }
            set
            {
                m_Dirty = true;
                m_ArchitecturalComplianceType = value;
            }
        }
        public string ArchitecturalCompliance
        {
            get { return m_ArchitecturalCompliance; }
            set
            {
                m_Dirty = true;
                m_ArchitecturalCompliance = value;
            }
        }
        public string PayBackPeriod
        {
            get { return m_PayBackPeriod; }
            set
            {
                m_Dirty = true;
                m_PayBackPeriod = value;
            }
        }
        public string CompletionDate
        {
            get { return m_CompletionDate; }
            set
            {
                m_Dirty = true;
                m_CompletionDate = value;
            }
        }
        public string RowCommand
        {
            get { return m_RowCommand; }
            set
            {
                m_Dirty = true;
                m_RowCommand = value;
            }
        }
        public int UploadID
        {
            get { return m_UploadID; }
            set
            {
                m_Dirty = true;
                m_UploadID = value;
            }
        }

        int m_rowsAffected;
        public int RowsAffected
        {
            get { return m_rowsAffected; }
        }

        #endregion // Properties

        #region  Constants&Enums

        #endregion // Constants&Enums

        #region  PrivateMethods

        #endregion // PrivateMethods

        #region  PublicMethods


        public IUInitiative()
        {

            // 
            // TODO: Add constructor logic here
            //
        }


        public override bool Insert()
        {
            return Insert(
m_Name, m_PrimarySponsoringArea, m_OtherSponsoringAreas, m_BusinessSponsorName, m_BusinessInitiativeManager, m_Region, m_GTOManagingBusinessArea, m_GTOInitiativeManager, m_FunctionalDomain, m_MajorApplicationName, m_InitiativeBusinessDrivers, m_InitiativeScopeAndObjectives, m_InitiativeBenefitCalculation, m_StrategicInitiativeInterfaces, m_SmartsourcingComponent, m_ArchitecturalComplianceType, m_ArchitecturalCompliance, m_PayBackPeriod, m_CompletionDate, m_RowCommand, m_UploadID);
        }


        public bool Insert(

                string Name, string PrimarySponsoringArea, string OtherSponsoringAreas, string BusinessSponsorName, string BusinessInitiativeManager, string Region, string GTOManagingBusinessArea, string GTOInitiativeManager, string FunctionalDomain, string MajorApplicationName, string InitiativeBusinessDrivers, string InitiativeScopeAndObjectives, string InitiativeBenefitCalculation, string StrategicInitiativeInterfaces, string SmartsourcingComponent, string ArchitecturalComplianceType, string ArchitecturalCompliance, string PayBackPeriod, string CompletionDate, string RowCommand, int UploadID
)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@Name", DbType.String, Name);
                m_DataAccess.AddInParameter("@PrimarySponsoringArea", DbType.String, PrimarySponsoringArea);
                m_DataAccess.AddInParameter("@OtherSponsoringAreas", DbType.String, OtherSponsoringAreas);
                m_DataAccess.AddInParameter("@BusinessSponsorName", DbType.String, BusinessSponsorName);
                m_DataAccess.AddInParameter("@BusinessInitiativeManager", DbType.String, BusinessInitiativeManager);
                m_DataAccess.AddInParameter("@Region", DbType.String, Region);
                m_DataAccess.AddInParameter("@GTOManagingBusinessArea", DbType.String, GTOManagingBusinessArea);
                m_DataAccess.AddInParameter("@GTOInitiativeManager", DbType.String, GTOInitiativeManager);
                m_DataAccess.AddInParameter("@FunctionalDomain", DbType.String, FunctionalDomain);
                m_DataAccess.AddInParameter("@MajorApplicationName", DbType.String, MajorApplicationName);
                m_DataAccess.AddInParameter("@InitiativeBusinessDrivers", DbType.String, InitiativeBusinessDrivers);
                m_DataAccess.AddInParameter("@InitiativeScopeAndObjectives", DbType.String, InitiativeScopeAndObjectives);
                m_DataAccess.AddInParameter("@InitiativeBenefitCalculation", DbType.String, InitiativeBenefitCalculation);
                m_DataAccess.AddInParameter("@StrategicInitiativeInterfaces", DbType.String, StrategicInitiativeInterfaces);
                m_DataAccess.AddInParameter("@SmartsourcingComponent", DbType.String, SmartsourcingComponent);
                m_DataAccess.AddInParameter("@ArchitecturalComplianceType", DbType.String, ArchitecturalComplianceType);
                m_DataAccess.AddInParameter("@ArchitecturalCompliance", DbType.String, ArchitecturalCompliance);
                m_DataAccess.AddInParameter("@PayBackPeriod", DbType.String, PayBackPeriod);
                m_DataAccess.AddInParameter("@CompletionDate", DbType.String, CompletionDate);
                m_DataAccess.AddInParameter("@RowCommand", DbType.String, RowCommand);
                m_DataAccess.AddInParameter("@_UploadID", DbType.Int32, UploadID);

                val1 = m_DataAccess.ExecuteNonQuery("IU_UploadInitiative");
                return (val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public override bool Update(int ID)
        {
            throw new Exception("no implementation - Update");
        }

        public override DataSet Select(int ID)
        {
            throw new Exception("no implementation - Select");
        }

        public override bool Delete(int ID)
        {
            throw new Exception("no implementation - Delete");
        }

        public override bool Validate()
        {
            return Validate(m_UploadID);
        }

        public bool Validate(int uploadID)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);

                val1 = m_DataAccess.ExecuteNonQuery("IU_ValidateInitiative");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));

                return (val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public override int Commit() { return Commit(m_UploadID); }

        public int Commit(int uploadID)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);

                val1 = m_DataAccess.ExecuteNonQuery("IU_CommitInitiative");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));

                return val1; //(val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        // returns a count of successfully uploaded rows, not total rows submitted
        protected override bool PopulateFromDataRow(DataRow dr)
        {
            m_Name = dr[0].ToString();
            m_PrimarySponsoringArea = dr[1].ToString();
            m_OtherSponsoringAreas = dr[2].ToString();
            m_BusinessSponsorName = dr[3].ToString();
            m_BusinessInitiativeManager = dr[4].ToString();
            m_Region = dr[5].ToString();
            m_GTOManagingBusinessArea = dr[6].ToString();
            m_GTOInitiativeManager = dr[7].ToString();
            m_FunctionalDomain = dr[8].ToString();
            m_MajorApplicationName = dr[9].ToString();
            m_InitiativeBusinessDrivers = dr[10].ToString();
            m_InitiativeScopeAndObjectives = dr[11].ToString();
            m_InitiativeBenefitCalculation = dr[12].ToString();
            m_StrategicInitiativeInterfaces = dr[13].ToString();
            m_SmartsourcingComponent = dr[14].ToString();
            m_ArchitecturalComplianceType = dr[15].ToString();
            m_ArchitecturalCompliance = dr[16].ToString();
            m_PayBackPeriod = dr[17].ToString();
            m_CompletionDate = dr[18].ToString();
            m_RowCommand = dr[19].ToString();
            


            //insert the data 
            return this.Insert();
        }

        // returns a count of successfully uploaded rows, not total rows submitted
        public override int PopulateFromDataSet(DataSet ds, int UploadID)
        {
            m_UploadID = UploadID;

            //ERW - this used to be done this way - now instead I have changed the code below
            // to only begin populating when the index is >2 (i.e. at the third row (for 0 based index)
            // JG Remove unnecessary rows - these are the two header rows on the sheet
            //ds.Tables[0].Rows.RemoveAt(0);
            //ds.Tables[0].Rows.RemoveAt(0);

            int idx = 0; int consecutiveBlankNames = 0;
            string currentName = "", prevName = "";
            int j = 0;

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                // ignore all the header rows - .NET by default seems to ignore the first row
                // since there are four "header" rows in total, this means we need to ignore the next three
                // for zero based idx this is everything above 2
                if (idx > 2)
                {
                    m_Name = dr[0].ToString();
                    currentName = dr[0].ToString();

                    // logic to detect end of spreadsheet
                    // detects consecutive blank Name cells
                    if (currentName.Equals(String.Empty))
                    {
                        if (currentName == prevName) ++consecutiveBlankNames;

                        if (consecutiveBlankNames > 20)
                            break;
                    }
                    else
                    { // only attempt to load it if the InitiativeName is non blank
                        if (this.PopulateFromDataRow(dr))
                        {
                            j++;
                        }
                    }

                    prevName = currentName;
                }
                ++idx;
            }

            m_rowsAffected = j;

            return j;
        }














        //returns the fault status as int
        public override int GetMyFaultStatus()
        {
            return GetMyFaultStatus(m_UploadID);
        }
        public int GetMyFaultStatus(int uploadID)
        {
            int val1 = 0, val2 = 0;
            m_DataAccess.ClearParameters();

            m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);
            m_DataAccess.AddInOutParameter("@FaultStatus", SqlDbType.Int, val1, 4);

            m_DataAccess.ExecuteNonQuery("IU_GetOverallFaultStatus");
            val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@FaultStatus"));

            return (val2);
        }

        public override DataSet GetAllFaults()
        {
            return GetAllFaults(m_UploadID);
        }
        public DataSet GetAllFaults(int uploadID)
        {
            int val1 = 0, val2 = 0;
            m_DataAccess.ClearParameters();

            m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);
            return m_DataAccess.ExecuteDataSet("IU_GetFaultsByUploadID");
        }

        //no implementation
        public override DataSet GetMyFaults()
        {
            DataSet ds;
            throw new Exception("no implementation for GetMyFaults");
        }





        #endregion // PublicMethods

    }
}
