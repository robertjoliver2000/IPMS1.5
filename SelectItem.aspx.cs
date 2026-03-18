/*
 *  Rev         By          Date            Description
 * 
 *  1.8.2       GMcF        2007-10-06      Added code for selecting Detailed Functional Domain
 * 
 */

using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ProjectPortfolio.Classes;

using System.DirectoryServices;
using System.Runtime.InteropServices;

namespace ProjectPortfolio
{
    public partial class SelectItem : System.Web.UI.Page
    {
        protected int nInitiativeID;

        protected DataView dvItems;
        protected int nCategory;

        protected void UpdateOpener()
        {
                string strControlID = "";

                object objControlID = Request.QueryString["ControlID"];
                if (objControlID != null)
                    strControlID = objControlID.ToString();

                string strControl2ID = "";
                object objControl2ID = Request.QueryString["Control2ID"];
                if (objControl2ID != null)
                    strControl2ID = objControl2ID.ToString();

                string strHiddenControlID = "";

                object objHiddenControlID = Request.QueryString["HiddenControlID"];
                if (objHiddenControlID != null)
                    strHiddenControlID = objHiddenControlID.ToString();

                string strControl3ID = "";
                object objControl3ID = Request.QueryString["Control3ID"];
                if (objControl3ID != null)
                    strControl3ID = objControl3ID.ToString();

                string strControl4ID = "";
                object objControl4ID = Request.QueryString["Control4ID"];
                if (objControl4ID != null)
                    strControl4ID = objControl4ID.ToString();


                string startupScript =
                          "<script language=JavaScript> " +
                          "function updateItem(itemValue,item2Value,itemID,item3Value) " +
                          "{" +
                          "opener.document.getElementById(\"" + strControlID + "\").value=itemValue;" +
                          "opener.document.getElementById(\"" + strHiddenControlID + "\").value=itemID;";
                // Rev 1.8.2 GMcF - added check for strControl2ID being set
                if (!string.IsNullOrEmpty(strControl2ID))
                {
                    startupScript +=
                          "if(item2Value!=\"\")" +
                          "{" +
                          "opener.document.getElementById(\"" + strControl2ID + "\").value=item2Value;" +
                          "}";
                }
                // End of Rev 1.8.2
                if (!string.IsNullOrEmpty(strControl3ID))
                {
                    startupScript +=
                          "if(item3Value!=\"\")" +
                          "{" +
                          "opener.document.getElementById(\"" + strControl3ID + "\").innerText=item3Value;" +
                          "}";
                }
                if (!string.IsNullOrEmpty(strControl4ID))
                {
                    startupScript +=
                          "if(item3Value!=\"\")" +
                          "{" +
                          "opener.document.getElementById(\"" + strControl4ID + "\").value=item3Value;" +
                          "}";
                }
                startupScript += 
                          "if (opener.SetDirtyFlag) opener.SetDirtyFlag();" + 
                          "window.close();" +
                          "}" +
                          "</script>";

            RegisterStartupScript("updateItem", startupScript);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            try
            {
                nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                nInitiativeID = -1;
            }

            object objCategory = Request.QueryString["CategoryID"];
            if (objCategory != null)
            {
                try
                {
                    nCategory = Convert.ToInt32(objCategory);
                }
                catch(Exception  e1)
                {
                    nCategory=-1;
                }
            }

            if (nCategory != -1)
            {
                btnNewItem.Attributes.Add("onclick", "javascript:popupWindowAddItem(" + nCategory.ToString() + ")");
            }

            switch (nCategory)
            {
                case 1:
                    {
                        lblSearch.Text = "  Surname ";
                        lblFirstName.Text = "First Name";
                        btnNewItem.Visible = false;
                        btnEmptyItem.Visible = true;
                        break;
                    }
                case 2:
                    {
                        lblSearch.Text = "Application Name";
                        lblFirstName.Text = "NAR ID";
                        lblFirstName.Visible = true;
                        txtFirstName.Visible = true;
                        break;
                    }
                case 3:
                    {
                        lblSearch.Text = "Server Name";
                        lblFirstName.Visible = false;
                        txtFirstName.Visible = false;
                        break;
                    }
                // Rev 1.8.2 GMcF
                case 4:
                    {
                        lblSearch.Text = "Detailed Functional Domain";
                        lblFirstName.Visible = false;
                        txtFirstName.Visible = false;
                        btnNewItem.Visible = false;
                        break;
                    }
                // End of Rev 1.8.2
            }

            if (!Page.IsPostBack)
            {
                Session["ApplicationDataView"] = null;
                Session["ApplicationFilter"] = "";
                Session["ServerFilter"] = "";
            }

            UpdateOpener();
            LoadDataSets();
            BindDataGrid();
       }
        
