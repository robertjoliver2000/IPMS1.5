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

public partial class Controls_SectionB_ProgramDeliverables : System.Web.UI.UserControl
{
    protected int nInitiativeID;
    
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

        btnAddDeliverable.Attributes.Add("onclick", "javascript:popupWindowAddDeliverable(" + nInitiativeID.ToString() + ")");
        
        LoadDeliverables(nInitiativeID);
    }


    protected void LoadDeliverables(int nInitiativeID)
    {
        DataSet dsDeliverables = SectionB_ProgramDeliverables_DB.GetProgramDeliverables(nInitiativeID);

        rptProgramDeliverables.DataSource = dsDeliverables.Tables["Deliverable"];
        rptProgramDeliverables.DataBind();
    }


    protected void rptProgramDeliverables_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Footer)
        {
            object objTotalCost = ((DataTable)rptProgramDeliverables.DataSource).Compute("SUM(Cost)", "");
            
            HtmlTableCell tdTotalCost = (HtmlTableCell)e.Item.FindControl("tdTotalCost");
            tdTotalCost.InnerText = (objTotalCost != DBNull.Value) ? ((Decimal)objTotalCost).ToString("N2") : "";
        }


        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (DataBinder.Eval(e.Item.DataItem, "DeliverableID") == DBNull.Value)
            {
                HtmlTableCell tdName = (HtmlTableCell)e.Item.FindControl("tdName");
                tdName.InnerText = "No records";
            }
            else
            {
                ImageButton imgDelete = (ImageButton)e.Item.FindControl("imgDelete");
                imgDelete.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this deliverable?')) AllowOneTimeSubmit(); else return false;");
            }
        }
    }


    protected void rptProgramDeliverables_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Delete":

                if (e.CommandArgument != null && e.CommandArgument != String.Empty)
                {
                    int intDeliverableID = Int32.Parse(e.CommandArgument.ToString());
                    SectionB_ProgramDeliverables_DB.DeleteDeliverable(nInitiativeID, intDeliverableID);
                }

                LoadDeliverables(nInitiativeID);

                break;
        }
    }
}
