//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.9.6       GMcF        15/02/2008      For PIR, replaced local switch statement working out what status icon to use
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


public partial class Controls_Admin_Review: System.Web.UI.UserControl
{
    DataView m_dvInitiatives;

    DataView m_dvDeletedInitiatives;
    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            //Session["Admin_InitiativeFilter"] = "SubmissionYear = " + DateTime.Now.Year.ToString();
            Session["Admin_SortExpression"] = "";
            Session["Admin_SortDirection"] = "";
        }
        BindGridView();

    }

    protected void BindGridView()
    {
        int nInitiativeID;
        try
        {
            nInitiativeID = Convert.ToInt32(Request.QueryString["InitiativeID"]);
        }
        catch 
        {
            nInitiativeID = -1;
        }

        DataSet dsInitiatives = Admin_DB.GetAdminInitiativeHistory(nInitiativeID);

        m_dvInitiatives = new DataView(dsInitiatives.Tables["Initiative"]);

        //m_dvInitiatives.RowFilter = Session["Admin_InitiativeFilter"].ToString();
        m_dvInitiatives.Sort = Session["Admin_SortExpression"].ToString() != String.Empty ?
                    (Session["Admin_SortExpression"].ToString() + " " + Session["Admin_SortDirection"].ToString()) :
                    null;

        gvInitiatives.DataSource = m_dvInitiatives;
        gvInitiatives.DataBind();

        DataSet dsDeletedInitiatives = Admin_DB.GetAdminInitiativeDeletedHistory(nInitiativeID);

        m_dvDeletedInitiatives = new DataView(dsDeletedInitiatives.Tables["Initiative"]);

        gvDeletedInitiatives.DataSource = m_dvDeletedInitiatives;
        gvDeletedInitiatives.DataBind();
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
            
            /* delete only the last version is possible
            case "DeleteReview":
                {
                    int nInitiativeID = Int32.Parse(e.CommandArgument.ToString());

                    Admin_DB.DeleteInitiative(nInitiativeID,false);

                    BindGridView();

                }
                break;
             */
        }
    }

    protected void gvDeletedInitiatives_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Reinstate":
                {
                    int nInitiativeID = Int32.Parse(e.CommandArgument.ToString());


                    Admin_DB.ReinstateInitiative(nInitiativeID, false);

                    BindGridView();

                }
                break;

            /* delete only the last version is possible
            case "DeleteReview":
                {
                    int nInitiativeID = Int32.Parse(e.CommandArgument.ToString());

                    Admin_DB.DeleteInitiative(nInitiativeID,false);

                    BindGridView();

                }
                break;
             */
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
                    imgStatus.ImageUrl = @"~\Images\draft.gif";
                    break;

                case 19:
                    imgStatus.ImageUrl = @"~\Images\draft.gif";
                    break;

                case 20:
                    imgStatus.ImageUrl = @"~\Images\draft.gif";
                    break;

                case 2:
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

            Button btnUnlock = (Button)e.Row.FindControl("btnUnlock");
            if(btnUnlock!=null)
                btnUnlock.Attributes.Add("onclick", "javascript:return confirm('Are you sure you want to unlock this initiative?')");

            ImageButton imgButt = (ImageButton)e.Row.FindControl("delInitiative");
            if (imgButt != null)
                imgButt.Attributes.Add("onClick", "javascript:return (confirm('Are you sure you wish to delete this initiative ?'))");

                

        }
    }

    protected void gvDeletedInitiatives_RowDataBound(object sender, GridViewRowEventArgs e)
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
            //int intIGStatus = (DataBinder.Eval(e.Row.DataItem, "IGApprovalStatusID") != DBNull.Value) ?
            //                        (int)DataBinder.Eval(e.Row.DataItem, "IGApprovalStatusID") : 1;

            int intIGStatus = 1;

            switch (intIGStatus)
            {
                case 1:
                    //imgStatus.ImageUrl = @"~\Images\draft.gif";
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

                default:
                    imgStatus.Visible = false;
                    break;
            }

            Button btnReinstate = (Button)e.Row.FindControl("btnReinstate");
            if (btnReinstate != null)
                btnReinstate.Attributes.Add("onclick", "javascript:return confirm('Are you sure you wish to Reinstate this Initiative?')");

            ImageButton imgButt = (ImageButton)e.Row.FindControl("delInitiative");
            if (imgButt != null)
                imgButt.Attributes.Add("onClick", "javascript:return (confirm('Are you sure you wish to delete this initiative ?'))");



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

    protected void gvDeletedInitiatives_Sorting(object sender, GridViewSortEventArgs e)
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

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/admin.aspx");
    }
}