        protected void LoadDataSets()
        {
            DataSet dsItems;

            switch (nCategory)
            {
                case 1:
                    {
                        CheckCondition();
                        break;
                    }
                case 2:
                    {
                        dvItems = Session["ApplicationDataView"] as DataView;

                        if (dvItems == null)
                        {
                            dsItems = SectionE_DB.GetNewApplications(nInitiativeID);
                            dvItems = new DataView(dsItems.Tables["Application"], (Session["ApplicationFilter"] == null) ? string.Empty : Session["ApplicationFilter"].ToString(), string.Empty, DataViewRowState.CurrentRows);
                        }

                        Session["ApplicationDataView"] = dvItems;

                        break;
                    }
                case 3:
                    {
                        dsItems = SectionE_DB.GetNewServers(nInitiativeID);
                        dvItems = new DataView(dsItems.Tables["Server"], (Session["ServerFilter"] == null) ? string.Empty : Session["ServerFilter"].ToString(), string.Empty, DataViewRowState.CurrentRows);

                        break;
                    }
                // Rev 1.8.2 GMcF
                case 4:
                    {
                        dsItems = SectionE_DB.GetNewDetailedFunctionalDomains(nInitiativeID);
                        dvItems = new DataView(dsItems.Tables["DetailedFunctionalDomain"],
                                                (Session["DetailedFunctionalDomainFilter"] == null) ? string.Empty : Session["DetailedFunctionalDomainFilter"].ToString(), string.Empty, DataViewRowState.CurrentRows);

                        break;
                    }
                // End of Rev 1.8.2
            }
        }

        protected void BindDataGrid()
        {

            switch (nCategory)
            {
                case 1:
                    {
                        ButtonField bfFirstName = new ButtonField();
                        bfFirstName.HeaderText = "Firstname";
                        bfFirstName.DataTextField = "Firstname";
                        bfFirstName.CommandName = "GetContact";
                                                
                        gvItems.Columns.Add(bfFirstName);
                        
                        BoundField bfSurname = new BoundField();
                        bfSurname.HeaderText = "Surname";
                        bfSurname.DataField = "Surname";

                        gvItems.Columns.Add(bfSurname);

                        break;
                    }
                case 2:
                    {
                        ButtonField bfApplication = new ButtonField();
                        bfApplication.HeaderText = "Application Instance Name";
                        bfApplication.DataTextField = "ApplicationInstanceName";
                        bfApplication.CommandName = "GetApplication";

                        gvItems.Columns.Add(bfApplication);
                        
                        BoundField bfSurname = new BoundField();
                        bfSurname.HeaderText = "Application ID";
                        bfSurname.DataField = "ExternalApplicationID";

                        gvItems.Columns.Add(bfSurname);

                        break;
                    }
                case 3:
                    {
                        ButtonField bfApplication = new ButtonField();
                        bfApplication.HeaderText = "Server Name";
                        bfApplication.DataTextField = "ServerNodeName";
                        bfApplication.CommandName = "GetServer";
                       
                        gvItems.Columns.Add(bfApplication);
                        
                                                
                        BoundField bfExternalAppID = new BoundField();
                        bfExternalAppID.HeaderText = "Server Node ID";
                        bfExternalAppID.DataField = "ExternalServerNodeID";

                        gvItems.Columns.Add(bfExternalAppID);

                        break;
                    }
                // Rev 1.8.2 GMcF
                case 4:
                    {
                        ButtonField bfDetailedFunctionalDomain = new ButtonField();
                        bfDetailedFunctionalDomain.HeaderText = "Detailed Functional Domain";
                        bfDetailedFunctionalDomain.DataTextField = "Description";
                        bfDetailedFunctionalDomain.CommandName = "GetDetailedFunctionalDomain";

                        gvItems.Columns.Add(bfDetailedFunctionalDomain);

                        break;
                    }
                 // End of Rev 1.8.2
            }
            
          
            gvItems.DataSource = dvItems;
            gvItems.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CheckCondition();

            gvItems.PageIndex = 0;
            gvItems.DataSource = dvItems;
            gvItems.DataBind();
        }

