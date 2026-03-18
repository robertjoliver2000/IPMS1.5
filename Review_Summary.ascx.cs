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

public partial class Controls_Review_Summary : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void UpdateInitiative()
    {
        SectionA ctlSectionA = (SectionA)FindControl("ctlSectionA");
        ctlSectionA.UpdateInitiative();

        Review_SectionB ctlSectionB = (Review_SectionB)FindControl("ctlReview_SectionB");
        ctlSectionB.UpdateInitiative();
    }

}
