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

    using ProjectPortfolio.Controls;

    public partial class Review_WorkflowAction : System.Web.UI.UserControl
    {
        public bool IsForReview
        {
            get
            {
                return ((section_status)FindControl("ctlSectionStatus")).IsForReview;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void UpdateInitiative()
        {
            SectionA ctlSectionA = (SectionA)FindControl("ctlSectionA");
            ctlSectionA.UpdateInitiative();

            Review_SectionB ctlReview_SectionB = (Review_SectionB)FindControl("ctlReview_SectionB");
            ctlReview_SectionB.UpdateInitiative();

            SectionC ctlSectionC = (SectionC)FindControl("ctlSectionC");
            ctlSectionC.UpdateInitiative();

            Review_SectionD ctlReview_SectionD = (Review_SectionD)FindControl("ctlReview_SectionD");
            ctlReview_SectionD.UpdateInitiative();

            SectionE ctlSectionE = (SectionE)FindControl("ctlSectionE");
            ctlSectionE.UpdateInitiative();

            Review_SectionF ctlReview_SectionF = (Review_SectionF)FindControl("ctlReview_SectionF");
            ctlReview_SectionF.UpdateInitiative();

        }
        protected void ctlSectionStatus_Load(object sender, EventArgs e)
        {

        }
}
}
