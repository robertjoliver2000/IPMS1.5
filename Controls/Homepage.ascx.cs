//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1         CA          25/01/2007      To add variable nInitiative 
//                                              To pass to InitiativeStatusGetReferenceTable
//                                              
//      1.1.1       CA          30/01/2007      Code to include option "Any" in year
//                                              drop down list
//
//      -----       GMcF        03/02/2008      For AP maint request 2008-01-02, made approval year default to current
//
//      1.9.1       GMcF        09/01/2009      For PIR, changed gvInitiatives_RowDataBound to include PIR cases
//
//      1.9.6       GMcF        15/02/2008      For PIR, replaced local switch statement working out what status icon to use
//
//      1.9.10      GMcF        06/03/2008      For PIR UAT Bug 8, disabled "New Review" button when initiative is any PIR
//
//      2.0         ERW         22 May 2008     Now incorporates what was Coordinator.ascx.cs and ProgrammeManager.ascx.cs
//
//*****************************************************************************************************


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
using System.Net.Mail;
using System.Collections.Generic;
using System.Net;

using ProjectPortfolio.Classes;


public partial class Controls_Coordinator : System.Web.UI.UserControl
{
    DataView m_dvInitiatives;
    private enum CtrlType
    { 
        Coordinator,
        ProgrammeManager
    }

    private CtrlType controlType;


    //rev 1.1 CA
    int nInitiativeID;
    //end rev

    protected void Page_Load(object sender, EventArgs e)
    {
        //rev 1.1 CA
        try
        {
            nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            nInitiativeID = -1;
        }
        //end rev

        try
        {
            int intContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;
            string strRole = Security_DB.GetUserRole(intContactID);

            if (strRole.ToLower() == "ig coordinator")
            {
                //Control ctlMyProjects = Page.LoadControl("Controls/Coordinator.ascx");
                //ctlMyProjects.ID = "ctlMyProjects";
                //ctlPlaceHolder.Controls.Add(ctlMyProjects);
                controlType = CtrlType.Coordinator;
            }
            else // if (strRole.ToLower() == "ig programme manager")
            {
                //Control ctlMyProjects = Page.LoadControl("Controls/ProgrammeManager.ascx");
                //ctlMyProjects.ID = "ctlMyProjects";
                //ctlPlaceHolder.Controls.Add(ctlMyProjects);

                controlType = CtrlType.ProgrammeManager;

                
            }
/*            else
            {
                // TO DO
                // Gordon - what would be a sensible course of action here?  
                //i.e. if it can't set something to either ig coordinator or ig programme manager
            }
  */
        }
        catch (Exception ex)
        { 
            // TO DO
            // Gordon - what would be a sensible course of action here?  i.e. if it can get a contactID from the session

            //do we need to catch this or provide an alternative course of action?  It won't get this far anyway will it, cos
            //    if No Session exists it will get -1
            //    GetUserRole will return IG Programme Manager if you pass in -1
            // so we don't need to worry about catching an exception
        }
        
        DataSet dsMyInitiatives = MyProjects_DB.GetMyInitiatives();

        m_dvInitiatives = new DataView(dsMyInitiatives.Tables["Initiative"]);

        lnkApprovalDateFrom.HRef = "javascript:popupWindowDatePicker('" + txtApprovalDateFrom.ClientID + "');";

        lnkApprovalDateTo.HRef = "javascript:popupWindowDatePicker('" + txtApprovalDateTo.ClientID + "');";

        lnkReviewDate.HRef = "javascript:popupWindowDatePicker('" + txtReviewDate.ClientID + "');";

        if (!Page.IsPostBack)
        {
            FillDropDowns();

            RestoreParams();

            //Session["Coordinator_InitiativeFilter"] = "SubmissionYear = " + DateTime.Now.Year.ToString();
            //Session["Coordinator_SortExpression"] = String.Empty;
            //Session["Coordinator_SortDirection"] = String.Empty;
        }

        //if ((Page.Request["review_request"] != null) && (Page.Request["review_request"] != string.Empty))
        if ((controlType == CtrlType.Coordinator) && (Page.Request["review_request"] != null) && (Page.Request["review_request"] != string.Empty))
        {
            m_dvInitiatives.RowFilter = "(IGBusinessAreaCode + '-' + IGIdentifierCode) = '" + Page.Request["review_request"].ToString() + "'";
            m_dvInitiatives.Sort = null;
        }
        else
        {
            if (Session["Coordinator_InitiativeFilter"] == null)
            {
                Session["Coordinator_InitiativeFilter"] = "SubmissionDate = " + DateTime.Now.Year.ToString();
            }

            if (Session["Coordinator_SortExpression"] == null)
            {
                Session["Coordinator_SortExpression"] = String.Empty;
                Session["Coordinator_SortDirection"] = String.Empty;
            }

            if (Session["Coordinator_SortDirection"] == null)
            {
                Session["Coordinator_SortDirection"] = String.Empty;
            }

            /* m_dvInitiatives.RowFilter = Session["Coordinator_InitiativeFilter"].ToString();*/
            /*m_dvInitiatives.Sort = Session["Coordinator_SortExpression"].ToString() != String.Empty ?
                        (Session["Coordinator_SortExpression"].ToString() + " " + Session["Coordinator_SortDirection"].ToString()) :
                        null;*/
        }
        gvInitiatives.DataSource = m_dvInitiatives;
        gvInitiatives.DataBind();
    }


