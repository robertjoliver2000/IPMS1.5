/*
	Generated  Mar  3 2009  8:58PM
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
    public class IUStaticData : aIUObject
    {


        #region  MemberVariables

        string m_Name;
        string m_IGApprovalCommittee;
        string m_IGApprovalStatus;
        string m_IGIdentifier;
        string m_IGApprovalDate;
        string m_RTBAdditionalConsumption;
        string m_AlignedToBusinessStrategy;
        string m_InitiativeImpactCategory;
        string m_FirstTimeInitiative;
        string m_InitiativeGTOReviewLevel;
        string m_NonDuplication;
        string m_RowCommand;
        int m_UploadID;

        int m_rowsAffected;

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
        public string IGApprovalCommittee
        {
            get { return m_IGApprovalCommittee; }
            set
            {
                m_Dirty = true;
                m_IGApprovalCommittee = value;
            }
        }
        public string IGApprovalStatus
        {
            get { return m_IGApprovalStatus; }
            set
            {
                m_Dirty = true;
                m_IGApprovalStatus = value;
            }
        }
        public string IGIdentifier
        {
            get { return m_IGIdentifier; }
            set
            {
                m_Dirty = true;
                m_IGIdentifier = value;
            }
        }
        public string IGApprovalDate
        {
            get { return m_IGApprovalDate; }
            set
            {
                m_Dirty = true;
                m_IGApprovalDate = value;
            }
        }
        public string RTBAdditionalConsumption
        {
            get { return m_RTBAdditionalConsumption; }
            set
            {
                m_Dirty = true;
                m_RTBAdditionalConsumption = value;
            }
        }
        public string AlignedToBusinessStrategy
        {
            get { return m_AlignedToBusinessStrategy; }
            set
            {
                m_Dirty = true;
                m_AlignedToBusinessStrategy = value;
            }
        }
        public string InitiativeImpactCategory
        {
            get { return m_InitiativeImpactCategory; }
            set
            {
                m_Dirty = true;
                m_InitiativeImpactCategory = value;
            }
        }
        public string FirstTimeInitiative
        {
            get { return m_FirstTimeInitiative; }
            set
            {
                m_Dirty = true;
                m_FirstTimeInitiative = value;
            }
        }
        public string InitiativeGTOReviewLevel
        {
            get { return m_InitiativeGTOReviewLevel; }
            set
            {
                m_Dirty = true;
                m_InitiativeGTOReviewLevel = value;
            }
        }
        public string NonDuplication
        {
            get { return m_NonDuplication; }
            set
            {
                m_Dirty = true;
                m_NonDuplication = value;
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


        public IUStaticData()
        {

            // 
            // TODO: Add constructor logic here
            //
        }


        public override bool Insert()
        {
            return Insert(
m_Name, m_IGApprovalCommittee, m_IGApprovalStatus, m_IGIdentifier, m_IGApprovalDate, m_RTBAdditionalConsumption, m_AlignedToBusinessStrategy, m_InitiativeImpactCategory, m_FirstTimeInitiative, m_InitiativeGTOReviewLevel, m_NonDuplication, m_RowCommand, m_UploadID);
        }


        public  bool Insert(

                string Name, string IGApprovalCommittee, string IGApprovalStatus, string IGIdentifier, string IGApprovalDate, string RTBAdditionalConsumption, string AlignedToBusinessStrategy, string InitiativeImpactCategory, string FirstTimeInitiative, string InitiativeGTOReviewLevel, string NonDuplication, string RowCommand, int UploadID
)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@Name", DbType.String, Name);
                m_DataAccess.AddInParameter("@IGApprovalCommittee", DbType.String, IGApprovalCommittee);
                m_DataAccess.AddInParameter("@IGApprovalStatus", DbType.String, IGApprovalStatus);
                m_DataAccess.AddInParameter("@IGIdentifier", DbType.String, IGIdentifier);
                m_DataAccess.AddInParameter("@IGApprovalDate", DbType.String, IGApprovalDate);
                m_DataAccess.AddInParameter("@RTBAdditionalConsumption", DbType.String, RTBAdditionalConsumption);
                m_DataAccess.AddInParameter("@AlignedToBusinessStrategy", DbType.String, AlignedToBusinessStrategy);
                m_DataAccess.AddInParameter("@InitiativeImpactCategory", DbType.String, InitiativeImpactCategory);
                m_DataAccess.AddInParameter("@FirstTimeInitiative", DbType.String, FirstTimeInitiative);
                m_DataAccess.AddInParameter("@InitiativeGTOReviewLevel", DbType.String, InitiativeGTOReviewLevel);
                m_DataAccess.AddInParameter("@NonDuplication", DbType.String, NonDuplication);
                m_DataAccess.AddInParameter("@RowCommand", DbType.String, RowCommand);
                m_DataAccess.AddInParameter("@_UploadID", DbType.Int32, UploadID);

                val1 = m_DataAccess.ExecuteNonQuery("IU_UploadStaticData");
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

        public  bool Validate(int uploadID)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);

                val1 = m_DataAccess.ExecuteNonQuery("IU_ValidateStaticData");
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

                val1 = m_DataAccess.ExecuteNonQuery("IU_CommitStaticData");
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
            m_IGApprovalCommittee = dr[1].ToString();
            m_IGApprovalStatus = dr[2].ToString();
            m_IGIdentifier = dr[3].ToString();
            m_IGApprovalDate = dr[4].ToString();
            m_RTBAdditionalConsumption = dr[5].ToString();
            m_AlignedToBusinessStrategy = dr[6].ToString();
            m_InitiativeImpactCategory = dr[7].ToString();
            m_FirstTimeInitiative = dr[8].ToString();
            m_InitiativeGTOReviewLevel = dr[9].ToString();
            m_NonDuplication = dr[10].ToString();
            m_RowCommand = dr[11].ToString();
           


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
