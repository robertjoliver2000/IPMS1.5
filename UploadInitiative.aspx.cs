//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.0         JG          27/01/2009      Page to implement Initiative Upload Template Functionality
//
//*****************************************************************************************************

#define debug   // ERW 18 Mar 2009

using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using System.IO;


using ProjectPortfolio.Classes;



namespace ProjectPortfolio
{
   

    public static class UploadTabName
    { 
        public const string Spend = "Spend";
        public const string Benefit = "Benefits";
        public const string Capex = "Capex";
        public const string Depreciation = "Depreciation";
    }

	public partial class UploadInitiative : System.Web.UI.Page
	{
        

        protected int nInitiativeID;
        int iApprovalID;
        string m_randomFilename;
        string dInitiativeYear;
        bool fileOK = false;
        bool bHasBeenDownloaded;

        //constants
        //ideally these would be in a res file, but they'll do here for the moment
        //const string sess_UploadID = "UploadID";
        const string downloadFileName = "InitiativeUploadTemplate.xls";
        const string msgUploadSuccess = "Upload committed successfully. See below for details on the rows updated / inserted";
        const string msgUploadError = "There was an unexpected error.\n The changes could not be committed.";
        const string msgFatalError = "There were fatal errors during the validation process as shown below.  Please correct these errors and try again.";
        const string msgInternalError = "There was an internal error during the validation process. Please try again.";
        const string msgNonFatalError = "There were non-fatal errors during the validation process as shown below, however the data can still be uploaded.  Review the non-fatal faults, and if happy to proceed click the button above to commit the changes.";
        const string msgValidationSuccess = "The validation process completed successfully.  Click the button to Commit the changes.";
        const string msgMissingTab = "One or more tabs was missing from the spreadsheet, or tab names have been changed.  Tabs can be left blank, but the upload process expects all tabs to be present. Please retry using the standard template which can be downloaded by clicking the link above.";
        const string msgUnresolvedContact = "The following people could not be resolved to known contacts. Click on the contact to select them from the global directory, or amend the upload spreadsheet.";
        const string msgReRunValidation = "If you have added all the above contacts click here to re-run the validation on the data already uploaded.";
        const string msgReAttemptUpload = "Once you have added all the above contacts, or udpated the spreadsheet, browse to the file and upload it again.";
        const string msgTimeout = "A database timeout occurred.  If you are trying to load a large number of rows (Financial data is particularly time consuming to load) you may want to consider splitting the upload into smaller units. The settings should permit a total of 2000 rows for all financial tabs combined, or approx 500 rows in each.\n\nIf the problem persists contact support.";
        const int timeOut = 120;

        int iUploadID;
        int iUserID;

        //AdminBusinessObject admBusObj; 
        IUControl IUCtrl;

        DataSet dsProjects; 
        DataSet dsInitiatives;

        //IUFinancial spend;
        //IUFinancial benefit;
        //IUFinancial depreciation;
        //IUFinancial capex;

        
        protected void Page_PreRender(object o, System.EventArgs e)
        { }
        protected void Page_Load(object sender, System.EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            //check the person requesting the page is a superuser
            if (Session["ContactID"] != null && Session["ContactID"].ToString() != String.Empty)
            {
                string strMaxPermission = Security_DB.GetMaxAccessRights((int)Session["ContactID"]);

                if (!Global.HasSuperUserRights(strMaxPermission))
                {
                    Response.ClearContent();
                    Response.Write("You are not allowed to see this page. Please contact your IPMS Administrator for more information");
                    Response.End();
                }
            }
            else
            {
                Response.ClearContent();
                Response.Write("You are not allowed to see this page. Please contact your IPMS Administrator for more information");
                Response.End();
            }

                     
            if (!Page.IsPostBack)
            {
                #region PriorCode3Mar2009
                /*
                DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(4);

                dsIGApprovalCommittee.Tables["Reference"].Rows.RemoveAt(0);

                DataView dvIGApprovalCommittee = new DataView(dsIGApprovalCommittee.Tables["Reference"]);
                dvIGApprovalCommittee.Sort = "Description ASC";

                ddlApprovalCommittee.DataSource = dvIGApprovalCommittee;
                ddlApprovalCommittee.DataValueField = "Description";
                ddlApprovalCommittee.DataTextField = "Description";

                ddlApprovalCommittee.DataBind();


                // Changed 2008-01-28, GMcF, for AP maint request 2008-01-02, followed up 2008-01-28. Added bwithAll = false to method call.
                DataSet dsYear = Global_DB.GetYears(false);

                ddlPeriod.DataSource = dsYear;
                ddlPeriod.DataValueField = "PeriodYear";
                ddlPeriod.DataTextField = "PeriodYear";

                ddlPeriod.DataBind();

                //rem CA
                //ddlPeriod.SelectedValue = DateTime.Now.Year.ToString();
                //end rem

                ////rev 1.1.1 CA
                //ddlPeriod.SelectedIndex = 3;
                ////end rev

                // Added 2008-01-28, GMcF, for AP maint request 2008-01-02, followed up 2008-01-28
                ddlPeriod.SelectedValue = DateTime.Now.Year.ToString();


                //rev 1.1.5 CA

                //not required at the moment
                //DataSet dsIGApprovalStatus = Global_DB.GetReferenceTable(5);

                ////dsIGApprovalStatus.Tables["Reference"].Rows[0]["Description"] = "Any";

                //ddlStatus.DataSource = dsIGApprovalStatus.Tables["Reference"];
                //ddlStatus.DataValueField = "ReferenceID";
                //ddlStatus.DataTextField = "Description";

                //ddlStatus.DataBind();
                //*

                ddlStatus.Items.Add("IG Draft");
                ddlStatus.Items.Add("Budget Request");

                //end rev 
*/
                #endregion
            }
            else
            {
                //we need to store the UploadID in hidden field so that we can get it back
                if (hidUploadID.Value != String.Empty)
                {
                    iUploadID = Convert.ToInt32(hidUploadID.Value);
                }

                //ERW 13 Feb 2009 
                // Consider instantiating this now
                //admBusObj = new AdminBusinessObject(); 

            }
		}
        

