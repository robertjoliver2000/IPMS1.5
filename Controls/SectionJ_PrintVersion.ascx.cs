//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.4       CA          07/02/2007     New Dynamic Header for Date
//                                              
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

public partial class SectionJ_PrintVersion : System.Web.UI.UserControl
{
    protected int nInitiativeID;

    //rev 1.1.4 CA
    string dInitiativeYear;
    //end rev

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

        if (!Page.IsPostBack)
        {
            //LoadInitiative();
        }

        //rev 1.1.4
        DataRow drInitiative = SectionJ_DB.GetInitiativeDetails(nInitiativeID);

        dInitiativeYear = drInitiative["SubmissionDate"].ToString();
        dInitiativeYear = dInitiativeYear.Substring(8, 2);
        //end rev

        BindRepeater();

    }

    public void BindRepeater()
    {
        repeaterProject.DataSource = SectionJ_DB.GetProjects(nInitiativeID);
        repeaterProject.DataBind();
    }


    public string GetIGAmountRequested()
    {
        decimal amount = SectionJ_DB.GetProjecTotals(nInitiativeID, "IGAmount");
        return amount.ToString("C");
    }

    public string GetTotalPlan()
    {
        decimal amount = SectionJ_DB.GetProjecTotals(nInitiativeID, "TotalPlan");
        return amount.ToString("C");
    }

    protected void repeaterProject_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
         //items
        //rem CA
        //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Header)
        //end rem

        //rev 1.1.4 CA
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Header)
        //end rev
        {
            ImageButton imgButt = (ImageButton)e.Item.FindControl("delProjectID");
            if (imgButt != null)
                imgButt.Attributes.Add("onClick", "javascript:return confirm('Are you sure you wish to delete this project?')");

            //rev 1.1.4 CA
            Label lblProjectID = (Label)e.Item.FindControl("lblProjectID");

            if (lblProjectID != null)
            {
                lblProjectID.Text = "Project ID";
            }

            Label lblProjectName = (Label)e.Item.FindControl("lblProjectName");

            if (lblProjectName != null)
            {
                lblProjectName.Text = "Project Name";
            }

            Label lblProjectDesc = (Label)e.Item.FindControl("lblProjectDesc");

            if (lblProjectDesc != null)
            {
                lblProjectDesc.Text = "Project Description";
            }

            Label lblProgramName = (Label)e.Item.FindControl("lblProgramName");

            if (lblProgramName != null)
            {
                lblProgramName.Text = "Program Name";
            }

            Label lblProjectType = (Label)e.Item.FindControl("lblProjectType");

            if (lblProjectType != null)
            {
                lblProjectType.Text = "Project Type";
            }

            Label lblIGAmount = (Label)e.Item.FindControl("lblIGAmount");

            if (lblIGAmount != null)
            {
                lblIGAmount.Text = "IG Amount Requested";
            }

            Label lblTotalEUR = (Label)e.Item.FindControl("lblTotalEUR");

            if (lblTotalEUR != null)
            {
                lblTotalEUR.Text = "Total Plan " + dInitiativeYear + " in EUR as per BEN 'PROVIDER VIEW'";
            }

            Label lblIGApproval = (Label)e.Item.FindControl("lblIGApproval");

            if (lblIGApproval != null)
            {
                lblIGApproval.Text = "If partial IG Approval is requested, % required";
            }

            Label lblTotalLocal = (Label)e.Item.FindControl("lblTotalLocal");

            if (lblTotalLocal != null)
            {
                lblTotalLocal.Text = "Total Plan " + dInitiativeYear + " in Local Currency as per BEN 'PROVIDER VIEW'";
            }

            Label lblBaseCurrency = (Label)e.Item.FindControl("lblBaseCurrency");

            if (lblBaseCurrency != null)
            {
                lblBaseCurrency.Text = "Base Currency as per BEN 'PROVIDER VIEW'";
            }

            Label lblFXRate = (Label)e.Item.FindControl("lblFXRate");

            if (lblFXRate != null)
            {
                lblFXRate.Text = "FX Rate used (for non - EURO projects)";
            }
            //end rev 
        }

    }

}
