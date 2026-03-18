//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1         JG          22/02/2007      Added overload static method 
//                                              GetInitiativeDetails(int intInitiativeID, bool useStoredProc )
//                                              which uses contains further parameter to make use of stored Proc 
//
//      1.6.1       GMcF        15/08/2007      Added routines for initiative sponsor UBR allocation maintenance
//                                              for Phase 1.6 Deliverable 93
//
//*****************************************************************************************************


using System;
using System.Data;
using System.Data.SqlClient;

namespace ProjectPortfolio.Classes
{
	/// <summary>
	/// Summary description for SectionB_SponsorAllocations_DB.
	/// </summary>
	public class SectionB_SponsorAllocations_DB
	{

        public static int UpdateInitiative(int intInitiativeID,
                                        string strAllocationsAgreed, int intAllocationsAgreedID,
                                        string strInitiativeBudgeted, int intInitiativeBudgeted,
                                        string strBasisForAllocation, int intBasisForAllocation,
                                        string strBasisForAllocationDescription
                                        )
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiative = new SqlCommand();
            cmdUpdateInitiative.Connection = dbConnection;

            cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionB_SponsorAllocations";

            cmdUpdateInitiative.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateInitiative.Parameters.Add("@AllocationsAgreed", strAllocationsAgreed);
            cmdUpdateInitiative.Parameters.Add("@AllocationsAgreedID", intAllocationsAgreedID);
            cmdUpdateInitiative.Parameters.Add("@InitiativeBudgeted", strInitiativeBudgeted);
            cmdUpdateInitiative.Parameters.Add("@InitiativeBudgetedID", intInitiativeBudgeted);
            cmdUpdateInitiative.Parameters.Add("@BasisForAllocation", strBasisForAllocation);
            cmdUpdateInitiative.Parameters.Add("@BasisForAllocationID", intBasisForAllocation);
            cmdUpdateInitiative.Parameters.Add("@BasisForAllocationDescription",
                                                    strBasisForAllocationDescription);

            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdUpdateInitiative.ExecuteNonQuery();
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

        public static int InsertInitiativeSponsorUBRAllocation(int initiativeID, int sponsorID, string ubrCode,
                                                                decimal ubrAllocation, bool isPercentage)
        {
            int nReturn = 0;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());
            SqlCommand cmdInsert = new SqlCommand();

            cmdInsert.Connection = dbConnection;
            cmdInsert.CommandType = CommandType.StoredProcedure;
            cmdInsert.CommandText = "spInsertInitiativeSponsorUBRAllocation";

            cmdInsert.Parameters.Add("@InitiativeID", initiativeID);
            cmdInsert.Parameters.Add("@SponsorID", sponsorID);
            cmdInsert.Parameters.Add("@UBRCode", ubrCode);
            cmdInsert.Parameters.Add("@UBRAllocation", ubrAllocation);
            cmdInsert.Parameters.Add("@Percentage", (isPercentage ? 1 : 0));

            SqlParameter parmReturn = new SqlParameter("@InitiativeSponsorUBRAllocationID", SqlDbType.Int);
            cmdInsert.Parameters.Add(parmReturn);
            parmReturn.Direction = ParameterDirection.ReturnValue;

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

            if (parmReturn.Value != null && parmReturn.Value != DBNull.Value)
            {
                nReturn = Convert.ToInt32(parmReturn.Value);
            }

            //if -1 the initiative already exists
            return nReturn;
        }

        public static int InsertInitiativeSponsorUBRAllocationForEdit(string sessionID, int initiativeID, int sponsorID, string ubrCode,
                                                                decimal ubrAllocation, bool isPercentage)
        {
            int nReturn = 0;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());
            SqlCommand cmdInsert = new SqlCommand();

            cmdInsert.Connection = dbConnection;
            cmdInsert.CommandType = CommandType.StoredProcedure;
            cmdInsert.CommandText = "spInsertInitiativeSponsorUBRAllocationForEdit";

