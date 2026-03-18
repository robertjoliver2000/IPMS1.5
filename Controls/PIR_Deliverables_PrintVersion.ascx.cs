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

    public partial class PIR_Deliverables_PrintVersion : System.Web.UI.UserControl
    {
        protected int nInitiativeID = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                nInitiativeID = -1;
            }

            LoadDeliverables(nInitiativeID);
        }


        protected void LoadDeliverables(int nInitiativeID)
        {
            DataSet dsDeliverables = PIR_Deliverables_DB.GetPIRProgramDeliverables(nInitiativeID);

            rptProgramDeliverables.DataSource = dsDeliverables.Tables["Deliverable"];
            rptProgramDeliverables.DataBind();
        }


        protected void rptProgramDeliverables_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (DataBinder.Eval(e.Item.DataItem, "DeliverableID") == DBNull.Value)
                {
                    HtmlTableCell tdName = (HtmlTableCell)e.Item.FindControl("tdName");
                    tdName.InnerText = "No records";
                }
                else
                {
                    HtmlTableCell tdStatus = (HtmlTableCell)e.Item.FindControl("tdStatus");
                    switch (DataBinder.Eval(e.Item.DataItem, "PIRStatus").ToString().ToLower())
                    {
                        case "red": tdStatus.Style["background-color"] = "red"; break;
                        case "amber": tdStatus.Style["background-color"] = "orange"; break;
                        case "green": tdStatus.Style["background-color"] = "green"; break;
                        default: tdStatus.Style["background-color"] = "inherit"; break;
                    }
                }
            }
        }

    }

}