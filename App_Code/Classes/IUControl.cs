using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;

namespace ProjectPortfolio.Classes
{
    public static class UploadTabName
    {
        public const string Initiative  = "Initiative";
        public const string Spend = "Spend";
        public const string Benefit = "Benefits";
        public const string Capex = "Capex";
        public const string Depreciation = "Depreciation";
        public const string BenRec = "BEN Reconciliation";
        public const string StaticData = "Static Data";
        public const string Sponsor = "Sponsors";
        public const string Deliverable = "Deliverables";

    }

    public static class UploadFaultCode
    {
        public const int UnresolvedContacts = -2;
        public const int FatalError = -1;
        public const int InternalError = 0;
        public const int NonFatalError = 1;
        public const int Success = 2;        
    }

    /// <summary>
    /// Summary description for IUControl
    /// </summary>
    public class IUControl
    {

        DataAccess m_DataAccess;
        //AdminBusinessObject admBusObj;
        //DataSet dsProjects;
        //DataSet dsInitiatives;

        IUInitiative initiative;
        
        IUFinancial spend;
        IUFinancial benefit;
        IUFinancial depreciation;
        IUFinancial capex;

        IUBenRec benRec;
        IUStaticData staticData;
        IUSponsor sponsor;
        IUDeliverable deliverable;


        #region Member Variables

        // Upload member variables
        // Global
        int m_UserID;
        string m_LoginDescription;
        string m_Name;
        int m_UploadID;            
        //OleDbConnection m_excelConn;
        #endregion

        #region Constants
        const int lengthenedTimeOut = 180;   //seconds
        #endregion


        #region Properties
        //public OleDbConnection ExcelConn
        //{
        //    get { return m_excelConn; }
        //    set
        //    {
        //        //m_Dirty = true;
        //        m_excelConn = value;
        //    }
        //}
        public int UploadID
        {
            get { return m_UploadID; }
            set
            {
                m_UploadID = value;
            }
        }

        #endregion


        //erw 3 Mar 2009
        public IUControl(int UploadID)
        {
            InitDataAccess();
            m_UploadID = UploadID;
            InstantiateIUObjects(UploadID);
        }
        //JG Feb 2009
        public IUControl(int userID, string loginDescription)
        {
            InitDataAccess();

            m_UserID = userID;
            m_LoginDescription = loginDescription;
        }


        private void InitDataAccess()
        {
            m_DataAccess = new DataAccess();
            m_DataAccess.Initialise("GlobalConnectionString");
        }


        public int Commit()
        {
            return Commit(m_UploadID);
            
        }
        public int Commit(int uploadID)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);

                //ERW 6 jun 2009
                //the commit process sometimes takes >30 seconds, so I increased the timeout
                //temporarily - store the current value, reset to the lengthened value, and 
                // then switch back after executing the proc.
                int currentTimeout = m_DataAccess.CommandTimeout;

                m_DataAccess.CommandTimeout = lengthenedTimeOut;

