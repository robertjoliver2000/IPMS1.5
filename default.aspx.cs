//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1         CA          25/01/2007      New Dataset to populate Initiative Status dropdown box 
//                                              This was to save changing all references to GetReferenceTable
//                                              to include two parameters
//
//      1.1.1       CA          30/01/2007      Code to include option "Any" in year
//                                              drop down list
//
//      1.1.2       CA          31/01/2007      Bug 22 give Programme Managers edit rights
//                                              for cases "In Review"
//
//      1.1.2       CA          15/02/2007      For cases "Budget Request" too!
//                                              
//      1.1.3       CA          05/02/2007      New Sponsor Data 
//                                              
//      1.1.4       GMcF        07/02/2007      Update Initiative Investment Tier 
//
//      1.9.1       GMcF        09/01/2008      Added code to Page_Load and ctlFooter_SaveClick
//                                              to handle initiative having PIR status
//
//      1.9.2       GMcF        28/01/2008      Amended SendNotificationEmail() and
//                                              SendNotificationEmailSponsorAllocation() to take email
//                                              template name as a parameter, set up no-param versions
//                                              to supply defaults.
//
//      1.9.4       GMcF        07/02/2008      Altered HasEditRights() to include "In PIR" status
//
//      1.9.5       GMcF        12/02/2008      Altered OnPreRender to added "In PIR" to list of statuses
//                                              that set validation level to "3", meaning "for submit".
//                                              Altered ctlWorkflowAction_NewStatusClick to handle PIRs.
//                                              Added IsValid check to ctlWorkflowAction_SubmitClick
//                                              and ctlWorkflowAction_NewStatusClick.
//*****************************************************************************************************

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Net;

using ProjectPortfolio.Classes;
using ProjectPortfolio.Controls;


public partial class _Default : System.Web.UI.Page
{
    protected int m_nInitiativeID;
    protected int m_nPreviousVersion_InitiativeID;
    protected int m_nActiveUserID; 

    public void CheckApplicationTable()
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetApplicationRecords = new SqlCommand();
        cmdGetApplicationRecords.Connection = dbConnection;

        cmdGetApplicationRecords.CommandType = CommandType.Text;
        cmdGetApplicationRecords.CommandText = "select * from Application where InvestmentStrategy = 'APP_ID'";
                                           

        //cmdGetSponsorValues.Parameters.Add("@InitiativeID", intInitiativeID);

        SqlDataAdapter daApplicationRecords = new SqlDataAdapter(cmdGetApplicationRecords);

        DataSet dsApplicationRecords = new DataSet();

        //daSponsorValues.FillSchema(dsSponsorValues, SchemaType.Source, "SponsorValue");
        daApplicationRecords.Fill(dsApplicationRecords, "Application");

        if (dsApplicationRecords.Tables["Application"] != null && dsApplicationRecords.Tables["Application"].Rows.Count > 0)
        {
            string sInvestmentStrategy;

            foreach (DataRow drApplicationRecords in dsApplicationRecords.Tables["Application"].Rows)
            {


                SqlConnection dbConnection2 = new SqlConnection(Global_DB.GetConnectionString());

                SqlCommand cmdGetApplicationDetails = new SqlCommand();
                cmdGetApplicationDetails.Connection = dbConnection2;

                cmdGetApplicationDetails.CommandType = CommandType.Text;
                //cmdGetApplicationDetails.CommandText = "select InvestmentStrategy as AppInvestmentStrategy from Application where ExternalApplicationID like '" + drApplicationRecords["ExternalApplicationID"].ToString().Trim() + "*' ";
                cmdGetApplicationDetails.CommandText = "select top 1 InvestmentStrategy from Application where ExternalApplicationID like '" + drApplicationRecords["ExternalApplicationID"].ToString().Trim() + "-" + "%' group by InvestmentStrategy order by count(*) desc ";

                //cmdGetSponsorValues.Parameters.Add("@InitiativeID", intInitiativeID);

                SqlDataAdapter daApplicationDetails = new SqlDataAdapter(cmdGetApplicationDetails);

                DataSet dsApplicationDetails = new DataSet();

                //daSponsorValues.FillSchema(dsSponsorValues, SchemaType.Source, "SponsorValue");
                daApplicationDetails.Fill(dsApplicationDetails, "Application");

                sInvestmentStrategy = dsApplicationDetails.Tables["Application"].Rows[0].ItemArray[0].ToString();

                SqlConnection dbConnection3 = new SqlConnection(Global_DB.GetConnectionString());

                SqlCommand cmdUpdateApplication = new SqlCommand();
                cmdUpdateApplication.Connection = dbConnection3;

                cmdUpdateApplication.CommandType = CommandType.Text;
                cmdUpdateApplication.CommandText = "update Application set InvestmentStrategy = @sInvestmentStrategy where ApplicationID = " + drApplicationRecords["ApplicationID"] + " ";

                cmdUpdateApplication.Parameters.Add("@sInvestmentStrategy", sInvestmentStrategy);

                int intApplicationsAffected = 0;
                try
                {
                    dbConnection3.Open();
                    intApplicationsAffected = cmdUpdateApplication.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    intApplicationsAffected = -1;
                }

                dbConnection2.Close();
                dbConnection3.Close();
            }
           
        }

