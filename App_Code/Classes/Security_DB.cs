using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ProjectPortfolio.Classes
{

    public class Security_DB
    {

        public static int GetActiveUserID(int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetActiveUserID = new SqlCommand();
            cmdGetActiveUserID.Connection = dbConnection;

            cmdGetActiveUserID.CommandType = CommandType.Text;
            cmdGetActiveUserID.CommandText = "SELECT ActiveUserID FROM Initiative WHERE InitiativeID=@InitiativeID";
            cmdGetActiveUserID.Parameters.Add("@InitiativeID", nInitiativeID);

            object obj;

            dbConnection.Open();
            obj = cmdGetActiveUserID.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
            {
                return (Int32)obj;
            }

            return -1;
        }

        //ERW 8 Oct 2008
        // Consider re-writing this proc and method so that it will not allow overwriting of a 
        // currently active user.  Method could return a true / false value to indicate success
        public static int SetActiveUserID(int intInitiativeID, int intContactID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdSetActiveUserID = new SqlCommand();
            cmdSetActiveUserID.Connection = dbConnection;

            cmdSetActiveUserID.CommandType = CommandType.StoredProcedure;
            cmdSetActiveUserID.CommandText = "spUpdateInitiative_ActiveUser";

            cmdSetActiveUserID.Parameters.Add("@ActiveUserID", intContactID);
            cmdSetActiveUserID.Parameters.Add("@InitiativeID", intInitiativeID);

            int intRecordsAffected = 0;
            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdSetActiveUserID.ExecuteNonQuery();
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


        public static int ClearActiveUserID(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdSetActiveUserID = new SqlCommand();
            cmdSetActiveUserID.Connection = dbConnection;

            cmdSetActiveUserID.CommandType = CommandType.Text;
            cmdSetActiveUserID.CommandText = "UPDATE Initiative SET ActiveUserID=NULL WHERE @InitiativeID=InitiativeID";
            cmdSetActiveUserID.Parameters.Add("@InitiativeID", intInitiativeID);

            int intRecordsAffected = 0;
            try
            {
                dbConnection.Open();
                intRecordsAffected = cmdSetActiveUserID.ExecuteNonQuery();
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


        public static string GetInitiativeAccessRights(int nContactID, int nInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiativeAccessRights = new SqlCommand();
            cmdGetInitiativeAccessRights.Connection = dbConnection;

            cmdGetInitiativeAccessRights.CommandType = CommandType.StoredProcedure;
            cmdGetInitiativeAccessRights.CommandText = "spGetInitiativeAccessRights";

            cmdGetInitiativeAccessRights.Parameters.Add("@ContactID", nContactID);
            cmdGetInitiativeAccessRights.Parameters.Add("@InitiativeID", nInitiativeID);

            SqlParameter parmMaxPermission = new SqlParameter("@MaxPermission", SqlDbType.NVarChar, 50);
            parmMaxPermission.Direction = ParameterDirection.Output;

            cmdGetInitiativeAccessRights.Parameters.Add(parmMaxPermission);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdGetInitiativeAccessRights.Parameters.Add(parmReturnValue);

            object obj;

            dbConnection.Open();
            obj = cmdGetInitiativeAccessRights.ExecuteNonQuery();
            dbConnection.Close();

            if (parmMaxPermission.Value != DBNull.Value && parmMaxPermission.Value.ToString() != String.Empty)
            {
                return parmMaxPermission.Value.ToString();
            }

            return "None";
        }


        public static string GetMaxAccessRights(int nContactID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetInitiativeAccessRights = new SqlCommand();
            cmdGetInitiativeAccessRights.Connection = dbConnection;

            cmdGetInitiativeAccessRights.CommandType = CommandType.StoredProcedure;
            cmdGetInitiativeAccessRights.CommandText = "spGetMaxAccessRights";

            cmdGetInitiativeAccessRights.Parameters.Add("@ContactID", nContactID);
 
            SqlParameter parmMaxPermission = new SqlParameter("@MaxPermission", SqlDbType.NVarChar, 50);
            parmMaxPermission.Direction = ParameterDirection.Output;

            cmdGetInitiativeAccessRights.Parameters.Add(parmMaxPermission);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdGetInitiativeAccessRights.Parameters.Add(parmReturnValue);

            object obj;

            dbConnection.Open();
            obj = cmdGetInitiativeAccessRights.ExecuteNonQuery();
            dbConnection.Close();

            /* This next line could be the problem - but not sure that its coming here ! */
            /*parmMaxPermission.Value = "IG Coordinator";*/

            if (parmMaxPermission.Value != DBNull.Value && parmMaxPermission.Value.ToString() != String.Empty)
            {
                return parmMaxPermission.Value.ToString();
            }

            return "None";
        }


        public static string GetUserRole(int nContactID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetUserRole = new SqlCommand();
            cmdGetUserRole.Connection = dbConnection;

            cmdGetUserRole.CommandType = CommandType.StoredProcedure;
            cmdGetUserRole.CommandText = "spGetContactRole";

            cmdGetUserRole.Parameters.Add("@ContactID", nContactID);

            SqlParameter parmRoleName = new SqlParameter("@RoleName", SqlDbType.NVarChar, 50);
            parmRoleName.Direction = ParameterDirection.Output;

            cmdGetUserRole.Parameters.Add(parmRoleName);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmdGetUserRole.Parameters.Add(parmReturnValue);

            object obj;

            dbConnection.Open();
            obj = cmdGetUserRole.ExecuteNonQuery();
            dbConnection.Close();

            if (parmRoleName.Value != DBNull.Value && parmRoleName.Value.ToString() != String.Empty)
            {
                return parmRoleName.Value.ToString();
            }

            /* Or this line could be the problem */
            return "IG Coordinator";
        }

    }

}