using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.DirectoryServices; 

/// <summary>
/// Summary description for LDAP
/// </summary>
public class LDAP
{
	public LDAP()
	{
		//
		// TODO: Add constructor logic here
		//
    }


    /* 
     * ERW 
     * 13 Mar 2009
     *  copied this code from SelectItem.aspx in order to use this functionality from other classes
     *  particularly the InitiativeUpload. 
     *   but commented out for now cos not in use
    protected DataView GetGroupDirDataSource(string strSurname, string strFirstName)
    {
        DataTable dtGroupDir = new DataTable();
        DataView dv;
        DataRow row;

        dtGroupDir.Columns.Add(new DataColumn("Firstname", typeof(string)));
        dtGroupDir.Columns.Add(new DataColumn("Surname", typeof(string)));
        dtGroupDir.Columns.Add(new DataColumn("Email", typeof(string)));
        dtGroupDir.Columns.Add(new DataColumn("Mobile", typeof(string)));
        dtGroupDir.Columns.Add(new DataColumn("Login", typeof(string)));


        if (strSurname == "" && strFirstName == "")
        {
            row = dtGroupDir.NewRow();

            row["Firstname"] = "AAA";
            row["Surname"] = "";
            row["Email"] = "";
            row["Mobile"] = "";
            row["Login"] = "";

            dtGroupDir.Rows.Add(row);

            dv = new DataView(dtGroupDir);
            return dv;
        }

        //LDAP server

        //connection parms
        string strHostName = ConfigurationSettings.AppSettings["HostName"];
        string strPortNbr = ConfigurationSettings.AppSettings["PortNo"];
        string strExtraInfo = ConfigurationSettings.AppSettings["ExtraInfo"];
        string strBindDN = ConfigurationSettings.AppSettings["bindDN"];
        string strBindPWD = ConfigurationSettings.AppSettings["bindPWD"];



        //commented for test 
        string strPath = "LDAP://" + strHostName + ":" + strPortNbr
                       + strExtraInfo;//+ "/ou=people,ou=global,dc=dbgroup,dc=com";

        //creating the entry
        DirectoryEntry entry = null;


        //testing...
        //entry = new DirectoryEntry(ConfigurationSettings.AppSettings["LDAPSERVER"],
        //"silviu.bujor@suthco.com","suthc0passw0rd");
        //...

        entry = new DirectoryEntry(strPath, strBindDN, strBindPWD);

        entry.AuthenticationType = System.DirectoryServices.AuthenticationTypes.ServerBind;
        //..entry


        //creating the searcher
        DirectorySearcher searcher = new DirectorySearcher(entry);

        searcher.CacheResults = false;

        searcher.PropertiesToLoad.Add("sn");
        searcher.PropertiesToLoad.Add("givenname");
        searcher.PropertiesToLoad.Add("mail");
        searcher.PropertiesToLoad.Add("mobile");
        searcher.PropertiesToLoad.Add("samaccountname");

        try
        {
            //surname = parm
            searcher.Filter = "(&(sn=" + strSurname + "*)(givenname=" + strFirstName + "*))";
            if (strSurname == "")
                searcher.Filter = "(givenname=" + strFirstName + "*)";
            if (strFirstName == "")
                searcher.Filter = "(sn=" + strSurname + "*)";

            searcher.Sort = new SortOption("givenname", System.DirectoryServices.SortDirection.Ascending);

            //getting the results
            SearchResultCollection searchResCol = searcher.FindAll();

            //iterate through each SearchResult in the SearchResultCollection
            foreach (SearchResult searchRes in searchResCol)
            {
                row = dtGroupDir.NewRow();

                //iterate through each property name in each SearchResult.
                foreach (string propKey in searchRes.Properties.PropertyNames)
                {
                    if ((propKey != "sn") && (propKey != "givenname")
                        && (propKey != "mail") && (propKey != "mobile")
                        && (propKey != "samaccountname")
                        )
                    {
                        continue;
                    }

                    if (searchRes.Properties[propKey].Count > 0)
                    {
                        switch (propKey)
                        {
                            case "sn":
                                {
                                    row["Surname"] = searchRes.Properties[propKey][0].ToString();
                                    break;
                                }
                            case "givenname":
                                {
                                    row["Firstname"] = searchRes.Properties[propKey][0].ToString();
                                    break;
                                }
                            case "mail":
                                {
                                    row["Email"] = searchRes.Properties[propKey][0].ToString();
                                    break;
                                }
                            case "mobile":
                                {
                                    row["Mobile"] = searchRes.Properties[propKey][0].ToString();
                                    break;
                                }
                            case "samaccountname":
                                {
                                    row["Login"] = searchRes.Properties[propKey][0].ToString();
                                    break;
                                }
                        }//end switch
                    }

                }//end iterate through each property name

                //make sure that the Surname is not empty (so we have something to click on)
                if (row["Firstname"].ToString() == "") row["Firstname"] = "Unknown";

                dtGroupDir.Rows.Add(row);

            }//end iterate through each searchResult

        }
        catch (Exception exc)
        {

        }



        dv = new DataView(dtGroupDir);
        dv.Sort = "Surname";

        return dv;
    }
    */
}
