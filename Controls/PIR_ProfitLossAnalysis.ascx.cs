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

using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

using ProjectPortfolio.Classes;

namespace ProjectPortfolio.Controls
{
    public partial class PIR_ProfitLossAnalysis : System.Web.UI.UserControl
    {
        protected int m_nInitiativeID = -1;
        protected int m_nEarliest_InitiativeID = -1;

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

            /*

            m_nEarliest_InitiativeID = Global_DB.GetEarliestVersionInitiativeID(m_nInitiativeID);

            hiddenCurrentInitiativeID.Value = m_nInitiativeID.ToString();
            hiddenEarliestInitiativeID.Value = m_nEarliest_InitiativeID.ToString();
            ReportParameter[] reportParams = { new ReportParameter("Previous_Review_Label", "Original - Benefit/Cost Analysis") };
            reportViewerProfitLossAnalysis.LocalReport.SetParameters(reportParams);

            */
        }

    }
}