        //---------------------
        // changed my mind ERW - not sure if necessary at all.
        //---------------------
        /////* Type is one of
        //// *      Initiative
        //// *      Spend
        //// *      Benefit
        //// *      Depreciation
        //// *      CAPEX
        //// *      Sponsor
        //// *      BenRec
        //// *      Depreciation
        //// *      StaticData
        //// */
        ////private aIUObject GetIUObject(string Type)
        ////{
        ////    Type = Type.ToLower(); 

        ////    switch (Type)
        ////    {
        ////       case "spend":
        ////           if (spend !=null) {return spend;} else { return new IUFinancial("Spend");}
        ////           break;
        ////       case "benefit":
        ////           if (spend != null) { return benefit; } else { return new IUFinancial("Benefit"); } 
        ////           break;
        ////       case "depreciation":
        ////           if (spend != null) { return depreciation ; } else { return new IUFinancial("Depreciation"); } 
        ////           break;
        ////       case "capex":
        ////           if (spend != null) { return capex; } else { return new IUFinancial("CAPEX"); } 
        ////           break;
               
        ////        default:
        ////        break;
        ////    }
            
        ////}


        protected void DownLoadTemplate_Click(object sender, EventArgs e)
        {
            if ((string)Session["snBeenSaved"] != "BeingSaved")
            {
                DownloadFile("~\\template\\" + downloadFileName, true);
            }
            Session["snBeenSaved"] = "NotBeingSaved";
        }

        protected void btnCommitChanges_Click(object sender, EventArgs e)
        { 
            // if the button has been enabled, the upload can be committed
            // no further checks here

            pnlUploadDetails.Visible = false;
            pnlResult.Visible = true;

            try
            {
                #region priorcode
                ////re-instantiate all the objects
                ////with the correct UploadID
                //InstantiateIUObjects(iUploadID); 

                ////Initiative
                //if (admBusObj == null)
                //{
                //    admBusObj = new AdminBusinessObject();
                //}
                //admBusObj.ApplyInitiativeChanges(iUploadID );



                ////IU_Financial
                ////  Spend;   Benefit;  Depreciation;  Capex
                ////write this in a loop ? calling each IUFinancialObject in turn?
                //// All the Financial objects store their data in the same table,
                //// and calling commit on any one of them runs commit process on the whole table
                //// thats why there is no commit call for all the IU_Financial objects                
                //spend.Commit(); 

                //// Sponsor

                ////Deliverable

                ////Static Data

                ////Ben Rec
                #endregion

                if (IUCtrl == null)
                {
                    IUCtrl = new IUControl(iUploadID);
                }

                //ERW - later correctly resolve the number of rows affected.
                int commitResult;
                commitResult = IUCtrl.Commit();
                if (commitResult > 0)
                {
                    //get num rows processed?
                    lblResult.Text = msgUploadSuccess;

                    //display results
                    gvRowsCommitted.DataSource = IUCtrl.GetRowsCommitted(); ;
                    gvRowsCommitted.DataBind();
                    gvRowsCommitted.Visible = true;
                }
                else
                {
                    lblResult.Text = msgUploadError;
                    gvRowsCommitted.Visible = false;
                }


                //disable the button so that it can't be clicked twice
                //btnCommitChanges.Enabled = false; 
                btnCommitChanges.Disabled = true;
            }
            
            catch (Exception ex)
            {
                if (ex.Message.Contains("Timeout"))
                {                    
                    lblResult.Text = msgTimeout;
                    gvRowsCommitted.Visible = false;
                }
                else 
                {
                    // if there is some other exception, just let the standard IPMS error handler deal with it
                    throw ex;
                }
            }

        }

        //protected void btnSaveProjects_Click(object sender, EventArgs e)
        //{
        //    decimal dcPercentRequired, dcAmountRequestedEUROs, dcTotalPlanLC, dcFXRate;