        dbConnection.Close();
        
    }


    protected void RegisterScrollScript()
    {
        ClientScriptManager cs = Page.ClientScript;
        Type cstype = this.GetType();

        if (!cs.IsOnSubmitStatementRegistered(cstype, "SaveScrollPosition"))
        {
            String cstext = "document.getElementById('" + hiddenScrollY.ClientID + "').value = contentLayer.scrollTop;";
            cs.RegisterOnSubmitStatement(cstype, "SaveScrollPosition", cstext);
        }

        if (!cs.IsStartupScriptRegistered(cstype, "RestoreScrollPosition"))
        {
            String cstext = "<script language=\"javascript\">" +
                                "function restoreScroll() {" +
                                    "var scrollTop = parseInt(document.getElementById('" + hiddenScrollY.ClientID + "').value);" +
                                    "if (!isNaN(scrollTop))" +
                                    "contentLayer.scrollTop = scrollTop;" +
                                "}" +
                            "</script>";
            cs.RegisterStartupScript(cstype, "RestoreScrollPosition", cstext);
        }
    }

    protected void RegisterBodyBeforeUnloadHandlerScript()
    {
        ClientScriptManager cs = Page.ClientScript;
        Type cstype = this.GetType();

        if (!cs.IsStartupScriptRegistered(cstype, "add_body_onbeforeunload_handler"))
        {
            String cstext = "<script language=\"javascript\">" +
                            "Events_chainEvent(" +
                                "document.body, " +
                                "\"onbeforeunload\", \"ConfirmUnload();\");" +
                            "</script>";
            cs.RegisterStartupScript(cstype, "add_body_onbeforeunload_handler", cstext);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Boolean bDoSharedDefault = false; /* Rev 1.9.6, 2008-02-15, GMcF, for PIR */

        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!CheckRegister()) return;

        RegisterScrollScript();

        try
        {
            m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch
        {
            m_nInitiativeID = -1;
        }

        CheckApplicationTable();

        m_nPreviousVersion_InitiativeID = Global_DB.GetPreviousVersionInitiativeID(m_nInitiativeID);
        m_nActiveUserID = Security_DB.GetActiveUserID(m_nInitiativeID);

        if (Request.QueryString["section"] != String.Empty && Request.QueryString["section"] != null)
        {
            if (m_nInitiativeID <= 0)
            {
                Response.Redirect("~/default.aspx");
            }
            else
            {
                if (m_nInitiativeID > 0 && m_nActiveUserID < 0)
                {
                    if (Session["ContactID"] != null && Session["ContactID"].ToString() != String.Empty)
                    {
                        string strPermissionName = Security_DB.GetInitiativeAccessRights((int)Session["ContactID"], m_nInitiativeID);
                        string strApprovalStatus = Global_DB.GetInitiativeStatus(m_nInitiativeID);

                        if (HasEditRights(strPermissionName, strApprovalStatus))
                        {
                            Session["ActiveInitiativeID"] = m_nInitiativeID;
                            Security_DB.SetActiveUserID(m_nInitiativeID, (int)Session["ContactID"]);
                        }
                    }
                }
            }

            if (Request.QueryString["section"] != "6") //not used for audit since there is nothting to save
                RegisterBodyBeforeUnloadHandlerScript();
        }

        // Rev 1.9.1, GMcF, 2008-01-09
        int nInitiativeStatusID = Global_DB.GetInitiativeStatusID(m_nInitiativeID);
    	
	    if ( Global_DB.IsPIR(nInitiativeStatusID) )
        {
            switch (Request.QueryString["section"])
            {
			    case "1":	// summary
                    Control ctlPIRSummary = Page.LoadControl("Controls/PIR_Summary.ascx");
                    ctlPIRSummary.ID = "ctlPIR_Summary";
                    ctlPlaceHolder.Controls.Add(ctlPIRSummary);
                    break;

			    case "2":	// financial ( ? review ? )
                    Control ctlFinancial = Page.LoadControl("Controls/Review_Financial.ascx");
                    ctlFinancial.ID = "ctlReview_Financial";
                    ctlPlaceHolder.Controls.Add(ctlFinancial);
                    break;

                case "5":	// workflow
                    Control ctlWorkflowAction = Page.LoadControl("Controls/PIR_WorkflowAction.ascx");
                    ctlWorkflowAction.ID = "ctlPIR_WorkflowAction";
                    ctlPlaceHolder.Controls.Add(ctlWorkflowAction);
                    section_status ctlSectionStatus = (section_status)ctlWorkflowAction.FindControl("ctlSectionStatus");
                    ctlSectionStatus.SubmitClick += new section_status.SubmitClickEventHandler(ctlWorkflowAction_SubmitClick);
                    ctlSectionStatus.NewStatusClick += new section_status.NewStatusClickEventHandler(ctlWorkflowAction_NewStatusClick);
                    break;

                case "6":	// audit
                    Control ctlIGAudit = Page.LoadControl("Controls/IGAudit.ascx");
                    ctlIGAudit.ID = "ctlReview_IGAudit";
                    ctlPlaceHolder.Controls.Add(ctlIGAudit);
                    break;

                case "99":  // tester
                    Control ctlPIR_Deliverables = Page.LoadControl("Controls/PIR_Deliverables.ascx");
                    ctlPIR_Deliverables.ID = "ctlPIR_Deliverables";
                    ctlPlaceHolder.Controls.Add(ctlPIR_Deliverables);
                    break;

                default:	// other eg initiative history, homepage, session[ "cmd" ] set
                    bDoSharedDefault = true; /* Rev 1.9.6, 2008-02-15, GMcF, for PIR */
                    break;
            }
        }
        else
        {
        // End of Rev 1.9.1
            switch (Request.QueryString["section"])
            {
                case "1":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlSummary = Page.LoadControl("Controls/Review_Summary.ascx");
                        ctlSummary.ID = "ctlReview_Summary";
                        ctlPlaceHolder.Controls.Add(ctlSummary);
                    }
                    else
                    {
                        //if (m_nInitiativeID == 0)
                        //{
                        //    Control ctlSummary_NewInitiative = Page.LoadControl("Controls/Summary_NewInitiative.ascx");
                        //    ctlSummary_NewInitiative.ID = "ctlSummary_NewInitiative";
                        //    ctlPlaceHolder.Controls.Add(ctlSummary_NewInitiative);
                        //    ctlValidationSummary.Enabled = false;
                        //}
                        //else
                        //{
                        //    Control ctlSummary = Page.LoadControl("Controls/Summary.ascx");
                        //    ctlSummary.ID = "ctlSummary";
                        //    ctlPlaceHolder.Controls.Add(ctlSummary);
                        //}

                        Control ctlSummary = Page.LoadControl("Controls/Summary.ascx");
                        ctlSummary.ID = "ctlSummary";
                        ctlPlaceHolder.Controls.Add(ctlSummary);

                    }
                    break;

                case "2":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlFinancial = Page.LoadControl("Controls/Review_Financial.ascx");
                        ctlFinancial.ID = "ctlReview_Financial";
                        ctlPlaceHolder.Controls.Add(ctlFinancial);
                    }
                    else
                    {
                        Control ctlFinancial = Page.LoadControl("Controls/Financial.ascx");
                        ctlFinancial.ID = "ctlFinancial";
                        ctlPlaceHolder.Controls.Add(ctlFinancial);
                    }
                    break;

                case "3":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlArchitectureAndRisk = Page.LoadControl("Controls/Review_ArchitectureAndRisk.ascx");
                        ctlArchitectureAndRisk.ID = "ctlReview_ArchitectureAndRisk";
                        ctlPlaceHolder.Controls.Add(ctlArchitectureAndRisk);
                    }
                    else
                    {
                        Control ctlArchitectureAndRisk = Page.LoadControl("Controls/ArchitectureAndRisk.ascx");
                        ctlArchitectureAndRisk.ID = "ctlArchitectureAndRisk";
                        ctlPlaceHolder.Controls.Add(ctlArchitectureAndRisk);
                    }
                    break;

                case "4":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlProjects = Page.LoadControl("Controls/Review_Projects.ascx");
                        ctlProjects.ID = "ctlReview_Projects";
                        ctlPlaceHolder.Controls.Add(ctlProjects);
                    }
                    else
                    {
                        Control ctlProjects = Page.LoadControl("Controls/Projects.ascx");
                        ctlProjects.ID = "ctlProjects";
                        ctlPlaceHolder.Controls.Add(ctlProjects);
                    }
                    break;

                case "5":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlWorkflowAction = Page.LoadControl("Controls/Review_WorkflowAction.ascx");
                        ctlWorkflowAction.ID = "ctlReview_WorkflowAction";
                        ctlPlaceHolder.Controls.Add(ctlWorkflowAction);
                        section_status ctlSectionStatus = (section_status)ctlWorkflowAction.FindControl("ctlSectionStatus");
                        ctlSectionStatus.SubmitClick += new section_status.SubmitClickEventHandler(ctlWorkflowAction_SubmitClick);
                        ctlSectionStatus.NewStatusClick += new section_status.NewStatusClickEventHandler(ctlWorkflowAction_NewStatusClick);
                    }
                    else
                    {
                        Control ctlWorkflowAction = Page.LoadControl("Controls/WorkflowAction.ascx");
                        ctlWorkflowAction.ID = "ctlWorkflowAction";
                        ctlPlaceHolder.Controls.Add(ctlWorkflowAction);
                        section_status ctlSectionStatus = (section_status)ctlWorkflowAction.FindControl("ctlSectionStatus");
                        ctlSectionStatus.SubmitClick += new section_status.SubmitClickEventHandler(ctlWorkflowAction_SubmitClick);
                        ctlSectionStatus.NewStatusClick += new section_status.NewStatusClickEventHandler(ctlWorkflowAction_NewStatusClick);
                    }
                    break;

                case "6":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlIGAudit = Page.LoadControl("Controls/IGAudit.ascx");
                        ctlIGAudit.ID = "ctlReview_IGAudit";
                        ctlPlaceHolder.Controls.Add(ctlIGAudit);
                    }
                    else
                    {
                        Control ctlIGAudit = Page.LoadControl("Controls/IGAudit.ascx");
                        ctlIGAudit.ID = "ctlIGAudit";
                        ctlPlaceHolder.Controls.Add(ctlIGAudit);
                    }
                    break;

                default:
                    bDoSharedDefault = true; /* Rev 1.9.6, 2008-02-15, GMcF, for PIR. Code was moved below for use by both PIR and non-PIR. */
                    break;

            }
        }

        /* Rev 1.9.6, 2008-02-15, GMcF, for PIR. Code was moved here from non-PIR default case above to be available to PIRs also */
        if (bDoSharedDefault)
        {
            if (m_nInitiativeID > 0)
            {
                Control ctlProjectHistory = Page.LoadControl("Controls/ProjectHistory.ascx");
                ctlProjectHistory.ID = "ctlProjectHistory";
                ctlPlaceHolder.Controls.Add(ctlProjectHistory);
            }
            else
            {

                Control ctlMyProjects = Page.LoadControl( "Controls/Homepage.ascx" );
                ctlMyProjects.ID = "ctlMyProjects";
                ctlPlaceHolder.Controls.Add(ctlMyProjects);


                //int intContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;
                //string strRole = Security_DB.GetUserRole(intContactID);

                //if (strRole.ToLower() == "ig coordinator")
                //{
                //    Control ctlMyProjects = Page.LoadControl("Controls/Coordinator.ascx");
                //    ctlMyProjects.ID = "ctlMyProjects";
                //    ctlPlaceHolder.Controls.Add(ctlMyProjects);
                //}
                //else
                //{
                //    Control ctlMyProjects = Page.LoadControl("Controls/ProgrammeManager.ascx");
                //    ctlMyProjects.ID = "ctlMyProjects";
                //    ctlPlaceHolder.Controls.Add(ctlMyProjects);
                //}
            }

            if (Session["cmd"] != null && Session["cmd"].ToString() == "showNoAccess")
            {
                Session["cmd"] = null;

                //Display error message in case the user hasn't got the rights to view the initiative details
                Page.RegisterStartupScript("errorLocked",
                                        "<script language=\"javascript\"> " +
                                               "alert(\"You are not authorized to access initiative details!\");" +
                                        "</script>");

            }

            if (Session["cmd"] != null && Session["cmd"].ToString() == "showRecordLocked")
            {
                //Also work out the name of the user who has locked the form and display their name
                Page.RegisterStartupScript("errorLocked",
                                        "<script language=\"javascript\"> " +
                                               "alert(\"You cannot edit this initiative as it is currently locked by " + Global_DB.GetContactName(m_nActiveUserID) + "\");" +
                                        "</script>");
            }

        }
        /* End of Rev 1.9.6 */

        ctlFooter.SaveClick += new Footer.SaveClickEventHandler(ctlFooter_SaveClick);

    }

    void ctlFooter_SaveClick(object sender, EventArgs e)
    {
        if (m_nInitiativeID == 0)
        {
            //int intInitiativeID;

            //if (Page.IsValid)
            //{
            //    Control ctlSummary_NewInitiative = Page.FindControl("ctlSummary_NewInitiative");
            //    intInitiativeID = ((Controls_Summary_NewInitiative)ctlSummary_NewInitiative).InsertInitiative();

            //    Response.Redirect("~/default.aspx?section=1&InitiativeID=" + intInitiativeID.ToString());
            //}
            //else
            //{
            //    Page.RegisterStartupScript("errorIGIdentifier",
            //             "<script language=\"javascript\"> " +
            //                    "alert('The IG Identifier is not valid. Please input an unique IG Identifier!');" +
            //             "</script>");
            //}

            // You cannot add new initiatives using InitiativeID=0 in address bar.
            // New initiatives can be added from Admin section.
            Page.RegisterStartupScript("errorIGIdentifier",
             "<script language=\"javascript\"> " +
                    "alert('Invalid InitiativeID. InitiativeID should be greater than 0.');" +
             "</script>");
        }
        else
        {
            int nInitiativeStatusID = Global_DB.GetInitiativeStatusID(m_nInitiativeID);

            // Rev 1.9.1, GMcF, 2008-01-09
            if ( Global_DB.IsPIR(nInitiativeStatusID) )
            {
                bool blnUpdate = false;

                switch (Request.QueryString["section"])
                {
                    case "1":	// summary
                        Control ctlPIR_Summary = Page.FindControl("ctlPIR_Summary");
                        ((ProjectPortfolio.Controls.PIR_Summary)ctlPIR_Summary).UpdateInitiative();
                        blnUpdate = true;
                        break;

                    case "2":	// financial
                        if (m_nPreviousVersion_InitiativeID > 0)
                        {
                            Control ctlReview_Financial = Page.FindControl("ctlReview_Financial");
                            ((Review_Financial)ctlReview_Financial).UpdateInitiative();
                        }
                        else
                        {
                            Control ctlFinancial = Page.FindControl("ctlFinancial");
                            ((Controls_Financial)ctlFinancial).UpdateInitiative();
                        }
                        blnUpdate = true;
                        break;

                    case "5":	// workflow
                        Control ctlPIR_WorkflowAction = Page.FindControl("ctlPIR_WorkflowAction");
                        ((ProjectPortfolio.Controls.PIR_WorkflowAction)ctlPIR_WorkflowAction).UpdateInitiative();
                        blnUpdate = true;
                        break;

                    case "6":	// audit
                        break;

                }

                if (blnUpdate)
                {
                    Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                    Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                }

            }
            else
            {
            // End of Rev 1.9.1
                switch (Request.QueryString["section"])
                {
                    case "1":
                        if (m_nPreviousVersion_InitiativeID > 0)
                        {
                            Control ctlReview_Summary = Page.FindControl("ctlReview_Summary");
                            ((Controls_Review_Summary)ctlReview_Summary).UpdateInitiative();
                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            if (m_nInitiativeID != 0)
                            {
                                Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            }
                            //end rev
                        }
                        else
                        {
                            Control ctlSummary = Page.FindControl("ctlSummary");
                            ((Controls_Summary)ctlSummary).UpdateInitiative();
                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            if (m_nInitiativeID != 0)
                            {
                                Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            }
                            //end rev
                        }
                        break;

                    case "2":
                        if (m_nPreviousVersion_InitiativeID > 0)
                        {
                            Control ctlReview_Financial = Page.FindControl("ctlReview_Financial");
                            ((Review_Financial)ctlReview_Financial).UpdateInitiative();

                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            //end rev
                        }
                        else
                        {
                            Control ctlFinancial = Page.FindControl("ctlFinancial");
                            ((Controls_Financial)ctlFinancial).UpdateInitiative();

                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            //end rev
                        }
                        break;

                    case "3":
                        if (m_nPreviousVersion_InitiativeID > 0)
                        {
                            Control ctlReview_ArchitectureAndRisk = Page.FindControl("ctlReview_ArchitectureAndRisk");
                            ((Review_ArchitectureAndRisk)ctlReview_ArchitectureAndRisk).UpdateInitiative();
                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            //end rev
                        }
                        else
                        {
                            Control ctlArchitectureAndRisk = Page.FindControl("ctlArchitectureAndRisk");
                            ((Controls_ArchitectureAndRisk)ctlArchitectureAndRisk).UpdateInitiative();
                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            //end rev
                        }

                        break;

                    case "4":
                        if (m_nPreviousVersion_InitiativeID > 0)
                        {
                            Control ctlReview_Projects = Page.FindControl("ctlReview_Projects");
                            ((Review_Projects)ctlReview_Projects).UpdateInitiative();
                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            //end rev
                        }
                        else
                        {
                            Control ctlProjects = Page.FindControl("ctlProjects");
                            ((Controls_Projects)ctlProjects).UpdateInitiative();
                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            //end rev
                        }

                        break;

                    case "5":
                        if (m_nPreviousVersion_InitiativeID > 0)
                        {
                            Control ctlReview_WorkflowAction = Page.FindControl("ctlReview_WorkflowAction");
                            ((Review_WorkflowAction)ctlReview_WorkflowAction).UpdateInitiative();

                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            //end rev
                        }
                        else
                        {
                            Control ctlWorkflowAction = Page.FindControl("ctlWorkflowAction");
                            ((Controls_WorkflowAction)ctlWorkflowAction).UpdateInitiative();

                            //rev 1.1.12
                            Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            Response.Redirect("~/default.aspx?section=" + Request.QueryString["section"] + "&InitiativeID=" + m_nInitiativeID.ToString());
                            //end rev
                        }

                        break;
                }
            // Rev 1.9.1, GMcF, 1.9.1
            }
            // End of Rev 1.9.1
        }
    }

