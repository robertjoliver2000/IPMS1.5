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

namespace ProjectPortfolio.Controls
{
    public partial class PIR_Summary : System.Web.UI.UserControl
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

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CoverDisabledStatusDdls", "coverDisabledStatusDdls();", true);


            // Rev 2.1.7, GMcF, 2008-05-22, Phase 2.1, Deliverable 7 - Performance Status capture
            TextBox txtHiddenPPROverall = (TextBox)this.FindControl( "ctlPIR_KeyMetrics" ).FindControl( "txtOverallStatus" );

            string strKeyMetricsOverallStatusClientId = txtHiddenPPROverall.ClientID;

            string strExecSummaryOverallStatusClientId = this.FindControl( "ctlPIR_ExecutiveSummary" ).FindControl( "sddlPIRStatus" ).ClientID + "_ddl";

            txtHiddenPPROverall.Attributes.Add( "ExecSummaryOverallStatusClientId", strExecSummaryOverallStatusClientId );

            string strUpdatePprOverallStatus = "Events_chainEvent( "
                                            + "document.getElementById( '" + strExecSummaryOverallStatusClientId + "' ), "
                                            + "'onclick',"
                                            + "'updatePprOverallStatus( this, \\\'" + strKeyMetricsOverallStatusClientId + "\\\' );' );";

            Page.ClientScript.RegisterStartupScript( Page.GetType(), "UpdatePprOverallStatus", strUpdatePprOverallStatus, true );
            // End of Rev 2.1.7

        }


        public int UpdateInitiative()
        {
            int intReturnValue = -1;

            if (nInitiativeID > 0)
            {
                Control ctl;

                ctl = this.FindControl("ctlPIR_ExecutiveSummary");
                intReturnValue = ((ProjectPortfolio.Controls.PIR_ExecutiveSummary)ctl).UpdateInitiative();

                ctl = this.FindControl("ctlPIR_KeyMetrics");
                intReturnValue = ((ProjectPortfolio.Controls.PIR_KeyMetrics)ctl).UpdateInitiative();

                ctl = this.FindControl("ctlPIR_FinancialsAndDelivery");
                intReturnValue = ((ProjectPortfolio.Controls.PIR_FinancialsAndDelivery)ctl).UpdateInitiative();

            }

            return intReturnValue;
        }

}

}