        //    int iProjectNo;
        //    int iCurrencyNo;

        //    Session["snBeenSaved"] = "BeingSaved";

        //    foreach (GridViewRow row in gvProjects.Rows)
        //    {

        //        try
        //        {
        //            dcTotalPlanLC = Convert.ToDecimal(row.Cells[8].Text);
        //        }
        //        catch (Exception e1)
        //        {
        //            dcTotalPlanLC = 0;
        //        }

        //        try
        //        {
        //            dcFXRate = Convert.ToDecimal(row.Cells[10].Text);
        //        }
        //        catch (Exception e1)
        //        {
        //            dcFXRate = 0;
        //        }

        //        try
        //        {
        //            dcAmountRequestedEUROs = Convert.ToDecimal(row.Cells[5].Text);
        //        }
        //        catch (Exception e1)
        //        {
        //            dcAmountRequestedEUROs = 0;
        //        }

        //        try
        //        {
        //            dcPercentRequired = (dcAmountRequestedEUROs / (dcTotalPlanLC * dcFXRate)) * 100;

        //        }
        //        catch (Exception e1)
        //        {
        //            dcPercentRequired = 0;
        //        }

        //        try
        //        {
        //            iProjectNo = SectionJ_DB.GetProjectNo(Convert.ToString(row.Cells[4].Text));

        //        }
        //        catch (Exception e1)
        //        {
        //            iProjectNo = 0;
        //        }

        //        try
        //        {
        //            iCurrencyNo = SectionJ_DB.GetCurrencyNo(Convert.ToString(row.Cells[9].Text));

        //        }
        //        catch (Exception e1)
        //        {
        //            iCurrencyNo = 0;
        //        }

        //        SectionJ_DB.InsertInitiativeProject(nInitiativeID,
        //                                            Convert.ToString(row.Cells[0].Text),
        //                                            Convert.ToString(row.Cells[1].Text),
        //                                            Convert.ToString(row.Cells[2].Text),
        //                                            Convert.ToString(row.Cells[3].Text),
        //                                            iProjectNo,
        //                                            Convert.ToString(row.Cells[4].Text),
        //                                            dcAmountRequestedEUROs,
        //                                            dcPercentRequired,
        //                                            dcTotalPlanLC,
        //                                            iCurrencyNo,
        //                                            Convert.ToString(row.Cells[9].Text),
        //                                            dcFXRate);

        //        //SectionJ_DB.InsertInitiativeProject(nInitiativeID,
        //        //                                    Convert.ToString(txtProjectID.Text),
        //        //                                    Convert.ToString(txtProjectName.Text),
        //        //                                    Convert.ToString(txtProjectDescr.Text),
        //        //                                    Convert.ToString(txtProgramName.Text),
        //        //                                    Convert.ToInt32(ddlProjectType.SelectedValue),
        //        //                                    ddlProjectType.SelectedItem.Text.ToString(),
        //        //                                    dcAmountRequestedEUROs,
        //        //                                    dcPercentRequired,
        //        //                                    dcTotalPlanLC,
        //        //                                    Convert.ToInt32(ddlBaseCurrency.SelectedValue),
        //        //                                    ddlBaseCurrency.SelectedItem.Text.ToString(),
        //        //                                    dcFXRate);

        //    }

        //    Response.Redirect("~/default.aspx?section=4&InitiativeID=" + nInitiativeID.ToString());

        //}
        
        private string NewRandomString()
        {
            System.Text.StringBuilder myCode = new System.Text.StringBuilder("");
            System.Random random = new Random(unchecked((int)DateTime.Now.Ticks));
            for (int i = 1; i <= 20; i++)
            {
                int c = (int)random.Next(65, 91);
                myCode.Append((char)c);
            }
            return myCode.ToString();
        }
        
        protected void gvProjects_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProjects.PageIndex = e.NewPageIndex;
            gvProjects.DataSource = dsProjects.Tables[0].DefaultView;
            gvProjects.DataBind();
            
        }

        //this loads the file that has been "browsed" to
        protected void btnPopGrid_Click(object sender, EventArgs e)
        {
            String[] allowedExtensions =  { ".xls" };


            String path = Server.MapPath("~/import/");
            if (FileUpload1.HasFile)
            {
                String fileExtension =
                    System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
                
               

                //ERW 13 May 2009 -For xlsx files we need an extra driver and need to load
                // it onto the server (I think) Not done cos of time constraints
                // for the moment IPMS only supports .xls files
                // for driver: ->  http://www.microsoft.com/downloads/details.aspx?familyid=7554F536-8C28-4598-9B72-EF94E038C891&displaylang=en
                //String[] allowedExtensions =  { ".xls", ".xlsx" };

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension.Trim() == allowedExtensions[i])
                    {
                        fileOK = true;
                        //don't check any further
                        i = allowedExtensions.Length;
                    }
                }

