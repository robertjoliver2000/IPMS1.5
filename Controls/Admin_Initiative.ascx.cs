//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1         CA          25/01/2007      To add variable nInitiative 
//                                              To pass to InitiativeStatusGetReferenceTable
//                                              
//      1.9.6       GMcF        15/02/2008      For PIR, replaced local switch statement working out what status icon to use
//
//      2.1.4       GMcF        02/05/2008      For Phase 2.1, Deliverable 4 - SBU filter on initiatives
//
//      2.1.5       GMcF        05/05/2008      For Phase 2.1, Deliverable 5 - Admin Screen – Identifying PPR Initiatives
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

using ProjectPortfolio.Classes;


public partial class Controls_Admin_Initiative: System.Web.UI.UserControl
{
    DataView m_dvInitiatives;

    //rev 1.1
    int nInitiativeID;
    //end rev

    protected void Page_LoadPostData()
    {

    }

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


        #region OTA756 - Update the session variables, as we were always searching one page behind
        //RH 2008-11-24
        Session["Admin_InitiativeFilter"] = GetFilterString();



        #endregion







        lnkReviewDate.HRef = "javascript:popupWindowDatePicker('" + txtReviewDate.ClientID + "');";

        if (!Page.IsPostBack)
        {
            FillDropDowns();
            Session["Admin_InitiativeFilter"] = "SubmissionYear = " + DateTime.Now.Year.ToString();
            Session["Admin_SortExpression"] = String.Empty;
            Session["Admin_SortDirection"] = String.Empty;
        }

        if (Session["Admin_InitiativeFilter"] == null)
        {
            Session["Admin_InitiativeFilter"] = "SubmissionYear = " + DateTime.Now.Year.ToString();
        }

        if (Session["Admin_SortExpression"] == null)
        {
            Session["Admin_SortExpression"] = String.Empty;
            Session["Admin_SortDirection"] = String.Empty;
        }

        if (Session["Admin_SortDirection"] == null)
        {
            Session["Admin_SortDirection"] = String.Empty;
        }
        
        BindGridView();

