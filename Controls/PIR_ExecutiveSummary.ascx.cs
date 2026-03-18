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
    public partial class PIR_ExecutiveSummary : System.Web.UI.UserControl
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


            lnkBusinessSponsorName.HRef = "#";
            lnkBusinessSponsorName.Attributes.Add("onclick",
                                            "javascript:popupWindowSelectItem(1,'" +
                                                        txtBusinessSponsorName.ClientID + "','" +
                                                        hBusinessSponsorID.ClientID + "'); " +
                                                        "return false;"
                                                        );


            txtBusinessSponsorName.Attributes.Add("onfocus", "parent.focus();");


            lnkGTOInitiativeManager.HRef = "#";
            lnkGTOInitiativeManager.Attributes.Add("onclick",
                                                        "javascript:popupWindowSelectItem(1,'" +
                                                        txtGTOInitiativeManager.ClientID + "','" +
                                                        hGTOInitiativeManagerID.ClientID + "'); " +
                                                        "return false;"
                                                        );

            txtGTOInitiativeManager.Attributes.Add("onfocus", "parent.focus();");


            lnkPIRStartDate.HRef = "#";
            lnkPIRStartDate.Attributes.Add("onclick",
                                        "javascript:popupWindowDatePicker('" + txtPIRStartDate.ClientID + "');" +
                                        "return false;"
                                      );

            lnkPIREndDate.HRef = "#";
            lnkPIREndDate.Attributes.Add("onclick",
                                        "javascript:popupWindowDatePicker('" + txtPIREndDate.ClientID + "');" +
                                        "return false;"
                                      );

            if (!Page.IsPostBack)
            {
                FillDropDowns();

                LoadInitiative();
            }

        }

        private void FillDropDowns()
        {
            DataSet dsImpactCategory = Global_DB.GetReferenceTable(8);

            ddlImpactCategory.DataSource = dsImpactCategory.Tables["Reference"];
            ddlImpactCategory.DataValueField = "ReferenceID";
            ddlImpactCategory.DataTextField = "Description";

            ddlImpactCategory.DataBind();

        }

        private void LoadInitiative()
        {
            DataRow drInitiative = PIR_ExecutiveSummary_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                txtName.Text = drInitiative["Name"].ToString();

                txtBusinessSponsorName.Text = drInitiative["BusinessSponsorName"].ToString();
                hBusinessSponsorID.Value = drInitiative["BusinessSponsorID"].ToString();

                txtGTOInitiativeManager.Text = drInitiative["GTOInitiativeManager"].ToString();
                hGTOInitiativeManagerID.Value = drInitiative["GTOInitiativeManagerID"].ToString();

                ddlImpactCategory.SelectedValue = drInitiative["InitiativeImpactCategoryID"].ToString();

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

                txtPPRComments.Text = drInitiative[ "PPR_Comments" ].ToString();

                txtInitiativeBusinessDrivers.Text = drInitiative["InitiativeBusinessDrivers"].ToString();
                txtInitiativeScopeAndObjectives.Text = drInitiative["InitiativeScopeAndObjectives"].ToString();
                txtInitiativeBenefitCalculation.Text = drInitiative["InitiativeBenefitCalculation"].ToString();

                txtPIRSuccesses.Text = drInitiative["PIRSuccesses"].ToString();
                txtPIRIssues.Text = drInitiative["PIRIssues"].ToString();

            }
        }

        public int UpdateInitiative()
        {
            int intReturnValue = -1;

            if (nInitiativeID > 0)
            {
                intReturnValue = PIR_ExecutiveSummary_DB.UpdateInitiative(
                                        nInitiativeID,
                                        txtBusinessSponsorName.Text,
                                        hBusinessSponsorID.Value != String.Empty ? Int32.Parse(hBusinessSponsorID.Value) : 0,
                                        txtGTOInitiativeManager.Text,
                                        hGTOInitiativeManagerID.Value != String.Empty ? Int32.Parse(hGTOInitiativeManagerID.Value) : 0,
                                        ddlImpactCategory.SelectedItem.Text,
                                        Convert.ToInt32(ddlImpactCategory.SelectedValue),
                                        (txtPIRStartDate.Text != String.Empty) ? (object)DateTime.Parse(txtPIRStartDate.Text) : DBNull.Value,
                                        (txtPIREndDate.Text != String.Empty) ? (object)DateTime.Parse(txtPIREndDate.Text) : DBNull.Value,
                                        // Rev 2.1.7, GMcF, 2008-05-20, for Phase 2.1, Deliverable 7 - Performance Status Capture - Overall Status save now being done at same time as PIR Key Metrics
                                        //sddlPIRStatus.Text,
                                        //Convert.ToInt32(sddlPIRStatus.SelectedValue),
                                        // End of Rev 2.1.7
                                        txtInitiativeBusinessDrivers.Text,
                                        txtInitiativeScopeAndObjectives.Text,
                                        txtInitiativeBenefitCalculation.Text,
                                        txtPIRSuccesses.Text,
                                        txtPIRIssues.Text
                                        ,txtPPRComments.Text    // Added 2008-05-30, GMcF, for OTA 582 - PPR Comments
                                        );
            }

            return intReturnValue;
        }

    }
}