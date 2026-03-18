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

public partial class Controls_ProjectHistory : System.Web.UI.UserControl
{
    protected int m_nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            m_nInitiativeID = -1;
        }

        if (m_nInitiativeID > 0)
        {
            DataSet dsPreviousInitiatives = MyProjects_DB.GetInitiativeHistory(m_nInitiativeID);

            gvMyProjects.DataSource = dsPreviousInitiatives.Tables["Initiative"];
            gvMyProjects.DataBind();
        }
        else
        {
            Response.Redirect("~/default.aspx");
        }
    }



    protected void gvMyProjects_RowDataBound(object sender, GridViewRowEventArgs e)
    {
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

        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/default.aspx");
    }
}
