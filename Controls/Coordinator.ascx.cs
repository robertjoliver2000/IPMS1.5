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
//      2.1.4       GMcF        02/05/2008      For Phase 2.1, Del 4 - SBU filter
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
using System.Collections.Generic;

using ProjectPortfolio.Classes;


public partial class Controls_Coordinator : System.Web.UI.UserControl
{
    DataView m_dvInitiatives;

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


        /*  ERW  2 Oct 2008
        * In looking at the default searching functionality when the homepage and admin pages load,
        * I realised that GetMyInitiatives was being called twice on every page load.
        * I have now commented these lines of code out to resolve this problem

           DataSet dsMyInitiatives = MyProjects_DB.GetMyInitiatives();

           m_dvInitiatives = new DataView(dsMyInitiatives.Tables["Initiative"]);
           if ((Page.Request["review_request"] != null) && (Page.Request["review_request"] != string.Empty))
           {
               m_dvInitiatives.RowFilter = "(IGBusinessAreaCode + '-' + IGIdentifierCode) = '" + Page.Request["review_request"].ToString() + "'";
               m_dvInitiatives.Sort = null;
           }
           else
           {
               if (Session["Coordinator_InitiativeFilter"] == null)
               {
                   Session["Coordinator_InitiativeFilter"] = "SubmissionYear = " + DateTime.Now.Year.ToString();
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

               m_dvInitiatives.RowFilter = Session["Coordinator_InitiativeFilter"].ToString();
               m_dvInitiatives.Sort = Session["Coordinator_SortExpression"].ToString() != String.Empty ?
                           (Session["Coordinator_SortExpression"].ToString() + " " + Session["Coordinator_SortDirection"].ToString()) :
                           null;
           }
           gvInitiatives.DataSource = m_dvInitiatives;
           gvInitiatives.DataBind();
         
         * 
         * */
   }


   protected void gvInitiatives_RowCommand(object sender, GridViewCommandEventArgs e)
   {
       /*  
   switch (e.CommandName)
       {
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
       }
   */
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
            PPRHeader.Controls.Add(new LiteralControl("<table class='PPRHeaders'><tr><th title='O - Overall'>O</th><th title='C - Cost'>C</th><th title='D - Deliverables'>D</th><th title='T - Time'>T</th><th title='R/I - Risks / Issues'>R/I</th><th title='B - Benefits'>B</th></tr></table>"));
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image imgStatus = (Image)e.Row.FindControl("imgStatus");
            int intIGStatus = (DataBinder.Eval(e.Row.DataItem, "IGApprovalStatusID") != DBNull.Value) ?
                                    (int)DataBinder.Eval(e.Row.DataItem, "IGApprovalStatusID") : 1;

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
                strPPRMeasure = PPRMeasures[intMeasure,0];
                strPPRStatus = (DataBinder.Eval(e.Row.DataItem, "PPR_" + strPPRMeasure + "Status") != DBNull.Value) ?
                                    (string)DataBinder.Eval(e.Row.DataItem, "PPR_" + strPPRMeasure + "Status") : "-";
                Image imgPPRMeasure = e.Row.FindControl("imgPPR_" + strPPRMeasure) as Image;
                if (imgPPRMeasure != null)
                {
                    switch (strPPRStatus.ToLower().Substring(0,1))
                    {
                        case "r": imgPPRMeasure.ImageUrl = "~/images/PPR_red.png"; break;
                        case "a": imgPPRMeasure.ImageUrl = "~/images/PPR_amber.png"; break;
                        case "g": imgPPRMeasure.ImageUrl = "~/images/PPR_green.png"; break;
                        default: imgPPRMeasure.ImageUrl = "~/images/PPR_grey.png"; break;
                    }

                    imgPPRMeasure.ToolTip = PPRMeasures[intMeasure,1];
                }
            }

            Button btnCreateReview = (Button)e.Row.FindControl("btnCreateReview");
            btnCreateReview.Attributes.Add("onclick", "javascript:return popupWindowNewReview( "+(DataBinder.Eval(e.Row.DataItem, "InitiativeID")) +");");

            // 2007-11-26, GMcF, for Bug 10 - IG Deferred not rollable
            btnCreateReview.Enabled =   (
                                            (
                                                (DataBinder.Eval(e.Row.DataItem, "Approved").ToString() == "True")
                                                || (intIGStatus == 8)
                                            )
                                            // Rev 1.9.10, 2008-03-06, GMcF
                                            && ! Global_DB.IsPIR(intIGStatus)
                                        );

            Button btnCreatePIR = (Button)e.Row.FindControl("btnCreatePIR");
            btnCreatePIR.Attributes.Add("onclick", "javascript:return popupWindowNewPIR( " + (DataBinder.Eval(e.Row.DataItem, "InitiativeID")) + ");");

            btnCreatePIR.Enabled = ((DataBinder.Eval(e.Row.DataItem, "Approved").ToString() == "True")
                                            || (intIGStatus == 8));

            Literal litHasPPRComments = (Literal)e.Row.FindControl("litHasPPRComments");

            litHasPPRComments.Text = "<a href='#' class='floating' onclick='popWindowPPR_Comments(" + DataBinder.Eval(e.Row.DataItem, "InitiativeId") + ", this);'";

            if ( DataBinder.Eval(e.Row.DataItem, "PPR_Has_Comments").ToString() == "Y" )
                litHasPPRComments.Text += " title='Has PPR Comments' >*</a>";
            else
                litHasPPRComments.Text += " title='Has No PPR Comments' >+</a>" ;
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

        txtInitiativeName.Text = Session["Coordinator_InitiativeName"].ToString();
        txtIGIdentifier.Text                    = Session["Coordinator_IGIdentifier"].ToString();
        ddlIGApprovalCommittee.SelectedValue    = Session["Coordinator_IGApprovalCommittee"].ToString();
        ddlSBU.SelectedValue                    = Session["Coordinator_StrategicBusinessUnit"].ToString();
        txtApprovalDateFrom.Text                = Session["Coordinator_ApprovalDateFrom"].ToString();
        txtApprovalDateTo.Text                  = Session["Coordinator_ApprovalDateTo"].ToString();
        txtReviewDate.Text                      = Session["Coordinator_ReviewDate"].ToString();
        ddlApprovalStatus.SelectedValue         = Session["Coordinator_ApprovalStatus"].ToString();
        ddlYear.SelectedValue                   = Session["Coordinator_Year"].ToString();
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


        ////rem CA
        //DataSet dsIGApprovalStatus = Global_DB.GetReferenceTable(5);
        ////end rem

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

        //rem CA
        //ddlYear.SelectedValue = DateTime.Now.Year.ToString();
        //end rem

        //rev 1.1.1 CA
        //ddlYear.SelectedIndex = 3;        //Taken out 2008-01-02, GMcF, for AP maint request 2008-01-02
        //end rev

        ddlYear.DataBind();

        // Added 2008-01-02, GMcF, for AP maint request 2008-01-02
        ddlYear.SelectedValue = DateTime.Now.Year.ToString();

    }

}
