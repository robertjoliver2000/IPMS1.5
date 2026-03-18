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

public partial class Financial_Printing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int m_nInitiativeID, m_nPreviousVersion_InitiativeID;

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
            //This is a review
            Control ctlFinancial = Page.LoadControl("Controls/Review_Financial_PrintVersion.ascx");
            ctlFinancial.ID = "ctlReview_Financial_PrintVersion";
            ctlPlaceHolder.Controls.Add(ctlFinancial);

        }
        else
        {
            //This is a summary
            Control ctlFinancial = Page.LoadControl("Controls/Financial_PrintVersion.ascx");
            ctlFinancial.ID = "ctlFinancial_PrintVersion";
            ctlPlaceHolder.Controls.Add(ctlFinancial);
        }
    }
}