    protected void gvInitiatives_RowCommand(object sender, GridViewCommandEventArgs e)
    {

	switch (e.CommandName)               
        {
            /*  
            case "CreateReview":
                {
                    int intInitiativeID = Int32.Parse(e.CommandArgument.ToString());

                    int intContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;
                    int intActiveUserID = Security_DB.GetActiveUserID(intInitiativeID);

                    string strPermissionName = Security_DB.GetInitiativeAccessRights(intContactID, intInitiativeID);

                    if (strPermissionName.ToLower() != "modify" && 
                        strPermissionName.ToLower() != "admin" && 
                        strPermissionName.ToLower() != "superuser")
                    {
                        Session["cmd"] = "showNoAccess";
                        Response.Redirect("~/default.aspx");
                        return;
                    }

                    else if (intActiveUserID > 0 && intActiveUserID != intContactID)
                    {
                        Session["cmd"] = "showRecordLocked";
                        Response.Redirect("~/default.aspx");
                        return;
                    }

                    int intNewVersion_InitiativeID = MyProjects_DB.InsertInitiative_CreateNewVersion(intInitiativeID, intContactID);

                    Response.Redirect("~/default.aspx?section=1&InitiativeID=" + intNewVersion_InitiativeID.ToString());
                }
                break;
             * */
            case "RequestNewReview":
                {
                    int intInitiativeID = Int32.Parse(e.CommandArgument.ToString());
                    SendNotificationEmail(intInitiativeID);
                    break;
                }

            case "RequestNewPIR":
                {
                    int intInitiativeID = Int32.Parse(e.CommandArgument.ToString());
                    SendPIRNotificationEmail(intInitiativeID);
                    break;
                }

        }
	
    }

    protected void gvInitiatives_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            foreach (Control headCell in e.Row.Controls)
            {
                foreach (Control child in headCell.Controls)
                {
                    LinkButton lnkSort = child as LinkButton;

                    if (lnkSort != null)
                    {
                        lnkSort.CssClass = "mp_headlink";
                    }
                }
            }
            Control PPRHeader = e.Row.Cells[6];
            PPRHeader.Controls.Add(new LiteralControl("Performance Status"));
            PPRHeader.Controls.Add(new LiteralControl("<br />"));
            // 2008-05-28, GMcF, for UAT feedback item 10 - PPR Comments, added column "Cm" for Has Comments icon
            PPRHeader.Controls.Add( new LiteralControl( "<table class='PPRHeaders'><tr><th title='O - Overall'>O</th><th title='C - Cost'>C</th><th title='D - Deliverables'>D</th><th title='T - Time'>T</th><th title='R/I - Risks / Issues'>R/I</th><th title='B - Benefits'>B</th><th style='width:5px;'></th><th title='Cm - Comments'>Cm</th></tr></table>" ) );
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image imgStatus = (Image)e.Row.FindControl("imgStatus");
            int intIGStatus = (DataBinder.Eval(e.Row.DataItem, "IGApprovalStatusID") != DBNull.Value) ?
                                    (int)DataBinder.Eval(e.Row.DataItem, "IGApprovalStatusID") : 1;

