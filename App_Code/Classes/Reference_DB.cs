/*
 *  Rev             By          Date            Description
 * ---------------------------------------------------------------------------------------------------------------
 *  1.8.1           GMcF        2007-09-18      Amended for maint of Secondary Functional Domain
 *                                              Variation with extra column for ParentReferenceId ( Primary Functional Domain )
 * 
 * ota 739 / 740    ERW         15 Oct 2008     Added CheckSortOrder()
 
 */

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{

    /// <summary>
    /// Summary description for Reference_DB
    /// </summary>
    public class Reference_DB
    {

        public static int UpdateReference(int intCategoryID, int intReferenceID, string strNewDescription)
        {
            DataSet dsCategoryField = GetCategoryFieldTable(intCategoryID);

            int intRecordsAffected, intColumnsAffected = 0;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            try
            {
                dbConnection.Open();
            }
            catch(SqlException ex)
            {
                return -1;
            }

            SqlCommand cmdUpdateReference = new SqlCommand();
            cmdUpdateReference.Connection = dbConnection;

            cmdUpdateReference.CommandType = CommandType.Text;
            cmdUpdateReference.CommandText = "UPDATE Reference SET Description = @NewDescription " +
                                "WHERE CategoryID=@CategoryID AND ReferenceID=@ReferenceID ";

            cmdUpdateReference.Parameters.Add("@NewDescription", strNewDescription);
            cmdUpdateReference.Parameters.Add("@CategoryID", intCategoryID);
            cmdUpdateReference.Parameters.Add("@ReferenceID", intReferenceID);

            try
            {
                intRecordsAffected = cmdUpdateReference.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }

            string strAffectedFinancialCategories = GetAffectedFinancialCategories(intCategoryID);

            foreach (DataRow drCategoryField in dsCategoryField.Tables["CategoryField"].Rows)
            {
                SqlCommand cmdUpdateDescription = new SqlCommand();
                cmdUpdateDescription.Connection = dbConnection;

                cmdUpdateDescription.CommandType = CommandType.Text;
                cmdUpdateDescription.CommandText = "UPDATE " + drCategoryField["TableName"] + 
                                        " SET [" + drCategoryField["ColumnName"] + "] = @NewDescription " + 
                                        " WHERE [" + drCategoryField["IDColumnName"] + "] = @ReferenceID ";

                if (drCategoryField["TableName"].ToString() == "InitiativeFinancial")
                {
                    cmdUpdateDescription.CommandText += " AND CategoryID IN " + strAffectedFinancialCategories;
                }

                if (drCategoryField["TableName"].ToString() == "InitiativeITPolicy")
                {
                    cmdUpdateDescription.CommandText += " AND ITPolicyID = " + drCategoryField["ITPolicyID"].ToString();
                }

                cmdUpdateDescription.Parameters.Add("@NewDescription", strNewDescription);
                cmdUpdateDescription.Parameters.Add("@ReferenceID", intReferenceID);

                try
                {
                    intRecordsAffected = cmdUpdateDescription.ExecuteNonQuery();
                    intColumnsAffected++;
                }
                catch (SqlException ex)
                {
                    intRecordsAffected = -1;
                }
            }

            dbConnection.Close();


            //ERW 15 Oct 2008 as part of ota 739 / 740
            CheckSortOrder( intCategoryID );


            return intColumnsAffected;
        }


        //Added 2007-02-21 GMcF for Phase 1.5 Deliverable 77 - IG Approval Status Approved/Not Approved/Neutral
        public static int UpdateReference(int intCategoryID, int intReferenceID, string strNewDescription, int intReportingCategory)
        {
            DataSet dsCategoryField = GetCategoryFieldTable(intCategoryID);

            int intRecordsAffected, intColumnsAffected = 0;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            try
            {
                dbConnection.Open();
            }
            catch (SqlException ex)
            {
                return -1;
            }

            SqlCommand cmdUpdateReference = new SqlCommand();
            cmdUpdateReference.Connection = dbConnection;

            cmdUpdateReference.CommandType = CommandType.Text;
            cmdUpdateReference.CommandText = "UPDATE Reference SET Description = @NewDescription " +
                                "ReportingCategory = @ReportingCategory " +
                                "WHERE CategoryID=@CategoryID AND ReferenceID=@ReferenceID ";

            cmdUpdateReference.Parameters.Add("@NewDescription", strNewDescription);
            cmdUpdateReference.Parameters.Add("@ReportingCategory", intReportingCategory);
            cmdUpdateReference.Parameters.Add("@CategoryID", intCategoryID);
            cmdUpdateReference.Parameters.Add("@ReferenceID", intReferenceID);

            try
            {
                intRecordsAffected = cmdUpdateReference.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }

            string strAffectedFinancialCategories = GetAffectedFinancialCategories(intCategoryID);

            foreach (DataRow drCategoryField in dsCategoryField.Tables["CategoryField"].Rows)
            {
                SqlCommand cmdUpdateDescription = new SqlCommand();
                cmdUpdateDescription.Connection = dbConnection;

                cmdUpdateDescription.CommandType = CommandType.Text;
                cmdUpdateDescription.CommandText = "UPDATE " + drCategoryField["TableName"] +
                                        " SET [" + drCategoryField["ColumnName"] + "] = @NewDescription " +
                                        " WHERE [" + drCategoryField["IDColumnName"] + "] = @ReferenceID ";

                if (drCategoryField["TableName"].ToString() == "InitiativeFinancial")
                {
                    cmdUpdateDescription.CommandText += " AND CategoryID IN " + strAffectedFinancialCategories;
                }

                if (drCategoryField["TableName"].ToString() == "InitiativeITPolicy")
                {
                    cmdUpdateDescription.CommandText += " AND ITPolicyID = " + drCategoryField["ITPolicyID"].ToString();
                }

                cmdUpdateDescription.Parameters.Add("@NewDescription", strNewDescription);
                cmdUpdateDescription.Parameters.Add("@ReferenceID", intReferenceID);

                try
                {
                    intRecordsAffected = cmdUpdateDescription.ExecuteNonQuery();
                    intColumnsAffected++;
                }
                catch (SqlException ex)
                {
                    intRecordsAffected = -1;
                }
            }

            dbConnection.Close();

            return intColumnsAffected;
        }
        //End of code added 2007-02-21


        // Rev 1.8.1 GMcF
        public static int UpdateReferenceWithParent(int intCategoryID, int intReferenceID, string strNewDescription, int intParentReferenceID)
        {
            DataSet dsCategoryField = GetCategoryFieldTable(intCategoryID);

            int intRecordsAffected, intColumnsAffected = 0;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            try
            {
                dbConnection.Open();
            }
            catch (SqlException ex)
            {
                return -1;
            }

            SqlCommand cmdUpdateReference = new SqlCommand();
            cmdUpdateReference.Connection = dbConnection;

            cmdUpdateReference.CommandType = CommandType.StoredProcedure;
            cmdUpdateReference.CommandText = "spUpdateReferenceWithParent";

            cmdUpdateReference.Parameters.Add("@NewDescription", strNewDescription);
            cmdUpdateReference.Parameters.Add("@ParentReferenceID", intParentReferenceID);
            cmdUpdateReference.Parameters.Add("@CategoryID", intCategoryID);
            cmdUpdateReference.Parameters.Add("@ReferenceID", intReferenceID);

            try
            {
                intRecordsAffected = cmdUpdateReference.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intRecordsAffected = -1;
            }

            dbConnection.Close();

            intColumnsAffected = UpdateAffectedCategories(intCategoryID, intReferenceID, strNewDescription);

            return intColumnsAffected;
        }
        // End of Rev 1.8.1


        // Rev 1.8.1 GMcF
        protected static int UpdateAffectedCategories(int intCategoryID, int intReferenceID, string strNewDescription)
        {
            DataSet dsCategoryField = GetCategoryFieldTable(intCategoryID);

            int intRecordsAffected, intColumnsAffected = 0;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            try
            {
                dbConnection.Open();
            }
            catch (SqlException ex)
            {
                return -1;
            }

            string strAffectedFinancialCategories = GetAffectedFinancialCategories(intCategoryID);

            foreach (DataRow drCategoryField in dsCategoryField.Tables["CategoryField"].Rows)
            {
                SqlCommand cmdUpdateDescription = new SqlCommand();
                cmdUpdateDescription.Connection = dbConnection;

                cmdUpdateDescription.CommandType = CommandType.Text;
                cmdUpdateDescription.CommandText = "UPDATE " + drCategoryField["TableName"] +
                                        " SET [" + drCategoryField["ColumnName"] + "] = @NewDescription " +
                                        " WHERE [" + drCategoryField["IDColumnName"] + "] = @ReferenceID ";

                if (drCategoryField["TableName"].ToString() == "InitiativeFinancial")
                {
                    cmdUpdateDescription.CommandText += " AND CategoryID IN " + strAffectedFinancialCategories;
                }

                if (drCategoryField["TableName"].ToString() == "InitiativeITPolicy")
                {
                    cmdUpdateDescription.CommandText += " AND ITPolicyID = " + drCategoryField["ITPolicyID"].ToString();
                }

                cmdUpdateDescription.Parameters.Add("@NewDescription", strNewDescription);
                cmdUpdateDescription.Parameters.Add("@ReferenceID", intReferenceID);

                try
                {
                    intRecordsAffected = cmdUpdateDescription.ExecuteNonQuery();
                    intColumnsAffected++;
                }
                catch (SqlException ex)
                {
                    intRecordsAffected = -1;
                }
            }

            dbConnection.Close();

            return intColumnsAffected;
        }
        // End of Rev 1.8.1


        public static DataSet GetCategoryFieldTable(int intCategoryID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;
            cmdGetDS.CommandText =
                        "SELECT CategoryID, TableName, ColumnName, IDColumnName, NULL AS ITPolicyID " +
                            "FROM CategoryField " +
                            "WHERE CategoryID=@CategoryID " +
                        "UNION " +
                        "SELECT ITPolicy.CategoryID AS CategoryID, 'InitiativeITPolicy' AS TableName, " +
                                    "'ITPolicyValue' AS ColumnName, 'ITPolicyValueID' AS IDColumnName, " +
                                    "ITPolicy.ITPolicyID AS ITPolicyID " +
                            "FROM ITPolicy " +
                            "JOIN ReferenceCategory ON ReferenceCategory.CategoryID = ITPolicy.CategoryID " +
                            "WHERE ITPolicy.CategoryID=@CategoryID "
                        ;

            cmdGetDS.Parameters.Add("@CategoryID", intCategoryID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "CategoryField");

            return ds;
        }


        public static DataSet GetReferenceCategoryTable()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            //ERW 
            //26 Sept 2008
            // OTA 738
            //cmdGetDS.CommandType = CommandType.Text;
            //cmdGetDS.CommandText = "SELECT * FROM ReferenceCategory WHERE IsEditable=1";
            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "ReferenceCategory_Search";
            cmdGetDS.Parameters.Add("@CategoryID", DBNull.Value  );  
            cmdGetDS.Parameters.Add("@Description", DBNull.Value  );
            cmdGetDS.Parameters.Add("@IsEditable", 1);  


            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "ReferenceCategory");

            return ds;
        }


        public static int GetMaxReferenceID(int intCategoryID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetMaxID = new SqlCommand();
            cmdGetMaxID.Connection = dbConnection;

            cmdGetMaxID.CommandType = CommandType.Text;
            cmdGetMaxID.CommandText = "SELECT MAX(ReferenceID) FROM Reference WHERE CategoryID=@CategoryID";

            cmdGetMaxID.Parameters.Add("@CategoryID", intCategoryID);

            object obj;

            dbConnection.Open();
            obj = cmdGetMaxID.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (Int32)obj;

            return 0;
        }


        public static int DeleteReference(int intCategoryID, int intReferenceID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDeleteReference = new SqlCommand();
            cmdDeleteReference.Connection = dbConnection;

            cmdDeleteReference.CommandType = CommandType.Text;
            cmdDeleteReference.CommandText = "DELETE Reference " +
                                "WHERE CategoryID=@CategoryID AND ReferenceID=@ReferenceID ";

            cmdDeleteReference.Parameters.Add("@CategoryID", intCategoryID);
            cmdDeleteReference.Parameters.Add("@ReferenceID", intReferenceID);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdDeleteReference.ExecuteNonQuery();
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


        public static string GetReferenceDescription(int intCategoryID, int intReferenceID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetReference = new SqlCommand();
            cmdGetReference.Connection = dbConnection;

            cmdGetReference.CommandType = CommandType.Text;
            cmdGetReference.CommandText = "SELECT Description FROM Reference " + 
                        "WHERE CategoryID=@CategoryID AND ReferenceID=@ReferenceID ";

            cmdGetReference.Parameters.Add("@CategoryID", intCategoryID);
            cmdGetReference.Parameters.Add("@ReferenceID", intReferenceID);

            object obj;

            dbConnection.Open();
            obj = cmdGetReference.ExecuteScalar();
            dbConnection.Close();

            return obj.ToString();
        }


        protected static string GetAffectedFinancialCategories(int intReferenceCategoryID)
        {
            string strAffectedFinancialCategories = String.Empty;

            switch (intReferenceCategoryID)
            {
                case 9:
                    strAffectedFinancialCategories = "(1)";
                    break;

                case 10:
                    strAffectedFinancialCategories = "(1)";
                    break;

                case 11:
                    strAffectedFinancialCategories = "(2, 3)";
                    break;

                case 12:
                    strAffectedFinancialCategories = "(2)";
                    break;

                case 13:
                    strAffectedFinancialCategories = "(3)";
                    break;

                case 14:
                    strAffectedFinancialCategories = "(4, 5)";
                    break;

                case 15:
                    strAffectedFinancialCategories = "(4)";
                    break;

                case 32:
                    strAffectedFinancialCategories = "(5)";
                    break;

                case 16:
                    strAffectedFinancialCategories = "(6, 7, 8)";
                    break;

                case 17:
                    strAffectedFinancialCategories = "(6)";
                    break;

                case 18:
                    strAffectedFinancialCategories = "(8)";
                    break;

                case 19:
                    strAffectedFinancialCategories = "(7)";
                    break;
            }

            return strAffectedFinancialCategories;
        }


        public static int DeleteApplication(int intApplicationID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDeleteApplication = new SqlCommand();
            cmdDeleteApplication.Connection = dbConnection;

            cmdDeleteApplication.CommandType = CommandType.Text;
            cmdDeleteApplication.CommandText = "DELETE Application WHERE ApplicationID=@ApplicationID ";

            cmdDeleteApplication.Parameters.Add("@ApplicationID", intApplicationID);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdDeleteApplication.ExecuteNonQuery();
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


        public static int DeleteServer(int intServerID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDeleteServer = new SqlCommand();
            cmdDeleteServer.Connection = dbConnection;

            cmdDeleteServer.CommandType = CommandType.Text;
            cmdDeleteServer.CommandText = "DELETE Server WHERE ServerID=@ServerID ";

            cmdDeleteServer.Parameters.Add("@ServerID", intServerID);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdDeleteServer.ExecuteNonQuery();
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


        public static int DeleteSponsor(int intSponsorID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDeleteServer = new SqlCommand();
            cmdDeleteServer.Connection = dbConnection;

            cmdDeleteServer.CommandType = CommandType.Text;
            cmdDeleteServer.CommandText = "DELETE Sponsor WHERE SponsorID=@SponsorID ";

            cmdDeleteServer.Parameters.Add("@SponsorID", intSponsorID);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdDeleteServer.ExecuteNonQuery();
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


        public static int GetMaxApplicationID()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetMaxID = new SqlCommand();
            cmdGetMaxID.Connection = dbConnection;

            cmdGetMaxID.CommandType = CommandType.Text;
            cmdGetMaxID.CommandText = "SELECT MAX(ApplicationID) FROM Application";

            object obj;

            dbConnection.Open();
            obj = cmdGetMaxID.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (Int32)obj;

            return -1;
        }


        public static int GetMaxServerID()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetMaxID = new SqlCommand();
            cmdGetMaxID.Connection = dbConnection;

            cmdGetMaxID.CommandType = CommandType.Text;
            cmdGetMaxID.CommandText = "SELECT MAX(ServerID) FROM Server";

            object obj;

            dbConnection.Open();
            obj = cmdGetMaxID.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (Int32)obj;

            return -1;
        }


        public static int GetMaxSponsorID()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetMaxID = new SqlCommand();
            cmdGetMaxID.Connection = dbConnection;

            cmdGetMaxID.CommandType = CommandType.Text;
            cmdGetMaxID.CommandText = "SELECT MAX(SponsorID) FROM Sponsor";

            object obj;

            dbConnection.Open();
            obj = cmdGetMaxID.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return (Int32)obj;

            return -1;
        }




        public static string GetApplicationName(int intApplicationID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetReference = new SqlCommand();
            cmdGetReference.Connection = dbConnection;

            cmdGetReference.CommandType = CommandType.Text;
            cmdGetReference.CommandText = "SELECT ApplicationInstanceName FROM Application " +
                        "WHERE ApplicationID=@ApplicationID ";

            cmdGetReference.Parameters.Add("@ApplicationID", intApplicationID);

            object obj;

            dbConnection.Open();
            obj = cmdGetReference.ExecuteScalar();
            dbConnection.Close();

            return obj.ToString();
        }


        public static string GetServerName(int intServerID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetReference = new SqlCommand();
            cmdGetReference.Connection = dbConnection;

            cmdGetReference.CommandType = CommandType.Text;
            cmdGetReference.CommandText = "SELECT ServerNodeName FROM Server " +
                        "WHERE ServerID=@ServerID ";

            cmdGetReference.Parameters.Add("@ServerID", intServerID);

            object obj;

            dbConnection.Open();
            obj = cmdGetReference.ExecuteScalar();
            dbConnection.Close();

            return obj.ToString();
        }

        /// <summary>
        ///  For a given Sponsor ID, returns the name of the sponsor
        /// </summary>
        /// <param name="intSponsorID">Sponsor ID (integer)</param>
        /// <returns>Sponsor Name (string)</returns>
        public static string GetSponsorName(int intSponsorID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetReference = new SqlCommand();
            cmdGetReference.Connection = dbConnection;

            cmdGetReference.CommandType = CommandType.Text;
            cmdGetReference.CommandText = "SELECT Name FROM Sponsor " +
                        "WHERE SponsorID=@SponsorID ";

            cmdGetReference.Parameters.Add("@SponsorID", intSponsorID);

            object obj;

            dbConnection.Open();
            obj = cmdGetReference.ExecuteScalar();
            dbConnection.Close();

            return obj.ToString();
        }

        //ERW 15 Oct 2008
        //ota 739 / 741
        /// <summary>
        /// Runs a check on the current sort order of the parameter category, changing
        /// the sort order if necessary.  Runs in conjunction with Sort Order options set in
        /// the Options table.  As of 15 Oct 2008 this is not user configurable
        /// </summary>
        /// <param name="CategoryID">The category for which sorting should be checked</param>
        public static void CheckSortOrder(int CategoryID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Reference_CheckSortOrder";


            cmd.Parameters.Add("@CategoryID", CategoryID);

            dbConnection.Open();
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                   // if there is an exception it will probably be because the Sort Option
                    // in the Options table is malformed.
                //For now throw this exception
                throw ex;
            }
            finally
            {
                dbConnection.Close();
            }

            //return obj.ToString();            
        }

        //Consider extending to other tables - e.g. Sponsor if req'd
        //public static void CheckSortOrder(string TableName)
        //{ }
    }
}
