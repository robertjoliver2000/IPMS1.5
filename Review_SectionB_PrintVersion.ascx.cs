namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;


    public partial class Review_SectionB_PrintVersion : System.Web.UI.UserControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
		}

		public int UpdateInitiative()
		{
			SectionB_BenefitsAnalysis ctlSectionB_BenefitsAnalysis = (SectionB_BenefitsAnalysis)FindControl("ctlSectionB_BenefitsAnalysis");
			ctlSectionB_BenefitsAnalysis.UpdateInitiative();

			SectionB_SponsorAllocations ctlSectionB_SponsorAllocations = (SectionB_SponsorAllocations)FindControl("ctlSectionB_SponsorAllocations");
			ctlSectionB_SponsorAllocations.UpdateInitiative();

			return 1;
		}

	}
}
