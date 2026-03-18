//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1         CA          25/01/2007      To add variable nInitiative 
//                                              To pass to InitiativeStatusGetReferenceTable
//                                              
//      -----       GMcF        03/02/2008      For AP maint request 2008-01-02, made approval year default to current
//
//      1.9.3       GMcF        30/01/2008      For PIR, added PIR statuses to code showing status icon
//
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

using ProjectPortfolio.Classes;


public partial class Controls_Admin_DeletedInitiative: System.Web.UI.UserControl
{
    DataView m_dvInitiatives;

    //rev 1.1
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
        
    }

    protected void BindGridView()
    {
        DataSet dsInitiatives = Admin_DB.GetAdminDeletedInitiatives();

        m_dvInitiatives = new DataView(dsInitiatives.Tables["Initiative"]);

        m_dvInitiatives.RowFilter = Session["Admin_InitiativeFilter"].ToString();
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
            case "Unlock":  //is now button reinstate
                {
                    int nInitiativeID = Int32.Parse(e.CommandArgument.ToString());

                    //Security_DB.ClearActiveUserID(nInitiativeID);
                    Admin_DB.ReinstateInitiative(nInitiativeID, false); //now for reinstate

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

            int iDeletedVersionNo = ((int)DataBinder.Eval(e.Row.DataItem, "IGVersionNumber"));
            string sIGIdentfier = ((string)DataBinder.Eval(e.Row.DataItem, "IGBusinessAreaCode")) + "-" + ((string)DataBinder.Eval(e.Row.DataItem, "IGIdentifierCode"));

            //start
            SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

            SqlCommand cmdGetMaxVersionNo = new SqlCommand();
            cmdGetMaxVersionNo.Connection = dbConnection;

            cmdGetMaxVersionNo.CommandType = CommandType.Text;
            cmdGetMaxVersionNo.CommandText = "SELECT Max(IGVersionNumber) as MaxVersionNo from Initiative where IGBusinessAreaCode + '-' + IGIdentifierCode = '" + sIGIdentfier + "'";


            SqlDataAdapter daVersionNo = new SqlDataAdapter(cmdGetMaxVersionNo);

            DataSet dsVersionNo = new DataSet();

            daVersionNo.Fill(dsVersionNo, "VersionNo");

            DataRow drMaxVersionNo = (dsVersionNo.Tables["VersionNo"].Rows[0]);

            int iMaxVersionNo = 0;

            if (drMaxVersionNo[0] != DBNull.Value)
            {
                iMaxVersionNo = (int)drMaxVersionNo[0];
            }
            //else
            //{
            //    iMaxVersionNo = (int)drMaxVersionNo[0];
            //}   
            //finish

            //Response.Write(iMaxVersionNo);

            //Response.Write(cmdGetMaxVersionNo.CommandText);

            switch (intIGStatus)
            {
                case 1:
                    imgStatus.ImageUrl = @"~\Images\delete.gif";
                    break;

                case 19:
                    imgStatus.ImageUrl = @"~\Images\delete.gif";
                    break;

                case 2:
                    imgStatus.ImageUrl = @"~\Images\delete.gif";
                    break;

                case 3:
                    imgStatus.ImageUrl = @"~\Images\delete.gif";
                    break;

                case 4:
                case 5:
                case 6:
                case 7:
                case 10:
                    imgStatus.ImageUrl = @"~\Images\delete.gif";
                    break;

                case 11:
                case 12:
                case 13:
                case 14:
                    imgStatus.ImageUrl = @"~\Images\delete.gif";
                    break;

                case 8:
                case 9:
                    imgStatus.ImageUrl = @"~\Images\delete.gif";
                    break;

                /* Rev 1.9.3, 2008-01-30, GMcF, for PIR */
                case 22:
                case 23:
                case 24:
                    imgStatus.ImageUrl = @"~\Images\delete.gif";
                    break;
                /* End of Rev 1.9.3 */

                default:
                    imgStatus.Visible = false;
                    break;
            }

            Button btnUnlock = (Button)e.Row.FindControl("btnUnlock");
            if(btnUnlock!=null)
                btnUnlock.Attributes.Add("onclick", "javascript:return confirm('Are you sure you want to Reinstate this initiative?')");

            // Replaced 2008-04-11, GMcF, for OTA 525 - deleted initatives missing from database
            //if (btnUnlock != null)
            //{
            //    btnUnlock.Enabled = (iDeletedVersionNo == 1);
            //}
            //
            //if (btnUnlock != null)
            //{
            //    btnUnlock.Enabled = (iDeletedVersionNo > iMaxVersionNo);
            //}


            // Replacement added 2008-04-11, GMcF, for OTA 525 - deleted initatives missing from database
            if (btnUnlock != null)
            {
                btnUnlock.Enabled = (DataBinder.Eval(e.Row.DataItem, "CanReinstate").ToString() == "Y");
            }


            ImageButton imgButt = (ImageButton)e.Row.FindControl("delInitiative");
            if (imgButt != null)
                imgButt.Attributes.Add("onClick", "javascript:return (confirm('Are you sure you wish to delete this initiative ?'))");


            // Button no longer on page
            //
            //Button btnReopen = (Button)e.Row.FindControl("btnReopen");
            //if (btnReopen != null)
            //{
            //    //rev fix for Bug 18
            //    //rem 
            //    //btnReopen.Enabled = (intIGStatus != 1);
            //    //end rem

            //    //rev
            //    btnReopen.Enabled = (intIGStatus != 1 && intIGStatus != 2 && intIGStatus != 3 && intIGStatus != 8 && intIGStatus != 9 && intIGStatus != 10 && intIGStatus != 16 && intIGStatus != 19 && intIGStatus != 20);
            //    //end rev
            //    btnReopen.Attributes.Add("onClick", "javascript:return (confirm('Are you sure you wish to reopen this initiative ?'))");
            //}                  

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

        Session["Admin_InitiativeFilter"] = strFilter;
        m_dvInitiatives.RowFilter = strFilter;

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