                if (fileOK)
                {
                    try
                    {
                        m_randomFilename = NewRandomString();
                        m_randomFilename = m_randomFilename.Trim() + fileExtension;
                        //FileUpload1.PostedFile.SaveAs(path + m_randomFilename.Trim() + ".xls");
                        FileUpload1.PostedFile.SaveAs(path + m_randomFilename.Trim());

                        lblShortUploadResponse.Text = "File uploaded!";
                    }
                    catch (Exception ex)
                    {
                        lblShortUploadResponse.Text = "File could not be uploaded.";
                    }
                }
                else
                {
                    string listExtensions = "";

                    for (int i = 0; i < allowedExtensions.Length; i++)
                    {
                        listExtensions += allowedExtensions[i] + ", "; 
                    }

                    //trim off the final ", "
                    listExtensions = listExtensions.Substring(0, listExtensions.Length - 2);    

                    lblShortUploadResponse.Text = "Cannot accept files of type \"" + fileExtension + "\". Please supply a file of type: \""
                                                  + listExtensions + "\".";
                }
            }
            else 
            {           
                lblShortUploadResponse.Text = "No file set.";            
            }



            if (fileOK)
            {

                #region priorcode
                //iUserID = Convert.ToInt32(Session["ContactID"]);                
                //admBusObj = new AdminBusinessObject(iUserID, iUserID + " logged in on " + DateTime.Now);
                //iUploadID = admBusObj.InitialiseUpload();
                ////store this value 
                //hidUploadID.Value  = iUploadID.ToString() ;
                #endregion


                iUserID = Convert.ToInt32(Session["ContactID"]);
                string userName = Session["Username"].ToString();

                IUCtrl = new IUControl(iUserID, userName + " logged in on " + DateTime.Now);
                iUploadID = IUCtrl.InitialiseUpload();
                //store this value 
                hidUploadID.Value = iUploadID.ToString();




                /*  Logic -
                 *  Upload
                 *  Validate
                 *  If all validates, show success message enable Save / commit button
                 *  else display failure results to user
                */
                #region priorCode
                ////LoadGridView();
                //InstantiateIUObjects(iUploadID);
                //Upload();
                //Validate();
                //DisplayResults();
                ////btnSaveProjects.Enabled = true;
                ////btnPopGrid.Enabled = false;
                #endregion //priorcode


                if (Upload())
                {
                    Validate();
                    DisplayResults();
                }
                else
                {
                    //if there was an error, make sure the details panel is visible
                    pnlUploadDetails.Visible = true;
                }

            }
 
        }

        private void DownloadFile(string fname, bool forceDownload)
        {
            string sPath = MapPath(fname);
            string sName = Path.GetFileName(sPath);
            string sExt = Path.GetExtension(sPath);
            string sType = "";

            bHasBeenDownloaded = true;

            // set known types based on file extension  
            if (sExt != null)
            {
                switch (sExt.ToLower())
                {
                    case ".htm":
                    case ".html":
                        sType = "text/HTML";
                        break;

                    case ".txt":
                        sType = "text/plain";
                        break;

                    case ".doc":
                    case ".rtf":
                        sType = "Application/msword";
                        break;
                }
            }
            if (forceDownload)
            {
                Response.AppendHeader("content-disposition",
                    "attachment; filename=" + sName);
            }
            if (sType != "")
                Response.ContentType = sType;
            Response.WriteFile(sPath);
            Response.End();
        }

        //the objects need to already be instantiated, with correct UploadID set by this point
        private void Validate()
        {
            ////Initiative
            //admBusObj.ValidateInitiative();
            
            ////The financial objects are all held within the same table. Calling Validate() on any one of them
            ////validates the whole table (for that uploadID).  Thats why there is no validate call on each of them
            //spend.Validate();

            IUCtrl.Validate(); 

        }
        
        //ERW 12 Feb 2009
        private void DisplayResults()
        {
            //gvProjects.Visible = false;
            //lblUploadMessage.Visible = false;
//            btnCommitChanges.Enabled = false;
            btnCommitChanges.Disabled = true;
            pnlUploadDetails.Visible = true;

            //ERW 14 Apr 2009
            //I also remove the file uploaded message at this point in time
            lblShortUploadResponse.Text = "";


            //Test if its OK - we need to do a count from the IU_Faults view - if its 0 
            // do upload
            //int faultCode = admBusObj.GetFaultStatus();
            int faultCode = IUCtrl.GetFaultStatus();

//ERW 14 April 2009
//Nice idea Eric,  but since this is built as a web site and not a web app
// it is always built in "debug" mode; you can't seem to influence whether its 
//release or debug.  Consider changing to a web app asap

//#if debug
//            // if we are debugging, don't show unresolved contacts 
//            // because we're not connected to same LDAP server, so 
//            // this is just more complicated.  Instead
//            //skip it and move on
//            if (faultCode == UploadFaultCode.UnresolvedContacts)
//            {
//                faultCode = UploadFaultCode.NonFatalError;
//            }
//#endif

            if (faultCode == UploadFaultCode.FatalError)   //(faultCode < 0)
            {
                //if its not all OK
                // with all the faults
                LoadGridView();
                lblUploadMessage.Text = msgFatalError;
                lblUploadMessage.Visible = true; 
               // btnCommitChanges.Enabled = false;                                
                btnCommitChanges.Disabled = true;
            }
            else if (faultCode == UploadFaultCode.InternalError ) //(faultCode == 0)
            { 
                // this is an internal error in the proc that returns the faultCode
                lblUploadMessage.Text = msgInternalError;
                lblUploadMessage.Visible = true; 
            }
            else if (faultCode == UploadFaultCode.UnresolvedContacts)
            {
                //make sure the other panels are hidden; only show the one we want
                ShowPanels(false);

                pnlUnresolvedContacts.Visible = true;
                lblUnresovledContactMsg.Visible = true;
                lblUnresovledContactMsg.Text = msgUnresolvedContact;
                gvUnresolvedContacts.DataSource = IUCtrl.GetUnresolvedContacts();
                gvUnresolvedContacts.DataBind();

                //msgReRunValidation msgReAttemptUpload
                //ERW set to visble = false just now. I think its easier just
                //to tell user to browse to the file and re-upload it again.
                lnkValidate.Text = msgReRunValidation;

                lblUnresolvedContactAlt.Text = msgReAttemptUpload;
                
            }
            else if (faultCode == UploadFaultCode.NonFatalError
                   || faultCode == UploadFaultCode.Success)    //(faultCode > 0)
            {
                if (faultCode == UploadFaultCode.NonFatalError)
                {
                    //non fatal errors
                    // show the datagrid
                    LoadGridView();
                    lblUploadMessage.Text = msgNonFatalError;
                    lblUploadMessage.Visible = true;
                }
                else
                {
                    //if its all ok
                    // show OK message and 
                    //possibly show a summary of total rows in each tab 
                    //  e.g. Initiative     26
                    //       Spend          38
                    // etc.
                    lblUploadMessage.Text = msgValidationSuccess;
                    lblUploadMessage.Visible = true;
                }

                //btnCommitChanges.Enabled = true;
                btnCommitChanges.Disabled = false;
            }
            
        }

        private void LoadGridView()
        { 
            //load grid view with any errors
            gvProjects.Visible = true;

            //Bind data to DataGrid control.
            //gvProjects.DataSource = admBusObj.GetFaults();              
            gvProjects.DataSource = IUCtrl.GetFaults(); 
            gvProjects.DataBind();
            
            
            //switch off Theme columns we don't want
            //gvRowsCommitted.Columns[].Visible =  false;
               
                            
        }

        //private void LoadGridView()
        private bool Upload()
        {
            #region prior code

            //----------------
            // moved to   CreateExcelObjectConn(...)
            //------------
            //// Create connection string variable. Modify the "Data Source"
            //// parameter as appropriate for your environment.
            //String sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
            //    "Data Source=" + Server.MapPath("import/" + m_randomFilename + ".xls") + ";" +
            //    "Extended Properties=Excel 8.0;";

            //// Create connection object by using the preceding connection string.
            //OleDbConnection objConn = new OleDbConnection(sConnectionString);

            //// Open connection with the database.
            //objConn.Open();

            
            // -----------------------
            // moved to GetDataSetFromExcelTab(...)
            // -----------------------
            // The code to follow uses a SQL SELECT command to display the data from the worksheet.

            // Create new OleDbCommand to return data from worksheet.
            //////OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [Initiative$]", objConn);

            //////// Create new OleDbDataAdapter that is used to build a DataSet
            //////// based on the preceding SQL SELECT statement.
            //////OleDbDataAdapter objAdapter1 = new OleDbDataAdapter();

            //////// Pass the Select command to the adapter.
            //////objAdapter1.SelectCommand = objCmdSelect;

            //////// Create new DataSet to hold information from the worksheet.
            //////dsInitiatives = new DataSet();

            //////// Fill the DataSet with the Initiative information from the worksheet.
            //////objAdapter1.Fill(dsInitiatives, "Initiative");

            //////// Remove unnecessary rows
            //////dsInitiatives.Tables[0].Rows.RemoveAt(0);
            //////dsInitiatives.Tables[0].Rows.RemoveAt(0);

            //////int idx = 0, consecutiveBlankNames = 0;
            //////string currentName = "", prevName = "";

            //////foreach (DataRow dr in dsInitiatives.Tables[0].Rows  )
            //////{
            //////    if (idx > 0)
            //////    {
            //////        admBusObj.Name = dr[0].ToString();
            //////        currentName = dr[0].ToString();

            //////        // logic to detect end of spreadsheet
            //////        if (currentName.Equals(String.Empty))
            //////        {
            //////            if (currentName == prevName) ++consecutiveBlankNames;
            //////        }
            //////        if (consecutiveBlankNames > 20)
            //////            break;

            //////        // Assign object properties from spreadsheet. Ordinal values 
            //////        // must be respected
            //////        admBusObj.PrimarySponsoringArea         = dr[1].ToString();
            //////        admBusObj.OtherSponsoringAreas          = dr[2].ToString();
            //////        admBusObj.BusinessSponsorName           = dr[3].ToString();
            //////        admBusObj.BusinessInitiativeManager     = dr[4].ToString();
            //////        admBusObj.Region                        = dr[5].ToString();
            //////        admBusObj.GTOManagingBusinessArea       = dr[6].ToString();
            //////        admBusObj.GTOInitiativeManager          = dr[7].ToString();
            //////        admBusObj.FunctionalDomain              = dr[8].ToString();
            //////        admBusObj.MajorApplicationName          = dr[9].ToString();
            //////        admBusObj.InitiativeBusinessDrivers     = dr[10].ToString();
            //////        admBusObj.InitiativeScopeAndObjectives  = dr[11].ToString();
            //////        admBusObj.InitiativeBenefitCalculation  = dr[12].ToString();
            //////        admBusObj.StrategicInitiativeInterfaces = dr[13].ToString();
            //////        admBusObj.SmartsourcingComponent        = dr[14].ToString();
            //////        admBusObj.ArchitecturalComplianceType   = dr[15].ToString();
            //////        admBusObj.ArchitecturalCompliance       = dr[16].ToString();
            //////        admBusObj.PaybackPeriod                 = dr[17].ToString();
            //////        admBusObj.CompletionDate                = dr[18].ToString();
            //////        admBusObj.RowCommand                    = dr[19].ToString();
            //////        admBusObj.UploadID                      = iUploadID;

            //////        admBusObj.UploadInitiative();

            //////        prevName = currentName;
            //////    }
            //////    ++idx;
            //////}


            // Bind data to DataGrid control.
            //     gvProjects.DataSource = dsProjects.Tables[0].DefaultView;
            //     gvProjects.DataBind();

            // Clean up objects.
            //objConn.Close();
            //File.Delete(Server.MapPath("import/" + randomFilename + ".xls"));

            #endregion

            //if user attempts upload again, make sure panels are hidden
            ShowPanels(false);


            //alterations ERW
            //24 Feb 2009
            OleDbConnection excelConn;
            excelConn = CreateExcelObjectConn(m_randomFilename);

            #region PriorCode3Mar2009
            ////  //ERW 24 Feb 2009
          ////  //Initiative is different cos it hasn't been reworked yet
          ////  Upload_Initiative(excelConn);
                       
          //////Upload_Spend(excelConn, iUploadID);

            ////  Upload_Financial(excelConn, iUploadID);
            #endregion

            try
            {
                IUCtrl.Upload(excelConn);
                return true;
            }
            catch (OleDbException oleDBEx)
            {
                //xxx$ is not a valid name
                //system.exception{system.Data.OleDbException
                //exceptions here are likely to be missing tabs
                if (oleDBEx.Message.Contains("is not a valid name"))
                {
                    lblUploadMessage.Text = msgMissingTab;
                    lblUploadMessage.Visible = true;
                }
                else
                {
                    throw oleDBEx; 
                }

                return false; 
            }
            //catch (Exception ex)
            //{

            //}
            finally
            {
                // Clean up objects.
                excelConn.Close();
                excelConn.Dispose();
                //File.Delete(Server.MapPath("import/" + m_randomFilename + ".xls"));
                File.Delete(Server.MapPath("import/" + m_randomFilename ));
            }
                        
        }


        #region PriorCode3Mar2009
        ////returns a dataset containing the data that is in the parameter tab, from the parameter Excel Connection
        //// the dataset contains a table with the same name as the parameter TabName
        //private DataSet GetDataSetFromExcelTab(string TabName, OleDbConnection excelConn)
        //{
        //    DataSet ds;

        //    // Create new OleDbCommand to return data from worksheet.
        //    OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [" + TabName + "$]", excelConn);

        //    // Create new OleDbDataAdapter that is used to build a DataSet
        //    // based on the preceding SQL SELECT statement.
        //    OleDbDataAdapter objAdapter1 = new OleDbDataAdapter();

        //    // Pass the Select command to the adapter.
        //    objAdapter1.SelectCommand = objCmdSelect;

        //    // Create new DataSet to hold information from the worksheet.
        //    ds = new DataSet();

        //    // Fill the DataSet with the Initiative information from the worksheet.
        //    objAdapter1.Fill(ds, TabName);

        //    return ds;
        //}
        #endregion


        //returns an open Object Connection to the named Excel File
        private OleDbConnection CreateExcelObjectConn(string Filename)
        {
            //sanitise ths string - if its got /xls on the end, remove it
            //Filename = Filename.Replace(".xls", "");

            String sConnectionString = "";
            FileInfo f = new FileInfo(Filename);
            

            // Create connection string variable. Modify the "Data Source"
            // parameter as appropriate for your environment.
            if (f.Extension.Trim() == ".xls")  
            {
                //String sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
                //"Data Source=" + Server.MapPath("import/" + Filename + ".xls") + ";" +
                //"Extended Properties=Excel 8.0;";
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
                "Data Source=" + Server.MapPath("import/" + Filename ) + ";" +
                "Extended Properties=Excel 8.0;";
            }
            else if (f.Extension.Trim() == ".xlsx")
            {
                //adapted from above and 
                //http://www.tipsntracks.com/100/read-and-display-data-from-an-excel-file-xsl-or-xlsx-in-aspnet.html
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;" +
                "Data Source=" + Server.MapPath("import/" + Filename + ".xls") + ";" +
                "Extended Properties=Excel 12.0;HDR=Yes;IMEX=2;";
            }
            else 
            {
                throw new Exception("Cannot connect to file. The file is not a supported type");
            }
            
            

            // Create connection object by using the preceding connection string.
            OleDbConnection objConn = new OleDbConnection(sConnectionString);

            // Open connection with the database.
            objConn.Open();

            return objConn;
        }


        //private void Upload_Spend(OleDbConnection excelConn, int UploadID)
        //private void Upload_Financial(OleDbConnection excelConn, int UploadID)
        //{
        //    //by this point in execution, the IU objects have all been created
        //    //IUFinancial SpendDB = new IUFinancial();
        //    //spend = GetIUObject("Spend");
            
        //    //Spend
        //    DataSet dsSpend = GetDataSetFromExcelTab("Spend", excelConn);
        //    spend.PopulateFromDataSet(dsSpend, UploadID); 

        //    //Benefit
        //    DataSet dsBenefit = GetDataSetFromExcelTab("Benefits", excelConn);
        //    benefit.PopulateFromDataSet(dsBenefit, UploadID);

        //    //CAPEX
        //    DataSet dsCAPEX = GetDataSetFromExcelTab("CAPEX", excelConn);
        //    capex.PopulateFromDataSet(dsCAPEX, UploadID); 

        //    //Depreciation
        //    DataSet dsDepreciation = GetDataSetFromExcelTab("Depreciation", excelConn);
        //    depreciation.PopulateFromDataSet(dsDepreciation, UploadID); 


        //}


        #region PriorCode Upload_Initiative
        //private void Upload_Initiative(OleDbConnection objConn)
        //{
        //    // The code to follow uses a SQL SELECT command to display the data from the worksheet.

        //    // Create new OleDbCommand to return data from worksheet.
        //    OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [Initiative$]", objConn);

        //    // Create new OleDbDataAdapter that is used to build a DataSet
        //    // based on the preceding SQL SELECT statement.
        //    OleDbDataAdapter objAdapter1 = new OleDbDataAdapter();

        //    // Pass the Select command to the adapter.
        //    objAdapter1.SelectCommand = objCmdSelect;

        //    // Create new DataSet to hold information from the worksheet.
        //    dsInitiatives = new DataSet();

        //    // Fill the DataSet with the Initiative information from the worksheet.
        //    objAdapter1.Fill(dsInitiatives, "Initiative");

        //    // Remove unnecessary rows
        //    dsInitiatives.Tables[0].Rows.RemoveAt(0);
        //    dsInitiatives.Tables[0].Rows.RemoveAt(0);

        //    int idx = 0, consecutiveBlankNames = 0;
        //    string currentName = "", prevName = "";

        //    foreach (DataRow dr in dsInitiatives.Tables[0].Rows)
        //    {
        //        if (idx > 0)
        //        {
        //            admBusObj.Name = dr[0].ToString();
        //            currentName = dr[0].ToString();

        //            // logic to detect end of spreadsheet
        //            if (currentName.Equals(String.Empty))
        //            {
        //                if (currentName == prevName) ++consecutiveBlankNames;
        //            }
        //            if (consecutiveBlankNames > 20)
        //                break;

        //            // Assign object properties from spreadsheet. Ordinal values 
        //            // must be respected
        //            admBusObj.PrimarySponsoringArea = dr[1].ToString();
        //            admBusObj.OtherSponsoringAreas = dr[2].ToString();
        //            admBusObj.BusinessSponsorName = dr[3].ToString();
        //            admBusObj.BusinessInitiativeManager = dr[4].ToString();
        //            admBusObj.Region = dr[5].ToString();
        //            admBusObj.GTOManagingBusinessArea = dr[6].ToString();
        //            admBusObj.GTOInitiativeManager = dr[7].ToString();
        //            admBusObj.FunctionalDomain = dr[8].ToString();
        //            admBusObj.MajorApplicationName = dr[9].ToString();
        //            admBusObj.InitiativeBusinessDrivers = dr[10].ToString();
        //            admBusObj.InitiativeScopeAndObjectives = dr[11].ToString();
        //            admBusObj.InitiativeBenefitCalculation = dr[12].ToString();
        //            admBusObj.StrategicInitiativeInterfaces = dr[13].ToString();
        //            admBusObj.SmartsourcingComponent = dr[14].ToString();
        //            admBusObj.ArchitecturalComplianceType = dr[15].ToString();
        //            admBusObj.ArchitecturalCompliance = dr[16].ToString();
        //            admBusObj.PaybackPeriod = dr[17].ToString();
        //            admBusObj.CompletionDate = dr[18].ToString();
        //            admBusObj.RowCommand = dr[19].ToString();
        //            admBusObj.UploadID = iUploadID;

        //            admBusObj.UploadInitiative();

        //            prevName = currentName;
        //        }
        //        ++idx;
        //    }

        //}
