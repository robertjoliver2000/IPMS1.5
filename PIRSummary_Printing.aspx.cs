/* ****************************************************************************************************
 * 
 *      Rev         By          Date            Description
 * 
 *      1.9.9       GMcF        03/03/2008      Re-wrote Page_Load() to force page breaks
 *      1.9.11      GMcF        07/03/2008      Put Exec Summ and Key Metrics into same page
 *                                              Put on page header and footer images here rather than in
 *                                              individual print controls.
 *
 * **************************************************************************************************** */

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

namespace ProjectPortfolio
{
    public partial class PIRSummary_Printing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int m_nInitiativeID;
            Control ctl;
            //Control ctl2 = null;

            try
            {
                m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);

                lblHeaderText.Text = Global_DB.GetInitiativeName(m_nInitiativeID);

                switch ( Request["Page"] )
                {
                    case "1":
                        ctl = Page.LoadControl("Controls/PIR_ExecutiveSummary_PrintVersion.ascx");
                        break;

                    case "2":
                        //ctl2 = Page.LoadControl("Controls/PIR_KeyMetrics_PrintVersion.ascx");
                        ctl = Page.LoadControl("Controls/PIR_KeyMetrics_PrintVersion.ascx");
                        //ctl2.ID = "ctl2";
                        //Control ctl = Page.LoadControl("Controls/PIR_Deliverables_PrintVersion.ascx");
                        //Control ctl = Page.LoadControl("Controls/PIR_ScopeChanges_PrintVersion.ascx");
                        break;
                        
                    case "3":
                        ctl = Page.LoadControl("Controls/PIR_FinancialsAndDelivery_PrintVersion.ascx");
                        break;

                    default:
                        ctl = Page.LoadControl("Controls/PIR_Summary_PrintVersion.ascx");
                        break;
                }
                ctl.ID = "ctl";
                ctlPlaceHolder.Controls.Add(ctl);

                /*
                if (ctl2 != null)
                {
                    ctlPlaceHolder.Controls.Add(ctl2);
                }
                 */

            }
            catch
            {
                m_nInitiativeID = -1;
            }

        }

    }

}