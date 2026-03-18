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

public partial class BubbleInfo : System.Web.UI.Page
{
    protected int m_nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        try
        {
            m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            m_nInitiativeID = -1;
        }

        ReportsTableAdapters.spReport_BenefitVsSpend_InitiativeDetailsTableAdapter taInitiativeDetails =
                        new ReportsTableAdapters.spReport_BenefitVsSpend_InitiativeDetailsTableAdapter();

        Reports.spReport_BenefitVsSpend_InitiativeDetailsDataTable dtInitiative =
                                    taInitiativeDetails.GetData(m_nInitiativeID);

        if (dtInitiative.Rows.Count > 0)
        {
            Reports.spReport_BenefitVsSpend_InitiativeDetailsRow drInitiative =
                    (Reports.spReport_BenefitVsSpend_InitiativeDetailsRow) dtInitiative.Rows[0];

            lblImpactCategory.Text = drInitiative.ImpactCategory;
            lblIGIdentifier.Text = drInitiative.IGIdentifier;
            lblInitiativeName.Text = drInitiative.InitiativeName;
            lblTotalBenefit.Text = drInitiative.TotalBenefit.ToString("N2");
            lblTotalSpend.Text = drInitiative.TotalSpend.ToString("N2");
            lblROI.Text = (drInitiative.TotalSpend != 0 ? (drInitiative.TotalBenefit / drInitiative.TotalSpend).ToString("N2") : "0.00");
        }
    }
}
