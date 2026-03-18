//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.3       CA          05/02/2007     New Sponsor Data 
//                                              
//
//*****************************************************************************************************


using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ProjectPortfolio.Classes
{
    /// <summary>
    /// Summary description for NotificationDB
    /// </summary>
    public class Notification_DB
    {

        public static DataSet GetNotificationList(int intCommitteeID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;

            // Change the email addresses to the test ones if this is a test environment.
            
            cmdGetDS.CommandText = "SELECT CommitteeContact.CommitteeID, Reference.Description AS Committee, " +
                                                        "CommitteeContact.ContactID, Login, Salutation, Surname, Firstname, " +
                                                        "Firstname + ' ' + Surname AS Name, "
                                                        + SetEmailAddresses("[Internal e-mail]") + " As EmailAddress " +
                                                        "FROM CommitteeContact " +
                                                        "JOIN Reference ON Reference.CategoryID=4 AND Reference.ReferenceID=CommitteeContact.CommitteeID " +
                                                        "JOIN Contacts ON Contacts.[Contact ID]=CommitteeContact.ContactID " +
                                                        "WHERE CommitteeID=@CommitteeID ";

            cmdGetDS.Parameters.Add("@CommitteeID", intCommitteeID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Contacts");

            return ds;
        }

        //rev 1.1.3
        public static DataSet GetSponsorNotificationList(int intSponsorID)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;

            cmdGetDS.CommandText = "SELECT " +
                                         "Sponsor.SponsorID, Sponsor.Name, Sponsor.Owner, Sponsor.sortorder, Sponsor.shortname, " +
                                         "SponsorContact.SponsorContactID, SponsorContact.SponsorID, " +
                                         SetEmailAddresses("SponsorContact.SponsorContactEmail") + " as SponsorContactEmail " +
                                        "FROM SponsorContact " +
                                        "JOIN Sponsor ON Sponsor.SponsorID = @SponsorID " +
                                        "AND Sponsor.SponsorID = SponsorContact.SponsorID ";


            cmdGetDS.Parameters.Add("@SponsorID", intSponsorID);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Contacts");

            return ds;
        }
        //end rev

        public static DataRow GetEmailTemplate(string strTemplateName)
        {
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetDS = new SqlCommand();
            cmdGetDS.Connection = dbConnection;

            cmdGetDS.CommandType = CommandType.Text;
            cmdGetDS.CommandText = "SELECT * FROM Template WHERE Name=@TemplateName ";

            cmdGetDS.Parameters.Add("@TemplateName", strTemplateName);

            SqlDataAdapter da = new SqlDataAdapter(cmdGetDS);

            DataSet ds = new DataSet();
            da.Fill(ds, "Templates");

            if (ds.Tables["Templates"] != null && ds.Tables["Templates"].Rows.Count > 0)
            {
                return ds.Tables["Templates"].Rows[0];
            }

            return null;
        }

        /// <summary>
        /// Given the contents of the web.config file, changes the email addresses
        /// to the testing ones
        /// </summary>
        /// <param name="productionValue">The email address value that will be used by production</param>
        /// <returns>The production or the test email address string, depending on the value in the web.config</returns>
        private static string SetEmailAddresses(string productionValue)
        {
            string emailaddresses = productionValue;

            if (ConfigurationManager.AppSettings["UseTestEmailAddresses"] == "true")
            {
                string testaddresses = ConfigurationManager.AppSettings["TestEmailAddresses"];
                if ( (testaddresses != "") && !(testaddresses == null))
                {
                    if (!testaddresses.Contains("'"))
                    {
                        //address has been listed without surrounding quotes
                        testaddresses = "'" + testaddresses + "'";
                    }
                    emailaddresses = testaddresses;
                }
            }

            return emailaddresses;
        }

    }
}
