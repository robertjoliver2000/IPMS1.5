namespace ProjectPortfolio.Controls
{
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

    public partial class PIR_ScopeChanges_PrintVersion : System.Web.UI.UserControl
    {
        protected int m_nInitiativeID = -1;

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

            LoadScopeChanges(m_nInitiativeID);
        }

        protected void LoadScopeChanges(int nInitiativeID)
        {
            DataSet ds = PIR_ScopeChanges_DB.GetScopeChanges(nInitiativeID);

            rptScopeChanges.DataSource = ds.Tables["InitiativeScopeChange"];
            rptScopeChanges.DataBind();
        }


        protected void rptScopeChanges_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (DataBinder.Eval(e.Item.DataItem, "InitiativeScopeChangeID") == DBNull.Value)
                {
                    HtmlTableCell tdScopeChange = (HtmlTableCell)e.Item.FindControl("tdScopeChange");
                    tdScopeChange.InnerText = "No records";
                }
                else
                {
                    HtmlTableCell tdStatus = (HtmlTableCell)e.Item.FindControl("tdStatus");
                    switch (DataBinder.Eval(e.Item.DataItem, "Status").ToString().ToLower())
                    {
                        case "major": tdStatus.Style["background-color"] = "red"; break;
                        case "minor": tdStatus.Style["background-color"] = "green"; break;
                        default: tdStatus.Style["background-color"] = "inherit"; break;
                    }
                }
            }
        }

    }

}