/*
    // Commented out 2008-01-25, GMcF, for PIR
 
    void ctlWorkflowAction_SubmitClick(object sender, EventArgs e)
    {
        if (m_nInitiativeID > 0)
        {
            switch (Request.QueryString["section"])
            {
                case "1":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlReview_Summary = Page.FindControl("ctlReview_Summary");
                        ((Controls_Review_Summary)ctlReview_Summary).UpdateInitiative();
                    }
                    else
                    {
                        Control ctlSummary = Page.FindControl("ctlSummary");
                        ((Controls_Summary)ctlSummary).UpdateInitiative();
                    }
                    break;

                case "2":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlReview_Financial = Page.FindControl("ctlReview_Financial");
                        ((Review_Financial)ctlReview_Financial).UpdateInitiative();
                    }
                    else
                    {
                        Control ctlFinancial = Page.FindControl("ctlFinancial");
                        ((Controls_Financial)ctlFinancial).UpdateInitiative();
                    }
                    break;

                case "3":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlReview_ArchitectureAndRisk = Page.FindControl("ctlReview_ArchitectureAndRisk");
                        ((Review_ArchitectureAndRisk)ctlReview_ArchitectureAndRisk).UpdateInitiative();
                    }
                    else
                    {
                        Control ctlArchitectureAndRisk = Page.FindControl("ctlArchitectureAndRisk");
                        ((Controls_ArchitectureAndRisk)ctlArchitectureAndRisk).UpdateInitiative();
                    }

                    break;

                case "4":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlReview_Projects = Page.FindControl("ctlReview_Projects");
                        ((Review_Projects)ctlReview_Projects).UpdateInitiative();
                    }
                    else
                    {
                        Control ctlProjects = Page.FindControl("ctlProjects");
                        ((Controls_Projects)ctlProjects).UpdateInitiative();
                    }

                    break;

                case "5":
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlReview_WorkflowAction = Page.FindControl("ctlReview_WorkflowAction");
                        ((Review_WorkflowAction)ctlReview_WorkflowAction).UpdateInitiative();
                        Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                    }
                    else
                    {
                        Control ctlWorkflowAction = Page.FindControl("ctlWorkflowAction");
                        ((Controls_WorkflowAction)ctlWorkflowAction).UpdateInitiative();
                        Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                    }

                    break;
            }

            Header_DB.UpdateInitiativeStatus(m_nInitiativeID, "IG Submitted", 2);
            SendNotificationEmail();

            SendNotificationEmailSponsorAllocation();

            Security_DB.ClearActiveUserID(m_nInitiativeID);
            Session["ActiveInitiativeID"] = null;

            Response.Redirect("~/default.aspx");
        }
    }
*/

    // Added 2008-01-25, GMcF, for PIR - simplified version of handler
    void ctlWorkflowAction_SubmitClick(object sender, EventArgs e)
    {
        if (m_nInitiativeID > 0)
        {
            if (IsValid) // Rev 1.9.5, 2008-02-12, GMcF, for PIR
            {
                int nInitiativeStatusID = Global_DB.GetInitiativeStatusID(m_nInitiativeID);

                if (Global_DB.IsPIR(nInitiativeStatusID))
                {
                    Control ctlPIR_WorkflowAction = Page.FindControl("ctlPIR_WorkflowAction");
                    ((ProjectPortfolio.Controls.PIR_WorkflowAction)ctlPIR_WorkflowAction).UpdateInitiative();
                    Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);

                    Header_DB.UpdateInitiativeStatus(m_nInitiativeID, "PIR Submitted", 23);
                    SendNotificationEmail("PIR Notification");

                    SendNotificationEmailSponsorAllocation("Sponsor PIR Notification");
                }

                else
                {
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        Control ctlReview_WorkflowAction = Page.FindControl("ctlReview_WorkflowAction");
                        ((Review_WorkflowAction)ctlReview_WorkflowAction).UpdateInitiative();
                        Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                    }
                    else
                    {
                        Control ctlWorkflowAction = Page.FindControl("ctlWorkflowAction");
                        ((Controls_WorkflowAction)ctlWorkflowAction).UpdateInitiative();
                        Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                    }
                    Header_DB.UpdateInitiativeStatus(m_nInitiativeID, "IG Submitted", 2);
                    SendNotificationEmail();

                    SendNotificationEmailSponsorAllocation();
                }

                Security_DB.ClearActiveUserID(m_nInitiativeID);
                Session["ActiveInitiativeID"] = null;

                Response.Redirect("~/default.aspx");
            }
        }
    }

    protected void ctlWorkflowAction_NewStatusClick(object sender, EventArgs e)
    {
        if (m_nInitiativeID > 0)
        {
            if (IsValid) // Rev 1.9.5, 2008-02-12, GMcF, for PIR
            {
                // Rev 1.9.5, 2008-02-12, GMcF, for PIR
                if (Global_DB.IsPIR(Global_DB.GetInitiativeStatusID(m_nInitiativeID)))
                {
                    Control ctlPIR_WorkflowAction = Page.FindControl("ctlPIR_WorkflowAction");
                    ((PIR_WorkflowAction)ctlPIR_WorkflowAction).UpdateInitiative();
                    Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                }
                else
                {
                    // End of Rev 1.9.5

                    switch (Request.QueryString["section"])
                    {
                        case "1":
                            if (m_nPreviousVersion_InitiativeID > 0)
                            {
                                Control ctlReview_Summary = Page.FindControl("ctlReview_Summary");
                                ((Controls_Review_Summary)ctlReview_Summary).UpdateInitiative();
                            }
                            else
                            {
                                Control ctlSummary = Page.FindControl("ctlSummary");
                                ((Controls_Summary)ctlSummary).UpdateInitiative();
                            }
                            break;

                        case "2":
                            if (m_nPreviousVersion_InitiativeID > 0)
                            {
                                Control ctlReview_Financial = Page.FindControl("ctlReview_Financial");
                                ((Review_Financial)ctlReview_Financial).UpdateInitiative();
                            }
                            else
                            {
                                Control ctlFinancial = Page.FindControl("ctlFinancial");
                                ((Controls_Financial)ctlFinancial).UpdateInitiative();
                            }
                            break;

                        case "3":
                            if (m_nPreviousVersion_InitiativeID > 0)
                            {
                                Control ctlReview_ArchitectureAndRisk = Page.FindControl("ctlReview_ArchitectureAndRisk");
                                ((Review_ArchitectureAndRisk)ctlReview_ArchitectureAndRisk).UpdateInitiative();
                            }
                            else
                            {
                                Control ctlArchitectureAndRisk = Page.FindControl("ctlArchitectureAndRisk");
                                ((Controls_ArchitectureAndRisk)ctlArchitectureAndRisk).UpdateInitiative();
                            }

                            break;

                        case "4":
                            if (m_nPreviousVersion_InitiativeID > 0)
                            {
                                Control ctlReview_Projects = Page.FindControl("ctlReview_Projects");
                                ((Review_Projects)ctlReview_Projects).UpdateInitiative();
                            }
                            else
                            {
                                Control ctlProjects = Page.FindControl("ctlProjects");
                                ((Controls_Projects)ctlProjects).UpdateInitiative();
                            }

                            break;

                        case "5":
                            if (m_nPreviousVersion_InitiativeID > 0)
                            {
                                Control ctlReview_WorkflowAction = Page.FindControl("ctlReview_WorkflowAction");
                                ((Review_WorkflowAction)ctlReview_WorkflowAction).UpdateInitiative();
                                Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            }
                            else
                            {
                                Control ctlWorkflowAction = Page.FindControl("ctlWorkflowAction");
                                ((Controls_WorkflowAction)ctlWorkflowAction).UpdateInitiative();
                                Global_DB.UpdateInitiativeInvestmentTier(m_nInitiativeID);
                            }

                            break;
                    }

                    //SendNotificationEmail();


                    // Rev 1.9.5, 2008-02-12, GMcF, for PIR
                }
                // End of Rev 1.9.5


                Security_DB.ClearActiveUserID(m_nInitiativeID);
                Session["ActiveInitiativeID"] = null;

                Response.Redirect("~/default.aspx");
            }
        }
    }

    protected void SendNotificationEmail(string EmailTemplateName) // Rev 1.9.3, 2008-01-28, GMcF, added param for email template name
    {
        string from = ConfigurationSettings.AppSettings["ApplicationEmailAddress"];

        DataRow drInitiative = Header_DB.GetInitiativeDetails(m_nInitiativeID);

        if (drInitiative != null)
        {
            DataSet dsContacts = Notification_DB.GetNotificationList((int)drInitiative["IGApprovalCommitteeID"]);

            MailMessage message = new MailMessage();
            message.From = new MailAddress(from);

            foreach(DataRow drContact in dsContacts.Tables["Contacts"].Rows)
            {
                message.To.Add(new MailAddress(drContact["EmailAddress"].ToString()));
            }

            // Rev 1.9.3, 2008-01-28, GMcF
            //DataRow drNotification = Notification_DB.GetEmailTemplate("Submission Notification");
            DataRow drNotification = Notification_DB.GetEmailTemplate(EmailTemplateName);
            // End of Rev 1.9.3

            string strSubject, strBody, strSubmittedBy;

            strSubject = String.Empty;
            strBody = String.Empty;
            strSubmittedBy = String.Empty;

            if (drNotification != null)
            {
                strSubject = drNotification["Subject"].ToString();
                strBody = drNotification["Body"].ToString();
            
                message.IsBodyHtml = (bool)drNotification["IsHTML"];

                if (drInitiative["ActiveUserID"] != DBNull.Value && drInitiative["ActiveUserID"] != null)
                {
                    strSubmittedBy = Global_DB.GetContactName((int)drInitiative["ActiveUserID"]);
                }

                strSubject = strSubject.Replace("<<INITIATIVE ID>>", drInitiative["InitiativeID"].ToString());
                strSubject = strSubject.Replace("<<INITIATIVE NAME>>", drInitiative["Name"].ToString());
                strSubject = strSubject.Replace("<<INITIATIVE CODE>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                            drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'));
                strSubject = strSubject.Replace("<<SUBMITTED BY NAME>>", strSubmittedBy);

                strBody = strBody.Replace("<<INITIATIVE ID>>", drInitiative["InitiativeID"].ToString());
                strBody = strBody.Replace("<<INITIATIVE NAME>>", drInitiative["Name"].ToString());
                strBody = strBody.Replace("<<INITIATIVE CODE>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                            drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'));
                strBody = strBody.Replace("<<SUBMITTED BY NAME>>", strSubmittedBy);
            }

            message.Subject = strSubject;
            message.Body = strBody;

            SmtpClient client = new SmtpClient();
            //SmtpClient client = new SmtpClient("10.1.5.102");

            try
            {
                client.Send(message);
            }
            catch (Exception ex)

            {

            }
        }
    }

    // Rev 1.9.3, 2008-01-28, GMcF, 
    protected void SendNotificationEmail()
    {
        SendNotificationEmail("Submission Notification");
    }

    //rev 1.1.3
    protected void SendNotificationEmailSponsorAllocation(string EmailTemplateName)
    // Rev 1.9.3, 2008-01-28, GMcF, added parameter EmailTemplateName
    {
        string from = ConfigurationSettings.AppSettings["ApplicationEmailAddress"];

        DataRow drInitiative = Header_DB.GetInitiativeDetails(m_nInitiativeID);

        DataSet dsSponsorValues = GetEmailSponsorValues(m_nInitiativeID);

        //dsSponsorValues.Tables.

        //string test;

        foreach (DataRow drSponsorValues in dsSponsorValues.Tables["SponsorValue"].Rows)
        
        {
        //test = (drSponsorValues["SponsorID"].ToString());

            
            //if (drInitiative != null && (int)drInitiative[72] != (int)drSponsorValues["SponsorID"])
            if (drInitiative != null && drInitiative[71].ToString() != drSponsorValues["Name"].ToString())
        {
            DataSet dsContacts = Notification_DB.GetSponsorNotificationList((int)drSponsorValues["SponsorID"]);

            MailMessage message = new MailMessage();
            message.From = new MailAddress(from);

            foreach (DataRow drContact in dsContacts.Tables["Contacts"].Rows)
            {
                message.To.Add(new MailAddress(drContact["SponsorContactEmail"].ToString()));
            }

            // Rev 1.9.3, 2008-01-28, GMcF
            //DataRow drNotification = Notification_DB.GetEmailTemplate("Sponsor Notification");
            DataRow drNotification = Notification_DB.GetEmailTemplate(EmailTemplateName);
            // End of Rev 1.9.3

            string strSubject, strBody, strSubmittedBy;

            strSubject = String.Empty;
            strBody = String.Empty;
            strSubmittedBy = String.Empty;

            if (drNotification != null)
            {
                strSubject = drNotification["Subject"].ToString();
                strBody = drNotification["Body"].ToString();

                message.IsBodyHtml = (bool)drNotification["IsHTML"];

                if (drInitiative["ActiveUserID"] != DBNull.Value && drInitiative["ActiveUserID"] != null)
                {
                    strSubmittedBy = Global_DB.GetContactName((int)drInitiative["ActiveUserID"]);
                }

                strSubject = strSubject.Replace("<<INITIATIVE ID>>", drInitiative["InitiativeID"].ToString());
                strSubject = strSubject.Replace("<<INITIATIVE NAME>>", drInitiative["Name"].ToString());
                strSubject = strSubject.Replace("<<INITIATIVE CODE>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                            drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'));
                strSubject = strSubject.Replace("<<SUBMITTED BY NAME>>", strSubmittedBy);

                strSubject = strSubject.Replace("<<COMMITTEE NAME>>", drInitiative["IGApprovalCommittee"].ToString());
                strSubject = strSubject.Replace("<<%>>", drSponsorValues["Allocation"].ToString());
                strSubject = strSubject.Replace("<<SPONSOR>>", drSponsorValues["Name"].ToString());


                strBody = strBody.Replace("<<INITIATIVE ID>>", drInitiative["InitiativeID"].ToString());
                strBody = strBody.Replace("<<INITIATIVE NAME>>", drInitiative["Name"].ToString());
                strBody = strBody.Replace("<<INITIATIVE CODE>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                            drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'));
                strBody = strBody.Replace("<<SUBMITTED BY NAME>>", strSubmittedBy);

                decimal tempApplocation = (decimal)drSponsorValues["Allocation"];
                string stempApplocation = tempApplocation.ToString("N2");

                //decimal val = 28;
                //string formatted = val.ToString("N2");

                strBody = strBody.Replace("<<COMMITTEE NAME>>", drInitiative["IGApprovalCommittee"].ToString());
                strBody = strBody.Replace("<<%>>", stempApplocation);
                strBody = strBody.Replace("<<SPONSOR>>", drSponsorValues["Name"].ToString());
                
                //drSponsorValues["Allocation"]
            }

            message.Subject = strSubject;
            message.Body = strBody;

            SmtpClient client = new SmtpClient();
            //SmtpClient client = new SmtpClient("10.1.5.102");

            try
            {
                client.Send(message);
            }
            catch (Exception ex)
            {

            }
        }
    }
    }
    //end rev

    // Rev 1.9.2, 2008-01-28, GMcF, added to give default template name for SendNotificationEmailSponsorAllocation()
    protected void SendNotificationEmailSponsorAllocation()
    {
        SendNotificationEmailSponsorAllocation("Sponsor Notification");
    }

    //rev 1.1.3
    public static DataSet GetEmailSponsorValues(int intInitiativeID)
    {
        SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

        SqlCommand cmdGetSponsorValues = new SqlCommand();
        cmdGetSponsorValues.Connection = dbConnection;

        cmdGetSponsorValues.CommandType = CommandType.Text;
        cmdGetSponsorValues.CommandText = "SELECT * FROM InitiativeSponsor " +
                                            "JOIN Sponsor ON InitiativeSponsor.SponsorID = Sponsor.SponsorID " +
                                          " WHERE InitiativeSponsor.InitiativeID=@InitiativeID and InitiativeSponsor.Allocation > 0";

        cmdGetSponsorValues.Parameters.Add("@InitiativeID", intInitiativeID);

        SqlDataAdapter daSponsorValues = new SqlDataAdapter(cmdGetSponsorValues);

        DataSet dsSponsorValues = new DataSet();

        daSponsorValues.FillSchema(dsSponsorValues, SchemaType.Source, "SponsorValue");
        daSponsorValues.Fill(dsSponsorValues, "SponsorValue");

        return dsSponsorValues;
    }
    //end rev

    protected bool CheckRegister()
    {
        if (Session["ContactID"] == null || Session["ContactID"].ToString() == string.Empty)
        {
            string strMsg;

            strMsg = "<html xmlns=\"http://www.w3.org/1999/xhtml\">";
            strMsg += "<head><title>Login Error</title>";
            strMsg += "<link href=\"style.css\" type=\"text/css\" rel=\"stylesheet\" /></head>";
            strMsg += "<body>";
            strMsg += "<font size=\"4\">You are not authorised to use the IPMS System.<br>";
            strMsg += "Please contact the system administrator to request access.<br>";
            strMsg += "You are currently trying to login as : " + Session["Username"].ToString() + ".";
            strMsg += "</font></body>";
            strMsg += "</html>";

            Response.Write(strMsg);
            Response.End();

            return false;
        }

        return true;
    }

    protected override void OnPreRender(EventArgs e)
    {
        if (Session["ContactID"] == null || Session["ContactID"].ToString() == string.Empty)
            return;
        
        if (m_nInitiativeID > 0 &&
            (Request.QueryString["section"] != null && Request.QueryString["section"] != String.Empty))
        {
            int intNextVersionInitiativeID = Global_DB.GetNextVersionInitiativeID(m_nInitiativeID);
            int intContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;

            string strPermissionName = Security_DB.GetInitiativeAccessRights(intContactID, m_nInitiativeID);
            string strApprovalStatus = Global_DB.GetInitiativeStatus(m_nInitiativeID);
            bool bApproved = Global_DB.GetInitiativeApprovedStatus(m_nInitiativeID);

            if (!HasViewRights(strPermissionName, strApprovalStatus))
            {
                Session["cmd"] = "showNoAccess";
                Response.Redirect("~/default.aspx");
                return;
            }

            if ((intNextVersionInitiativeID > 0) ||
                (m_nActiveUserID > 0 && m_nActiveUserID != (int)Session["ContactID"]) ||
                !HasEditRights(strPermissionName, strApprovalStatus) ||
                bApproved == true)
            {
                ctlFooter.HideSaveButtons();
                ProjectPortfolio.Global.DisableControl(ctlPlaceHolder);

            }

            if (HasEditRights(strPermissionName, strApprovalStatus) && Request.QueryString["section"] == "1")
            {
                if (intNextVersionInitiativeID > 0)
                {
                    Page.RegisterStartupScript("errorLocked",
                                            "<script language=\"javascript\"> " +
                                                   "alert(\"Warning: you may not edit previous versions of an initiative.\");" +
                                            "</script>");
                }
                else if (bApproved == true)
                {
                    Page.RegisterStartupScript("errorLocked",
                                            "<script language=\"javascript\"> " +
                                                   "alert(\"Warning: to make changes to this initiative please create a new Interim Review form.\");" +
                                            "</script>");
                }
                else if (m_nActiveUserID > 0 && m_nActiveUserID != (int)Session["ContactID"])
                {
                    //Also work out the name of the user who has locked the form and display their name
                    Page.RegisterStartupScript("errorLocked",
                                            "<script language=\"javascript\"> " +
                                                   "alert(\"You may not save any changes to this initiative as it is currently locked by " + Global_DB.GetContactName(m_nActiveUserID) + "\");" +
                                            "</script>");
                }
            }
        }

        if (m_nInitiativeID > 0 &&
            (Request.QueryString["section"] != null && Request.QueryString["section"] != String.Empty))
        {
            ProjectPortfolio.Global.AddChangeHandlers(ctlPlaceHolder);

            int nValidationLevel = 2;//default (when submit button is pressed)

            string strApprovalStatus = Global_DB.GetInitiativeStatus(m_nInitiativeID);
            if (strApprovalStatus.ToLower() != "ig draft"
                        && strApprovalStatus.ToLower() != "in review"
                        && strApprovalStatus.ToLower() != "budget request"
                        && strApprovalStatus.ToLower() != "in pir"          // Added 
                )
                nValidationLevel = 3;
                      
            DataTable dtValidation = Global_DB.GetValidationTable(nValidationLevel).Tables["Validation"];

            ProjectPortfolio.Global.ValidateControl(ctlPlaceHolder, m_nInitiativeID, dtValidation);
        }


        base.OnPreRender(e);
    }

    public static bool HasEditRights(string strPermissionName, string strApprovalStatus)
    {
        bool bHasEditRights;

        switch (strPermissionName.ToLower())
        {
            case "read-only":
                bHasEditRights = false;
                break;

            case "modify":
                //rem CA
                //bHasEditRights = (strApprovalStatus.ToLower() == "ig draft");
                //end rem

                //rev 1.1.2 CA
                bHasEditRights =    (strApprovalStatus.ToLower() == "ig draft"
                                    || strApprovalStatus.ToLower() == "in review"
                                    || strApprovalStatus.ToLower() == "budget request")
                                    || strApprovalStatus.ToLower() == "in pir"  // Rev 1.9.4, 2008-02-07, GMcF, for PIR
                                    ;
                //end rev
                break;

            case "admin":
            case "superuser":
                bHasEditRights = true;
                break;

            default:
                bHasEditRights = false;
                break;
        }

        return bHasEditRights;
    }

    protected bool HasViewRights(string strPermissionName, string strApprovalStatus)
    {
        bool bHasViewRights;

        switch (strPermissionName.ToLower())
        {
            case "read-only":
                bHasViewRights = true;
                break;

            case "modify":
                bHasViewRights = true;
                break;

            case "admin":
            case "superuser":
                bHasViewRights = true;
                break;

            default:
                bHasViewRights = false;
                break;
        }

        return bHasViewRights;
    }
}
