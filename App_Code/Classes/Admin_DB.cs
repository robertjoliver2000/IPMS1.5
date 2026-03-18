//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.5       CA          13/02/2007      Code to add Approval Status
//                                              drop down list.
//
//      2.2.2.8     ERW         2 Oct 2008      (Phase 2.2 Point 2.8)
//                                              Allow admin users to alter more Initiative Details.
//                                              Give users choice of applying to Current Init or ALL Inits
//                                              Added method GetAdminInitiative
//                               
//*****************************************************************************************************

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{

    //ERW 2 Oct 2008
    //simple struct to hold data that can be changed from the Admin Initiative screen
    // Holds the data and a bool to say whether the change should be applied to All versions or not
    public struct Admin_Initiative
    {
        public string Name;
        public bool AAVName;  //Apply to All Versions
        public string IGIdentifier;
        public bool AAVIGIdentifier;
        public string PrimarySBU;
        public bool AAVPrimarySBU;
    }
    

    public class Admin_DB
    {
        public static DataSet GetAdminInitiatives()
        {
            return GetAdminInitiatives(0, "", 0); 
        }

        public static DataSet GetAdminInitiative(int? InitiativeID)
        {
            return GetAdminInitiatives(InitiativeID, "", 0);            
        }

        public static DataSet GetAdminInitiatives(string SubmissionYear)
        {
            return GetAdminInitiatives(0, SubmissionYear, 0);
        }
        public static DataSet GetAdminInitiatives(int? SelectTop)
        {
            return GetAdminInitiatives(0, "", SelectTop);
        }
        public static DataSet GetAdminInitiatives(string SubmissionYear, int? SelectTop)
        {
            return GetAdminInitiatives(0, SubmissionYear, SelectTop);
        }

        /// <summary>
        /// Private method returns All Admin Initiatives or a subset of
        /// </summary>
        /// <param name="InitiativeID"></param>
        /// <param name="CurrentYear">e.g.  2008, 2007 </param>
        /// <param name="SelectTop">e.g. 10, 50, 100</param>
        /// <returns></returns>
        private static DataSet GetAdminInitiatives(int? InitiativeID, string SubmissionYear, int? SelectTop)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "GetAdminInitiatives";

             

            if (InitiativeID == null || InitiativeID <= 0)
            {
                cmdGetDS.Parameters.Add("@InitiativeID", DBNull.Value  );
            }
            else
            {
                cmdGetDS.Parameters.Add("@InitiativeID", InitiativeID);
            }

            if (SubmissionYear == null || SubmissionYear == "")
            //if (SubmissionYear == null || SubmissionYear <=0 )
            {
                cmdGetDS.Parameters.Add("@SubmissionYear", DBNull.Value );
            }
            else
            {
                cmdGetDS.Parameters.Add("@SubmissionYear", SubmissionYear);
            }

            if (SelectTop == null || SelectTop <= 0)
            {
                 cmdGetDS.Parameters.Add("@SelectTop", DBNull.Value);
            }
            else
            {
                 cmdGetDS.Parameters.Add("@SelectTop", SelectTop);
            }


            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Initiative");


            return ds;
        }

        public static DataSet GetAdminDeletedInitiatives()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetAdminDeletedInitiatives";

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Initiative");


            return ds;
        }

        public static DataSet GetAllPeriods()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetPeriods = new SqlCommand();
            cmdGetPeriods.Connection = dbConnection;

            cmdGetPeriods.CommandType = CommandType.Text;
            cmdGetPeriods.CommandText = "SELECT * from Period order by PeriodYear, Convert(int,Right(Name,4)), Name DESC";


            SqlDataAdapter daPeriods = new SqlDataAdapter(cmdGetPeriods);

            DataSet dsPeriods = new DataSet();

            daPeriods.Fill(dsPeriods, "AllPeriods");

            return dsPeriods;
        }

        public static int DeletePeriodYear(int nYear)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDel = new SqlCommand();
            cmdDel.Connection = dbConnection;

            cmdDel.CommandType = CommandType.StoredProcedure;
            cmdDel.CommandText = "spDeletePeriodYear";

            cmdDel.Parameters.Add("@PeriodYear", nYear);

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

        public static int DeleteCommitteeContact(int nCommitteeID,int nContactID)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDel = new SqlCommand();
            cmdDel.Connection = dbConnection;

            cmdDel.CommandType = CommandType.StoredProcedure;
            cmdDel.CommandText = "spDeleteCommitteeContact";

            cmdDel.Parameters.Add("@CommitteeID", nCommitteeID);
            cmdDel.Parameters.Add("@ContactID", nContactID);


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

        // rev 1.1.11
        public static int DeleteSponsorEmail(int nSponsorContactID)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDel = new SqlCommand();
            cmdDel.Connection = dbConnection;

            cmdDel.CommandType = CommandType.StoredProcedure;
            cmdDel.CommandText = "spDeleteSponsorEmail";

            cmdDel.Parameters.Add("@SponsorContactID", nSponsorContactID);
            //cmdDel.Parameters.Add("@ContactID", nContactID);


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

        public static void InsertPeriodYear(int nYear)
        {


            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertPeriodYear = new SqlCommand();
            cmdInsertPeriodYear.Connection = dbConnection;

            cmdInsertPeriodYear.CommandType = CommandType.StoredProcedure;
            cmdInsertPeriodYear.CommandText = "spInsertPeriodYear";

            cmdInsertPeriodYear.Parameters.Add("@PeriodYear", nYear);



            try
            {
                dbConnection.Open();
                cmdInsertPeriodYear.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {

            }
            finally
            {
                dbConnection.Close();
            }


        }

        public static void InsertInCommitteeContactList(int nCommitteeID,int nContactID)
        {


            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsert = new SqlCommand();
            cmdInsert.Connection = dbConnection;

            cmdInsert.CommandType = CommandType.StoredProcedure;
            cmdInsert.CommandText = "spInsertCommitteeContact";

            cmdInsert.Parameters.Add("@CommitteeID", nCommitteeID);
            cmdInsert.Parameters.Add("@ContactID", nContactID);



            try
            {
                dbConnection.Open();
                cmdInsert.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {

            }
            finally
            {
                dbConnection.Close();
            }


        }

        // rev 1.1.11
        public static void InsertSponsorEmail(int nSponsorID, string sEmailAddress)
        {


            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsert = new SqlCommand();
            cmdInsert.Connection = dbConnection;

            cmdInsert.CommandType = CommandType.StoredProcedure;
            cmdInsert.CommandText = "spInsertSponsorEmail";

            cmdInsert.Parameters.Add("@SponsorID", nSponsorID);
            cmdInsert.Parameters.Add("@mailAddress", sEmailAddress);



            try
            {
                dbConnection.Open();
                cmdInsert.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {

            }
            finally
            {
                dbConnection.Close();
            }

        }

        public static int DeleteInitiative(int nInitiativeID, bool bIncludingReviews)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDel = new SqlCommand();
            cmdDel.Connection = dbConnection;

            cmdDel.CommandType = CommandType.StoredProcedure;
            if (bIncludingReviews)
                cmdDel.CommandText = "spDeleteInitiative_AllVersions";
            else
                cmdDel.CommandText = "spDeleteInitiative";

            cmdDel.Parameters.Add("@InitiativeID", nInitiativeID);

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

        public static int ReinstateInitiative(int nInitiativeID, bool bIncludingReviews)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDel = new SqlCommand();
            cmdDel.Connection = dbConnection;

            cmdDel.CommandType = CommandType.StoredProcedure;
            if (bIncludingReviews)
                cmdDel.CommandText = "spReinstateInitiative_AllVersions";
            else
                cmdDel.CommandText = "spReinstateInitiative";

            cmdDel.Parameters.Add("@InitiativeID", nInitiativeID);

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

        /// <summary>
        /// Updates the Initiative by InitiativeID
        /// Takes Parameters for Name, IG Identifier, PrimarySBU, and Boolean values
        /// indicating whether the changes to these items should be Applied to All Versions (AAV)
        /// or not
        /// </summary>
        /// <param name="InitiativeID">The InitiativeID</param>
        /// <param name="InitiativeName">The Initiative Name</param>
        /// <param name="AAVName">Apply name change to All Versions</param>
        /// <param name="IGIdentifier">The IG Identifier</param>
        /// <param name="AAVIGIdentifier">Apply Identifier change to All Versions</param>
        /// <param name="PrimarySBU">The Primary Sponsoring Business Unit</param>
        /// <param name="AAVPrimarySBU">Apply SBU change to All Versions</param>
        /// <returns>Boolean indicating overall success or failure</returns>
        public static bool UpdateInitiative(int InitiativeID, 
                                            string InitiativeName, bool NameAAV,
                                            string IGIdentifier, bool IGIdentifierAAV,
                                            string PrimarySBU, int PrimarySBUID, bool PrimarySBUAAV)
        {
            //int nRecordsAffected;
            //SqlTransaction trans;
            bool success = false;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            //SqlCommand cmdUpdate = new SqlCommand();
            SqlCommand cmdName = new SqlCommand();
            SqlCommand cmdIdentifier = new SqlCommand();
            SqlCommand cmdPrimarySBU = new SqlCommand();

            cmdName.Connection = dbConnection;
            cmdName.CommandType = CommandType.StoredProcedure;
            //cmdUpdate.CommandText = "spUpdateInitiativeName_AllVersions";
            cmdName.CommandText = "Admin_UpdateInitiativeName";
            cmdName.Parameters.Add("@Name", InitiativeName);
            cmdName.Parameters.Add("@InitiativeID", InitiativeID);
            cmdName.Parameters.Add("@AllVersions", NameAAV);


            cmdIdentifier.Connection = dbConnection;
            cmdIdentifier.Connection = dbConnection;
            cmdIdentifier.CommandType = CommandType.StoredProcedure;
            cmdIdentifier.CommandText = "Admin_UpdateInitiativeIGIdentifier";
            cmdIdentifier.Parameters.Add("@IGIdentifier", IGIdentifier);
            cmdIdentifier.Parameters.Add("@InitiativeID", InitiativeID);
            //cmdIdentifier.Parameters.Add("@AllVersions", xxx);


            cmdPrimarySBU.Connection = dbConnection;
            cmdPrimarySBU.Connection = dbConnection;
            cmdPrimarySBU.CommandType = CommandType.StoredProcedure;
            cmdPrimarySBU.CommandText = "Admin_UpdateInitiativePrimarySBU";
            cmdPrimarySBU.Parameters.Add("@PrimarySBU", PrimarySBU);
            cmdPrimarySBU.Parameters.Add("@InitiativeID", InitiativeID);
            cmdPrimarySBU.Parameters.Add("@PrimarySBUID", PrimarySBUID);
            cmdPrimarySBU.Parameters.Add("@AllVersions", PrimarySBUAAV);


            try
            {                
                dbConnection.Open();
                //trans = dbConnection.BeginTransaction();

                cmdName.ExecuteNonQuery();
                cmdIdentifier.ExecuteNonQuery();
                cmdPrimarySBU.ExecuteNonQuery();

                success = true;
                                
                //trans.Commit();
            }
            catch (SqlException sqlE)
            {

                //ERW 9 Oct 2008
                //throw this error back to whatever called the function
                //success = false;
                throw sqlE;
            }
            finally
            {
                dbConnection.Close();
            }

            return success;

        }

        public static DataSet GetAdminInitiativeHistory(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetAdminInitiativeHistory";

            cmdGetDS.Parameters.Add("InitiativeID", intInitiativeID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Initiative");

           
            return ds;
        }

        public static DataSet GetAdminInitiativeDeletedHistory(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetAdminInitiativeDeletedHistory";

            cmdGetDS.Parameters.Add("InitiativeID", intInitiativeID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Initiative");


            return ds;
        }

        public static int GetInitiativesPerYear(int nYear)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetNbr = new SqlCommand();
            cmdGetNbr.Connection = dbConnection;

            DateTime dt = new DateTime(nYear, 1, 1, 0, 0,1);
            
            //dt.Hour = 0;
            //dt.Minute = 0;
            //dt.Second = 1;

            cmdGetNbr.CommandType = CommandType.Text;
            cmdGetNbr.CommandText = "SELECT COUNT(*) FROM Initiative WHERE SubmissionDate>=@ParmDate";
            cmdGetNbr.Parameters.Add("@ParmDate", dt);

            object obj;

            dbConnection.Open();
            obj = cmdGetNbr.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (Int32)obj;

            return -1;
        }

        public static DataSet GetCommitteeContactList(int intCommitteeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;
            cmdGetDS.CommandText = "SELECT CommitteeContact.CommitteeID, Reference.Description AS Committee, " + 
                                            "CommitteeContact.ContactID as ContactID, Login, Salutation, Surname, Firstname, " + 
                                            "Firstname + ' ' + Surname AS Name, [Email] As EmailAddress " + 
                                        "FROM CommitteeContact " + 
                                        "JOIN Reference ON Reference.CategoryID=4 AND Reference.ReferenceID=CommitteeContact.CommitteeID " + 
                                        "JOIN Contacts ON Contacts.[ContactID]=CommitteeContact.ContactID " + 
                                        "WHERE CommitteeID=@CommitteeID ";

            cmdGetDS.Parameters.Add("@CommitteeID", intCommitteeID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Contacts");

            return ds;
        }
        //rem CA
        //public static int InsertInitiative(string strIGName,string strBusinessAreaCode,
        //                            string strIGIdentifierCode,string strApprovalCommmitee,DateTime dt)
        //end rem

        //rev 1.1.5 CA
        public static int InsertInitiative(string strIGName,string strBusinessAreaCode,
                                    string strIGIdentifierCode, string strApprovalCommmitee, DateTime dt, string strApprovalStatus, int iApprovalID)
        //end rev
        {

           int nReturn = 0;

            int nSecurityID;
            try
            {
                nSecurityID = Convert.ToInt32(ConfigurationSettings.AppSettings["DefaultSecurityID"]);
            }
            catch (Exception e1)
            {
                nSecurityID = -1;
            }

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdInsertInitiative = new SqlCommand();
            cmdInsertInitiative.Connection = dbConnection;

            cmdInsertInitiative.CommandType = CommandType.StoredProcedure;
            cmdInsertInitiative.CommandText = "spInsertAdminInitiative";

            
            cmdInsertInitiative.Parameters.Add("@IGBusinessAreaCode", strBusinessAreaCode);
            cmdInsertInitiative.Parameters.Add("@IGIdentifierCode", strIGIdentifierCode);
            cmdInsertInitiative.Parameters.Add("@Name", strIGName);
            cmdInsertInitiative.Parameters.Add("@IGApprovalCommittee", strApprovalCommmitee);
            cmdInsertInitiative.Parameters.Add("@SubmissionDate", dt);
            cmdInsertInitiative.Parameters.Add("@SecurityID", nSecurityID);

            //rev 1.1.5 CA
            cmdInsertInitiative.Parameters.Add("@IGApprovalStatus", strApprovalStatus);
            cmdInsertInitiative.Parameters.Add("@IGApprovalID", iApprovalID);
            //end rev

            SqlParameter parmReturn = new SqlParameter("@Return_Value", SqlDbType.Int);
            cmdInsertInitiative.Parameters.Add(parmReturn);
            parmReturn.Direction = ParameterDirection.ReturnValue;

            try
            {
                dbConnection.Open();
                cmdInsertInitiative.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {

            }
            finally
            {
                dbConnection.Close();
            }

            if (parmReturn.Value != null && parmReturn.Value != DBNull.Value)
            {
                nReturn = Convert.ToInt32(parmReturn.Value);
            }
            
            //if -1 the initiative already exists
            return nReturn;
        }

        public static int Reopen(int nInitiativeID)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdate = new SqlCommand();
            cmdUpdate.Connection = dbConnection;

            cmdUpdate.CommandType = CommandType.StoredProcedure;
            cmdUpdate.CommandText = "spReopenInitiative";

            cmdUpdate.Parameters.Add("@InitiativeID", nInitiativeID);

            try
            {
                dbConnection.Open();
                nRecordsAffected = cmdUpdate.ExecuteNonQuery();
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
}
