
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

    public partial class Controls_WorkflowAction : System.Web.UI.UserControl
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

            SectionB ctlSectionB = (SectionB)FindControl("ctlSectionB");
            ctlSectionB.UpdateInitiative();

            SectionC ctlSectionC = (SectionC)FindControl("ctlSectionC");
            ctlSectionC.UpdateInitiative();

            SectionD ctlSectionD = (SectionD)FindControl("ctlSectionD");
            ctlSectionD.UpdateInitiative();

            SectionE ctlSectionE = (SectionE)FindControl("ctlSectionE");
            ctlSectionE.UpdateInitiative();

            SectionF ctlSectionF = (SectionF)FindControl("ctlSectionF");
            ctlSectionF.UpdateInitiative();

            SectionG ctlSectionG = (SectionG)FindControl("ctlSectionG");
            ctlSectionG.UpdateInitiative();

            SectionH ctlSectionH = (SectionH)FindControl("ctlSectionH");
            ctlSectionH.UpdateInitiative();

            SectionI ctlSectionI = (SectionI)FindControl("ctlSectionI");
            ctlSectionI.UpdateInitiative();
        }
    }

}