        /*
        protected DataView GetGroupDirDataSource(string strSurname)
        {
            DataTable dtGroupDir = new DataTable();
            DataView dv;
            DataRow row;

            dtGroupDir.Columns.Add(new DataColumn("Firstname", typeof(string)));
            dtGroupDir.Columns.Add(new DataColumn("Surname", typeof(string)));
            dtGroupDir.Columns.Add(new DataColumn("Email", typeof(string)));
            dtGroupDir.Columns.Add(new DataColumn("Mobile", typeof(string)));
            dtGroupDir.Columns.Add(new DataColumn("Login", typeof(string)));


            if (strSurname == "")
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

            entry = new DirectoryEntry(strPath,strBindDN, strBindPWD);
          
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
                searcher.Filter = "(sn=" + strSurname + ")";
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
                    if (row["Firstname"] == "") row["Firstname"] = "Unknown";

                    dtGroupDir.Rows.Add(row);

                }//end iterate through each searchResult

            }
            catch (Exception exc)
            {
              
            }
            
           
            dv = new DataView(dtGroupDir);
            return dv;
        }
        */

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

        /*
        protected void CheckCondition()
        {

            bool bGroupDir = false;


            if (txtSearch.Text != "")
            {
                switch (nCategory)
                {
                    case 1:
                        {
                            bGroupDir = true;

                            dvItems = null;
                            dvItems = GetGroupDirDataSource(txtSearch.Text);
                            
                            
                            break;
                        }
                    case 2:
                        {
                            Session["ApplicationFilter"] = "ApplicationInstanceName LIKE " + "'" + txtSearch.Text + "%'";
                            dvItems.RowFilter=Session["ApplicationFilter"].ToString();
                                     
                            break;
                        }
                    case 3:
                        {
                            Session["ServerFilter"]= "ServerNodeName LIKE " + "'" + txtSearch.Text + "%'";
                            dvItems.RowFilter = Session["ServerFilter"].ToString();

                            break;
                        }
                }
                    
            }
            else if (nCategory == 1) //just a way of showing the headers of the grid view
            {
                DataTable dtGroupDir= new DataTable(); 
                DataView dv;
                DataRow row;


                dtGroupDir.Columns.Add(new DataColumn("Firstname", typeof(string)));
                dtGroupDir.Columns.Add(new DataColumn("Surname", typeof(string)));
                dtGroupDir.Columns.Add(new DataColumn("Email", typeof(string)));
                dtGroupDir.Columns.Add(new DataColumn("Mobile", typeof(string)));
                dtGroupDir.Columns.Add(new DataColumn("Login", typeof(string)));
                
                row = dtGroupDir.NewRow();

                row["Firstname"] = "";
                row["Surname"] = "";
                row["Email"] = "";
                row["Mobile"] = "";
                row["Login"] = "";

                dtGroupDir.Rows.Add(row);

                dv = new DataView(dtGroupDir);
                dvItems=dv;
            }

                
        }
        */
        protected void CheckCondition()
        {
            bool bGroupDir = false;

            int sortOrder = -1;

            if (txtSearch.Text != "" || txtFirstName.Text != "")
            {
                switch (nCategory)
                {
                    case 1:
                        {
                            bGroupDir = true;
                            dvItems = null;
                            dvItems = GetGroupDirDataSource(txtSearch.Text, txtFirstName.Text);
                            break;
                        }
                    case 2:
                        {
                            if (txtSearch.Text.Equals(string.Empty) && txtFirstName.Text.Equals(string.Empty))
                            {
                                Session["ApplicationFilter"] = "ApplicationInstanceName LIKE " + "'%'";
                            }
                            else
                            {
                                if (!txtSearch.Text.Equals(string.Empty) && txtFirstName.Text.Equals(string.Empty))
                                {
                                    Session["ApplicationFilter"] = "ApplicationInstanceName LIKE " + "'%" + txtSearch.Text + "%'";
                                    sortOrder = 0;
                                }
                                else
                                {
                                    if (txtSearch.Text.Equals(string.Empty) && !txtFirstName.Text.Equals(string.Empty))
                                    {
                                        Session["ApplicationFilter"] = "ExternalApplicationID LIKE '%" + txtFirstName.Text + "%'";
                                        sortOrder = 1;
                                    }
                                    else
                                    {
                                        Session["ApplicationFilter"] = "ApplicationInstanceName LIKE " + "'%" + txtSearch.Text + "%' OR " +
                                         "ExternalApplicationID LIKE '%" + txtFirstName.Text + "%'";
                                        sortOrder = 2;
                                    }
                                }
                            }
                            dvItems.RowFilter = Session["ApplicationFilter"].ToString();
                            if( sortOrder == 0 )
                                dvItems.Sort = "ApplicationInstanceName";
                            else if( sortOrder == 1 )
                                dvItems.Sort = "ExternalApplicationID ";
                            else if( sortOrder == 2 )
                                 dvItems.Sort = "ApplicationInstanceName, ExternalApplicationID "; 
                            break;
                        }
                    case 3:
                        {
                            Session["ServerFilter"] = "ServerNodeName LIKE " + "'" + txtSearch.Text + "%'";
                            dvItems.RowFilter = Session["ServerFilter"].ToString();
                            break;
                        }
                }
            }
            else if (nCategory == 1) //just a way of showing the headers of the grid view
            {
                DataTable dtGroupDir = new DataTable();
                DataView dv;
                DataRow row;

                dtGroupDir.Columns.Add(new DataColumn("Firstname", typeof(string)));
                dtGroupDir.Columns.Add(new DataColumn("Surname", typeof(string)));
                dtGroupDir.Columns.Add(new DataColumn("Email", typeof(string)));
                dtGroupDir.Columns.Add(new DataColumn("Mobile", typeof(string)));
                dtGroupDir.Columns.Add(new DataColumn("Login", typeof(string)));

                row = dtGroupDir.NewRow();
                row["Firstname"] = "";
                row["Surname"] = "";
                row["Email"] = "";
                row["Mobile"] = "";
                row["Login"] = "";

                dtGroupDir.Rows.Add(row);

                dv = new DataView(dtGroupDir);
                dvItems = dv;
            }
            else if (nCategory == 2)
            {
                Session["ApplicationFilter"] = "ApplicationInstanceName LIKE " + "'%'";

                dvItems.RowFilter = Session["ApplicationFilter"].ToString();
            }
        }

