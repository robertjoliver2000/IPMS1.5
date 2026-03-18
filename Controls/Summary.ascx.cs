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

public partial class Controls_Summary : System.Web.UI.UserControl
{
    protected int m_nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["section"] != String.Empty && Request.QueryString["section"] != null)
        {
            if (Request.QueryString["InitiativeID"] == String.Empty || Request.QueryString["InitiativeID"] == null)
            {
                Response.Redirect("~/default.aspx");
            }

            try
            {
                m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (FormatException)
            {
                m_nInitiativeID = -1;
            }

            if (m_nInitiativeID < 0)
            {
                Response.Redirect("~/default.aspx");
            }
        }
    }


    public void UpdateInitiative()
    {
        SectionA ctlSectionA = (SectionA)FindControl("ctlSectionA");
        ctlSectionA.UpdateInitiative();

        SectionB ctlSectionB = (SectionB)FindControl("ctlSectionB");
        ctlSectionB.UpdateInitiative();
    }

}

