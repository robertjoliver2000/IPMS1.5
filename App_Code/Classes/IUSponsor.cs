/*
	Generated  Mar  3 2009  8:10PM
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
	public class IUSponsor : aIUObject 
	{ 

 
	#region  MemberVariables 
 
		string m_Name;
		string m_InitiativeBudgeted;
		string m_AllocationsAgreed;
		string m_BasisForAllocation;
		string m_BasisForAllocationDescription;
		string m_SponsAllocBusinessGM;
		string m_SponsAllocBusinessGB_GCF;
		string m_SponsAllocBusinessGB_GTB;
		string m_SponsAllocBusinessPBC;
		string m_SponsAllocBusinessPWM;
		string m_SponsAllocBusinessAM;
		string m_SponsAllocBusinessCA_S;
		string m_SponsAllocBusinessCI;
		string m_SponsAllocGTOIB_IT;
		string m_SponsAllocGTOIB_OPS;
		string m_SponsAllocGTOPCB_ITO;
		string m_SponsAllocGTOAM_ITO;
		string m_SponsAllocGTOSOM_OPS;
		string m_SponsAllocGTOIES;
		string m_SponsAllocGTOOTH;
		string m_SponsAllocCFFINANCE;
		string m_SponsAllocCFRISK_TREAS;
		string m_SponsAllocCFCOMP_LEG;
		string m_SponsAllocCFHR;
		string m_SponsAllocCFGM_TMG;
		string m_SponsAllocCFREG_MGMT;
		string m_SponsAllocCFOTH_CF;
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
		public string InitiativeBudgeted
		{
			get { return m_InitiativeBudgeted; }
			set 
			{
				m_Dirty = true;
				m_InitiativeBudgeted = value;
			}
		}
		public string AllocationsAgreed
		{
			get { return m_AllocationsAgreed; }
			set 
			{
				m_Dirty = true;
				m_AllocationsAgreed = value;
			}
		}
		public string BasisForAllocation
		{
			get { return m_BasisForAllocation; }
			set 
			{
				m_Dirty = true;
				m_BasisForAllocation = value;
			}
		}
		public string BasisForAllocationDescription
		{
			get { return m_BasisForAllocationDescription; }
			set 
			{
				m_Dirty = true;
				m_BasisForAllocationDescription = value;
			}
		}
		public string SponsAllocBusinessGM
		{
			get { return m_SponsAllocBusinessGM; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocBusinessGM = value;
			}
		}
		public string SponsAllocBusinessGB_GCF
		{
			get { return m_SponsAllocBusinessGB_GCF; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocBusinessGB_GCF = value;
			}
		}
		public string SponsAllocBusinessGB_GTB
		{
			get { return m_SponsAllocBusinessGB_GTB; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocBusinessGB_GTB = value;
			}
		}
		public string SponsAllocBusinessPBC
		{
			get { return m_SponsAllocBusinessPBC; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocBusinessPBC = value;
			}
		}
		public string SponsAllocBusinessPWM
		{
			get { return m_SponsAllocBusinessPWM; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocBusinessPWM = value;
			}
		}
		public string SponsAllocBusinessAM
		{
			get { return m_SponsAllocBusinessAM; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocBusinessAM = value;
			}
		}
		public string SponsAllocBusinessCA_S
		{
			get { return m_SponsAllocBusinessCA_S; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocBusinessCA_S = value;
			}
		}
		public string SponsAllocBusinessCI
		{
			get { return m_SponsAllocBusinessCI; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocBusinessCI = value;
			}
		}
		public string SponsAllocGTOIB_IT
		{
			get { return m_SponsAllocGTOIB_IT; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocGTOIB_IT = value;
			}
		}
		public string SponsAllocGTOIB_OPS
		{
			get { return m_SponsAllocGTOIB_OPS; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocGTOIB_OPS = value;
			}
		}
		public string SponsAllocGTOPCB_ITO
		{
			get { return m_SponsAllocGTOPCB_ITO; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocGTOPCB_ITO = value;
			}
		}
		public string SponsAllocGTOAM_ITO
		{
			get { return m_SponsAllocGTOAM_ITO; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocGTOAM_ITO = value;
			}
		}
		public string SponsAllocGTOSOM_OPS
		{
			get { return m_SponsAllocGTOSOM_OPS; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocGTOSOM_OPS = value;
			}
		}
		public string SponsAllocGTOIES
		{
			get { return m_SponsAllocGTOIES; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocGTOIES = value;
			}
		}
		public string SponsAllocGTOOTH
		{
			get { return m_SponsAllocGTOOTH; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocGTOOTH = value;
			}
		}
		public string SponsAllocCFFINANCE
		{
			get { return m_SponsAllocCFFINANCE; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocCFFINANCE = value;
			}
		}
		public string SponsAllocCFRISK_TREAS
		{
			get { return m_SponsAllocCFRISK_TREAS; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocCFRISK_TREAS = value;
			}
		}
		public string SponsAllocCFCOMP_LEG
		{
			get { return m_SponsAllocCFCOMP_LEG; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocCFCOMP_LEG = value;
			}
		}
		public string SponsAllocCFHR
		{
			get { return m_SponsAllocCFHR; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocCFHR = value;
			}
		}
		public string SponsAllocCFGM_TMG
		{
			get { return m_SponsAllocCFGM_TMG; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocCFGM_TMG = value;
			}
		}
		public string SponsAllocCFREG_MGMT
		{
			get { return m_SponsAllocCFREG_MGMT; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocCFREG_MGMT = value;
			}
		}
		public string SponsAllocCFOTH_CF
		{
			get { return m_SponsAllocCFOTH_CF; }
			set 
			{
				m_Dirty = true;
				m_SponsAllocCFOTH_CF = value;
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
 
	
	public IUSponsor()
	{ 

		// 
		// TODO: Add constructor logic here
		//
	} 
  

		public override bool Insert()
		{
			return Insert(
m_Name, m_InitiativeBudgeted, m_AllocationsAgreed, m_BasisForAllocation, m_BasisForAllocationDescription, m_SponsAllocBusinessGM, m_SponsAllocBusinessGB_GCF, m_SponsAllocBusinessGB_GTB, m_SponsAllocBusinessPBC, m_SponsAllocBusinessPWM, m_SponsAllocBusinessAM, m_SponsAllocBusinessCA_S, m_SponsAllocBusinessCI, m_SponsAllocGTOIB_IT, m_SponsAllocGTOIB_OPS, m_SponsAllocGTOPCB_ITO, m_SponsAllocGTOAM_ITO, m_SponsAllocGTOSOM_OPS, m_SponsAllocGTOIES, m_SponsAllocGTOOTH, m_SponsAllocCFFINANCE, m_SponsAllocCFRISK_TREAS, m_SponsAllocCFCOMP_LEG, m_SponsAllocCFHR, m_SponsAllocCFGM_TMG, m_SponsAllocCFREG_MGMT, m_SponsAllocCFOTH_CF, m_RowCommand, m_UploadID); 
		}


		public bool Insert( string Name, string InitiativeBudgeted, string AllocationsAgreed, 
                            string BasisForAllocation, string BasisForAllocationDescription, 
                            string SponsAllocBusinessGM, string SponsAllocBusinessGB_GCF, string SponsAllocBusinessGB_GTB, 
                            string SponsAllocBusinessPBC, string SponsAllocBusinessPWM, 
                            string SponsAllocBusinessAM, string SponsAllocBusinessCA_S, string SponsAllocBusinessCI, 
                            string SponsAllocGTOIB_IT, string SponsAllocGTOIB_OPS, string SponsAllocGTOPCB_ITO, 
                            string SponsAllocGTOAM_ITO, string SponsAllocGTOSOM_OPS, string SponsAllocGTOIES, 
                            string SponsAllocGTOOTH, string SponsAllocCFFINANCE, string SponsAllocCFRISK_TREAS, 
                            string SponsAllocCFCOMP_LEG, string SponsAllocCFHR, string SponsAllocCFGM_TMG, 
                            string SponsAllocCFREG_MGMT, string SponsAllocCFOTH_CF, string RowCommand, 
                            int UploadID)
        {
			try 
			{ 
				int val1 = 0, val2 = 0; 
				m_DataAccess.ClearParameters();


				m_DataAccess.AddInParameter("@Name", DbType.String, Name);
				m_DataAccess.AddInParameter("@InitiativeBudgeted", DbType.String, InitiativeBudgeted);
				m_DataAccess.AddInParameter("@AllocationsAgreed", DbType.String, AllocationsAgreed);
				m_DataAccess.AddInParameter("@BasisForAllocation", DbType.String, BasisForAllocation);
				m_DataAccess.AddInParameter("@BasisForAllocationDescription", DbType.String, BasisForAllocationDescription);
				m_DataAccess.AddInParameter("@SponsAllocBusinessGM", DbType.String, SponsAllocBusinessGM);
				m_DataAccess.AddInParameter("@SponsAllocBusinessGB_GCF", DbType.String, SponsAllocBusinessGB_GCF);
				m_DataAccess.AddInParameter("@SponsAllocBusinessGB_GTB", DbType.String, SponsAllocBusinessGB_GTB);
				m_DataAccess.AddInParameter("@SponsAllocBusinessPBC", DbType.String, SponsAllocBusinessPBC);
				m_DataAccess.AddInParameter("@SponsAllocBusinessPWM", DbType.String, SponsAllocBusinessPWM);
				m_DataAccess.AddInParameter("@SponsAllocBusinessAM", DbType.String, SponsAllocBusinessAM);
				m_DataAccess.AddInParameter("@SponsAllocBusinessCA_S", DbType.String, SponsAllocBusinessCA_S);
				m_DataAccess.AddInParameter("@SponsAllocBusinessCI", DbType.String, SponsAllocBusinessCI);
				m_DataAccess.AddInParameter("@SponsAllocGTOIB_IT", DbType.String, SponsAllocGTOIB_IT);
				m_DataAccess.AddInParameter("@SponsAllocGTOIB_OPS", DbType.String, SponsAllocGTOIB_OPS);
				m_DataAccess.AddInParameter("@SponsAllocGTOPCB_ITO", DbType.String, SponsAllocGTOPCB_ITO);
				m_DataAccess.AddInParameter("@SponsAllocGTOAM_ITO", DbType.String, SponsAllocGTOAM_ITO);
				m_DataAccess.AddInParameter("@SponsAllocGTOSOM_OPS", DbType.String, SponsAllocGTOSOM_OPS);
				m_DataAccess.AddInParameter("@SponsAllocGTOIES", DbType.String, SponsAllocGTOIES);
				m_DataAccess.AddInParameter("@SponsAllocGTOOTH", DbType.String, SponsAllocGTOOTH);
				m_DataAccess.AddInParameter("@SponsAllocCFFINANCE", DbType.String, SponsAllocCFFINANCE);
				m_DataAccess.AddInParameter("@SponsAllocCFRISK_TREAS", DbType.String, SponsAllocCFRISK_TREAS);
				m_DataAccess.AddInParameter("@SponsAllocCFCOMP_LEG", DbType.String, SponsAllocCFCOMP_LEG);
				m_DataAccess.AddInParameter("@SponsAllocCFHR", DbType.String, SponsAllocCFHR);
				m_DataAccess.AddInParameter("@SponsAllocCFGM_TMG", DbType.String, SponsAllocCFGM_TMG);
				m_DataAccess.AddInParameter("@SponsAllocCFREG_MGMT", DbType.String, SponsAllocCFREG_MGMT);
				m_DataAccess.AddInParameter("@SponsAllocCFOTH_CF", DbType.String, SponsAllocCFOTH_CF);
				m_DataAccess.AddInParameter("@RowCommand", DbType.String, RowCommand);
				m_DataAccess.AddInParameter("@_UploadID", DbType.Int32, UploadID);

				val1 = m_DataAccess.ExecuteNonQuery("IU_UploadSponsor");

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
 
                val1 = m_DataAccess.ExecuteNonQuery("IU_ValidateSponsor");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));
 
                return (val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

		public override int Commit() {       return Commit(m_UploadID);  } 

		public  int Commit(int uploadID)
{
         try
            {
                int val1 = 0, val2 = 0;
                m_DataAccess.ClearParameters();

                m_DataAccess.AddInParameter("@UploadID", DbType.Int32, uploadID);
 
                val1 = m_DataAccess.ExecuteNonQuery("IU_CommitSponsor");
                //       val2 = Convert.ToInt32(m_DataAccess.GetParameterValue("@_UploadID"));
 
                return val1; //(val1 != -1);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
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

        //consider making this private
        // returns a count of successfully uploaded rows, not total rows submitted
        protected override bool PopulateFromDataRow(DataRow dr)
        {
            m_Name = dr[0].ToString();
            m_InitiativeBudgeted = dr[1].ToString();
            m_AllocationsAgreed = dr[2].ToString();
            m_BasisForAllocation = dr[3].ToString();
//            m_BasisForAllocationDescription = dr[5].ToString();
            m_SponsAllocBusinessGM = dr[4].ToString();
            m_SponsAllocBusinessGB_GCF = dr[5].ToString();
            m_SponsAllocBusinessGB_GTB = dr[6].ToString();
            m_SponsAllocBusinessPBC = dr[7].ToString();
            m_SponsAllocBusinessPWM = dr[8].ToString();
            m_SponsAllocBusinessAM = dr[9].ToString();
            m_SponsAllocBusinessCA_S = dr[10].ToString();
            m_SponsAllocBusinessCI = dr[11].ToString();
            m_SponsAllocGTOIB_IT = dr[12].ToString();
            m_SponsAllocGTOIB_OPS = dr[13].ToString();
            m_SponsAllocGTOPCB_ITO = dr[14].ToString();
            m_SponsAllocGTOAM_ITO = dr[15].ToString();
            m_SponsAllocGTOSOM_OPS = dr[16].ToString();
            m_SponsAllocGTOIES = dr[17].ToString();
            m_SponsAllocGTOOTH = dr[18].ToString();
            m_SponsAllocCFFINANCE = dr[19].ToString();
            m_SponsAllocCFRISK_TREAS = dr[20].ToString();
            m_SponsAllocCFCOMP_LEG = dr[21].ToString();
            m_SponsAllocCFHR = dr[22].ToString();
            m_SponsAllocCFGM_TMG = dr[23].ToString();
            m_SponsAllocCFREG_MGMT = dr[24].ToString();
            m_SponsAllocCFOTH_CF = dr[25].ToString();
            m_RowCommand = dr[27].ToString();
            

            //insert the data 
            return this.Insert();
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
