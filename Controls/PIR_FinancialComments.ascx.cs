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
    public partial class PIR_FinancialComments : System.Web.UI.UserControl
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
                txtPIRFinancialComments.Text = drInitiative["PIRFinancialComments"].ToString();
            }
            catch (Exception)
            {
                // do nothing
            }
        }

        public int UpdateInitiative()
        {
            int intReturnValue = -1;


            if (m_nInitiativeID > 0)
            {
                intReturnValue = PIR_FinancialComments_DB.UpdateInitiative(
                                            m_nInitiativeID, txtPIRFinancialComments.Text
                                        );
            }

            return intReturnValue;
        }

    }
}
