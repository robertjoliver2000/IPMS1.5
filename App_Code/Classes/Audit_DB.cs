using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace ProjectPortfolio.Classes
{

    public class AuditFilter
    {
        int nInitiativeID;
        string strIGIdentifier;
        string strTableName;
        string strUserName;
        DateTime dtModifyDate;
        
        public AuditFilter()
        {
            nInitiativeID = -1;
            strTableName = "";
            strUserName = "";
            strIGIdentifier = "";
            dtModifyDate = DateTime.MinValue;
        }

        public int InitiativeID
        {
            get { return nInitiativeID; }
            set { nInitiativeID = value; }
        }

        public string TableName
        {
            get { return strTableName; }
            set { strTableName = value; }
        }
        public string UserName
        {
            get { return strUserName; }
            set { strUserName = value; }
        }
        public DateTime ModifyDate
        {
            get { return dtModifyDate; }
            set { dtModifyDate = value; }
        }

        public string IGIdentifier
        {
            get { return strIGIdentifier; }
            set { strIGIdentifier = value; }
        }

    }

    public class Audit_DB
    {
        public static DataSet GetAuditTable(AuditFilter auditFilter)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandTimeout = Global_DB.SQLCommandTimeOut;

            cmdGetDS.CommandType = CommandType.StoredProcedure;
            cmdGetDS.CommandText = "AUDIT_prc_CustomReport";

            if (auditFilter.InitiativeID == -1)
                cmdGetDS.Parameters.Add("@INITIATIVE_ID", System.DBNull.Value);
            else
                cmdGetDS.Parameters.Add("@INITIATIVE_ID", auditFilter.InitiativeID);
                        
            if (auditFilter.TableName == "")
                cmdGetDS.Parameters.Add("@TABLE_NAME", System.DBNull.Value);
            else
                cmdGetDS.Parameters.Add("@TABLE_NAME", auditFilter.TableName);

            if (auditFilter.IGIdentifier == "")
                cmdGetDS.Parameters.Add("@IG_IDENTIFIER", System.DBNull.Value);
            else
                cmdGetDS.Parameters.Add("@IG_IDENTIFIER", auditFilter.IGIdentifier);


            if (auditFilter.UserName == "")
                cmdGetDS.Parameters.Add("@CONTACT_NAME", System.DBNull.Value);
            else
                cmdGetDS.Parameters.Add("@CONTACT_NAME", auditFilter.UserName);

            if (auditFilter.ModifyDate == DateTime.MinValue)
            {
                cmdGetDS.Parameters.Add("@DATE_FROM", System.DBNull.Value);
                cmdGetDS.Parameters.Add("@DATE_TO", System.DBNull.Value);
            }
            else
            {
                DateTime dtFrom = new DateTime(auditFilter.ModifyDate.Year,auditFilter.ModifyDate.Month,auditFilter.ModifyDate.Day);
                dtFrom.AddHours(0);
                dtFrom.AddMinutes(0);
                dtFrom.AddSeconds(0);

                DateTime dtTo = new DateTime(auditFilter.ModifyDate.Year, auditFilter.ModifyDate.Month, auditFilter.ModifyDate.Day);
                dtTo.AddHours(23);
                dtTo.AddMinutes(59);
                dtTo.AddSeconds(59);

                cmdGetDS.Parameters.Add("@DATE_FROM", dtFrom);
                cmdGetDS.Parameters.Add("@DATE_TO", dtTo);
            }


            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Audit");
                        
            return ds;
        }

        public static string GetIGTableName(string strTableName)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetTable = new SqlCommand();
            cmdGetTable.Connection = dbConnection;

            cmdGetTable.CommandType = CommandType.Text;
            cmdGetTable.CommandText = "SELECT  R1.Description + ' -> ' + R2.Description AS TableName "+
                                        "FROM Reference R1 INNER JOIN Reference R2 ON R1.ReferenceID = R2.ReferenceID "+
                                        "WHERE (R1.CategoryID = 33) AND (R2.CategoryID = 34) AND (R1.Description=@TableName)";

            cmdGetTable.Parameters.Add("@TableName", strTableName);

            object obj;

            dbConnection.Open();
            obj = cmdGetTable.ExecuteScalar();
            dbConnection.Close();

            if (obj != DBNull.Value && obj != null)
                return obj.ToString();

            return "";
        }
       
    }
}
