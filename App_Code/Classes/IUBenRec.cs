/*
	Generated  Mar  3 2009  4:48PM
	©HCSCodeGen
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
    public class IUBenRec : aIUObject
    {

        #region  MemberVariables

        string m_Name;
        string m_ProjectID;
        string m_ProjectName;
        string m_ProgramName;
        string m_ProjectType;
        string m_TotalPlanCurrentyearEUR;
        string m_TotalPlanCurrentYearLocalCurrency;
        string m_BaseCurrency;
        string m_FXRate;
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
        public string ProjectID
        {
            get { return m_ProjectID; }
            set
            {
                m_Dirty = true;
                m_ProjectID = value;
            }
        }
        public string ProjectName
        {
            get { return m_ProjectName; }
            set
            {
                m_Dirty = true;
                m_ProjectName = value;
            }
        }
        public string ProgramName
        {
            get { return m_ProgramName; }
            set
            {
                m_Dirty = true;
                m_ProgramName = value;
            }
        }
        public string ProjectType
        {
            get { return m_ProjectType; }
            set
            {
                m_Dirty = true;
                m_ProjectType = value;
            }
        }
        public string TotalPlanCurrentyearEUR
        {
            get { return m_TotalPlanCurrentyearEUR; }
            set
            {
                m_Dirty = true;
                m_TotalPlanCurrentyearEUR = value;
            }
        }
        public string TotalPlanCurrentYearLocalCurrency
        {
            get { return m_TotalPlanCurrentYearLocalCurrency; }
            set
            {
                m_Dirty = true;
                m_TotalPlanCurrentYearLocalCurrency = value;
            }
        }
        public string BaseCurrency
        {
            get { return m_BaseCurrency; }
            set
            {
                m_Dirty = true;
                m_BaseCurrency = value;
            }
        }
        public string FXRate
        {
            get { return m_FXRate; }
            set
            {
                m_Dirty = true;
                m_FXRate = value;
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
        //public int _ProjectTypeID
        //{
        //    get { return m__ProjectTypeID; }
        //    set
        //    {
        //        m_Dirty = true;
        //        m__ProjectTypeID = value;
        //    }
        //}
        //public int _BaseCurrencyID
        //{
        //    get { return m__BaseCurrencyID; }
        //    set
        //    {
        //        m_Dirty = true;
        //        m__BaseCurrencyID = value;
        //    }
        //}
        public int UploadID
        {
            get { return m_UploadID; }
            set
            {
                m_Dirty = true;
                m_UploadID = value;
            }
        }
        //public int _InitiativeID
        //{
        //    get { return m__InitiativeID; }
        //    set 
        //    {
        //        m_Dirty = true;
        //        m__InitiativeID = value;
        //    }
        //}
        //public bool _NewFlag
        //{
        //    get { return m__NewFlag; }
        //    set 
        //    {
        //        m_Dirty = true;
        //        m__NewFlag = value;
        //    }
        //}
        //public bool _Validated
        //{
        //    get { return m__Validated; }
        //    set 
        //    {
        //        m_Dirty = true;
        //        m__Validated = value;
        //    }
        //}
        //public bool _IsValid
        //{
        //    get { return m__IsValid; }
        //    set 
        //    {
        //        m_Dirty = true;
        //        m__IsValid = value;
        //    }
        //}
        //public bool _Committed
        //{
        //    get { return m__Committed; }
        //    set 
        //    {
        //        m_Dirty = true;
        //        m__Committed = value;
        //    }
        //}
        //public string _Fault
        //{
        //    get { return m__Fault; }
        //    set 
        //    {
        //        m_Dirty = true;
        //        m__Fault = value;
        //    }
        //}
        //public int _FaultCount
        //{
        //    get { return m__FaultCount; }
        //    set 
        //    {
        //        m_Dirty = true;
        //        m__FaultCount = value;
        //    }
        //}
        
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

        public IUBenRec()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public override bool Insert()
        {
            return Insert(m_Name, m_ProjectID, m_ProjectName, m_ProgramName, m_ProjectType, m_TotalPlanCurrentyearEUR, m_TotalPlanCurrentYearLocalCurrency, m_BaseCurrency, m_FXRate, m_RowCommand, m_UploadID);
        }


        public bool Insert(string Name, string ProjectID, string ProjectName,
                                        string ProgramName, string ProjectType, string TotalPlanCurrentyearEUR,
                                        string TotalPlanCurrentYearLocalCurrency, string BaseCurrency,
                                        string FXRate, string RowCommand, int _UploadID)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();


                m_DataAccess.AddInParameter("@Name", DbType.String, Name);
                m_DataAccess.AddInParameter("@ProjectID", DbType.String, ProjectID);
                m_DataAccess.AddInParameter("@ProjectName", DbType.String, ProjectName);
                m_DataAccess.AddInParameter("@ProgramName", DbType.String, ProgramName);
                m_DataAccess.AddInParameter("@ProjectType", DbType.String, ProjectType);
                m_DataAccess.AddInParameter("@TotalPlanCurrentyearEUR", DbType.String, TotalPlanCurrentyearEUR);
                m_DataAccess.AddInParameter("@TotalPlanCurrentYearLocalCurrency", DbType.String, TotalPlanCurrentYearLocalCurrency);
                m_DataAccess.AddInParameter("@BaseCurrency", DbType.String, BaseCurrency);
                m_DataAccess.AddInParameter("@FXRate", DbType.String, FXRate);
                m_DataAccess.AddInParameter("@RowCommand", DbType.String, RowCommand);
                m_DataAccess.AddInParameter("@_UploadID", DbType.Int32, _UploadID);


                val1 = m_DataAccess.ExecuteNonQuery("IU_UploadBenRec");
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

                val1 = m_DataAccess.ExecuteNonQuery("IU_ValidateBenRec");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));

                return (val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }


        public override int Commit()
        {
            return Commit(m_UploadID);
        }
        public  int Commit(int uploadID)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);

                val1 = m_DataAccess.ExecuteNonQuery("IU_CommitBenRec");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));

                return val1; //(val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        //consider making this private
        protected override bool PopulateFromDataRow(DataRow dr)
        {            
            m_Name = dr[0].ToString();
            m_ProjectID = dr[1].ToString();
            m_ProjectName = dr[2].ToString();
            m_ProgramName = dr[3].ToString();
            m_ProjectType = dr[4].ToString();
            m_TotalPlanCurrentyearEUR = dr[5].ToString();

            m_TotalPlanCurrentYearLocalCurrency = dr[6].ToString();
            m_BaseCurrency = dr[7].ToString();
            m_FXRate = dr[8].ToString();
            m_RowCommand = dr[9].ToString();
            
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
