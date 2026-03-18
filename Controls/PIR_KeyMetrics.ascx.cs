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

namespace ProjectPortfolio.Controls
{
    public partial class PIR_KeyMetrics : System.Web.UI.UserControl
    {
        protected int nInitiativeID = -1;

        protected void Page_Load(object sender, EventArgs e)
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


            // Rev 2.1.7, GMcF, 2008-05-22

            // set up automatic recalc of overall status
            string PPRStatusClientIDs = "";

            foreach (string statusCtlName in new string[] { "sddlSpend", "sddlDelivery", "sddlTime", "sddlRiskMan", "sddlImpact" })
            {
                if ( PPRStatusClientIDs != string.Empty ) { PPRStatusClientIDs += " "; }

                PPRStatusClientIDs += FindControl( statusCtlName ).ClientID + "_ddl";
            }

            // Note on the Overall Status the ids of the individual PPR Status controls and the Overall Status ID control
            txtOverallStatus.Attributes.Add( "PprStatusClientIds", PPRStatusClientIDs );
            txtOverallStatus.Attributes.Add( "OverallStatusIdClientId", txtOverallStatusID.ClientID );

            // To each of the PPR Status controls (apart from the overall one), add an event handler to do the overall status recalc
            string strAddPPRStatusEventHandlers =
                      "var Ids = '" + PPRStatusClientIDs + "';\n"
                    + "var IdArray = Ids.split( ' ' );\n"
                    + "for ( var i = 0; i < IdArray.length; i++ )\n"
                    + "{\n"
                    //+ " window.alert( 'DEBUG: IdArray[ ' + i + ' ]: \"' + IdArray[ i ] + '\"' ); "
                    + "	Events_chainEvent( document.getElementById( IdArray[ i ] ), 'onchange', 'recalcPPROverallStatus( \"" + txtOverallStatus.ClientID + "\" )' );\n"
                    + "}";

            Page.ClientScript.RegisterStartupScript( Page.GetType(), "PPRStatusHandlers", strAddPPRStatusEventHandlers, true );

            // End of Rev 2.1.7

        }

        private void LoadInitiative()
        {
            DataRow drInitiative = PIR_KeyMetrics_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                sddlSpend.SelectedValue = drInitiative["PIRKeyMetricSpendStatusID"].ToString();
                sddlDelivery.SelectedValue = drInitiative["PIRKeyMetricDeliveryStatusID"].ToString();
                sddlTime.SelectedValue = drInitiative["PIRKeyMetricTimeStatusID"].ToString();           // Rev 2.1.7, GMcF, 2008-05-06
                sddlImpact.SelectedValue = drInitiative["PIRKeyMetricImpactStatusID"].ToString();
                sddlScope.SelectedValue = drInitiative["PIRKeyMetricScopeStatusID"].ToString();
                sddlProjMan.SelectedValue = drInitiative["PIRKeyMetricProjManStatusID"].ToString();
                sddlRiskMan.SelectedValue = drInitiative["PIRKeyMetricRiskManStatusID"].ToString();
                sddlAlpha.SelectedValue = drInitiative["PIRKeyMetricAlphaStatusID"].ToString();

                txtSpendComments.Text = drInitiative["PIRKeyMetricSpendComments"].ToString();
                txtDeliveryComments.Text = drInitiative["PIRKeyMetricDeliveryComments"].ToString();
                txtTimeComments.Text = drInitiative["PIRKeyMetricTimeComments"].ToString();             // Rev 2.1.7, GMcF, 2008-05-06
                txtImpactComments.Text = drInitiative["PIRKeyMetricImpactComments"].ToString();
                txtScopeComments.Text = drInitiative["PIRKeyMetricScopeComments"].ToString();
                txtProjManComments.Text = drInitiative["PIRKeyMetricProjManComments"].ToString();
                txtRiskManComments.Text = drInitiative["PIRKeyMetricRiskManComments"].ToString();
                txtAlphaComments.Text = drInitiative["PIRKeyMetricAlphaComments"].ToString();

                // Rev 2.1.7, GMcF, 2008-05-22
                txtOverallStatus.Text = drInitiative[ "PIRStatus" ].ToString();
                txtOverallStatusID.Text = drInitiative[ "PIRStatusID" ].ToString();
                // End of Rev 2.1.7
            }

        }


        public int UpdateInitiative()
        {
            int intReturnValue = -1;

            if (nInitiativeID > 0)
            {
                intReturnValue = PIR_KeyMetrics_DB.UpdateInitiative(
                                        nInitiativeID,

                                        sddlSpend.Text,
                                        Int32.Parse(sddlSpend.SelectedValue),
                                        txtSpendComments.Text,

                                        sddlDelivery.Text,
                                        Int32.Parse(sddlDelivery.SelectedValue),
                                        txtDeliveryComments.Text,

                                        sddlTime.Text,
                                        Int32.Parse(sddlTime.SelectedValue),
                                        txtTimeComments.Text,

                                        sddlImpact.Text,
                                        Int32.Parse(sddlImpact.SelectedValue),
                                        txtImpactComments.Text,

                                        sddlScope.Text,
                                        Int32.Parse(sddlScope.SelectedValue),
                                        txtScopeComments.Text,

                                        sddlProjMan.Text,
                                        Int32.Parse(sddlProjMan.SelectedValue),
                                        txtProjManComments.Text,

                                        sddlRiskMan.Text,
                                        Int32.Parse(sddlRiskMan.SelectedValue),
                                        txtRiskManComments.Text,

                                        sddlAlpha.Text,
                                        Int32.Parse(sddlAlpha.SelectedValue),
                                        txtAlphaComments.Text

                                        // Rev 2.1.7, GMcF, 2008-05-20, for Phase 2.1, Deliverable 7 - Performance Status capture - overall status now saved at same time as key metrics
                                        ,
                                        txtOverallStatus.Text,
                                        Int32.Parse(txtOverallStatusID.Text)
                                        // end of Rev 2.1.7
                                        );
            }

            return intReturnValue;

        }

    }
}
