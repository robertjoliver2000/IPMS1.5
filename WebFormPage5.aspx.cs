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

public partial class WebFormPage5 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    protected void btnUpdate_Click(object sender, System.EventArgs e)
    {
        SectionF ctlSectionF = (SectionF)FindControl("ctlSectionF");
        ctlSectionF.UpdateInitiative();

        
        SectionH ctlSectionH = (SectionH)FindControl("ctlSectionH");
        ctlSectionH.UpdateInitiative();

        SectionG ctlSectionG = (SectionG)FindControl("ctlSectionG");
        ctlSectionG.UpdateInitiative();

    }
}