            cmdInsert.Parameters.Add("@SessionID", sessionID);
            cmdInsert.Parameters.Add("@InitiativeID", initiativeID);
            cmdInsert.Parameters.Add("@SponsorID", sponsorID);
            cmdInsert.Parameters.Add("@UBRCode", ubrCode);
            cmdInsert.Parameters.Add("@UBRAllocation", ubrAllocation);
            cmdInsert.Parameters.Add("@Percentage", (isPercentage ? 1 : 0));

            SqlParameter parmReturn = new SqlParameter("@InitiativeSponsorUBRAllocationID", SqlDbType.Int);
            cmdInsert.Parameters.Add(parmReturn);
            parmReturn.Direction = ParameterDirection.ReturnValue;

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

            if (parmReturn.Value != null && parmReturn.Value != DBNull.Value)
            {
                nReturn = Convert.ToInt32(parmReturn.Value);
            }

            //if -1 the initiative already exists
            return nReturn;
        }

        public static void DeleteInitiativeSponsorUBRAllocations(int initiativeID, int sponsorID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());
            SqlCommand cmdDelete = new SqlCommand();

            cmdDelete.Connection = dbConnection;
            cmdDelete.CommandType = CommandType.StoredProcedure;
            cmdDelete.CommandText = "spDeleteInitiativeSponsorUBRAllocations";

            cmdDelete.Parameters.Add("@InitiativeID", initiativeID);
            cmdDelete.Parameters.Add("@SponsorID", sponsorID);

            try
            {
                dbConnection.Open();
                cmdDelete.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
            }
            finally
            {
                dbConnection.Close();
            }

        }

        public static void DeleteInitiativeSponsorUBRAllocationsForEdit(string sessionID, int initiativeID, int sponsorID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());
            SqlCommand cmdDelete = new SqlCommand();

            cmdDelete.Connection = dbConnection;
            cmdDelete.CommandType = CommandType.StoredProcedure;
            cmdDelete.CommandText = "spDeleteInitiativeSponsorUBRAllocationsForEdit";

            cmdDelete.Parameters.Add("@SessionID", sessionID);
            cmdDelete.Parameters.Add("@InitiativeID", initiativeID);
            cmdDelete.Parameters.Add("@SponsorID", sponsorID);

            try
            {
                dbConnection.Open();
                cmdDelete.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
            }
            finally
            {
                dbConnection.Close();
            }

        }

        public static DataSet GetInitiativeSponsorUBRAllocation(int initiativeID, int sponsorID, int includePrev)
        {
            try
            {
                SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

                SqlCommand cmdGetInitiative = new SqlCommand();
                cmdGetInitiative.Connection = dbConnection;

                cmdGetInitiative.CommandType = CommandType.StoredProcedure;
                cmdGetInitiative.CommandText = "spGetInitiativeSponsorUBRAllocation";

                cmdGetInitiative.Parameters.Add("@InitiativeID", initiativeID);
                cmdGetInitiative.Parameters.Add("@SponsorID", sponsorID);
                cmdGetInitiative.Parameters.Add("@IncludePrevVersion", includePrev);

                SqlDataAdapter daGetInitiative = new SqlDataAdapter(cmdGetInitiative);

                DataSet dsInitiative = new DataSet();

                daGetInitiative.Fill(dsInitiative, "SponsorAllocations");
                return dsInitiative;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static DataSet GetInitiativeSponsorUBRAllocationForEdit(int initiativeID, int sponsorID, string sessionID, int storeSponsorLevel, int includePrev)
        {
            try
            {
                SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

                SqlCommand cmdGetInitiative = new SqlCommand();
                cmdGetInitiative.Connection = dbConnection;

                cmdGetInitiative.CommandType = CommandType.StoredProcedure;
                cmdGetInitiative.CommandText = "spGetInitiativeSponsorUBRAllocationForEdit";

                cmdGetInitiative.Parameters.Add("@InitiativeID", initiativeID);
                cmdGetInitiative.Parameters.Add("@SponsorID", sponsorID);
                cmdGetInitiative.Parameters.Add("@SessionID", sessionID);
                cmdGetInitiative.Parameters.Add("@storeSponsorLevel", storeSponsorLevel);
                cmdGetInitiative.Parameters.Add("@IncludePrevVersion", includePrev);

                SqlDataAdapter daGetInitiative = new SqlDataAdapter(cmdGetInitiative);

                DataSet dsInitiative = new DataSet();

                daGetInitiative.Fill(dsInitiative, "SponsorAllocations");
                return dsInitiative;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static DataRow GetInitiativeDetails(int intInitiativeID)
        {
            DataRow drInitiative = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiative = new SqlCommand();
            cmdGetInitiative.Connection = dbConnection;

            cmdGetInitiative.CommandType = CommandType.Text;
            cmdGetInitiative.CommandText = "SELECT * FROM Initiative WHERE InitiativeID=@InitiativeID";

            cmdGetInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter daGetInitiative = new SqlDataAdapter(cmdGetInitiative);

            DataSet dsInitiative = new DataSet();

            try
            {
                daGetInitiative.Fill(dsInitiative, "Initiative");
            }
            catch (SqlException)
            {
                drInitiative = null;
            }

            if (dsInitiative.Tables["Initiative"] != null && dsInitiative.Tables["Initiative"].Rows.Count > 0)
            {
                drInitiative = dsInitiative.Tables["Initiative"].Rows[0];
            }

            return drInitiative;
        }

        public static DataRow GetInitiativeDetails(int intInitiativeID, bool useStoredProc )
        {
            if (!useStoredProc)
            {
                return GetInitiativeDetails(intInitiativeID);
            }
            else
            {
                DataRow drInitiative = null;

                SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

                SqlCommand cmdGetInitiative = new SqlCommand();
                cmdGetInitiative.Connection = dbConnection;

                cmdGetInitiative.CommandType = CommandType.StoredProcedure;
                cmdGetInitiative.CommandText = "spGetSingleInitiative";

                cmdGetInitiative.Parameters.Add("@InitiativeID", intInitiativeID);

                SqlDataAdapter daGetInitiative = new SqlDataAdapter(cmdGetInitiative);

                DataSet dsInitiative = new DataSet();

                try
                {
                    daGetInitiative.Fill(dsInitiative, "Initiative");
                }
                catch (SqlException)
                {
                    drInitiative = null;
                }

                if (dsInitiative.Tables["Initiative"] != null && dsInitiative.Tables["Initiative"].Rows.Count > 0)
                {
                    drInitiative = dsInitiative.Tables["Initiative"].Rows[0];
                }
                return drInitiative;
            }
        }

        public static DataSet GetSponsors()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetSponsors = new SqlCommand();
            cmdGetSponsors.Connection = dbConnection;

            cmdGetSponsors.CommandType = CommandType.Text;
            cmdGetSponsors.CommandText = "SELECT * FROM Sponsor order by SortOrder";    //2007-08-06, GMcF: Added sort

            SqlDataAdapter daSponsors = new SqlDataAdapter(cmdGetSponsors);

            DataSet dsSponsors = new DataSet();

            daSponsors.FillSchema(dsSponsors, SchemaType.Source, "Sponsor");
            daSponsors.Fill(dsSponsors, "Sponsor");

            return dsSponsors;
        }

        public static string GetSponsorType(int sponsorId)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetSponsors = new SqlCommand();
            cmdGetSponsors.Connection = dbConnection;

            cmdGetSponsors.CommandType = CommandType.Text;
            cmdGetSponsors.CommandText = "SELECT Shortname FROM Sponsor WHERE SponsorID = " + sponsorId;

            dbConnection.Open();
            object objReturn = cmdGetSponsors.ExecuteScalar();
            dbConnection.Close();

            if (objReturn != null && objReturn != DBNull.Value)
                return objReturn.ToString();
            else
                return "";
        }

        public static int GetSponsorID(string sponsorType)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetSponsors = new SqlCommand();
            cmdGetSponsors.Connection = dbConnection;

            cmdGetSponsors.CommandType = CommandType.Text;
            cmdGetSponsors.CommandText = "SELECT SponsorID FROM Sponsor WHERE Shortname='" + sponsorType + "'";

            dbConnection.Open();
            object objReturn = cmdGetSponsors.ExecuteScalar();
            dbConnection.Close();

            if (objReturn != null && objReturn != DBNull.Value)
                return Convert.ToInt32(objReturn);

            return -1;
        }

        public static DataSet GetSponsorMapping()
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetSponsors = new SqlCommand();
            cmdGetSponsors.Connection = dbConnection;

            cmdGetSponsors.CommandType = CommandType.StoredProcedure;
            cmdGetSponsors.CommandText = "spGetSponsorMapping";

            SqlDataAdapter daSponsors = new SqlDataAdapter(cmdGetSponsors);

            DataSet dsSponsors = new DataSet();

            daSponsors.FillSchema(dsSponsors, SchemaType.Source, "Sponsor");
            daSponsors.Fill(dsSponsors, "Sponsor");

            return dsSponsors;
        }

        public static DataSet GetSponsorUBRMapping( string sponsorType )
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetSponsorUBRs = new SqlCommand();
            cmdGetSponsorUBRs.Connection = dbConnection;

            cmdGetSponsorUBRs.CommandType = CommandType.StoredProcedure;
            cmdGetSponsorUBRs.CommandText = "spGetSponsorUBRMapping";
            cmdGetSponsorUBRs.Parameters.Add("@SponsorType", sponsorType );

            SqlDataAdapter daSponsors = new SqlDataAdapter(cmdGetSponsorUBRs);

            DataSet dsSponsors = new DataSet();

            daSponsors.FillSchema(dsSponsors, SchemaType.Source, "Sponsor");
            daSponsors.Fill(dsSponsors, "Sponsor");

            return dsSponsors;
        }

        public static DataSet GetSponsorValues(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetSponsorValues = new SqlCommand();
            cmdGetSponsorValues.Connection = dbConnection;

            cmdGetSponsorValues.CommandType = CommandType.Text;
            cmdGetSponsorValues.CommandText = "SELECT * FROM InitiativeSponsor " +
                                                "JOIN Sponsor ON InitiativeSponsor.SponsorID = Sponsor.SponsorID " +
                                              " WHERE InitiativeSponsor.InitiativeID=@InitiativeID";

            cmdGetSponsorValues.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter daSponsorValues = new SqlDataAdapter(cmdGetSponsorValues);

            DataSet dsSponsorValues = new DataSet();

            daSponsorValues.FillSchema(dsSponsorValues, SchemaType.Source, "SponsorValue");
            daSponsorValues.Fill(dsSponsorValues, "SponsorValue");

            return dsSponsorValues;
        }

        public static int UpdateSponsorValue(int intInitiativeID, int intSponsorID, decimal dAllocation, bool bStoreSponsorLevel, string strSessionID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiativeValue = new SqlCommand();
            cmdUpdateInitiativeValue.Connection = dbConnection;

            cmdUpdateInitiativeValue.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiativeValue.CommandText = "spUpdateInitiative_SectionB_SponsorValueFromEdit";

            cmdUpdateInitiativeValue.Parameters.Add("@InitiativeID", intInitiativeID);
            cmdUpdateInitiativeValue.Parameters.Add("@SponsorID", intSponsorID);
            cmdUpdateInitiativeValue.Parameters.Add("@SessionID", strSessionID);
            cmdUpdateInitiativeValue.Parameters.Add("@Allocation", dAllocation);
            cmdUpdateInitiativeValue.Parameters.Add("@StoreSponsorLevel", (bStoreSponsorLevel ? 1 : 0));

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

	}
}