            //Project Portfolio status
            imgStatus.ImageUrl = ProjectPortfolio.Global.GetImageURLForStatus(intIGStatus); /* Rev 1.9.6, 2008-02-15, GMcF. Replaced local switch statement */

            #region Rev 1.9.6, 2008-02-15, GMcF. Replaced by call to GetImageURLforStatus()
            /*
            switch (intIGStatus)
            {
                case 1:
                case 19:
                case 20:
                case 22:    // Rev 1.9.1, 2008-01-09, GMcF, for status "In PIR"
                    imgStatus.ImageUrl = @"~\Images\draft.gif";
                    break;

                case 2:
                case 23:    // Rev 1.9.1, 2008-01-09, GMcF, for status "PIR Submitted"
                    imgStatus.ImageUrl = @"~\Images\submitted.gif";
                    break;

                case 3:
                    imgStatus.ImageUrl = @"~\Images\pending.gif";
                    break;

                case 4:
                case 5:
                case 6:
                case 7:
                case 10:
                case 11:
                case 12:
                case 13:
                case 14:
                case 24:    // Rev 1.9.1, 2008-01-09, GMcF, for status "PIR Complete"
                    imgStatus.ImageUrl = @"~\Images\approved.gif";
                    break;

                case 8:
                case 9:
                    imgStatus.ImageUrl = @"~\Images\rejected.gif";
                    break;

                default:
                    imgStatus.Visible = false;
                    break;
            }
            */
            #endregion


            //--------------------------------
            //PPR RAG Status Indicators
            //--------------------------------

            string strPPRStatus;
            string[,] PPRMeasures = {
                                        { "Overall", "O - Overall" },
                                        { "Cost", "C - Cost" },
                                        { "Deliverables", "D - Deliverables" },
                                        { "Time", "T - Time" },
                                        { "Risks", "R/I - Risks / Issues" },
                                        { "Benefits", "B - Benefits" }
                                    };
            string strPPRMeasure;
            for (int intMeasure = 0; intMeasure < PPRMeasures.GetLength(0); intMeasure++)
            {
                strPPRMeasure = PPRMeasures[intMeasure, 0];
                strPPRStatus = (DataBinder.Eval(e.Row.DataItem, "PPR_" + strPPRMeasure + "Status") != DBNull.Value) ?
                                    (string)DataBinder.Eval(e.Row.DataItem, "PPR_" + strPPRMeasure + "Status") : "-";
                Image imgPPRMeasure = e.Row.FindControl("imgPPR_" + strPPRMeasure) as Image;
                if (imgPPRMeasure != null)
                {
                    imgPPRMeasure.ImageUrl = "~/images/PPR_grey.png";
                    if ( strPPRStatus.Length > 0 )
                    {
                        imgPPRMeasure.ImageUrl = "~/" + ProjectPortfolio.Global.PPRStatusImageFromDBStatus(strPPRStatus.ToLower().Substring(0, 1));
                        imgPPRMeasure.ImageUrl = imgPPRMeasure.ImageUrl.Replace(".gif", ".png");  

                        //ERW 9 Jun 2008 - put this info in global variables (see above) 
                        //instead of having it all over the 
                        //ship.  Come back and change the replace(..) later.
                        //switch ( strPPRStatus.ToLower().Substring( 0, 1 ) )
                        //{
                        //    case "r": imgPPRMeasure.ImageUrl = "~/images/PPR_red.png"; break;
                        //    case "a": imgPPRMeasure.ImageUrl = "~/images/PPR_amber.png"; break;
                        //    case "g": imgPPRMeasure.ImageUrl = "~/images/PPR_green.png"; break;
                        //}
                    }
                    imgPPRMeasure.ToolTip = PPRMeasures[intMeasure, 1];
                }
            }

            //Table tblPPR_RAG_Status = (Table)e.Row.FindControl("tblPPR_RAG_Status");  
            //////Button btnCreatePIR = (Button)e.Row.FindControl("btnCreatePIR");
            //if (tblPPR_RAG_Status != null)
            //{
            //    tblPPR_RAG_Status.Attributes.Add("onclick", "javascript:return popWindowPPR_RAG_Status(" + DataBinder.Eval(e.Row.DataItem, "InitiativeId") + ", this);");
            //}

