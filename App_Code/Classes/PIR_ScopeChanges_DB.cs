namespace ProjectPortfolio.Classes
{
    using System;
    using System.Data;
    using System.Data.SqlClient;

    using ProjectPortfolio.Classes;

    public class PIR_ScopeChanges_DB
    {
        public static DataSet GetScopeChanges(int intInitiativeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spGetInitiativePIR_ScopeChanges";

            cmd.Parameters.Add("@InitiativeID", intInitiativeID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();

            try
            {
                da.Fill(ds, "InitiativeScopeChange");

                if (ds.Tables["InitiativeScopeChange"].Rows.Count == 0)
                {
                    DataRow drNoRecords = ds.Tables["InitiativeScopeChange"].NewRow();
                    drNoRecords["ScopeChange"] = "No records";

                    ds.Tables["InitiativeScopeChange"].Rows.Add(drNoRecords);
                }

            }
            catch (SqlException)
            {
                ds = null;
            }

            return ds;
        }

        public static int DeleteScopeChange(int intInitiativeScopeChangeID)
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spDeleteInitiative_ScopeChange";

            cmd.Parameters.Add("@InitiativeScopeChangeID", intInitiativeScopeChangeID);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmd.Parameters.Add(parmReturnValue);

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

        public static int InsertScopeChange(
                            int intInitiativeID,
                            string strScopeChange,
                            string strCommentary,
                            string strStatus,
                            int intStatusID
                            )
        {
            int intInitiativeScopeChangeID;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spInsertInitiative_PIR_ScopeChange";

            cmd.Parameters.Add("@InitiativeID", intInitiativeID);
            cmd.Parameters.Add("@ScopeChange", strScopeChange);
            cmd.Parameters.Add("@Commentary", strCommentary);
            cmd.Parameters.Add("@Status", strStatus);
            cmd.Parameters.Add("@StatusID", intStatusID);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmd.Parameters.Add(parmReturnValue);

            try
            {
                dbConnection.Open();
                cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                intInitiativeScopeChangeID = -1;
            }
            finally
            {
                dbConnection.Close();
            }

            if (parmReturnValue.Value != null && parmReturnValue.Value != DBNull.Value)
            {
                intInitiativeScopeChangeID = Convert.ToInt32(parmReturnValue.Value);
            }
            else
            {
                intInitiativeScopeChangeID = -1;
            }

            return intInitiativeScopeChangeID;

        }

        public static int UpdateScopeChange(
                            int intInitiativeScopeChangeID,
                            int intInitiativeID,
                            string strScopeChange,
                            string strCommentary,
                            string strStatus,
                            int intStatusID
                            )
        {
            int intRecordsAffected;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spUpdateInitiative_PIR_ScopeChange";

            cmd.Parameters.Add("@InitiativeScopeChangeID", intInitiativeScopeChangeID);
            cmd.Parameters.Add("@InitiativeID", intInitiativeID);
            cmd.Parameters.Add("@ScopeChange", strScopeChange);
            cmd.Parameters.Add("@Commentary", strCommentary);
            cmd.Parameters.Add("@Status", strStatus);
            cmd.Parameters.Add("@StatusID", intStatusID);

            SqlParameter parmReturnValue = new SqlParameter("@RETURN_VALUE", SqlDbType.Int);
            parmReturnValue.Direction = ParameterDirection.ReturnValue;

            cmd.Parameters.Add(parmReturnValue);

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

        public static DataRow GetScopeChangeDetails(int intInitiativeScopeChangeID)
        {
            DataRow dr = null;

            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spGetInitiativePIR_ScopeChange";

            cmd.Parameters.Add("@InitiativeScopeChangeID", intInitiativeScopeChangeID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();

            try
            {
                da.Fill(ds, "InitiativeScopeChange");
            }
            catch (SqlException)
            {
                dr = null;
            }

            if (ds.Tables["InitiativeScopeChange"] != null && ds.Tables["InitiativeScopeChange"].Rows.Count > 0)
            {
                dr = ds.Tables["InitiativeScopeChange"].Rows[0];
            }

            return dr;
        }

    }

}