/*
 *  Rev         By          Date            Description
 * 
 *  1.8.2       GMcF        2007-10-06      Added for Detailed Functional Domains
 * 
 */

namespace ProjectPortfolio.Controls
{
    using System;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using Classes;


    public partial class SectionE_PrintVersion : System.Web.UI.UserControl
    {
        protected int nInitiativeID;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            try
            {
                nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                nInitiativeID = -1;
            }

            if (!Page.IsPostBack)
            {
                LoadInitiative();
            }

            BindAppRepeater();
            BindServerRepeater();
            BindDFDRepeater();
        }


        protected void BindAppRepeater()
        {
            repeaterApp.DataSource = SectionE_DB.GetApplications(nInitiativeID);
            repeaterApp.DataBind();
        }


        protected void BindServerRepeater()
        {
            repeaterServer.DataSource = SectionE_DB.GetServers(nInitiativeID);
            repeaterServer.DataBind();
        }


        // Rev 1.8.2 GMcF
        protected void BindDFDRepeater()
        {
            repeaterDFD.DataSource = SectionE_DB.GetDetailedFunctionalDomains(nInitiativeID);
            repeaterDFD.DataBind();
        }
        // End Rev 1.8.2

        
        private void LoadInitiative()
        {

            DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                txtImpact.Text = Global.TextToHTML(drInitiative["ImpactOfNotDoingThisInvestment"].ToString());
                txtShutDownComments.Text = Global.TextToHTML(drInitiative["ShutdownComments"].ToString());
                txtKeyPerformance.Text = Global.TextToHTML(drInitiative["KeyPerformanceIndicators"].ToString());
            }
        }

    }
}
