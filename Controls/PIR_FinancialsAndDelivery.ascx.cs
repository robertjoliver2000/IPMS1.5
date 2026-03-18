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
    public partial class PIR_FinancialsAndDelivery : System.Web.UI.UserControl
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

        }


        public int UpdateInitiative()
        {
            int intReturnValue = -1;

            if (nInitiativeID > 0)
            {
                Control ctl;

                ctl = this.FindControl("ctlPIR_FinancialComments");
                intReturnValue = ((ProjectPortfolio.Controls.PIR_FinancialComments)ctl).UpdateInitiative();

                ctl = this.FindControl("ctlSectionb_sponsorallocations");
                intReturnValue = ((ProjectPortfolio.Controls.SectionB_SponsorAllocations)ctl).UpdateInitiative();

            }

            return intReturnValue;
        }


    }

}
