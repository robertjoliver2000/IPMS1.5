/*
 *  Rev         By          Date            Description
 * 
 *  1.8.2       GMcF        2007-10-06      Amended for Phase 1.8 Deliverable 2 - Detailed Functional Domains
 * 
 */

using System;
using System.Data;
using System.Data.SqlClient;

namespace ProjectPortfolio.Classes
{
	/// <summary>
	/// Summary description for SectionE_DB.
	/// </summary>
	public class SectionE_DB
	{

		public static int UpdateInitiative( int nInitiativeID,
	                                        string strImpactOfNotDoingThisInvestment,
	                                        string strShutdownComments,
	                                        string strKeyPerformanceIndicators)
		{
			int intRecordsAffected;

			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdUpdateInitiative = new SqlCommand();
			cmdUpdateInitiative.Connection = dbConnection;

			cmdUpdateInitiative.CommandType = CommandType.StoredProcedure;
			cmdUpdateInitiative.CommandText = "spUpdateInitiative_SectionE";

			cmdUpdateInitiative.Parameters.Add("@InitiativeID", nInitiativeID);

			cmdUpdateInitiative.Parameters.Add("@ImpactOfNotDoingThisInvestment", strImpactOfNotDoingThisInvestment);
			cmdUpdateInitiative.Parameters.Add("@ShutdownComments", strShutdownComments);
			cmdUpdateInitiative.Parameters.Add("@KeyPerformanceIndicators", strKeyPerformanceIndicators);
			
			try
			{
				dbConnection.Open();
				intRecordsAffected = cmdUpdateInitiative.ExecuteNonQuery();			
			}
			catch(SqlException sqlE)
			{
				intRecordsAffected = -1;
			}
			finally
			{
				dbConnection.Close();
			}

			return intRecordsAffected;
		}


		public static DataSet GetApplications(int nInitiativeID)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetDS = new SqlCommand();
			cmdGetDS.Connection = dbConnection;

			cmdGetDS.CommandType = CommandType.Text;


            cmdGetDS.CommandText = "SELECT InitiativeApplicationID,Impact,Application.ApplicationID,Application.ApplicationInstanceName,"
						+"Application.ExternalApplicationID, InitiativeApplication.DecommisioningDate, InitiativeApplication.InvestmentStrategy "
						+"FROM Application JOIN InitiativeApplication ON Application.ApplicationID = InitiativeApplication.ApplicationID "
						+"WHERE (InitiativeApplication.InitiativeID = @InitiativeID)";
				
		

			cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

			SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

			DataSet ds = new DataSet();
			da.Fill(ds, "Application");

			return ds;		
		}


        public static DataSet GetNewApplications(int nInitiativeID)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetDS = new SqlCommand();
			cmdGetDS.Connection = dbConnection;

			cmdGetDS.CommandType = CommandType.Text;

            cmdGetDS.CommandText = "SELECT InitiativeApplicationID,Impact,Application.ApplicationID,Application.ApplicationInstanceName, Application.ExternalApplicationID, Application.InvestmentStrategy "
					+ "FROM   Application LEFT OUTER JOIN "
					+ "(SELECT * FROM InitiativeApplication WHERE InitiativeApplication.InitiativeID = @InitiativeID) TempTB ON Application.ApplicationID = TempTB.ApplicationID " 
					+ "WHERE TempTB.InitiativeID IS NULL AND Application.IsDeleted=0 ";

			cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

			SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

			DataSet ds = new DataSet();
			da.Fill(ds, "Application");