        // Rev 2.1.5, GMcF, 2008-05-05
        RegisterBodyBeforeUnloadHandlerScript();
    }

    protected void BindGridView()
    {
        /* 
        //m_dvInitiatives.RowFilter = Session["Admin_InitiativeFilter"].ToString();
        string year = Session["Admin_InitiativeFilter"].ToString();

        Removed this code, as the ALL plus a IG code was causing an error
        //cut out everything beyond the = sign
        year = year.Substring(year.IndexOf("=") +1).Trim();
         * Added the following code to retreive the year value
         */

        string year = ddlYear.SelectedValue;
        if (year.ToLower() == "all") year = ""; //reset the year value, if it is set to All

        DataSet dsInitiatives = Admin_DB.GetAdminInitiatives(year);

        m_dvInitiatives = new DataView(dsInitiatives.Tables["Initiative"]);

        /*m_dvInitiatives.RowFilter = Session["Admin_InitiativeFilter"].ToString(); */          
        m_dvInitiatives.Sort = Session["Admin_SortExpression"].ToString() != String.Empty ?
                    (Session["Admin_SortExpression"].ToString() + " " + Session["Admin_SortDirection"].ToString()) :
                    null;

        gvInitiatives.DataSource = m_dvInitiatives;
        gvInitiatives.DataBind();
    }

    protected void gvInitiatives_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Unlock":
                {
                    int nInitiativeID = Int32.Parse(e.CommandArgument.ToString());

                    Security_DB.ClearActiveUserID(nInitiativeID);

                    BindGridView();
                }
                break;

            case "DeleteInitiative":
                {
                    int nInitiativeID = Int32.Parse(e.CommandArgument.ToString());


                    Admin_DB.DeleteInitiative(nInitiativeID,false);
                    //Admin_DB.DeleteInitiative(nInitiativeID,true);

                    BindGridView();

                }
                break;

            case "Reopen":
                {
                    int intInitiativeID = Int32.Parse(e.CommandArgument.ToString());

                    Admin_DB.Reopen(intInitiativeID);

                    BindGridView();
                }
                break;
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
                case 22:
                    imgStatus.ImageUrl = @"~\Images\draft.gif";
                    break;

                case 2:
                case 23:
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
                case 24:
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


            // Rev 2.1.5, GMcF, 2008-05-05 - add "In PPR" checkbox
            // Following block removed by RJO 27-Apr-14
            /* string strInPPR = DataBinder.Eval(e.Row.DataItem,"InPPR").ToString().ToUpper();
            if (strInPPR == "Y")
            {
                CheckBox cbxInPPR = (CheckBox)e.Row.FindControl("cbxInPPR");
                cbxInPPR.Checked = true;
            } */
            // End of block removed by RJO 27-Apr-14
            // End of Rev 2.1.5


            Button btnUnlock = (Button)e.Row.FindControl("btnUnlock");
            if(btnUnlock!=null)
                btnUnlock.Attributes.Add("onclick", "javascript:return confirm('Are you sure you want to unlock this initiative?')");

            ImageButton imgButt = (ImageButton)e.Row.FindControl("delInitiative");
            if (imgButt != null)
                imgButt.Attributes.Add("onClick", "javascript:return (confirm('Are you sure you wish to delete this initiative ?'))");

            Button btnReopen = (Button)e.Row.FindControl("btnReopen");
            if (btnReopen != null)
            {
                //rev fix for Bug 18
                //rem 
                //btnReopen.Enabled = (intIGStatus != 1);
                //end rem

                //rev
                btnReopen.Enabled = (intIGStatus != 1 && intIGStatus != 2 && intIGStatus != 3 && intIGStatus != 8 && intIGStatus != 9 && intIGStatus != 16 && intIGStatus != 19 && intIGStatus != 20
                            && intIGStatus != 22 && intIGStatus != 23); // Rev 1.9.6, 2008-02-15, GMcF, for PIR
                //end rev
                btnReopen.Attributes.Add("onClick", "javascript:return (confirm('Are you sure you wish to reopen this initiative ?'))");
            }                  

        }
    }


    protected void gvInitiatives_Sorting(object sender, GridViewSortEventArgs e)
    {
        if (Session["Admin_SortExpression"].ToString() == e.SortExpression)
        {
            Session["Admin_SortDirection"] = (Session["Admin_SortDirection"].ToString() == "ASC") ? "DESC" : "ASC";
        }
        else
        {
            Session["Admin_SortDirection"] = "ASC";
        }

        Session["Admin_SortExpression"] = e.SortExpression;

        m_dvInitiatives.Sort = Session["Admin_SortExpression"].ToString() + " " + Session["Admin_SortDirection"].ToString();

        gvInitiatives.DataSource = m_dvInitiatives;
        gvInitiatives.DataBind();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string strFilter;

        strFilter = GetFilterString();

        // Session["Admin_InitiativeFilter"] = strFilter;
        /* m_dvInitiatives.RowFilter = strFilter;*/

        gvInitiatives.DataSource = m_dvInitiatives;
        gvInitiatives.DataBind();
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


        // Rev 2.1.4, GMcF, 2008-05-02
        if (ddlSBU.SelectedIndex > 0)
        {
            strFilter += bAnd ? " AND " : "";
            strFilter += "PrimarySponsoringArea = '" + ddlSBU.SelectedItem.Text + "'";
            bAnd = true;
        }
        // End of Rev 2.1.4


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

        if (ddlYear.SelectedIndex > 0)
        {
            strFilter += bAnd ? " AND " : "";
            strFilter += "SubmissionYear = " + ddlYear.SelectedValue;
            bAnd = true;
        }

        return strFilter;
    }


    protected void FillDropDowns()
    {
        // Rev 2.1.4, GMcF, 2008-05-02
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
        //ddlYear.SelectedIndex = 3;    //Taken out 2008-01-03, GMcF, for AP maint request 2008-01-02
        //end rev

        ddlYear.DataBind();

        //Added 2008-01-03, GMcF, for AP maint request 2008-01-02
        ddlYear.SelectedValue = DateTime.Now.Year.ToString();

    }

    // Rev 2.1.5, GMcF, 2008-05-05
    protected void btnSave_Click(object sender, EventArgs e)
    {
        HiddenField hId;
        CheckBox cbxInPPR;

        for (int i = 0; i < gvInitiatives.Rows.Count; i++)
        {
            hId = (HiddenField)gvInitiatives.Rows[i].FindControl("hdnInitiativeId");
            cbxInPPR = (CheckBox)gvInitiatives.Rows[i].FindControl("cbxInPPR");
            if (hId != null && cbxInPPR != null)
            {
                Global_DB.UpdateInitiativeInPPR(
                                                    System.Convert.ToInt32(hId.Value),
                                                    cbxInPPR.Checked ? "Y" : "N",
                                                    System.Convert.ToInt32(Session["ContactID"].ToString())
                                                ); 
            }
        }
    }

    // Rev 2.1.5, GMcF, 2008-05-05
    protected void RegisterBodyBeforeUnloadHandlerScript()
    {
        ClientScriptManager cs = Page.ClientScript;
        Type cstype = this.GetType();

        if (!cs.IsStartupScriptRegistered(cstype, "add_body_ppr_onbeforeunload_handler"))
        {
            String cstext = "<script language=\"javascript\">" +

                            "Events_chainEvent(" +
                                "document.body, " +
                                "\"onbeforeunload\", \"ConfirmUnload();\");" +

                            "Events_chainEvent(" +
                                "document.body, " +
                                "\"onload\", \"AddPPRChangeHandlers();\");" +
                            
                            "Events_chainEvent(" +
                                "document.getElementById( '" + btnCancel.ClientID + "' ), " +
                                //"\"onclick\", \"AllowOneTimeSubmit();\");" +
                                "\"onclick\", \"ClearDirtyFlag();\");" +
                           

                            "Events_chainEvent(" +
                                "document.getElementById( '" + btnSave.ClientID + "' ), " +
                                //"\"onclick\", \"AllowOneTimeSubmit();\");" +
                                "\"onclick\", \"ClearDirtyFlag();\");" +

                            "</script>";

            cs.RegisterStartupScript(cstype, "add_body_onbeforeunload_handler", cstext);

        }
    }

}