            //---------------
            //CreateReview BUTTON
            //----------------
            Button btnCreateReview = (Button)e.Row.FindControl("btnCreateReview");
            if (btnCreateReview != null)
            {
                if (controlType == CtrlType.Coordinator)
                {
                    btnCreateReview.ToolTip = "Create a new review";
                    btnCreateReview.CommandName = "CreateReview";

                    btnCreateReview.Attributes.Add("onclick", "javascript:return popupWindowNewReview( " + (DataBinder.Eval(e.Row.DataItem, "InitiativeID")) + ");");
                }
                else if (controlType == CtrlType.ProgrammeManager)
                {
                    btnCreateReview.ToolTip = "Request a new review";
                    btnCreateReview.CommandName = "RequestNewReview";

                    btnCreateReview.Attributes.Add("onclick", "javascript:return confirm('Are you sure you want to request a new Interim Review for this initiative?')");

                }


              //  if (btnCreateReview != null)
              //  {

                    // 2007-11-26, GMcF, for Bug 10 - IG Deferred not rollable
                //*** Next Code Removed by RJO as no such column as Approved
                 /*   btnCreateReview.Enabled = (
                                                    (
                                                        (DataBinder.Eval(e.Row.DataItem, "Approved").ToString() == "True")
                                                        || (intIGStatus == 8)
                                                    )
                        // Rev 1.9.10, 2008-03-06, GMcF
                                                    && !Global_DB.IsPIR(intIGStatus)
                                                );*/
            }


            //----------------
            //PIR BUTTON
            //----------------
            Button btnCreatePIR = (Button)e.Row.FindControl("btnCreatePIR");

