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

using ProjectPortfolio.Classes;
using ProjectPortfolio.Controls;

public partial class ArchitectureAndRisk_Printing : System.Web.UI.Page
{
    protected int m_nInitiativeID;
    protected int m_nPreviousVersion_InitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch
        {
            m_nInitiativeID = -1;
        }

        m_nPreviousVersion_InitiativeID = Global_DB.GetPreviousVersionInitiativeID(m_nInitiativeID);

        if (m_nPreviousVersion_InitiativeID > 0)
        {
            Control ctlArchitectureAndRisk = Page.LoadControl("Controls/Review_ArchitectureAndRisk_PrintVersion.ascx");
            ctlArchitectureAndRisk.ID = "ctlReview_ArchitectureAndRisk";
            ctlPlaceHolder.Controls.Add(ctlArchitectureAndRisk);
        }
        else
        {
            Control ctlArchitectureAndRisk = Page.LoadControl("Controls/ArchitectureAndRisk_PrintVersion.ascx");
            ctlArchitectureAndRisk.ID = "ctlArchitectureAndRisk";
            ctlPlaceHolder.Controls.Add(ctlArchitectureAndRisk);
        }

    }
}
