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
    public partial class PIR_FinancialComments_PrintVersion : System.Web.UI.UserControl
    {
        protected int m_nInitiativeID = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                m_nInitiativeID = -1;
            }

            LoadInitiative();
        }

        private void LoadInitiative()
        {
            DataRow drInitiative = PIR_FinancialComments_DB.GetInitiativeDetails(m_nInitiativeID);

            try
            {
                txtPIRFinancialComments.Text = Global.TextToHTML(drInitiative["PIRFinancialComments"].ToString());
                if ( txtPIRFinancialComments.Text == string.Empty) txtPIRFinancialComments.Text = "&nbsp;";
            }
            catch (Exception)
            {
                // do nothing
            }
        }

    }
}
