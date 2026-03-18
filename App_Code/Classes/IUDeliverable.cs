/*
	Generated  Mar  3 2009  9:11PM
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
    public class IUDeliverable : aIUObject
    {


        #region  MemberVariables

        string m_Name;
        string m_DeliverableDescription;
        string m_DueDate;
        string m_Cost;
        string m_AffectedApplications;
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
        public string DeliverableDescription
        {
            get { return m_DeliverableDescription; }
            set
            {
                m_Dirty = true;
                m_DeliverableDescription = value;
            }
        }
        public string DueDate
        {
            get { return m_DueDate; }
            set
            {
                m_Dirty = true;
                m_DueDate = value;
            }
        }
        public string Cost
        {
            get { return m_Cost; }
            set
            {
                m_Dirty = true;
                m_Cost = value;
            }
        }
        public string AffectedApplications
        {
            get { return m_AffectedApplications; }
            set
            {
                m_Dirty = true;
                m_AffectedApplications = value;
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


        public IUDeliverable()
        {

            // 
            // TODO: Add constructor logic here
            //
        }


        public override bool Insert()
        {
            return Insert(
m_Name, m_DeliverableDescription, m_DueDate, m_Cost, m_AffectedApplications, m_RowCommand, m_UploadID);
        }


        public  bool Insert(

                string Name, string DeliverableDescription, string DueDate, string Cost, string AffectedApplications, string RowCommand, int UploadID
)
        {
            try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@Name", DbType.String, Name);
                m_DataAccess.AddInParameter("@DeliverableDescription", DbType.String, DeliverableDescription);
                m_DataAccess.AddInParameter("@DueDate", DbType.String, DueDate);
                m_DataAccess.AddInParameter("@Cost", DbType.String, Cost);
                m_DataAccess.AddInParameter("@AffectedApplications", DbType.String, AffectedApplications);
                m_DataAccess.AddInParameter("@RowCommand", DbType.String, RowCommand);
                m_DataAccess.AddInParameter("@_UploadID", DbType.Int32, UploadID);

                val1 = m_DataAccess.ExecuteNonQuery("IU_UploadDeliverable");
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

                val1 = m_DataAccess.ExecuteNonQuery("IU_ValidateDeliverable");
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

                val1 = m_DataAccess.ExecuteNonQuery("IU_CommitDeliverable");
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
            m_DeliverableDescription = dr[1].ToString();
            m_DueDate = dr[2].ToString();
            m_Cost = dr[3].ToString();
            m_AffectedApplications = dr[4].ToString();
            //this is not accidental - RowCommand is in column F -> 6
            m_RowCommand = dr[6].ToString();
          

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
