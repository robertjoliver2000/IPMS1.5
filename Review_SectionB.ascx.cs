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

    public partial class Review_SectionB : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        public int UpdateInitiative()
        {
            Review_SectionB_ProfitLossAnalysis ctlReview_SectionB_ProfitLossAnalysis = (Review_SectionB_ProfitLossAnalysis)FindControl("ctlReview_SectionB_ProfitLossAnalysis");
            ctlReview_SectionB_ProfitLossAnalysis.UpdateInitiative();

            Review_SectionB_BenefitsAnalysis ctlReview_SectionB_BenefitsAnalysis = (Review_SectionB_BenefitsAnalysis)FindControl("ctlReview_SectionB_BenefitsAnalysis");
            ctlReview_SectionB_BenefitsAnalysis.UpdateInitiative();

            Review_SectionB_SponsorAllocations ctlReview_SectionB_SponsorAllocations = (Review_SectionB_SponsorAllocations)FindControl("ctlReview_SectionB_SponsorAllocations");
            ctlReview_SectionB_SponsorAllocations.UpdateInitiative();

            return 1;
        }

    }
}
