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

public partial class Controls_ArchitectureAndRisk : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void UpdateInitiative()
    {
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
