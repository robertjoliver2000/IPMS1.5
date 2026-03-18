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

    public partial class Review_Financial : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void UpdateInitiative()
        {
            SectionC ctlSectionC = (SectionC)FindControl("ctlSectionC");
            ctlSectionC.UpdateInitiative();

            Review_SectionD ctlReview_SectionD = (Review_SectionD)FindControl("ctlReview_SectionD");
            ctlReview_SectionD.UpdateInitiative();
        }
    }
}
