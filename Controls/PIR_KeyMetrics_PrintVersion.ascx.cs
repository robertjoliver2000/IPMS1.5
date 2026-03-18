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
    public partial class PIR_KeyMetrics_PrintVersion : System.Web.UI.UserControl
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

        }

        private void LoadInitiative()
        {
            DataRow drInitiative = PIR_KeyMetrics_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                sddlSpend.SelectedValue = drInitiative["PIRKeyMetricSpendStatusID"].ToString();
                sddlDelivery.SelectedValue = drInitiative["PIRKeyMetricDeliveryStatusID"].ToString();
                sddlImpact.SelectedValue = drInitiative["PIRKeyMetricImpactStatusID"].ToString();
                sddlScope.SelectedValue = drInitiative["PIRKeyMetricScopeStatusID"].ToString();
                sddlProjMan.SelectedValue = drInitiative["PIRKeyMetricProjManStatusID"].ToString();
                sddlRiskMan.SelectedValue = drInitiative["PIRKeyMetricRiskManStatusID"].ToString();
                sddlAlpha.SelectedValue = drInitiative["PIRKeyMetricAlphaStatusID"].ToString();
                sddlTime.SelectedValue = drInitiative[ "PIRKeyMetricTimeStatusID" ].ToString();

                txtSpendComments.Text = Global.TextToHTML(drInitiative["PIRKeyMetricSpendComments"].ToString());
                txtDeliveryComments.Text = Global.TextToHTML(drInitiative["PIRKeyMetricDeliveryComments"].ToString());
                txtImpactComments.Text = Global.TextToHTML(drInitiative["PIRKeyMetricImpactComments"].ToString());
                txtScopeComments.Text = Global.TextToHTML(drInitiative["PIRKeyMetricScopeComments"].ToString());
                txtProjManComments.Text = Global.TextToHTML(drInitiative["PIRKeyMetricProjManComments"].ToString());
                txtRiskManComments.Text = Global.TextToHTML(drInitiative["PIRKeyMetricRiskManComments"].ToString());
                txtAlphaComments.Text = Global.TextToHTML(drInitiative["PIRKeyMetricAlphaComments"].ToString());
                txtTimeComments.Text = Global.TextToHTML( drInitiative[ "PIRKeyMetricTimeComments" ].ToString() );

                if (txtSpendComments.Text == String.Empty) txtSpendComments.Text = "&nbsp;";
                if (txtDeliveryComments.Text == String.Empty) txtDeliveryComments.Text = "&nbsp;"; 
                if (txtImpactComments.Text == String.Empty) txtImpactComments.Text = "&nbsp;"; 
                if (txtScopeComments.Text == String.Empty) txtScopeComments.Text = "&nbsp;"; 
                if (txtProjManComments.Text == String.Empty) txtProjManComments.Text = "&nbsp;"; 
                if (txtRiskManComments.Text == String.Empty) txtRiskManComments.Text = "&nbsp;"; 
                if (txtAlphaComments.Text == String.Empty) txtAlphaComments.Text = "&nbsp;";
                if ( txtTimeComments.Text == string.Empty ) txtTimeComments.Text = "&nbsp;";
            }

        }

    }

}
