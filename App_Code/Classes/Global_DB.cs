/*//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1         CA          25/01/2007      New Dataset to populate Initiative Status dropdown box 
//                                              This was to save changing all references to GetReferenceTable
//                                              to include two parameters
//
//      1.1.1       CA          30/01/2007      Code to include option "Any" in year
//                                              drop down list
//
//                  GMcF        02/02/2007      Added static
//                                              method UpdateInitiativeInvestmentTier( int intInitiativeID )
//
//      1.1.7       GMcF        09/02/2007      Trimmed string versions of years in GetYears()
//
//
//      1.1.8       JG          20/02/2007      Added overload static method 
//                                              GetUBRLookupTable( int  paramFinancialCategoryID )
//
//      1.7.5       GMcF        31/08/2007      Changed GetPeriods to use new stored proc spGetInitiativePeriods
//
//      1.8.1       GMcF        01/10/2007      Secondary Functional Domains now dependent on Primary Functional Domain.
//                                              List provided by HW
//
//      1.9.1       GMcF        09/01/2008      Added GetInitiativeStatusID, for use in PIR
//
//      1.9.2       GMcF        14/01/2008      Added GetEarliestVersionInitiativeID, for use in PIR
//
//      2.1.2       GMcF        28/04/2008      For Phase 2.1, Deliverable 2 - Comments & Issues, added
//                                              GetInitiativeComments() and UpdateInitiativeComments()
//
//      2.1.5       GMcF        05/05/2008      For Phase 2.1, Deliverable 5, added UppdateInitiativeInPPR()
//
    ota739 / 740    ERW         15 Oct 2008     Altered  GetReferenceTable - added Order By clause

//*****************************************************************************************************/

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{
	public class Global_DB
	{
        public const int SQLCommandTimeOut = 300;
		
		public static string GetConnectionString()
		{
			return ConfigurationSettings.AppSettings["connectionString"];
		}


        public static int GetPreviousVersionInitiativeID(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetPreviousInitiativeID = new SqlCommand();
            cmdGetPreviousInitiativeID.Connection = dbConnection;

            cmdGetPreviousInitiativeID.CommandType = CommandType.StoredProcedure;
            cmdGetPreviousInitiativeID.CommandText = "spGetPreviousVersionInitiativeID";

            cmdGetPreviousInitiativeID.Parameters.Add("@InitiativeID", nInitiativeID);

            object obj;

            /* RJO dbConnection.Open(); */
            /* RJO obj = cmdGetPreviousInitiativeID.ExecuteScalar(); */
            /* RJO dbConnection.Close(); */

            obj = null;
            if (obj != DBNull.Value && obj != null)
                return (Int32)obj;

            return -1;
        }

        /* Rev 1.9.2, GMcF, 2008-01-14 */
        public static int GetEarliestVersionInitiativeID(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetEarliestInitiativeID = new SqlCommand();
            cmdGetEarliestInitiativeID.Connection = dbConnection;

            cmdGetEarliestInitiativeID.CommandType = CommandType.StoredProcedure;
            cmdGetEarliestInitiativeID.CommandText = "spGetEarliestVersionInitiativeID";

            cmdGetEarliestInitiativeID.Parameters.Add("@InitiativeID", nInitiativeID);

            object obj;

            dbConnection.Open();
            obj = cmdGetEarliestInitiativeID.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (Int32)obj;

            return -1;
        }
        /* End of Rev 1.9.2 */

        public static int GetNextVersionInitiativeID(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetPreviousInitiativeID = new SqlCommand();
            cmdGetPreviousInitiativeID.Connection = dbConnection;

            cmdGetPreviousInitiativeID.CommandType = CommandType.StoredProcedure;
            cmdGetPreviousInitiativeID.CommandText = "spGetNextVersionInitiativeID";

            cmdGetPreviousInitiativeID.Parameters.Add("@InitiativeID", nInitiativeID);

            object obj;

            dbConnection.Open();
            obj = cmdGetPreviousInitiativeID.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (Int32)obj;

            return -1;
        }


        public static int IsIGIdentifierUnique(string strIGBusinessAreaCode, string strIGIdentifierCode)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetPreviousInitiativeID = new SqlCommand();
            cmdGetPreviousInitiativeID.Connection = dbConnection;

            cmdGetPreviousInitiativeID.CommandType = CommandType.StoredProcedure;
            cmdGetPreviousInitiativeID.CommandText = "spIsIGIdentifierUnique";

            cmdGetPreviousInitiativeID.Parameters.Add("@IGBusinessAreaCode", strIGBusinessAreaCode);
            cmdGetPreviousInitiativeID.Parameters.Add("@IGIdentifierCode", strIGIdentifierCode);

            object obj;

            dbConnection.Open();
            obj = cmdGetPreviousInitiativeID.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (int)obj;

            return -1;
        }   


		public static string GetInitiativeName(int nInitiativeID)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetInvestment = new SqlCommand();
			cmdGetInvestment.Connection = dbConnection;

			cmdGetInvestment.CommandType = CommandType.Text;
			cmdGetInvestment.CommandText="SELECT Name FROM Initiative WHERE InitiativeID=@InitiativeID";
			cmdGetInvestment.Parameters.Add("@InitiativeID", nInitiativeID);

			object obj;

			dbConnection.Open();
			obj = cmdGetInvestment.ExecuteScalar();			
			dbConnection.Close();

			if (obj != DBNull.Value && obj != null)
				return obj.ToString();

			return null;
		}


        public static string GetInitiativeStatus(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT IGApprovalStatus FROM Initiative WHERE InitiativeID=@InitiativeID";
            cmdGetInitiative.Parameters.Add("@InitiativeID", nInitiativeID);

            object obj;

            dbConnection.Open();
            obj = cmdGetInitiative.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return obj.ToString();

            return null;
        }

        // Rev 1.9.1, GMcF, 2008-01-09
        public static Int32 GetInitiativeStatusID(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT IGApprovalStatusID FROM Initiative WHERE InitiativeID=@InitiativeID";
            cmdGetInitiative.Parameters.Add("@InitiativeID", nInitiativeID);

            object obj;

            dbConnection.Open();
            obj = cmdGetInitiative.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return System.Convert.ToInt32(obj.ToString());

            return -1;
        }

        // Rev 1.9.2, GMcF, 2008-01-14
        public static bool IsPIR(int nStatusID)
        {
            bool bReturnValue;

            switch (nStatusID)
            {
                case 22:
                case 23:
                case 24:
                    bReturnValue = true;
                    break;
                default:
                    bReturnValue = false;
                    break;
            }
            return bReturnValue;
        }

        public static bool GetInitiativeApprovedStatus(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT CAST((CASE WHEN IGApprovalStatusID IN (SELECT * FROM vwLookupApprovedStatuses) THEN 1 ELSE 0 END) AS bit) " +
                                                "FROM Initiative WHERE InitiativeID=@InitiativeID";

            cmdGetInitiative.Parameters.Add("@InitiativeID", nInitiativeID);

            object obj;

            dbConnection.Open();
            obj = cmdGetInitiative.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (bool)obj;

            return false;
        }

        //rev 1.1 CA
        public static DataSet GetInitiativeStatusReferenceTable(int intCategoryID, int iInitiativeStatus)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetReferenceTable = new SqlCommand();
            cmdGetReferenceTable.Connection = dbConnection;

            //rev 1.1 CA
            string sSQL;

            sSQL = "SELECT ReferenceID, Description FROM Reference ";
            sSQL += "WHERE CategoryID = @CategoryID AND IsDeleted = 0 ";



            //*****apparently no longer needed************
            //string strApprovalStatus = Global_DB.GetInitiativeStatus(iInitiativeStatus);

            //if (intCategoryID == 5 && (strApprovalStatus == "IG Submitted" || strApprovalStatus == "IG Pending Approval" || strApprovalStatus == "IG Deferred" || strApprovalStatus == "IG Rejected" || strApprovalStatus == "IG Budget Approved" || strApprovalStatus == "IG Full Analysis" || strApprovalStatus == "In Review"))
            //{
            //    sSQL += "AND ReferenceID <> 1";
            //}
            //*******************************************


            //end rev 1.1

            cmdGetReferenceTable.CommandType = CommandType.Text;

            ////rem CA
            //cmdGetReferenceTable.CommandText = "SELECT ReferenceID, Description FROM Reference " + 
            //                                           "WHERE CategoryID=@CategoryID AND IsDeleted=0";
            ////end rem CA

            //rev 1.1 CA
            cmdGetReferenceTable.CommandText = sSQL;
            //end rev 1.1

            cmdGetReferenceTable.Parameters.Add("@CategoryID", intCategoryID);

            SqlDataAdapter daReferenceTable = new SqlDataAdapter(cmdGetReferenceTable);

            DataSet dsReferenceTable = new DataSet();
            daReferenceTable.Fill(dsReferenceTable, "Reference");

            DataRow drReference_PleaseSelect = dsReferenceTable.Tables["Reference"].NewRow();
            drReference_PleaseSelect["ReferenceID"] = 0;
            drReference_PleaseSelect["Description"] = "Please select";

            dsReferenceTable.Tables["Reference"].Rows.InsertAt(drReference_PleaseSelect, 0);

            return dsReferenceTable;
        }
        //end rev 1.1


		public static DataSet GetReferenceTable(int intCategoryID)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetReferenceTable = new SqlCommand();
			cmdGetReferenceTable.Connection = dbConnection;

			cmdGetReferenceTable.CommandType = CommandType.Text;
            //ERW 15 Oct 2008
            // ota739 / 741
            //altered to include ORDER BY clause
			cmdGetReferenceTable.CommandText = " SELECT ReferenceID, Description " + 
                                               " FROM Reference                  " + 
                                               " WHERE CategoryID=@CategoryID    " + 
                                               " AND IsDeleted=0                 " + 
                                               " ORDER BY SortOrder              ";

			cmdGetReferenceTable.Parameters.Add("@CategoryID", intCategoryID);

			SqlDataAdapter daReferenceTable = new SqlDataAdapter(cmdGetReferenceTable);

			DataSet dsReferenceTable = new DataSet();
			daReferenceTable.Fill(dsReferenceTable, "Reference");

            //temp removal CA
            if (intCategoryID != 8)
            {
                DataRow drReference_PleaseSelect = dsReferenceTable.Tables["Reference"].NewRow();
                drReference_PleaseSelect["ReferenceID"] = 0;
                drReference_PleaseSelect["Description"] = "Please select";
                //end

                dsReferenceTable.Tables["Reference"].Rows.InsertAt(drReference_PleaseSelect, 0);
            }
			return dsReferenceTable;			
		}

        // Rev 1.8.1f GMcF - taken out
        //// Rev 1.8.1 GMcF: copied and modified from GetReferenceTable(int)
        //public static DataSet GetParentReferenceTable(int intCategoryID, int intParentReferenceID, int intCurrentReferenceID)
        //{
        //    // if intParentReferenceID = -1 returns parents
        //    // otherwise returns children

        //    SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = dbConnection;

        //    cmd.CommandText = "spGetParentReferenceTable";
        //    cmd.CommandType = CommandType.StoredProcedure;

        //    cmd.Parameters.Add("@CategoryID", intCategoryID);
        //    cmd.Parameters.Add("@ParentReferenceID", intParentReferenceID);
        //    cmd.Parameters.Add("@CurrentReferenceID", intCurrentReferenceID);

        //    SqlDataAdapter da = new SqlDataAdapter(cmd);

        //    DataSet ds = new DataSet();
        //    da.Fill(ds, "Reference");

        //    DataRow dr_PleaseSelect = ds.Tables["Reference"].NewRow();
        //    dr_PleaseSelect["ReferenceID"] = 0;
        //    dr_PleaseSelect["CombinedID"] = "0|0";
        //    dr_PleaseSelect["Description"] = "Please select";

        //    ds.Tables["Reference"].Rows.InsertAt(dr_PleaseSelect, 0);

        //    return ds;

        //}
        ////End of Rev 1.8.1
        // End of Rev 1.8.1f

        // Rev 1.8.1f GMcF
        public static DataSet GetReferenceTableParents(int intCategoryID, int intCurrentReferenceID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandText = "spGetReferenceTableParents";
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CategoryID", intCategoryID);
            cmd.Parameters.Add("@CurrentReferenceID", intCurrentReferenceID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            da.Fill(ds, "Reference");

            DataRow dr_PleaseSelect = ds.Tables["Reference"].NewRow();
            dr_PleaseSelect["ReferenceID"] = 0;
            /* *** RJO No Combined columndr_PleaseSelect["CombinedID"] = "0|0";*/
            dr_PleaseSelect["ParentReferenceID"] = 0;
            dr_PleaseSelect["Description"] = "Please select";

            ds.Tables["Reference"].Rows.InsertAt(dr_PleaseSelect, 0);

            return ds;

        }
        //End of Rev 1.8.1f

        // Rev 1.8.1f GMcF
        public static DataSet GetReferenceTableChildren(int intCategoryID, int intParentReferenceID, int intCurrentReferenceID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandText = "spGetReferenceTableChildren";
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CategoryID", intCategoryID);
            cmd.Parameters.Add("@ParentReferenceID", intParentReferenceID);
            cmd.Parameters.Add("@CurrentReferenceID", intCurrentReferenceID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            da.Fill(ds, "Reference");

            DataRow dr_PleaseSelect = ds.Tables["Reference"].NewRow();
            dr_PleaseSelect["ReferenceID"] = 0;
            /* *** RJO dr_PleaseSelect["CombinedID"] = "0|0";*/
            dr_PleaseSelect["ParentReferenceID"] = 0;
            dr_PleaseSelect["Description"] = "Please select";

            ds.Tables["Reference"].Rows.InsertAt(dr_PleaseSelect, 0);

            return ds;

        }
        //End of Rev 1.8.1f

        public static DataSet GetApprovedStatus()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetTable = new SqlCommand();
            cmdGetTable.Connection = dbConnection;

            cmdGetTable.CommandType = CommandType.Text;
            cmdGetTable.CommandText = "SELECT * from vwLookupApprovedStatusDescription";
 
            SqlDataAdapter daTable = new SqlDataAdapter(cmdGetTable);

            DataSet dsTable = new DataSet();
            daTable.Fill(dsTable, "ApprovedStatus");
                        

            return dsTable;
        }

		public static DataSet GetContacts()
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetContacts = new SqlCommand();
			cmdGetContacts.Connection = dbConnection;

			cmdGetContacts.CommandType = CommandType.Text;
            cmdGetContacts.CommandText = "SELECT Firstname,Surname,[Contact ID], Surname + \', \' + Firstname AS Name FROM Contacts WHERE (Login IS NOT NULL)";

			SqlDataAdapter daContacts = new SqlDataAdapter(cmdGetContacts);

			DataSet dsContacts = new DataSet();
			daContacts.Fill(dsContacts, "Contacts");

			return dsContacts;					
		}

        public static DataSet GetUBRLookupTable( int paramFinancialCategoryID )
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            try
            {
                SqlCommand cmdGetUBRLookupTable = new SqlCommand();
                cmdGetUBRLookupTable.Connection = dbConnection;

                cmdGetUBRLookupTable.CommandType = CommandType.StoredProcedure ;
                cmdGetUBRLookupTable.CommandText = "spGetFilteredUBRCodes";
                cmdGetUBRLookupTable.Parameters.Add("@FinancialCategoryID", paramFinancialCategoryID); 

                SqlDataAdapter daUBRLookupTable = new SqlDataAdapter(cmdGetUBRLookupTable);

                DataSet dsUBRLookupTable = new DataSet();
                daUBRLookupTable.Fill(dsUBRLookupTable, "UBRLookup");

                DataRow drUBRLookup_PleaseSelect = dsUBRLookupTable.Tables["UBRLookup"].NewRow();
                drUBRLookup_PleaseSelect["UBR_ID"] = 0;
                drUBRLookup_PleaseSelect["Level5Code"] = "-";
                drUBRLookup_PleaseSelect["Level5Name"] = "-";
                drUBRLookup_PleaseSelect["Level6Code"] = "-";
                drUBRLookup_PleaseSelect["Level6Name"] = "-";
                drUBRLookup_PleaseSelect["Level7Code"] = "-";
                drUBRLookup_PleaseSelect["Level7Name"] = "-";
                drUBRLookup_PleaseSelect["Level8Code"] = "-";
                drUBRLookup_PleaseSelect["Level8Name"] = "-";
                drUBRLookup_PleaseSelect["Level9Code"] = "-";
                drUBRLookup_PleaseSelect["Level9Name"] = "-";
                drUBRLookup_PleaseSelect["Level10Code"] = "Please Select";
                drUBRLookup_PleaseSelect["Level10Name"] = "-";

                dsUBRLookupTable.Tables["UBRLookup"].Rows.InsertAt(drUBRLookup_PleaseSelect, 0);

                return dsUBRLookupTable;
            }
            catch (SqlException ex)
            {
                return null;
            }
            finally
            {
                dbConnection.Close();
            }
        }

        public static DataSet GetUBRLookupTable()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetUBRLookupTable = new SqlCommand();
            cmdGetUBRLookupTable.Connection = dbConnection;

            cmdGetUBRLookupTable.CommandType = CommandType.Text;
            cmdGetUBRLookupTable.CommandText = "SELECT * FROM UBRLookup ORDER BY Level10Code";

            SqlDataAdapter daUBRLookupTable = new SqlDataAdapter(cmdGetUBRLookupTable);

            DataSet dsUBRLookupTable = new DataSet();
            daUBRLookupTable.Fill(dsUBRLookupTable, "UBRLookup");

            DataRow drUBRLookup_PleaseSelect = dsUBRLookupTable.Tables["UBRLookup"].NewRow();
            drUBRLookup_PleaseSelect["UBR_ID"] = 0;
            drUBRLookup_PleaseSelect["Level5Code"] = "-";
            drUBRLookup_PleaseSelect["Level5Name"] = "-";
            drUBRLookup_PleaseSelect["Level6Code"] = "-";
            drUBRLookup_PleaseSelect["Level6Name"] = "-";
            drUBRLookup_PleaseSelect["Level7Code"] = "-";
            drUBRLookup_PleaseSelect["Level7Name"] = "-";
            drUBRLookup_PleaseSelect["Level8Code"] = "-";
            drUBRLookup_PleaseSelect["Level8Name"] = "-";
            drUBRLookup_PleaseSelect["Level9Code"] = "-";
            drUBRLookup_PleaseSelect["Level9Name"] = "-";
            drUBRLookup_PleaseSelect["Level10Code"] = "Please Select";
            drUBRLookup_PleaseSelect["Level10Name"] = "-";

            dsUBRLookupTable.Tables["UBRLookup"].Rows.InsertAt(drUBRLookup_PleaseSelect, 0);

            return dsUBRLookupTable;
        }


        public static DataRow GetUBRDetails(int intUBR_ID)
        {
            DataRow drUBR = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetUBR = new SqlCommand();
            cmdGetUBR.Connection = dbConnection;

            cmdGetUBR.CommandType = CommandType.Text;
            cmdGetUBR.CommandText = "SELECT * FROM UBRLookup WHERE UBR_ID=@UBR_ID";

            cmdGetUBR.Parameters.Add("@UBR_ID", intUBR_ID);

            SqlDataAdapter daGetUBR = new SqlDataAdapter(cmdGetUBR);

            DataSet dsUBRLookup = new DataSet();
            daGetUBR.Fill(dsUBRLookup, "UBRLookup");

            if (dsUBRLookup.Tables["UBRLookup"] != null && dsUBRLookup.Tables["UBRLookup"].Rows.Count > 0)
            {
                drUBR = dsUBRLookup.Tables["UBRLookup"].Rows[0];
            }

            return drUBR;
        }


        public static string GetContactName(int contactID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetUsers = new SqlCommand();
            cmdGetUsers.Connection = dbConnection;

            cmdGetUsers.CommandType = CommandType.Text;
            /* RJO cmdGetUsers.CommandText = "SELECT FirstName + ' ' + Surname FROM Contacts WHERE [Contact ID]=@ContactID"; */
            cmdGetUsers.CommandText = "SELECT FirstName + ' ' + Surname FROM Contacts WHERE [ContactID]=@ContactID";

            cmdGetUsers.Parameters.Add("@ContactID", contactID);

            SqlDataAdapter daUsers = new SqlDataAdapter(cmdGetUsers);

            dbConnection.Open();
            string strReturn = cmdGetUsers.ExecuteScalar().ToString();
            dbConnection.Close();

            return strReturn;
        }


        public static int GetContactID(string strUser)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetUsers = new SqlCommand();
            cmdGetUsers.Connection = dbConnection;

            cmdGetUsers.CommandType = CommandType.Text;
            /* cmdGetUsers.CommandText = "SELECT [Contact ID] FROM Contacts WHERE ContactLogin=@Login"; */
            cmdGetUsers.CommandText = "SELECT [ContactID] FROM Contacts WHERE Login=@Login";

            cmdGetUsers.Parameters.Add("@Login", strUser);

            SqlDataAdapter daUsers = new SqlDataAdapter(cmdGetUsers);

            dbConnection.Open();
            object objReturn = cmdGetUsers.ExecuteScalar();

            if (objReturn != null && objReturn != DBNull.Value)
                return Convert.ToInt32(objReturn);

            return -1;            
        }
        

        public static DataSet GetPeriods(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetPeriods = new SqlCommand();
            cmdGetPeriods.Connection = dbConnection;

            // Rev 1.7.5, GMcF: Replaced by stored proc call further down routine
            //cmdGetPeriods.CommandType = CommandType.Text;

            //// Required for Deliverable 81
            //cmdGetPeriods.CommandText = " SELECT Period.* FROM Period " +
            //        "WHERE PeriodID IN ( " +
            //            "SELECT Period.PeriodID FROM Period " +
            //            "INNER JOIN InitiativeValue ON Period.PeriodID = InitiativeValue.PeriodID " +
            //            "INNER JOIN InitiativeFinancial ON InitiativeValue.ReferenceID = InitiativeFinancial.InitiativeFinancialID " +
            //            "WHERE InitiativeFinancial.InitiativeID = @InitiativeID " +
            //            "GROUP BY Period.PeriodID) " +
            //            "ORDER BY Right(Name,4), Name DESC";  
            // End of Rev 1.7.5

            //// Rev 1.7.5
            cmdGetPeriods.CommandType = CommandType.StoredProcedure;
            cmdGetPeriods.CommandText = "spGetInitiativePeriods";
            //// End of Rev 1.7.5

            cmdGetPeriods.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter daPeriods = new SqlDataAdapter(cmdGetPeriods);

            DataSet dsPeriods = new DataSet();

            daPeriods.FillSchema(dsPeriods, SchemaType.Source, "Period");
            daPeriods.Fill(dsPeriods, "Period");

            //DataColumn[] dcaPrimaryKey = new DataColumn[] { dsPeriods.Tables["Period"].Columns["PeriodId"] };
            //dsPeriods.Tables["Period"].PrimaryKey = dcaPrimaryKey; // Rev 1.7.5, GMcF

            return dsPeriods;
        }

        // Returns the priods for an Initiative.
        // All periods that wich will be displayed in Tables, compute: 'PRE InitativeYear'
        // Required for Deliverable 81
        public static DataSet GetPeriodsForDisplay(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetPeriods = new SqlCommand();
            cmdGetPeriods.Connection = dbConnection;
            // *** Reinstated RJO
            cmdGetPeriods.CommandType = CommandType.Text;
            cmdGetPeriods.CommandText = "SELECT Period.* FROM Initiative  " + 
                          "JOIN Period ON YEAR(Initiative.SubmissionDate) = Period.PeriodYear " + 
                         "WHERE Initiative.InitiativeID=@InitiativeID " ;

            //cmdGetPeriods.CommandText = " SELECT Period.* FROM Period " +
            //                    "WHERE PeriodID IN ( " +
            //                        "SELECT Period.PeriodID FROM Period " +
            //                        "INNER JOIN InitiativeValue ON Period.PeriodID = InitiativeValue.PeriodID " +
            //                        "INNER JOIN InitiativeFinancial ON InitiativeValue.ReferenceID = InitiativeFinancial.InitiativeFinancialID " +
            //                        "WHERE InitiativeFinancial.InitiativeID = @InitiativeID " +
            //                        "GROUP BY Period.PeriodID) " +
            //                        "ORDER BY Right(Period.Name,4)";
                        
            // *** RJO cmdGetPeriods.CommandText = "SELECT * FROM [Initiative_GetInitiativePeriods](@InitiativeID)";

            cmdGetPeriods.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter daPeriods = new SqlDataAdapter(cmdGetPeriods);

            DataSet dsPeriods = new DataSet();

            daPeriods.FillSchema(dsPeriods, SchemaType.Source, "Period");
            daPeriods.Fill(dsPeriods, "Period");

            return dsPeriods;
        }

        public static DataSet GetYears()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetYears = new SqlCommand();
            cmdGetYears.Connection = dbConnection;

            cmdGetYears.CommandType = CommandType.Text;

            //rem CA
            //cmdGetYears.CommandText = "SELECT DISTINCT PeriodYear from Period";
            //end rem

            //rem 1.1.1 CA
            //cmdGetYears.CommandText = "SELECT DISTINCT str(PeriodYear) as PeriodYear from Period";
            // end rem

            //rev 1.1.7 GMcF
            cmdGetYears.CommandText = "SELECT DISTINCT rtrim(ltrim(str(PeriodYear))) as PeriodYear from Period";
            // end rev

            SqlDataAdapter daYears = new SqlDataAdapter(cmdGetYears);

            DataSet dsYears = new DataSet();

            daYears.Fill(dsYears, "PeriodYears");

            // rev 1.1.1 CA
            DataRow drYears_PleaseSelect = dsYears.Tables["PeriodYears"].NewRow();
            //drYears_PleaseSelect["ReferenceID"] = 0;
            drYears_PleaseSelect["PeriodYear"] = "All";

            dsYears.Tables["PeriodYears"].Rows.InsertAt(drYears_PleaseSelect, 0);
            //end rev 

            return dsYears;
        }

        /// <summary>
        /// KI use this overload when you do not want "All" option in ddl...
        /// </summary>
        /// <param name="bwithAll"></param>
        /// <returns>a dataset WITHOUT the 'All' record</returns>
        public static DataSet GetYears(bool bwithAll)
        {
            if (bwithAll)
            {
                return GetYears();
            }
            else
            {
                SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

                SqlCommand cmdGetYears = new SqlCommand();
                cmdGetYears.Connection = dbConnection;

                cmdGetYears.CommandType = CommandType.Text;
                
                cmdGetYears.CommandText = "SELECT DISTINCT rtrim(ltrim(str(PeriodYear))) as PeriodYear from Period";            

                SqlDataAdapter daYears = new SqlDataAdapter(cmdGetYears);

                DataSet dsYears = new DataSet();

                daYears.Fill(dsYears, "PeriodYears");

                return dsYears;
            }
        }
       
        public static int InsertInitiativeValue(
                                    int intReferenceID,
                                    int intInitiativeID,
                                    int intTypeID,
                                    int intPeriodID,
                                    object objQuarterNo,
                                    decimal dAmount
                                    )
        {
            int intReturnValue;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertInitiativeValue = new SqlCommand();
            cmdInsertInitiativeValue.Connection = dbConnection;

            cmdInsertInitiativeValue.CommandType = CommandType.StoredProcedure;
            cmdInsertInitiativeValue.CommandText = "spInsertInitiativeValue";

            cmdInsertInitiativeValue.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdInsertInitiativeValue.Parameters.Add("@TypeID", intTypeID);
            cmdInsertInitiativeValue.Parameters.Add("@ReferenceID", intReferenceID);
            cmdInsertInitiativeValue.Parameters.Add("@PeriodID", intPeriodID);
            cmdInsertInitiativeValue.Parameters.Add("@QuarterNo", objQuarterNo);
            cmdInsertInitiativeValue.Parameters.Add("@Amount", dAmount);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsertInitiativeValue.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                cmdInsertInitiativeValue.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intReturnValue = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                intReturnValue = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                intReturnValue = -1;
            }

            return intReturnValue;
        }


        public static int UpdateInitiativeValue(
                                  int intReferenceID,
                                  int intInitiativeID,
                                  int intTypeID,
                                  int intPeriodID,
                                  object objQuarterNo,
                                  decimal dAmount
                                  )
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiativeValue = new SqlCommand();
            cmdUpdateInitiativeValue.Connection = dbConnection;

            cmdUpdateInitiativeValue.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiativeValue.CommandText = "spUpdateInitiativeValue";

            cmdUpdateInitiativeValue.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateInitiativeValue.Parameters.Add("@TypeID", intTypeID);
            cmdUpdateInitiativeValue.Parameters.Add("@ReferenceID", intReferenceID);
            cmdUpdateInitiativeValue.Parameters.Add("@PeriodID", intPeriodID);
            cmdUpdateInitiativeValue.Parameters.Add("@QuarterNo", objQuarterNo);
            cmdUpdateInitiativeValue.Parameters.Add("@Amount", dAmount);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdUpdateInitiativeValue.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;
        }
             
        
        public static int InsertItem(
                            int nCategoryID,
                            string strParm1,
                            string strParm2)
        {
            int nReturnValue=-1;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertItem = new SqlCommand();
            cmdInsertItem.Connection = dbConnection;

            SqlParameter parmReturnValue=null;

            if(nCategoryID==2)//Application
            {
                cmdInsertItem.CommandType = CommandType.StoredProcedure;
                cmdInsertItem.CommandText = "spInsertApplication";

                cmdInsertItem.Parameters.Add("@AppName", strParm1);
                cmdInsertItem.Parameters.Add("@ExternalAppID", strParm2);

                parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
                parmReturnValue.Direction = ParameterDirection.ReturnValue;

                cmdInsertItem.Parameters.Add(parmReturnValue);
            }
            else if (nCategoryID == 3)//Server
            {
                cmdInsertItem.CommandType = CommandType.StoredProcedure;
                cmdInsertItem.CommandText = "spInsertServer";

                cmdInsertItem.Parameters.Add("@ServerName", strParm1);
                cmdInsertItem.Parameters.Add("ServerNodeID", strParm2);

                parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
                parmReturnValue.Direction = ParameterDirection.ReturnValue;

                cmdInsertItem.Parameters.Add(parmReturnValue);
            }

            
            try
            {
                dbConnection.Open();
                cmdInsertItem.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                nReturnValue = -1;
            }
            finally
            {
                dbConnection.Close();
            }


            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                nReturnValue = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                nReturnValue = -1;
            }

            return nReturnValue;
                       
        }


        public static DataSet GetBENProjects()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetBENProject = new SqlCommand();
            cmdGetBENProject.Connection = dbConnection;

            cmdGetBENProject.CommandType = CommandType.Text;
            cmdGetBENProject.CommandText = "SELECT * FROM BENProject";

            SqlDataAdapter daBENProject = new SqlDataAdapter(cmdGetBENProject);

            DataSet dsBENProject = new DataSet();

            daBENProject.Fill(dsBENProject, "BENProject");

            return dsBENProject;
        }


        public static int GetInitiativeID(int nProjectID)
        {
            int nReturnValue = -1;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            
            int nSecurityID;
            try
            {
                nSecurityID = Convert.ToInt32(ConfigurationSettings.AppSettings["DefaultSecurityID"]);
            }
            catch (Exception e1)
            {
                nSecurityID = -1;
            }
            
            cmdGetInitiative.CommandType = CommandType.StoredProcedure;
            cmdGetInitiative.CommandText = "spGetInitiativeID";

            
            cmdGetInitiative.Parameters.Add("@ProjectID", nProjectID);
            cmdGetInitiative.Parameters.Add("@SecurityID", nSecurityID);


            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdGetInitiative.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                cmdGetInitiative.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                nReturnValue = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                nReturnValue = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                nReturnValue = -1;
            }

            return nReturnValue;
        }

        public static int InsertContact(
                                    string strFirstname,
                                    string strSurname,
                                    string strEmail,
                                    string strMobile,
                                    string strLogin                                    
                                    )
        {
            int nReturnValue;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertContact = new SqlCommand();
            cmdInsertContact.Connection = dbConnection;

            cmdInsertContact.CommandType = CommandType.StoredProcedure;
            cmdInsertContact.CommandText = "spInsertContact";

            cmdInsertContact.Parameters.Add("@Firstname", strFirstname);
            cmdInsertContact.Parameters.Add("@Surname", strSurname);
            cmdInsertContact.Parameters.Add("@Email", strEmail);
            cmdInsertContact.Parameters.Add("@Mobile", strMobile);
            cmdInsertContact.Parameters.Add("@ContactLogin", strLogin);
            

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdInsertContact.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                cmdInsertContact.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                nReturnValue = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                nReturnValue = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                nReturnValue = -1;
            }

            return nReturnValue;
        }


        public static DataSet GetBENProjectInitiatives()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetBENProjectInitiatives";

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "BENProjectInitiative");

            if (ds.Tables["BENProjectInitiative"].Rows.Count == 0)
            {
                DataRow drNoRecords = ds.Tables["BENProjectInitiative"].NewRow();
                drNoRecords["IGName"] = "No records";

                ds.Tables["BENProjectInitiative"].Rows.Add(drNoRecords);
            }

            return ds;
        }


        public static DataSet GetValidationTable(int nValidationLevel)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetValidation = new SqlCommand();
            cmdGetValidation.Connection = dbConnection;

            cmdGetValidation.CommandType = CommandType.Text;
            cmdGetValidation.CommandText = "SELECT ControlID,ControlStatus FROM Validation "+
                                    "WHERE ValidationLevel=@ValidationLevel";

            cmdGetValidation.Parameters.Add("@ValidationLevel", nValidationLevel);

            SqlDataAdapter daReferenceTable = new SqlDataAdapter(cmdGetValidation);

            DataSet dsReferenceTable = new DataSet();
            daReferenceTable.Fill(dsReferenceTable, "Validation");

            
            return dsReferenceTable;
        }

        //2007-02-01 GMcF for IMPS Phase 1.5 Deliverable 70 - Investment Tier Calculation
        public static int UpdateInitiativeInvestmentTier(int intInitiativeID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spUpdateInitiativeInvestmentTier";

            cmd.Parameters.Add("@InitiativeID", intInitiativeID);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;
        }

        // Rev 2.1.2, GMcF, 2008-04-28
        public static string GetInitiativeComments(int intInitiativeId)
        {
            string strReturnValue = "";

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spGetInitiativePPR_Comments";
            cmd.Parameters.Add("@InitiativeId",intInitiativeId);

            try
            {
                dbConnection.Open();
                strReturnValue = cmd.ExecuteScalar().ToString();
            }
            catch (Exception e)
            {
                strReturnValue = "";
            }
            finally
            {
                dbConnection.Close();
            }

            return strReturnValue;
        }


        // Rev 2.1.2, GMcF, 2008-04-28
        public static int UpdateInitiativeComments(int intInitiativeId, string strComments, string strChangedBy, int intChangedById)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spUpdateInitiative_PPR_Comments";
            cmd.Parameters.Add("@InitiativeId", intInitiativeId);
            cmd.Parameters.Add("@Comments", strComments);
            cmd.Parameters.Add("@ChangedBy", strChangedBy);
            cmd.Parameters.Add("@ChangedById", intChangedById);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;
        }

        // Rev 2.1.5, GMcF, 2008-05-05
        public static int UpdateInitiativeInPPR(int intInitiativeId, string strInPPR, int intChangedById)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spUpdateInitiative_PPR_InPPR";
            cmd.Parameters.Add("@InitiativeId", intInitiativeId);
            cmd.Parameters.Add("@InPPR", strInPPR);
            cmd.Parameters.Add("@ChangedById", intChangedById);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;

        }

        //ERW 9 July 2008
        //ota 606
        public static int UpdateInitiativePPR_RAG_Indicators(int intInitiativeId, 
                                                            string OverallStatus, int OverallStatusID,                                                            
                                                            string CostStatus, int CostStatusID,
                                                            string DeliverablesStatus, int DeliverablesStatusID,
                                                            string TimeStatus, int TimeStatusID,
                                                            string RisksStatus, int RisksStatusID,
                                                            string BenefitsStatus, int BenefitsStatusID,
                                                             string strChangedBy, int intChangedById)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            /*
             * UpdateInitiative_PPR_RAGStatus
	                @InitiativeId	int,
	                @OverallStatus nvarchar(50),
	                @OverallStatusID int,
	                @CostStatus nvarchar(50),
	                @CostStatusID int,
	                @DeliverablesStatus nvarchar(50),
	                @DeliverablesStatusID int,
	                @TimeStatus nvarchar(50),
	                @TimeStatusID int,
	                @RisksStatus nvarchar(50),
	                @RisksStatusID int,
	                @BenefitsStatus nvarchar(50),
	                @BenefitsStatusID int,
	                @ChangedBy		nvarchar( 50 ),
	                @ChangedById	int
             * 
             * 
             */
                         

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "UpdateInitiative_PPR_RAGStatus";
            cmd.Parameters.Add("@InitiativeId", intInitiativeId);
            //            
            cmd.Parameters.Add("@OverallStatus", OverallStatus);
            cmd.Parameters.Add("@OverallStatusID", OverallStatusID);
            cmd.Parameters.Add("@CostStatus", CostStatus);
            cmd.Parameters.Add("@CostStatusID", CostStatusID);
            cmd.Parameters.Add("@DeliverablesStatus", DeliverablesStatus);
            cmd.Parameters.Add("@DeliverablesStatusID", DeliverablesStatusID);
            cmd.Parameters.Add("@TimeStatus", TimeStatus);
            cmd.Parameters.Add("@TimeStatusID", TimeStatusID);
            cmd.Parameters.Add("@RisksStatus", RisksStatus);
            cmd.Parameters.Add("@RisksStatusID", RisksStatusID);
            cmd.Parameters.Add("@BenefitsStatus", BenefitsStatus);
            cmd.Parameters.Add("@BenefitsStatusID", BenefitsStatusID);
            //
            cmd.Parameters.Add("@ChangedBy", strChangedBy);
            cmd.Parameters.Add("@ChangedById", intChangedById);
            //

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                intRecordsAffected = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            return intRecordsAffected;
        }
    }

}
