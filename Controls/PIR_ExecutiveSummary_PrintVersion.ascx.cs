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

namespace ProjectPortfolio.Controls
{
    public partial class PIR_ExecutiveSummary_PrintVersion : System.Web.UI.UserControl
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

            if (!Page.IsPostBack)
            {
                LoadInitiative();
            }

        }

        private void LoadInitiative()
        {
            DataRow drInitiative = PIR_ExecutiveSummary_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                txtName.Text = drInitiative["Name"].ToString();

                txtBusinessSponsorName.Text = drInitiative["BusinessSponsorName"].ToString();

                txtGTOInitiativeManager.Text = drInitiative["GTOInitiativeManager"].ToString();

                ddlImpactCategory.Text = drInitiative["InitiativeImpactCategory"].ToString();

                txtPIRStartDate.Text = (drInitiative["PIRStartDate"] != DBNull.Value) ? ((DateTime)drInitiative["PIRStartDate"]).ToShortDateString() : "";
                txtPIREndDate.Text = (drInitiative["PIREndDate"] != DBNull.Value) ? ((DateTime)drInitiative["PIREndDate"]).ToShortDateString() : "";

                Decimal decSpendPlanned = (drInitiative["SpendPlanned"] != DBNull.Value) ? (Decimal)drInitiative["SpendPlanned"] : 0m;
                Decimal decSpendActual = (drInitiative["SpendActual"] != DBNull.Value) ? (Decimal)drInitiative["SpendActual"] : 0m;
                Decimal decBenefitActual = (drInitiative["BenefitActual"] != DBNull.Value) ? (Decimal)drInitiative["BenefitActual"] : 0m;

                lblSpendPlanned.Text = "&euro; " + decSpendPlanned.ToString("0.00");
                lblSpendActual.Text = "&euro; " + decSpendActual.ToString("0.00");
                lblSpendVariance.Text = (decSpendPlanned == 0m ? 0m : 100m * (decSpendActual / decSpendPlanned) - 100m).ToString("0") + "%";
                lblROI.Text = ((decSpendActual != 0m) ? (decBenefitActual / decSpendActual) : 0m).ToString("0.00");

                sddlPIRStatus.SelectedValue = drInitiative["PIRStatusID"].ToString();

                txtPPRComments.Text = Global.TextToHTML( drInitiative[ "PPR_Comments" ].ToString() );    // Added 2008-06-02, GMcF, for OTA 582 - Handling of PPR Comments

                txtInitiativeBusinessDrivers.Text = Global.TextToHTML(drInitiative["InitiativeBusinessDrivers"].ToString());
                txtInitiativeScopeAndObjectives.Text = Global.TextToHTML(drInitiative["InitiativeScopeAndObjectives"].ToString());
                txtInitiativeBenefitCalculation.Text = Global.TextToHTML(drInitiative["InitiativeBenefitCalculation"].ToString());

                txtPIRSuccesses.Text = Global.TextToHTML(drInitiative["PIRSuccesses"].ToString());
                txtPIRIssues.Text = Global.TextToHTML(drInitiative["PIRIssues"].ToString());

            }

        }

    }
}