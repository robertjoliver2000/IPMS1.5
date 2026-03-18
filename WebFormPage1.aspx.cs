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

public partial class WebFormPage1 : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnUpdate_Click(object sender, System.EventArgs e)
    {
        SectionA ctlSectionA = (SectionA)FindControl("ctlSectionA");
        ctlSectionA.UpdateInitiative();

        //SectionB ctlSectionB = (SectionB)FindControl("ctlSectionB");
        //ctlSectionB.UpdateInitiative();

        SectionB_BenefitsAnalysis ctlSectionB_BenefitsAnalysis = (SectionB_BenefitsAnalysis)FindControl("ctlSectionB_BenefitsAnalysis");
        ctlSectionB_BenefitsAnalysis.UpdateInitiative();

        SectionB_SponsorAllocations ctlSectionB_SponsorAllocations = (SectionB_SponsorAllocations)FindControl("ctlSectionB_SponsorAllocations");
        ctlSectionB_SponsorAllocations.UpdateInitiative();
    }

    protected void btnInsert_Click(object sender, System.EventArgs e)
    {
        int intInitiativeID;

        SectionA ctlSectionA = (SectionA)FindControl("ctlSectionA");
        intInitiativeID = ctlSectionA.InsertInitiative();
    }
}