			return ds;		
		}


        public static DataSet GetApplication(int nInitiativeAppID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;


            cmdGetDS.CommandText = "SELECT InitiativeApplicationID,Impact,Application.ApplicationID,Application.ApplicationInstanceName,"
                        + "Application.ExternalApplicationID, Application.InvestmentStrategy, InitiativeApplication.DecommisioningDate "
                        + "FROM Application JOIN InitiativeApplication ON Application.ApplicationID = InitiativeApplication.ApplicationID "
                        + "WHERE (InitiativeApplicationID = @InitiativeAppID)";



            cmdGetDS.Parameters.Add("@InitiativeAppID", nInitiativeAppID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Application");

            return ds;
        }


		public static string GetExternalAppID(int nApplicationID)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetExternal = new SqlCommand();
			cmdGetExternal.Connection = dbConnection;

			cmdGetExternal.CommandType = CommandType.Text;
			cmdGetExternal.CommandText="SELECT ExternalApplicationID FROM Application WHERE ApplicationID=@ApplicationID";
			cmdGetExternal.Parameters.Add("@ApplicationID", nApplicationID);

			object obj;

			dbConnection.Open();
			obj = cmdGetExternal.ExecuteScalar();			
			dbConnection.Close();

			if (obj != DBNull.Value && obj != null)
				return obj.ToString();

			return "-1";

		}

        public static void InsertInitiativeApp(int nInitiativeID, int nApplicationID, DateTime dtDec, string strImpact, string strInvestmentStrategy)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdInsertInitiativeApp = new SqlCommand();
			cmdInsertInitiativeApp.Connection = dbConnection;

			cmdInsertInitiativeApp.CommandType = CommandType.StoredProcedure;
			cmdInsertInitiativeApp.CommandText = "spInsertInitiative_SectionE_Application";

			cmdInsertInitiativeApp.Parameters.Add("@InitiativeID", nInitiativeID);
			cmdInsertInitiativeApp.Parameters.Add("@ApplicationID", nApplicationID);
			cmdInsertInitiativeApp.Parameters.Add("@DecDate", dtDec);
            cmdInsertInitiativeApp.Parameters.Add("@Impact", strImpact);
            cmdInsertInitiativeApp.Parameters.Add("@InvestmentStrategy", strInvestmentStrategy);

			try
			{
				dbConnection.Open();
				cmdInsertInitiativeApp.ExecuteNonQuery();	
			}
			catch(SqlException sqlE)
			{
			
			}
			finally
			{
				dbConnection.Close();
			}
		}

        public static void UpdateInitiativeApp(int nInitiativeAppID, int nApplicationID, DateTime dtDec, string strImpact, string strInvestmentStrategy)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiativeApp = new SqlCommand();
            cmdUpdateInitiativeApp.Connection = dbConnection;

            cmdUpdateInitiativeApp.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiativeApp.CommandText = "spUpdateInitiative_SectionE_Application";

            cmdUpdateInitiativeApp.Parameters.Add("@InitiativeAppID", nInitiativeAppID);
            cmdUpdateInitiativeApp.Parameters.Add("@ApplicationID", nApplicationID);
            cmdUpdateInitiativeApp.Parameters.Add("@DecDate", dtDec);
            cmdUpdateInitiativeApp.Parameters.Add("@Impact", strImpact);
            cmdUpdateInitiativeApp.Parameters.Add("@InvestmentStrategy", strInvestmentStrategy);

            try
            {
                dbConnection.Open();
                cmdUpdateInitiativeApp.ExecuteNonQuery();
            }
            catch (SqlException sqlE)
            {

            }
            finally
            {
                dbConnection.Close();
            }
        }

		public static DataSet GetServers(int nInitiativeID)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetDS = new SqlCommand();
			cmdGetDS.Connection = dbConnection;

			cmdGetDS.CommandType = CommandType.Text;
			cmdGetDS.CommandText="SELECT InitiativeServerID,Impact,Server.ServerID,Server.ServerNodeName, Server.ExternalServerNodeID,"
					+"InitiativeServer.DecommissioningDate "
					+"FROM InitiativeServer JOIN Server ON InitiativeServer.ServerID = Server.ServerID "
					+"WHERE (InitiativeServer.InitiativeID = @InitiativeID)";
		
			cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

			SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

			DataSet ds = new DataSet();
			da.Fill(ds, "Server");

			return ds;		
		}

        public static DataSet GetServer(int nInitiativeServerID)
        {


            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;
            cmdGetDS.CommandText = "SELECT InitiativeServerID,Impact,Server.ServerID,Server.ServerNodeName, Server.ExternalServerNodeID,"
                    + "InitiativeServer.DecommissioningDate "
                    + "FROM InitiativeServer JOIN Server ON InitiativeServer.ServerID = Server.ServerID "
                    + "WHERE (InitiativeServerID = @InitiativeServerID)";

            cmdGetDS.Parameters.Add("@InitiativeServerID", nInitiativeServerID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Server");

            return ds;
        }


		public static DataSet GetNewServers(int nInitiativeID)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetDS = new SqlCommand();
			cmdGetDS.Connection = dbConnection;

			cmdGetDS.CommandType = CommandType.Text;
			
			
			cmdGetDS.CommandText="SELECT Impact,Server.ServerID,Server.ServerNodeName, Server.ExternalServerNodeID "
				            + "FROM Server LEFT OUTER JOIN "
				            + "(SELECT * FROM InitiativeServer WHERE InitiativeServer.InitiativeID = @InitiativeID) TempTB ON Server.ServerID = TempTB.ServerID " 
				            + "WHERE TempTB.InitiativeID IS NULL AND Server.IsDeleted=0";

			cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

			SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

			DataSet ds = new DataSet();
			da.Fill(ds, "Server");

			return ds;		
		}

        public static void UpdateInitiativeServer(int nInitiativeServerID, int nServerID, DateTime dtDec,string strImpact)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdUpdateInitiativeServer = new SqlCommand();
            cmdUpdateInitiativeServer.Connection = dbConnection;

            cmdUpdateInitiativeServer.CommandType = CommandType.StoredProcedure;
            cmdUpdateInitiativeServer.CommandText = "spUpdateInitiative_SectionE_Server";

            cmdUpdateInitiativeServer.Parameters.Add("@InitiativeServerID", nInitiativeServerID);
            cmdUpdateInitiativeServer.Parameters.Add("@ServerID", nServerID);
            cmdUpdateInitiativeServer.Parameters.Add("@DecDate", dtDec);
            cmdUpdateInitiativeServer.Parameters.Add("@Impact", strImpact);

            try
            {
                dbConnection.Open();
                cmdUpdateInitiativeServer.ExecuteNonQuery();
            }
            catch (SqlException sqlE)
            {

            }
            finally
            {
                dbConnection.Close();
            }
        }


		public static string GetExternalServerNodeID(int nServerID)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetExternal = new SqlCommand();
			cmdGetExternal.Connection = dbConnection;

			cmdGetExternal.CommandType = CommandType.Text;
			cmdGetExternal.CommandText="SELECT ExternalServerNodeID FROM Server WHERE ServerID=@ServerID";
			cmdGetExternal.Parameters.Add("@ServerID", nServerID);

			object obj;

			dbConnection.Open();
			obj = cmdGetExternal.ExecuteScalar();			
			dbConnection.Close();

			if (obj != DBNull.Value && obj != null)
				return obj.ToString();

			return "-1";

		}

		public static void InsertInitiativeServer(int nInitiativeID,int nServerID,DateTime dtDec,string strImpact)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdInsertInitiativeApp = new SqlCommand();
			cmdInsertInitiativeApp.Connection = dbConnection;

			cmdInsertInitiativeApp.CommandType = CommandType.StoredProcedure;
			cmdInsertInitiativeApp.CommandText = "spInsertInitiative_SectionE_Server";

			cmdInsertInitiativeApp.Parameters.Add("@InitiativeID", nInitiativeID);
			cmdInsertInitiativeApp.Parameters.Add("@ServerID", nServerID);
			cmdInsertInitiativeApp.Parameters.Add("@DecDate", dtDec);
            cmdInsertInitiativeApp.Parameters.Add("@Impact", strImpact);

			try
			{
				dbConnection.Open();
				cmdInsertInitiativeApp.ExecuteNonQuery();	
			}
			catch(SqlException sqlE)
			{
			
			}
			finally
			{
				dbConnection.Close();
			}
		}

        
        public static int DeleteInitiativeApp(int nAppID)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDel = new SqlCommand();
            cmdDel.Connection = dbConnection;

            cmdDel.CommandType = CommandType.StoredProcedure;
            cmdDel.CommandText = "spDeleteInitiative_Application";

            cmdDel.Parameters.Add("@InitiativeApplicationID", nAppID);

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


        public static int DeleteInitiativeServer(int nServerID)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDel = new SqlCommand();
            cmdDel.Connection = dbConnection;

            cmdDel.CommandType = CommandType.StoredProcedure;
            cmdDel.CommandText = "spDeleteInitiative_Server";

            cmdDel.Parameters.Add("@InitiativeServerID", nServerID);

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

        // Rev 1.8.2 GMcF
        public static DataSet GetInitiativeDetailedFunctionalDomain(int intInitiativeDetailedFunctionalDomainID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetInitiativeDetailedFunctionalDomain";
            cmdGetDS.Parameters.Add("@InitiativeDetailedFunctionalDomainID", intInitiativeDetailedFunctionalDomainID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "InitiativeDetailedFunctionalDomain");

            return ds;
        }
        // End of Rev 1.8.2

        // Rev 1.8.2 GMcF
        public static void UpdateInitiativeDetailedFunctionalDomain(
                                    int intInitiativeDetailedFunctionalDomainId,
                                    int intInitiativeId,
                                    int intDetailedFunctionalDomainId,
                                    decimal decAllocation,
                                    string strComments
                                )
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spUpdateInitiative_SectionE_DetailedFunctionalDomain";

            cmd.Parameters.Add("@InitiativeDetailedFunctionalDomainID", intInitiativeDetailedFunctionalDomainId);
            cmd.Parameters.Add("@InitiativeID", intInitiativeId);
            cmd.Parameters.Add("@DetailedFunctionalDomainId", intDetailedFunctionalDomainId);
            cmd.Parameters.Add("@Allocation", decAllocation);
            cmd.Parameters.Add("@Comments", strComments);

            try
            {
                dbConnection.Open();
                cmd.ExecuteNonQuery();
            }
            catch (SqlException sqlE)
            {

            }
            finally
            {
                dbConnection.Close();
            }

        }
        // End of Rev 1.8.2

        // Rev 1.8.2 GMcF
        public static int DeleteInitiativeDetailedFunctionalDomain(int nInitiativeDetailedFunctionalDomainID)
        {
            int nRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdDel = new SqlCommand();
            cmdDel.Connection = dbConnection;

            cmdDel.CommandType = CommandType.StoredProcedure;
            cmdDel.CommandText = "spDeleteInitiative_DetailedFunctionalDomainID";

            cmdDel.Parameters.Add("@intInitiativeDetailedFunctionalDomainID", nInitiativeDetailedFunctionalDomainID);

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
        // End of Rev 1.8.2


        // Rev 1.8.2 GMcF
        public static DataSet GetDetailedFunctionalDomains(int intInitiativeId)
		{
			SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

			SqlCommand cmdGetDS = new SqlCommand();
			cmdGetDS.Connection = dbConnection;

			cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetInitiativeDetailedFunctionalDomains";
		
			cmdGetDS.Parameters.Add("@InitiativeID", intInitiativeId);

			SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

			DataSet ds = new DataSet();
			da.Fill(ds, "InitiativeDetailedFunctionalDomain");

			return ds;		
		}
        // End of Rev 1.8.2

        // Rev 1.8.2 GMcF
        public static DataSet GetNewDetailedFunctionalDomains(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "spGetNewDetailedFunctionalDomains";

            cmdGetDS.Parameters.Add("@InitiativeID", nInitiativeID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "DetailedFunctionalDomain");

            return ds;
        }
        // End of Rev 1.8.2

    }
}
