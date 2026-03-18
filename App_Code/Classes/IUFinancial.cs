/*
 * ERW 23 Feb 2009
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
    /// Summary description for IUFinancial
    /// </summary>
    public class IUFinancial : aIUObject
    {
     #region MemberVariables

            int m_UploadID;
            string m_name;
            string m_financialCategory;
            string m_categoryType;
            string m_Description;
            string m_detail;
            string m_owner;
            string m_startDate;
            string m_level9UBR;
           // string m_level10UBR;
            decimal m_previousYear;
            decimal m_q1CurrentYear;
            decimal m_q2CurrentYear;
            decimal m_q3CurrentYear;
            decimal m_q4CurrentYear;
            decimal m_q1SubsequentYear;
            decimal m_q2SubsequentYear;
            decimal m_q3SubsequentYear;
            decimal m_q4SubsequentYear;
            decimal m_currentYearPlus2;
            decimal m_currentYearPlus3;
            decimal m_currentYearPlus4;
            decimal m_Total;
            int m_initiativeFinancialID;
            //int m_categoryID;
            //int m_typeID;
            //int m_descriptionID;
            //int m_ownerID;
            //string m_level9UBRCode;
            //string m_level10UBRCode;
            string m_rowType;
            string m_RowCommand;

            int m_rowsAffected;

            //used internally within IUFinancial; not part of upload
            FinancialTabType m_tabType;


            #endregion

     #region Properties


                public string Name
                {
                    get { return m_name; }
                    set
                    {
                        m_Dirty = true;                    
                        m_name = value;
                    }
                }

                 public int UploadID
                {
                    get { return m_UploadID;  }
                    set
                    {
                        m_Dirty = true;
                        m_UploadID = value;
                    }
                }

                public string FinancialCategory
                {
                    get { return m_financialCategory; }
                    set
                    {
                        m_Dirty = true;
                        m_financialCategory = value;
                    }
                }
                public string CatgoryType
                {
                    get { return m_categoryType; }
                    set
                    {
                        m_Dirty = true;
                        m_categoryType = value;
                    }
                }
                public string Description
                {
                    get { return m_Description; }
                    set
                    {
                        m_Dirty = true;
                        m_Description = value;
                    }
                }
                public string Detail
                {
                    get { return m_detail; }
                    set
                    {
                        m_Dirty = true;
                        m_detail = value;
                    }
                }
                public string Owner
                {
                    get { return m_owner; }
                    set
                    {
                        m_Dirty = true;
                        m_owner = value;
                    }
                }
                public string StartDate
                {
                    get { return m_startDate; }
                    set { m_Dirty = true; m_startDate = value; }
                }
                public string Level9UBR
                {
                    get { return m_level9UBR; }
                    set
                    {
                        m_Dirty = true;
                        m_level9UBR = value;
                    }
                }
                //public string Level10UBR
                //{
                //    get { return m_level10UBR; }
                //    set
                //    {
                //        m_Dirty = true;
                //        m_level10UBR = value;
                //    }
                //}
                public decimal PreviousYear
                {
                    get { return m_previousYear; }
                    set
                    {
                        m_Dirty = true;
                        m_previousYear = value;
                    }
                }
                public decimal Q1CurrentYear
                {
                    get { return m_q1CurrentYear; }
                    set
                    {
                        m_Dirty = true;
                        m_q1CurrentYear = value;
                    }
                }
                public decimal Q2CurrentYear
                {
                    get { return m_q2CurrentYear; }
                    set
                    {
                        m_Dirty = true;
                        m_q2CurrentYear = value;
                    }
                }
                public decimal Q3CurrentYear
                {
                    get { return m_q3CurrentYear; }
                    set
                    {
                        m_Dirty = true;
                        m_q3CurrentYear = value;
                    }
                }
                public decimal Q4CurrentYear
                {
                    get { return m_q4CurrentYear; }
                    set
                    {
                        m_Dirty = true;
                        m_q4CurrentYear = value;
                    }
                }
                public decimal Q1SubsequentYear
                {
                    get { return m_q1SubsequentYear; }
                    set
                    {
                        m_Dirty = true;
                        m_q1SubsequentYear = value;
                    }
                }
                public decimal Q2SubsequentYear
                {
                    get { return m_q2SubsequentYear; }
                    set
                    {
                        m_Dirty = true;
                        m_q2SubsequentYear = value;
                    }
                }
                public decimal Q3SubsequentYear
                {
                    get { return m_q3SubsequentYear; }
                    set
                    {
                        m_Dirty = true;
                        m_q3SubsequentYear = value;
                    }
                }
                public decimal Q4SubsequentYear
                {
                    get { return m_q4SubsequentYear; }
                    set
                    {
                        m_Dirty = true;
                        m_q4SubsequentYear = value;
                    }
                }
                public decimal CurrentYearPlus2
                {
                    get { return m_currentYearPlus2; }
                    set
                    {
                        m_Dirty = true;
                        m_currentYearPlus2 = value;
                    }
                }
                public decimal CurrentYearPlus3
                {
                    get { return m_currentYearPlus3; }
                    set
                    {
                        m_Dirty = true;
                        m_currentYearPlus3 = value;
                    }
                }
                public decimal CurrentYearPlus4
                {
                    get { return m_currentYearPlus4; }
                    set
                    {
                        m_Dirty = true;
                        m_currentYearPlus4 = value;
                    }
                }
                public decimal Total
                {
                    get { return m_Total; }
                    set
                    {
                        m_Dirty = true;
                        m_Total = value;
                    }
                }
                public int InitiativeFinancialID
                {
                    get { return m_initiativeFinancialID; }
                    set
                    {
                        m_Dirty = true;
                        m_initiativeFinancialID = value;
                    }
                }
                public string RowType
                {
                    get { return m_rowType; }
                    set
                    {
                        m_Dirty = true;
                        m_rowType = value;
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

                public int RowsAffected
                {
                    get { return m_rowsAffected; }
                }

            #endregion

     #region Constants & Enums
                
        public enum FinancialTabType  
        {
            Spend
            , Benefit
            , Depreciation
            , CAPEX
        }

        //public static class FinancialTabType
        //{
        //    public const string Spend = "Spend";
        //    public const string Benefit = "Benefit";
        //    public const string Depreciation = "Depreciation";
        //    public const string CAPEX = "CAPEX";
        //}

     #endregion

     #region Private Methods

        // none yet specified

     #endregion  // Private Methods

     #region Public Methods


        public IUFinancial(FinancialTabType TabType)
	    {
            m_tabType = TabType;
            m_rowType = GetRowType(TabType);
	    }

        private string GetRowType(FinancialTabType TabType)
        {
            string rowType;

            switch (TabType)
            {
                case FinancialTabType.Spend:
                    rowType = "Spend";
                    break;
                case FinancialTabType.Benefit:
                    rowType = "Benefit";
                    break;
                case FinancialTabType.Depreciation:
                    rowType = "Depreciation";
                    break;
                case FinancialTabType.CAPEX:
                    rowType = "CAPEX";
                    break;
                default:
                    throw new Exception("");
                    break;
            }

            return rowType; 
        }

        public override bool Update(int ID) 
        { 
            throw new Exception("no implementation - Update");
        }

        //used to be "UploadInitiativeFinancial()"
        public override bool Insert() 
        {
            return Insert(m_name, m_financialCategory, m_categoryType, m_Description, m_detail, m_owner,
                                    m_startDate, m_level9UBR, m_previousYear, m_q1CurrentYear, m_q2CurrentYear, m_q3CurrentYear,
                                    m_q4CurrentYear, m_q1SubsequentYear, m_q2SubsequentYear, m_q3SubsequentYear, m_q4SubsequentYear,
                                    m_currentYearPlus2, m_currentYearPlus3, m_currentYearPlus4, m_Total, m_initiativeFinancialID, 
                                    m_rowType, m_RowCommand, m_UploadID);
        }
       
        public  bool Insert(string name, string financialCategory, string catgoryType, string description,
                                       string detail, string owner, string startDate, string level9UBR,
                                       decimal previousYear, 
                                        decimal q1CurrentYear, decimal q2CurrentYear, decimal q3CurrentYear, decimal q4CurrentYear, 
                                        decimal q1SubsequentYear, decimal q2SubsequentYear, decimal q3SubsequentYear, decimal q4SubsequentYear, 
                                        decimal currentYearPlus2, decimal currentYearPlus3, decimal currentYearPlus4, 
                                        decimal Total, 
                                        int initiativeFinancialID, string rowType, string rowCommand, int _uploadID )
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();
                
                m_DataAccess.AddInParameter("@Name", DbType.String, name);
                m_DataAccess.AddInParameter("@FinancialCategory", DbType.String, financialCategory);
                m_DataAccess.AddInParameter("@CategoryType", DbType.String, catgoryType);
                m_DataAccess.AddInParameter("@Description", DbType.String, description);
                m_DataAccess.AddInParameter("@Detail", DbType.String, detail);
                m_DataAccess.AddInParameter("@Owner", DbType.String, owner);
                m_DataAccess.AddInParameter("@StartDate", DbType.String, startDate);
                m_DataAccess.AddInParameter("@Level9UBR", DbType.String, level9UBR);
                //m_DataAccess.AddInParameter("@Level10UBR", DbType.String, level10UBR);
                m_DataAccess.AddInParameter("@PreviousYear", DbType.Decimal, previousYear);
                m_DataAccess.AddInParameter("@Q1CurrentYear", DbType.Decimal, q1CurrentYear);
                m_DataAccess.AddInParameter("@Q2CurrentYear", DbType.Decimal, q2CurrentYear);
                m_DataAccess.AddInParameter("@Q3CurrentYear", DbType.Decimal, q3CurrentYear);
                m_DataAccess.AddInParameter("@Q4CurrentYear", DbType.Decimal, q4CurrentYear);
                m_DataAccess.AddInParameter("@Q1SubsequentYear", DbType.Decimal, q1SubsequentYear);
                m_DataAccess.AddInParameter("@Q2SubsequentYear", DbType.Decimal, q2SubsequentYear);
                m_DataAccess.AddInParameter("@Q3SubsequentYear", DbType.Decimal, q3SubsequentYear);
                m_DataAccess.AddInParameter("@Q4SubsequentYear", DbType.Decimal, q4SubsequentYear);
                m_DataAccess.AddInParameter("@CurrentYearPlus2", DbType.Decimal, currentYearPlus2);
                m_DataAccess.AddInParameter("@CurrentYearPlus3", DbType.Decimal, currentYearPlus3);
                m_DataAccess.AddInParameter("@CurrentYearPlus4", DbType.Decimal, currentYearPlus4 );
                m_DataAccess.AddInParameter("@Total", DbType.Decimal, Total);
                m_DataAccess.AddInParameter("@InitiativeFinancialID", DbType.Int32, initiativeFinancialID);
                //m_DataAccess.AddInParameter("@CategoryID", DbType.Int32, categoryID);
                //m_DataAccess.AddInParameter("@TypeD", DbType.Int32, typeID);
                //m_DataAccess.AddInParameter("@DescriptionID", DbType.Int32, descriptionID);
                //m_DataAccess.AddInParameter("@OwnerID", DbType.Int32, ownerID);
                //m_DataAccess.AddInParameter("@Level9UBRCode", DbType.String, level9UBRCode);
                //m_DataAccess.AddInParameter("@Level10UBRCode", DbType.String, level10UBRCode);                
                m_DataAccess.AddInParameter("@RowType", DbType.String, rowType);
                m_DataAccess.AddInParameter("@_RowCommand", DbType.String, rowCommand);
                m_DataAccess.AddInParameter("@_UploadID", DbType.Int32, _uploadID);
                 
                val1 = m_DataAccess.ExecuteNonQuery("IU_UploadFinancial");
                
                return (val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }





        public override DataSet Select(int ID) { throw new Exception("no implementation - Select"); }
        public override bool Delete(int ID) { throw new Exception("no implementation - Delete"); }


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

                val1 = m_DataAccess.ExecuteNonQuery("IU_ValidateFinancial");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));

                return (val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

  
        //returns num rows affected
        public override int Commit()
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

                val1 = m_DataAccess.ExecuteNonQuery("IU_CommitFinancial");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));

                return val1; //(val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
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


        





        //consider making this private
        protected override bool PopulateFromDataRow(DataRow dr)
        {    
            switch (m_tabType)
            {
                case FinancialTabType.Benefit:
                    m_name              = dr[0].ToString();
                    m_Description       = dr[1].ToString();
                    m_categoryType      = dr[2].ToString();
                    m_owner             = dr[3].ToString();
                    m_startDate         = dr[4].ToString();
                    m_level9UBR         = dr[5].ToString();

                    m_previousYear      = GetNumericValueFromDataRow (dr, 6);
                    m_q1CurrentYear     = GetNumericValueFromDataRow(dr, 7);
                    m_q2CurrentYear     = GetNumericValueFromDataRow(dr, 8);
                    m_q3CurrentYear     = GetNumericValueFromDataRow(dr, 9);
                    m_q4CurrentYear     = GetNumericValueFromDataRow(dr, 10);
                    m_q1SubsequentYear  = GetNumericValueFromDataRow(dr, 11);
                    m_q2SubsequentYear  = GetNumericValueFromDataRow(dr, 12);
                    m_q3SubsequentYear  = GetNumericValueFromDataRow(dr, 13);
                    m_q4SubsequentYear  = GetNumericValueFromDataRow(dr, 14);
                    m_currentYearPlus2  = GetNumericValueFromDataRow(dr, 15);
                    m_currentYearPlus3  = GetNumericValueFromDataRow(dr, 16);
                    m_currentYearPlus4  = GetNumericValueFromDataRow(dr, 17);
                    m_Total             = GetNumericValueFromDataRow(dr, 18); 

                    m_RowCommand = dr[19].ToString();
                    m_initiativeFinancialID = (int)GetNumericValueFromDataRow(dr, 20);  //dr[20].ToString();
                    break;

                case FinancialTabType.Spend:
                    m_name = dr[0].ToString();
                    m_financialCategory = dr[1].ToString();
                    m_categoryType = dr[2].ToString();
                    m_Description = dr[3].ToString();
                    m_detail = dr[4].ToString();
                    m_startDate = dr[5].ToString();
                    m_level9UBR = dr[6].ToString();

                    m_previousYear = GetNumericValueFromDataRow(dr, 7);
                    m_q1CurrentYear = GetNumericValueFromDataRow(dr, 8);
                    m_q2CurrentYear = GetNumericValueFromDataRow(dr, 9);
                    m_q3CurrentYear = GetNumericValueFromDataRow(dr, 10);
                    m_q4CurrentYear = GetNumericValueFromDataRow(dr, 11);
                    m_q1SubsequentYear = GetNumericValueFromDataRow(dr, 12);
                    m_q2SubsequentYear = GetNumericValueFromDataRow(dr, 13);
                    m_q3SubsequentYear = GetNumericValueFromDataRow(dr, 14);
                    m_q4SubsequentYear = GetNumericValueFromDataRow(dr, 15);
                    m_currentYearPlus2 = GetNumericValueFromDataRow(dr, 16);
                    m_currentYearPlus3 = GetNumericValueFromDataRow(dr, 17);
                    m_currentYearPlus4 = GetNumericValueFromDataRow(dr, 18);
                    m_Total = GetNumericValueFromDataRow(dr, 19);

                    m_RowCommand = dr[20].ToString();
                    m_initiativeFinancialID = (int)GetNumericValueFromDataRow(dr, 21);  //dr[21].ToString();
                    
                    break;

                case FinancialTabType.Depreciation:
                    m_name = dr[0].ToString();
                    m_financialCategory = dr[1].ToString();

                    m_previousYear = GetNumericValueFromDataRow(dr, 2);
                    m_q1CurrentYear = GetNumericValueFromDataRow(dr, 3);
                    m_q2CurrentYear = GetNumericValueFromDataRow(dr, 4);
                    m_q3CurrentYear = GetNumericValueFromDataRow(dr, 5);
                    m_q4CurrentYear = GetNumericValueFromDataRow(dr, 6);
                    m_q1SubsequentYear = GetNumericValueFromDataRow(dr, 7);
                    m_q2SubsequentYear = GetNumericValueFromDataRow(dr, 8);
                    m_q3SubsequentYear = GetNumericValueFromDataRow(dr, 9);
                    m_q4SubsequentYear = GetNumericValueFromDataRow(dr, 10);
                    m_currentYearPlus2 = GetNumericValueFromDataRow(dr, 11);
                    m_currentYearPlus3 = GetNumericValueFromDataRow(dr, 12);
                    m_currentYearPlus4 = GetNumericValueFromDataRow(dr, 13);
                    m_Total = GetNumericValueFromDataRow(dr, 14);

                    m_RowCommand = dr[15].ToString();
                    m_initiativeFinancialID = (int)GetNumericValueFromDataRow(dr, 16);  //dr[16].ToString();
                    break;

                case FinancialTabType.CAPEX:

                    m_name = dr[0].ToString();
                    m_financialCategory  = dr[1].ToString();
                    m_categoryType = dr[2].ToString();
                    m_Description = dr[3].ToString();                    
                    m_detail = dr[4].ToString();
                    m_startDate = dr[5].ToString();
                    m_level9UBR = dr[6].ToString();

                    m_previousYear = GetNumericValueFromDataRow(dr, 7);
                    m_q1CurrentYear = GetNumericValueFromDataRow(dr, 8);
                    m_q2CurrentYear = GetNumericValueFromDataRow(dr, 9);
                    m_q3CurrentYear = GetNumericValueFromDataRow(dr, 10);
                    m_q4CurrentYear = GetNumericValueFromDataRow(dr, 11);
                    m_q1SubsequentYear = GetNumericValueFromDataRow(dr, 12);
                    m_q2SubsequentYear = GetNumericValueFromDataRow(dr, 13);
                    m_q3SubsequentYear = GetNumericValueFromDataRow(dr, 14);
                    m_q4SubsequentYear = GetNumericValueFromDataRow(dr, 15);
                    m_currentYearPlus2 = GetNumericValueFromDataRow(dr, 16);
                    m_currentYearPlus3 = GetNumericValueFromDataRow(dr, 17);
                    m_currentYearPlus4 = GetNumericValueFromDataRow(dr, 18);
                    m_Total = GetNumericValueFromDataRow(dr, 19);

                    m_RowCommand = dr[20].ToString();
                    m_initiativeFinancialID = (int)GetNumericValueFromDataRow(dr, 21);  //dr[21].ToString();

                    break;

                default:
                    throw new Exception ("There is no implementation for row type " + m_rowType);
            }
            

            //insert the data
            return this.Insert();
   
        }

        //ERW 22 Apr 2009
        // be careful using this method - it always returns a value - if it can't set anything, it returns 
        // 0 which is what the upload process currently requires.  However other applications or 
        // amendments to this code one may need a null value to be returned.
        //
        //ERW 27 Dec 2009
        // Returns 0 if it can't convert to a decimal
        // i.e. even if you pass in text, it will still return 0, not throw an error
        //I want the initial upload to succeed wherever possible.  The validation
        //at the database level will catch non-numeric values
        private decimal GetNumericValueFromDataRow(DataRow dr, string ColumnName)
        {
            decimal value;
            value = 0;
                      
            try
            { 
                value = Convert.ToDecimal(dr[ColumnName].ToString().Equals(String.Empty) ? "0" : dr[ColumnName].ToString());
            }
            catch (Exception ex)
            { 
                //always return a 0
                value = 0;
            }

            return value;
            
        }
        private decimal GetNumericValueFromDataRow(DataRow dr, int ColOrdinal)
        {            
            decimal value;
            value = 0;
                       
            try
            {
                value = Convert.ToDecimal(dr[ColOrdinal].ToString().Equals(String.Empty) ? "0" : dr[ColOrdinal].ToString());
            }
            catch (Exception ex)
            {
                //always return a 0, regardless of the cell contents
                value = 0;
            }
              
            return value;            
        }






        // returns a count of successfully uploaded rows, not total rows submitted
        public override int PopulateFromDataSet (DataSet ds, int UploadID)
        {
            m_UploadID = UploadID;

            //ERW - this used to be done this way - now instead I have changed the code below
            // to only begin populating when the index is >2 (i.e. at the third row (for 0 based index)
                // JG Remove unnecessary rows - these are the two header rows on the sheet
                //ds.Tables[0].Rows.RemoveAt(0);
                //ds.Tables[0].Rows.RemoveAt(0);

            int idx = 0 ;  int consecutiveBlankNames = 0;
            string currentName = "", prevName = "";
            int j = 0;

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                // ignore all the header rows - .NET by default seems to ignore the first row
                // since there are four "header" rows in total, this means we need to ignore the next three
                // for zero based idx this is everything above 2
                if (idx > 2)
                {
                    m_name = dr[0].ToString();
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

            #endregion



        #region ExcelCodeCopiedFromWebsite
        /*ERW 24 Feb 2009
         * Read all the sheet names from Excel
         * From http://blog.lab49.com/archives/196
         * 
           OleDbConnection dbConnection = new OleDbConnection (@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\BAR.XLS;Extended Properties=""Excel 8.0;HDR=Yes;&quot;"");
            dbConnection.Open ();
            try
            {
                // Get the name of the first worksheet:
                DataTable dbSchema = dbConnection.GetOleDbSchemaTable (OleDbSchemaGuid.Tables, null);
                if (dbSchema == null || dbSchema.Rows.Count < 1)
                {
                    throw new Exception ("Error: Could not determine the name of the first worksheet.");
                }
                string firstSheetName = dbSchema.Rows [0] ["TABLE_NAME"].ToString ();

                // Now we have the table name; proceed as before:
                OleDbCommand dbCommand = new OleDbCommand ("SELECT * FROM [" + firstSheetName + "]", dbConnection);
                OleDbDataReader dbReader = dbCommand.ExecuteReader ();

                // And so on...
            }
            finally
            {
                dbConnection.Close ();
            }
         */
        #endregion

    }
}