                val1 = m_DataAccess.ExecuteNonQuery("IU_CommitAll");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));

                m_DataAccess.CommandTimeout = currentTimeout;

                return val1; //(val1 != -1);
            }
            catch (Exception ex)
            {
                throw ex; 
            }
        }


        public  bool Validate()
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

                val1 = m_DataAccess.ExecuteNonQuery("IU_ValidateAll");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));

                return (val1 != -1);
            }
            catch (Exception ex)
            {
                throw ex; 
            }
        }

        public DataSet GetResults(int uploadID)
        { return new DataSet() ; }



        public int GetFaultStatus()
        {
            return GetFaultStatus(m_UploadID);
        }
        public int GetFaultStatus(int uploadID)
        {
            int val1 = 0, val2 = 0;
            m_DataAccess.ClearParameters();

            m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);
            m_DataAccess.AddInOutParameter("@FaultStatus", SqlDbType.Int, val1, 4);

            m_DataAccess.ExecuteNonQuery("IU_GetOverallFaultStatus");
            val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@FaultStatus"));

            return (val2);
        }

        public DataSet GetFaults()
        {
            return GetFaults(m_UploadID);
        }

        public DataSet GetFaults(int uploadID)
        {
            int val1 = 0, val2 = 0;
            m_DataAccess.ClearParameters();

            m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);
            return m_DataAccess.ExecuteDataSet("IU_GetFaultsByUploadID");
        }

        private void InstantiateIUObjects(int UploadID)
        {
            //IU_Initiative
            if (initiative == null)
            {
                initiative = new IUInitiative();
                initiative.UploadID = UploadID;
            }

            //IU_Financial objects
            if (spend == null)
            {
                spend = new IUFinancial(IUFinancial.FinancialTabType.Spend);
                spend.UploadID = UploadID;
            }

            if (benefit == null)
            {
                benefit = new IUFinancial(IUFinancial.FinancialTabType.Benefit);
                benefit.UploadID = UploadID;
            }

            if (depreciation == null)
            {
                depreciation = new IUFinancial(IUFinancial.FinancialTabType.Depreciation);
                depreciation.UploadID = UploadID;
            }

            if (capex == null)
            {
                capex = new IUFinancial(IUFinancial.FinancialTabType.CAPEX);
                capex.UploadID = UploadID;
            }


            //IU_Sponsor
            if (sponsor  == null)
            {
                sponsor = new IUSponsor();
                sponsor.UploadID = UploadID;
            }
            //IU_StaticData
            if (staticData  == null)
            {
                staticData = new IUStaticData();
                staticData.UploadID = UploadID;
            }
            //IU_Deliverable
            if (deliverable   == null)
            {
                deliverable = new IUDeliverable();
                deliverable.UploadID = UploadID;
            }
            //IU_BenRec
            if (benRec  == null)
            {
                benRec = new IUBenRec();
                benRec.UploadID = UploadID;
            }
        }



        public int InitialiseUpload()
        {
            return InitialiseUpload(m_LoginDescription);
        }

        public int InitialiseUpload(string description)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@UserID", DbType.Int32, m_UserID);
                m_DataAccess.AddInParameter("@Description", DbType.String, description);
                m_DataAccess.AddInOutParameter("@UploadID", SqlDbType.Int, val1, 4);

                val1 = m_DataAccess.ExecuteNonQuery("IU_Initialise");
                val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@UploadID"));

                // ERW 12 Feb 2009
                // store the upload ID
                m_UploadID = val2;

                return val2;
            }
            catch (Exception ex)
            {
                throw ex; 
            }
        }


        public void Upload(OleDbConnection excelConn)
        {
            DataSet ds;

            //double check the objects are all created
            InstantiateIUObjects(m_UploadID);

            //try
            //{
                //Initiative
                ds = GetDataSetFromExcelTab(UploadTabName.Initiative, excelConn);
                initiative.PopulateFromDataSet(ds, UploadID);

                //Spend
                ds = GetDataSetFromExcelTab(UploadTabName.Spend, excelConn);
                spend.PopulateFromDataSet(ds, UploadID);

                //Benefit
                ds = GetDataSetFromExcelTab(UploadTabName.Benefit, excelConn);
                benefit.PopulateFromDataSet(ds, UploadID);

                //CAPEX
                ds = GetDataSetFromExcelTab(UploadTabName.Capex, excelConn);
                capex.PopulateFromDataSet(ds, UploadID);

                //Depreciation
                ds = GetDataSetFromExcelTab(UploadTabName.Depreciation, excelConn);
                depreciation.PopulateFromDataSet(ds, UploadID);

                //Sponsor
                ds = GetDataSetFromExcelTab(UploadTabName.Sponsor, excelConn);
                sponsor.PopulateFromDataSet(ds, UploadID);

                //StaticData
                ds = GetDataSetFromExcelTab(UploadTabName.StaticData, excelConn);
                staticData.PopulateFromDataSet(ds, UploadID);

                //BenRec
                ds = GetDataSetFromExcelTab(UploadTabName.BenRec, excelConn);
                benRec.PopulateFromDataSet(ds, UploadID);

                //Deliverable
                ds = GetDataSetFromExcelTab(UploadTabName.Deliverable, excelConn);
                deliverable.PopulateFromDataSet(ds, UploadID);
            //}
            //catch (Exception ex)
            //{ 
                //xxx$ is not a valid name
                //system.exception{system.Data.OleDbException
                //exceptions here are likely to be missing tabs
                 
            //}

        }


        //returns a dataset containing the data that is in the parameter tab, from the parameter Excel Connection
        // the dataset contains a table with the same name as the parameter TabName
        private DataSet GetDataSetFromExcelTab(string TabName, OleDbConnection excelConn)
        {
            DataSet ds;

            // Create new OleDbCommand to return data from worksheet.
            OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [" + TabName + "$]", excelConn);

            // Create new OleDbDataAdapter that is used to build a DataSet
            // based on the preceding SQL SELECT statement.
            OleDbDataAdapter objAdapter1 = new OleDbDataAdapter();
             
            // Pass the Select command to the adapter.
            objAdapter1.SelectCommand = objCmdSelect;

            // Create new DataSet to hold information from the worksheet.
            ds = new DataSet();
             
            // Fill the DataSet with the Initiative information from the worksheet.
            objAdapter1.Fill(ds, TabName);           

            return ds;
        }

        

        public DataSet GetRowsCommitted()
        {
            return GetResults(m_UploadID, false, true) ;
        }

        //call it with true, true to get ALL results
        private DataSet GetResults(int uploadID, Boolean getValidateResults, Boolean getCommitResults)
        {            
            m_DataAccess.ClearParameters();

            m_DataAccess.AddInParameter("@UploadID", DbType.Int32, UploadID);
            m_DataAccess.AddInParameter("@ShowValidateResults", DbType.Boolean, getValidateResults);
            m_DataAccess.AddInParameter("@ShowCommitResults", DbType.Boolean, getCommitResults);
            
            DataSet ds = m_DataAccess.ExecuteDataSet("IU_GetResultsByUploadID", "Results");

            return ds; //(val1 != -1);            
        }


        //erw 18 Mar 2009
        public DataSet GetUnresolvedContacts()
        {
            return GetUnresolvedContacts(m_UploadID);
        }

        public DataSet GetUnresolvedContacts(int uploadID)
        {
            int val1 = 0, val2 = 0;
            m_DataAccess.ClearParameters();

            m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);
            return m_DataAccess.ExecuteDataSet("IU_GetUnresolvedContactsByUploadID");
        }

    }
}