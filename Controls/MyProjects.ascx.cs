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

public partial class Controls_MyProjects : System.Web.UI.UserControl
{
    DataView m_dvInitiatives;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet dsMyInitiatives = MyProjects_DB.GetMyInitiatives();
        
        m_dvInitiatives = new DataView(dsMyInitiatives.Tables["Initiative"]);

        gvMyProjects.DataSource = m_dvInitiatives;
        gvMyProjects.DataBind();
    }
    

    protected void btnNewInitiative_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/default.aspx?section=1&InitiativeID=0");
    }


    protected void gvMyProjects_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "CreateReview":
                {
                    int intInitiativeID = Int32.Parse(e.CommandArgument.ToString());
                    int intContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;

                    int intNewVersion_InitiativeID = MyProjects_DB.InsertInitiative_CreateNewVersion(intInitiativeID, intContactID,DateTime.MinValue);

                    Response.Redirect("~/default.aspx?section=1&InitiativeID=" + intNewVersion_InitiativeID.ToString());
                }
                break;
        }
    }


    protected void gvMyProjects_RowDataBound(object sender, GridViewRowEventArgs e)
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

            Button btnCreateReview = (Button)e.Row.FindControl("btnCreateReview");
            btnCreateReview.Attributes.Add("onclick", "javascript:return confirm('Are you sure you want to create a new Interim Review Form for this initiative?')");

        }
    }


    protected void gvMyProjects_Sorting(object sender, GridViewSortEventArgs e)
    {
        m_dvInitiatives.Sort = e.SortExpression + " " + ((e.SortDirection == SortDirection.Ascending) ? "ASC" : "DESC");

        gvMyProjects.DataSource = m_dvInitiatives;
        gvMyProjects.DataBind();
    }

}