        protected void gvItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "GetContact":
                    {
                        int index = 0;// = Convert.ToInt32(e.CommandArgument);

                        index = gvItems.PageIndex * gvItems.PageSize + Convert.ToInt32(e.CommandArgument);

                        string strFirstname=dvItems[index]["Firstname"].ToString();
                        string strSurname = dvItems[index]["Surname"].ToString();
                        string strEmail = dvItems[index]["Email"].ToString();
                        string strMobile= dvItems[index]["Mobile"].ToString();
                        string strLogin = dvItems[index]["Login"].ToString();

                        int nContactID = Global_DB.InsertContact(strFirstname, strSurname, strEmail, strMobile, strLogin);

                        string strScript = string.Format("<script language=\"javascript\"> updateItem('{0}','','{1}')  </script>", strSurname + ", " + strFirstname, nContactID);
                        RegisterStartupScript("updateItemCaller", strScript);                       

                        break;
                    }
                case "GetApplication":
                    {
                        int index = 0;// = Convert.ToInt32(e.CommandArgument);

                        index = gvItems.PageIndex * gvItems.PageSize + Convert.ToInt32(e.CommandArgument);

                       
                       string strAppInstanceName = dvItems[index]["ApplicationInstanceName"].ToString();
                       string strExternalAppID = dvItems[index]["ExternalApplicationID"].ToString();
                       string strAppID = dvItems[index]["ApplicationID"].ToString();
                       string strAppInvestmentStrategy = dvItems[index]["InvestmentStrategy"].ToString();


                       string strScript = string.Format("<script language=\"javascript\"> updateItem('{0}','{1}','{2}','{3}') </script>", 
                            strAppInstanceName,strExternalAppID, strAppID, strAppInvestmentStrategy);
                       RegisterStartupScript("updateItemCaller", strScript);
                       

                       break;
                    }
                case "GetServer":
                    {
                        
                        int index=0;// = Convert.ToInt32(e.CommandArgument);

                        index = gvItems.PageIndex*gvItems.PageSize + Convert.ToInt32(e.CommandArgument);

                        string strServerNode=dvItems[index]["ServerNodeName"].ToString(); 
                        string strExternalServerNode=dvItems[index]["ExternalServerNodeID"].ToString();
                        string strServerID=dvItems[index]["ServerID"].ToString();


                        string strScript = string.Format("<script language=\"javascript\"> updateItem('{0}','{1}','{2}') </script>",
                         strServerNode, strExternalServerNode, strServerID);
                        RegisterStartupScript("updateItemCaller", strScript);

                        break;
                    }
                // Rev 1.8.2 GMcF
                case "GetDetailedFunctionalDomain":
                    {
                        int index = 0;// = Convert.ToInt32(e.CommandArgument);

                        index = gvItems.PageIndex * gvItems.PageSize + Convert.ToInt32(e.CommandArgument);

                        string strDescription = dvItems[index]["Description"].ToString();
                        string strReferenceID = dvItems[index]["ReferenceID"].ToString();


                        string strScript = string.Format("<script language=\"javascript\"> updateItem('{0}','','{1}') </script>",
                                                            strDescription, strReferenceID);
                        RegisterStartupScript("updateItemCaller", strScript);

                        break;
                    }
            }
        }

        protected void gvItems_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            CheckCondition();
            
            gvItems.PageIndex = e.NewPageIndex;

            gvItems.DataSource = dvItems;
            gvItems.DataBind();

        }

        protected void btnEmptyItem_Click(object sender, EventArgs e)
        {
            string strScript = string.Format("<script language=\"javascript\"> updateItem('{0}','','{1}')  </script>", "", 0);
            RegisterStartupScript("updateItemCaller", strScript);

        }

        // set the wait cursor when search
        protected override void OnPreRender(EventArgs e)
        {
            Page.RegisterClientScriptBlock("setWaitCursor",
                    "<script language=\"javascript\"> " +
                    "function setWaitCursor() { " +
                    "document.body.style.cursor=\"wait\"; " +
                    "document.frmItemPicker.btnSearch.style.cursor = \"wait\"; " +
                      "}</script>"
                    );

            this.btnSearch.Attributes.Add("OnClick", "setWaitCursor()");

            base.OnPreRender(e);
        }
}
}
