namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using ProjectPortfolio.Classes;

    using ProjectPortfolio;

	/// <summary>
	///		Summary description for SectionA.
	/// </summary>
    /// 

	public partial class SectionA_PrintVersion : System.Web.UI.UserControl
	{
        protected int nInitiativeID;

		protected void Page_Load(object sender, System.EventArgs e)
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
                txtLargeName.Text = "IPMS - " + drInitiative["IGBusinessAreaCode"].ToString() + "-" +
                                drInitiative["IGIdentifierCode"].ToString() + "-" +
                                drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0') + ": " +
                                "Initiative " + drInitiative["Name"].ToString();

				//txtName.Text = drInitiative["Name"].ToString();       // Taken out 2008-06-02, GMcF, for Phase 2.1, Deliverable 7 - Summary Screen - Performance Status capture

                //Added 2008-06-02, GMcF, for Phase 2.1, Deliverable 7 - Summary Screen - Performance Status capture
                imgPPROverall.Src = "../" + Global.PPRStatusImageFromId( drInitiative[ "PPR_OverallStatusID" ].ToString() );
                imgPPRCost.Src = "../" + Global.PPRStatusImageFromId( drInitiative[ "PPR_CostStatusID" ].ToString() );
                imgPPRDeliverables.Src = "../" + Global.PPRStatusImageFromId( drInitiative[ "PPR_DeliverablesStatusId" ].ToString() );
                imgPPRTime.Src = "../" + Global.PPRStatusImageFromId( drInitiative[ "PPR_TimeStatusID" ].ToString() );
                imgPPRRisks.Src = "../" + Global.PPRStatusImageFromId( drInitiative[ "PPR_RisksStatusId" ].ToString() );
                imgPPRBenefits.Src = "../" + Global.PPRStatusImageFromId( drInitiative[ "PPR_BenefitsStatusId" ].ToString() );
                // End of code added 2008-06-02

                txtPPRComments.Text = Global.TextToHTML( drInitiative[ "PPR_Comments" ].ToString() );    // Added 2008-06-02, GMcF, for OTA 582 - Handling of PPR Comments

                ddlInvestmentTier.Text = drInitiative["InvestmentTier"].ToString();

				txtPrimarySponsoringArea.Text = drInitiative["PrimarySponsoringArea"].ToString();

                txtOtherSponsoringAreas.Text = drInitiative["OtherSponsoringAreas"].ToString();
                if ( txtOtherSponsoringAreas.Text.Length == 0 )
                    txtOtherSponsoringAreas.Text = "&nbsp;";

                txtBusinessSponsorName.Text = drInitiative["BusinessSponsorName"].ToString();

                txtBusinessInitiativeManager.Text = drInitiative["BusinessInitiativeManager"].ToString();

                ddlRegion.Text = drInitiative["Region"].ToString();

                txtGTOManagingBusinessArea.Text = drInitiative["GTOManagingBusinessArea"].ToString();

                txtGTOInitiativeManager.Text = drInitiative["GTOInitiativeManager"].ToString();

                ddlFunctionalDomain.Text = drInitiative["FunctionalDomain"].ToString();

                ddlSecondaryFunctionalDomain.Text = drInitiative["SecondaryFunctionalDomain"].ToString();

                ddlTechnologyFunction.Text = drInitiative["TechnologyFunction"].ToString();

                txtMajorApplicationName.Text = drInitiative["MajorApplicationName"].ToString();

                txtMajorApplicationInvestmentStrategy.Text = drInitiative["MajorApplicationInvestmentStrategy"].ToString();
			}
		}
	}
}