            if (btnCreatePIR != null)
            { 
                if (controlType == CtrlType.Coordinator)
                {
                    btnCreatePIR.ToolTip = "Create a new PIR";
                    btnCreatePIR.CommandName = "CreatePIR";

                    btnCreatePIR.Attributes.Add("onclick", "javascript:return popupWindowNewPIR( " + (DataBinder.Eval(e.Row.DataItem, "InitiativeID")) + ");");
                }
                else if (controlType == CtrlType.ProgrammeManager)
                {
                    btnCreatePIR.ToolTip = "Request a new PIR";
                    btnCreatePIR.CommandName = "RequestNewPIR";

                    btnCreatePIR.Attributes.Add("onclick", "javascript:return confirm('Are you sure you want to request a new Post-Implementation Review for this initiative?')");
                }

      
                //** Removed by RJO as no such data column as Approved    
                /* btnCreatePIR.Enabled = ((DataBinder.Eval(e.Row.DataItem, "Approved").ToString() == "True")
                                                    || (intIGStatus == 8));*/


            //----------------
            //PPR Comments
            //----------------

                    Literal litHasPPRComments = (Literal)e.Row.FindControl("litHasPPRComments");

                    // Replaced 2008-05-28, GMcF, for Phase 2.1 UAT Feedback Item 13 - Comments as tooltip
                    //litHasPPRComments.Text = "<a href='#' class='floating' onclick='popWindowPPR_Comments(" + DataBinder.Eval(e.Row.DataItem, "InitiativeId") + ", this);'";

                    //if (DataBinder.Eval(e.Row.DataItem, "PPR_Has_Comments").ToString() == "Y")
                    //    litHasPPRComments.Text += " title='Has PPR Comments' >*</a>";
                    //else
                    //    litHasPPRComments.Text += " title='Has No PPR Comments' >+</a>";
                    // End of code replaced 2008-05-28


                    // Added 2008-05-28, GMcF, for Phase 2.1 UAT Feedback Item 13 - Comments as tooltip
                    litHasPPRComments.Text = "<a href='#' onclick='popWindowPPR_Comments(" + DataBinder.Eval( e.Row.DataItem, "InitiativeId" ) + ", this);'";

                // *** Removed by RJO as no such column as PPR_has_comments    
                /*if ( DataBinder.Eval( e.Row.DataItem, "PPR_Has_Comments" ).ToString() == "Y" )
                        litHasPPRComments.Text += " title=\""
                                                    + Server.HtmlEncode( DataBinder.Eval( e.Row.DataItem, "PPR_Comments" ).ToString() )
                                                    + "\" ><img src='Images/PPR_Comments_Exist.gif' />";
                    else
                        litHasPPRComments.Text += " title='No PPR Comments' ><img src='Images/PPR_Comments_None.gif' />";

                    litHasPPRComments.Text += "</a>";*/
                    // End of code replaced 2008-05-28

            }

        }
    }


    protected void gvInitiatives_Sorting(object sender, GridViewSortEventArgs e)
    {
        if (Session["Coordinator_SortExpression"].ToString() == e.SortExpression)
        {
            Session["Coordinator_SortDirection"] = (Session["Coordinator_SortDirection"].ToString() == "ASC") ? "DESC" : "ASC";
        }
        else
        {
            Session["Coordinator_SortDirection"] = "ASC";
        }

        Session["Coordinator_SortExpression"] = e.SortExpression;

        m_dvInitiatives.Sort = Session["Coordinator_SortExpression"].ToString() + " " + Session["Coordinator_SortDirection"].ToString();

        gvInitiatives.DataSource = m_dvInitiatives;
        gvInitiatives.DataBind();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SaveParams();

        string strFilter;

        strFilter = GetFilterString();

        Session["Coordinator_InitiativeFilter"] = strFilter;
        m_dvInitiatives.RowFilter = strFilter;

        gvInitiatives.DataSource = m_dvInitiatives;
        gvInitiatives.DataBind();
    }


    protected void SaveParams()
    {
        Session["Coordinator_InitiativeName"]       = txtInitiativeName.Text;
        Session["Coordinator_IGIdentifier"]         = txtIGIdentifier.Text;
        Session["Coordinator_IGApprovalCommittee"]  = ddlIGApprovalCommittee.SelectedValue;
        Session["Coordinator_StrategicBusinessUnit"] = ddlSBU.SelectedValue;
        Session["Coordinator_ApprovalDateFrom"]     = txtApprovalDateFrom.Text;
        Session["Coordinator_ApprovalDateTo"]       = txtApprovalDateTo.Text;
        Session["Coordinator_ReviewDate"]           = txtReviewDate.Text;
        Session["Coordinator_ApprovalStatus"]       = ddlApprovalStatus.SelectedValue;
        Session["Coordinator_Year"]                 = ddlYear.SelectedValue;

        Session["Coordinator_PPR"]                 = ddlPPR.SelectedValue;
    }

    protected void RestoreParams()
    {
        if (Session["Coordinator_InitiativeName"]       == null) Session["Coordinator_InitiativeName"] = "";
        if (Session["Coordinator_IGIdentifier"]         == null) Session["Coordinator_IGIdentifier"] = "";
        if (Session["Coordinator_IGApprovalCommittee"]  == null) Session["Coordinator_IGApprovalCommittee"] = "";
        if (Session["Coordinator_StrategicBusinessUnit"] == null) Session["Coordinator_StrategicBusinessUnit"] = "";
        if (Session["Coordinator_ApprovalDateFrom"]     == null) Session["Coordinator_ApprovalDateFrom"] = "";
        if (Session["Coordinator_ApprovalDateTo"]       == null) Session["Coordinator_ApprovalDateTo"] = "";
        if (Session["Coordinator_ReviewDate"]           == null) Session["Coordinator_ReviewDate"] = "";
        if (Session["Coordinator_ApprovalStatus"]       == null) Session["Coordinator_ApprovalStatus"] = "";
        if (Session["Coordinator_Year"]                 == null) Session["Coordinator_Year"] = "";
        if (Session["Coordinator_PPR"]                  == null) Session["Coordinator_PPR"] = "";

        txtInitiativeName.Text = Session["Coordinator_InitiativeName"].ToString();
        txtIGIdentifier.Text                    = Session["Coordinator_IGIdentifier"].ToString();
        ddlIGApprovalCommittee.SelectedValue    = Session["Coordinator_IGApprovalCommittee"].ToString();
        ddlSBU.SelectedValue                    = Session["Coordinator_StrategicBusinessUnit"].ToString();
        txtApprovalDateFrom.Text                = Session["Coordinator_ApprovalDateFrom"].ToString();
        txtApprovalDateTo.Text                  = Session["Coordinator_ApprovalDateTo"].ToString();
        txtReviewDate.Text                      = Session["Coordinator_ReviewDate"].ToString();
        ddlApprovalStatus.SelectedValue         = Session["Coordinator_ApprovalStatus"].ToString();
        ddlYear.SelectedValue                   = Session["Coordinator_Year"].ToString();

        ddlPPR.SelectedValue                    = Session["Coordinator_PPR"].ToString();
    }

    protected string GetFilterString()
    {
        bool bAnd = false;
        string strFilter = String.Empty;

        if (txtInitiativeName.Text != String.Empty)
        {
            strFilter += "Name LIKE '*" + txtInitiativeName.Text + "*'";
            bAnd = true;
        }

        if (txtIGIdentifier.Text != String.Empty)
        {
            strFilter += bAnd ? " AND " : "";
            strFilter += "(IGBusinessAreaCode + '-' + IGIdentifierCode) LIKE '*" + txtIGIdentifier.Text + "*'";
            bAnd = true;
        }

        //
        if (ddlIGApprovalCommittee.SelectedIndex > 0)
        {
            strFilter += bAnd ? " AND " : "";
            strFilter += "IGApprovalCommittee = '" + ddlIGApprovalCommittee.SelectedItem.Text + "' ";
            bAnd = true;
        }
        //..
        // Rev 2.1.4, GMcF, 2008-05-02
        if (ddlSBU.SelectedIndex > 0)
        {
            strFilter += bAnd ? " AND " : "";
            strFilter += "PrimarySponsoringArea = '" + ddlSBU.SelectedItem.Text + "' ";
            bAnd = true;
        }
        // End of Rev 2.1.4

        if ((txtApprovalDateFrom.Text != String.Empty) || (txtApprovalDateTo.Text != String.Empty))
        {
            string startDate;

            if (txtApprovalDateFrom.Text != String.Empty)
            {
                startDate = txtApprovalDateFrom.Text;
            }
            else
            {
                startDate = txtApprovalDateTo.Text;
            }

            startDate += " 00:00:00";

            string endDate;

            if (txtApprovalDateTo.Text != String.Empty)
            {
                endDate = txtApprovalDateTo.Text;
            }
            else
            {
                endDate = txtApprovalDateFrom.Text;
            }

            endDate += " 23:59:59";

            strFilter += bAnd ? " AND " : "";
            strFilter += "IGApprovalDate >= " + "'" + startDate + "'";
            strFilter += " AND ";
            strFilter += "IGApprovalDate <= " + "'" + endDate + "'";

            bAnd = true;
        }

        if (txtReviewDate.Text != String.Empty)
        {
            string startDate = txtReviewDate.Text + " 00:00:00";
            string endDate = txtReviewDate.Text + " 23:59:59";

            strFilter += bAnd ? " AND " : "";
            strFilter += "IGReviewDate > " + "'" + startDate + "'";
            strFilter += " AND ";
            strFilter += "IGReviewDate < " + "'" + endDate + "'";

            bAnd = true;
        }

        if (ddlApprovalStatus.SelectedIndex > 0)
        {
            strFilter += bAnd ? " AND " : "";
            strFilter += "IGApprovalStatusID = " + ddlApprovalStatus.SelectedValue;
            bAnd = true;
        }

        //if (ddlYear.SelectedIndex > 0)

        //rev 1.1.1 CA
        if (ddlYear.SelectedIndex != 0)
        //end rev
        {
            strFilter += bAnd ? " AND " : "";
            strFilter += "SubmissionYear = " + ddlYear.SelectedValue;
            bAnd = true;
        }

        if (ddlPPR.SelectedIndex > 0)
        {
            strFilter += bAnd ? " AND " : "";

            if (ddlPPR.SelectedIndex == 2)
            {
                //make an adjustment for NULL values - if user selects NO
                //include NULL values too
                strFilter += "( InPPR = '" + ddlPPR.SelectedValue + "' ";
                strFilter += " OR InPPR IS NULL )" ;
            }
            else
            {
                strFilter += " InPPR = '" + ddlPPR.SelectedValue + "' ";
            }
          
            bAnd = true;
        }

        return strFilter;
    }


    protected void FillDropDowns()
    {
        DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(4);

        ddlIGApprovalCommittee.DataSource = dsIGApprovalCommittee.Tables["Reference"];
        ddlIGApprovalCommittee.DataValueField = "ReferenceID";
        ddlIGApprovalCommittee.DataTextField = "Description";

        ddlIGApprovalCommittee.DataBind();

        // Rev 2.1.4, GMcF
        DataSet dsSBU = Global_DB.GetReferenceTable(59);

        ddlSBU.DataSource = dsSBU.Tables["Reference"];
        ddlSBU.DataValueField = "ReferenceID";
        ddlSBU.DataTextField = "Description";

        ddlSBU.DataBind();
        // End of Rev 2.1.4
        //rev 1.1 CA
        DataSet dsIGApprovalStatus = Global_DB.GetInitiativeStatusReferenceTable(5, nInitiativeID);
        //end rev 1.1

        dsIGApprovalStatus.Tables["Reference"].Rows[0]["Description"] = "Any";

        ddlApprovalStatus.DataSource = dsIGApprovalStatus.Tables["Reference"];
        ddlApprovalStatus.DataValueField = "ReferenceID";
        ddlApprovalStatus.DataTextField = "Description";

        ddlApprovalStatus.DataBind();

        DataSet dsYears = Global_DB.GetYears();
        ddlYear.DataSource=dsYears.Tables["PeriodYears"];
        ddlYear.DataValueField = "PeriodYear";
        ddlYear.DataTextField = "PeriodYear";

        ddlYear.DataBind();

        // Added 2008-01-02, GMcF, for AP maint request 2008-01-02
        ddlYear.SelectedValue = DateTime.Now.Year.ToString();


        //PPR drop down
        //ERW 29 May 2008 - not the best idea to hard code the text and value.
        //Consider moving these to some type of static data table or config file
        ddlPPR.Items.Add(new ListItem("Any", "0")); 
        ddlPPR.Items.Add(new ListItem("In PPR", "Y"));
        ddlPPR.Items.Add(new ListItem("Not In PPR", "N"));

    }




        protected void SendNotificationEmail(int nIntitiativeID)
    {
        string from = ConfigurationSettings.AppSettings["ApplicationEmailAddress"];
                
        DataRow drInitiative = Header_DB.GetInitiativeDetails(nIntitiativeID);

        if (drInitiative != null)
        {
            DataSet dsContacts = Notification_DB.GetNotificationList((int)drInitiative["IGApprovalCommitteeID"]);

            MailMessage message = new MailMessage();
            message.From = new MailAddress(from);

            foreach (DataRow drContact in dsContacts.Tables["Contacts"].Rows)
            {
                message.To.Add(new MailAddress(drContact["EmailAddress"].ToString()));
            }                       

            DataRow drNotification = Notification_DB.GetEmailTemplate("Request New Review");

            string strSubject, strBody, strSubmittedBy;

            strSubject = String.Empty;
            strBody = String.Empty;
            strSubmittedBy = String.Empty;

            // Replaced 2007-11-12, GMcF, for Bug 11 - Alert email incorrect
            //if (Session["UserName"] != null)
            //    strSubmittedBy = Session["UserName"].ToString(); ;
            //

            // Replacement added 2007-11-12, GMcF, for Bug 11 - Alert email incorrect
            if (Session["ContactID"] != null)
            {
                strSubmittedBy = Global_DB.GetContactName((int)Session["ContactID"]);
            }


            if (drNotification != null)
            {
                strSubject = drNotification["Subject"].ToString();
                strBody = drNotification["Body"].ToString();

                message.IsBodyHtml = (bool)drNotification["IsHTML"];


                strSubject = strSubject.Replace("<<INITIATIVE NAME>>", drInitiative["Name"].ToString());
                strSubject = strSubject.Replace("<<IDENTIFIER>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                            drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'));


                strBody = strBody.Replace("<<INITIATIVE NAME>>", drInitiative["Name"].ToString());
                strBody = strBody.Replace("<<IDENTIFIER>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                            drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'));
                strBody = strBody.Replace("<<LOGGED IN USER NAME>>", strSubmittedBy);

                // Added 2007-11-12, GMcF, for Bug 11 - Alert email incorrect
                strBody = strBody.Replace("<<SHORT IDENTIFIER>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" + drInitiative["IGIdentifierCode"].ToString());

            }

            message.Subject = strSubject;
            message.Body = strBody;

            // For debugging on a machine other than the dev server
            //SmtpClient client = new SmtpClient("192.1.1.15");

            // For use on the IPMS Live/UAT servers
            SmtpClient client = new SmtpClient();

            try
            {
                if (message.To.ToString().Equals(String.Empty))
                {
                    Page.RegisterStartupScript("MessageRequestSent",
                        "<script language=\"javascript\"> " +
                               "alert(\"The request was not sent. This IG Approval Committee has no IG Coordinator.\");" +
                        "</script>");                    
                }
                else
                {
                    client.Send(message);

                    Page.RegisterStartupScript("MessageRequestSent",
                            "<script language=\"javascript\"> " +
                                   "alert(\"The request has been sent.\");" +
                            "</script>");
                }
            }
            catch (Exception ex)
            {
                Page.RegisterStartupScript("MessageRequestSent",
               "<script language=\"javascript\"> " +
                      "alert(\"The request was not sent. There was an error with SMTP server.\");" +
               "</script>"); 
            }
        }

    }

    // Added 2008-01-21, GMcF, for PIR
    protected void SendPIRNotificationEmail(int nIntitiativeID)
    {
        string from = ConfigurationSettings.AppSettings["ApplicationEmailAddress"];

        DataRow drInitiative = Header_DB.GetInitiativeDetails(nIntitiativeID);

        if (drInitiative != null)
        {
            DataSet dsContacts = Notification_DB.GetNotificationList((int)drInitiative["IGApprovalCommitteeID"]);

            MailMessage message = new MailMessage();
            message.From = new MailAddress(from);

            foreach (DataRow drContact in dsContacts.Tables["Contacts"].Rows)
            {
                message.To.Add(new MailAddress(drContact["EmailAddress"].ToString()));
            }

            DataRow drNotification = Notification_DB.GetEmailTemplate("Request New PIR");

            string strSubject, strBody, strSubmittedBy;

            strSubject = String.Empty;
            strBody = String.Empty;
            strSubmittedBy = String.Empty;

            if (Session["ContactID"] != null)
            {
                strSubmittedBy = Global_DB.GetContactName((int)Session["ContactID"]);
            }


            if (drNotification != null)
            {
                strSubject = drNotification["Subject"].ToString();
                strBody = drNotification["Body"].ToString();

                message.IsBodyHtml = (bool)drNotification["IsHTML"];


                strSubject = strSubject.Replace("<<INITIATIVE NAME>>", drInitiative["Name"].ToString());
                strSubject = strSubject.Replace("<<IDENTIFIER>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                            drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'));


                strBody = strBody.Replace("<<INITIATIVE NAME>>", drInitiative["Name"].ToString());
                strBody = strBody.Replace("<<IDENTIFIER>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                            drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'));
                strBody = strBody.Replace("<<LOGGED IN USER NAME>>", strSubmittedBy);

                strBody = strBody.Replace("<<SHORT IDENTIFIER>>", drInitiative["IGBusinessAreaCode"].ToString() + "-" + drInitiative["IGIdentifierCode"].ToString());

            }

            message.Subject = strSubject;
            message.Body = strBody;

            // For debugging on a machine other than the dev server
            //SmtpClient client = new SmtpClient("192.1.1.15");

            // For use on the IPMS Live/UAT servers
            SmtpClient client = new SmtpClient();

            try
            {
                if (message.To.ToString().Equals(String.Empty))
                {
                    Page.RegisterStartupScript("MessageRequestSent",
                        "<script language=\"javascript\"> " +
                               "alert(\"The request was not sent. This IG Approval Committee has no IG Coordinator.\");" +
                        "</script>");
                }
                else
                {
                    client.Send(message);

                    Page.RegisterStartupScript("MessageRequestSent",
                            "<script language=\"javascript\"> " +
                                   "alert(\"The request has been sent.\");" +
                            "</script>");
                }
            }
            catch (Exception ex)
            {
                Page.RegisterStartupScript("MessageRequestSent",
               "<script language=\"javascript\"> " +
                      "alert(\"The request was not sent. There was an error with SMTP server.\");" +
               "</script>");
            }
        }

    }

}
