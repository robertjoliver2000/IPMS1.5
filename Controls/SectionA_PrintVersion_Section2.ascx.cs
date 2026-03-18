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
using ProjectPortfolio;

public partial class Controls_SectionA_PrintVersion_Section2 : System.Web.UI.UserControl
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

        if (!Page.IsPostBack)
        {
            LoadInitiative();
        }
    }

    private void LoadInitiative()
    {
        DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

        if (drInitiative != null)
        {
            txtInitiativeBusinessDrivers.Text = Global.TextToHTML(drInitiative["InitiativeBusinessDrivers"].ToString());
            txtInitiativeScopeAndObjectives.Text = Global.TextToHTML(drInitiative["InitiativeScopeAndObjectives"].ToString());
            txtInitiativeBenefitCalculation.Text = Global.TextToHTML(drInitiative["InitiativeBenefitCalculation"].ToString());
            txtStrategicInitiativeInterfaces.Text = Global.TextToHTML(drInitiative["StrategicInitiativeInterfaces"].ToString());
            txtSmartsourcingComponent.Text = Global.TextToHTML(drInitiative["SmartsourcingComponent"].ToString());
            txtArchitecturalCompliance.Text = Global.TextToHTML(drInitiative["ArchitecturalCompliance"].ToString());
            ddlArchitecturalComplianceType.Text = Global.TextToHTML(drInitiative["ArchitecturalComplianceType"].ToString());
        }
    }
}