#endregion 

        //private void Upload_Financial(OleDbConnection objConn, string TabName)
        //{ }
        //private void Upload_Sponsor(OleDbConnection objConn)
        //{ }
        //private void Upload_StaticData(OleDbConnection objConn)
        //{ }
        //private void Upload_Deliverable(OleDbConnection objConn)
        //{ }
        //private void Upload_BenRec(OleDbConnection objConn)
        //{ }


        //private void InstantiateIUObjects(int UploadID)
        //{

        //    //IU_Initiative
        //    //if (initiative == null)
        //    //{
        //    //    initiative = new IUInitiative();
        //    //    initiative.UploadID = UploadID;
        //    //}

        //    //IU_Financial objects
        //    if (spend == null)
        //    {
        //        spend = new IUFinancial( IUFinancial.FinancialTabType.Spend   );
        //        spend.UploadID = UploadID;
        //    }

        //    if (benefit  == null)
        //    {
        //        benefit = new IUFinancial(IUFinancial.FinancialTabType.Benefit);
        //        benefit.UploadID = UploadID;
        //    }

        //    if (depreciation  == null)
        //    {
        //        depreciation = new IUFinancial(IUFinancial.FinancialTabType.Depreciation);
        //        depreciation.UploadID = UploadID;
        //    }

        //    if (capex == null)
        //    {
        //        capex = new IUFinancial(IUFinancial.FinancialTabType.CAPEX);
        //        capex.UploadID = UploadID;
        //    }



        //    //IU_Sponsor
        //    //IU_StaticData
        //    //IU_Depreciation
        //    //IU_BenRec

        //}

        protected void gvProjects_DataBinding(object sender, EventArgs e)
        {
              
        }
        protected void gvProjects_DataBound(object sender, EventArgs e)
        {

        }

        protected void gvProjects_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           
            
            // I had problems with this giving errors when fault has 0 length (i.e. no fault)
            //            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {                
                //mark each with a *
                string fault;
                fault = e.Row.Cells[4].Text.Trim();
                if (fault.Length > 0)
                {
                    fault = fault.Replace("|n|", "\n*");

                    //we want to remove the final *, if there is one.  And if there is
                    //one it will be in the 2 final characters, since we have trimmed the string
                    //  \n* is only 2 chars, not as you might expect - cos \n is a single char
                    if ((fault.Length > 2) && (fault.LastIndexOf("\n*") >= (fault.Length - 2)))
                    {
                        fault = fault.Substring(0, fault.Length - 2);
                    }
                    
                    fault = "*" + fault; //e.Row.Cells[4].Text.Replace("|n|", "\n*");                    
                    e.Row.Cells[4].Text = fault;
                }
                //e.Row.Cells[4].Text = "*" + e.Row.Cells[4].Text.Replace(";", "\n*");
            }

        }

        protected void ShowPanels(bool show)
        {
            pnlResult.Visible = show;
            pnlUploadDetails.Visible = show;
            pnlUnresolvedContacts.Visible = show; 
        }


        protected void  gvUnresolvedContacts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
             
             //change each name to be a link to the select contacts pop-upbox.
             if (e.Row.RowType == DataControlRowType.DataRow)
             {  
     
                 string contactName;
                 contactName = e.Row.Cells[0].Text;

                 //make the name an anchor to run the pop-up window - e.g.
                 //
                 //<a runat="server" ID="lnkGTOInitiativeManager"><img src="Images/pick.jpg" border="0" ></a>
                 //
                  //lnkGTOInitiativeManager.Attributes.Add("onclick",
                  //                                      "javascript:popupWindowSelectItem(1,'" +
                  //                                      txtGTOInitiativeManager.ClientID + "','" +
                  //                                      hGTOInitiativeManagerID.ClientID + "'); "+
                  //                                      "return false;"
                  //                                      );
                                
                HtmlAnchor anchor = new HtmlAnchor();
                anchor.Attributes.Add ("onclick",
                                            "javascript:popupWindowSelectItem(1,'" +
                                            hContact.ClientID + "','" +
                                            hContactID.ClientID + "'); "+
                                            "return false;"
                                            );
                anchor.Style.Add("cursor", "pointer");
                anchor.InnerText =  contactName;


                //add the anchor to the gridView cell
                //System.Web.UI.HtmlControls.HtmlAnchor  
                e.Row.Cells[0].Controls.Add(anchor);
             }
        }
        protected void lnkValidate_Click(object sender, EventArgs e)
        {
            //re-run the validation
            Validate();
        }
}
}
