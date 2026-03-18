namespace ProjectPortfolio.Controls
{
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


    public partial class Review_SectionB_ProfitLossAnalysis_PrintVersion : System.Web.UI.UserControl
	{
        private DataSet m_dsInitiativeValues;
        private DataSet m_dsPeriod;

        private int m_currentYear;

        private const string DefaultCellWidth = "50px";
        private const string Pre2006CellWidth = "55px";

        protected int m_nInitiativeID;
        protected int m_nPreviousVersion_InitiativeID;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            try
            {
                m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                m_nInitiativeID = -1;
            }

            m_nPreviousVersion_InitiativeID = Global_DB.GetPreviousVersionInitiativeID(m_nInitiativeID);

            LoadInitiative();

            tdCurrentYearBenefitsTitle.InnerText = m_currentYear.ToString() + " Benefits";
            tdCurrentYearSpendTitle.InnerText = m_currentYear.ToString() + " Spend";

            //m_dsPeriod = Global_DB.GetPeriods(m_nInitiativeID);
            m_dsPeriod = Global_DB.GetPeriodsForDisplay(m_nInitiativeID);
            m_dsInitiativeValues = SectionB_DB.GetInitiativeValues(m_nInitiativeID);

            DoFinancialAnalysis();
        }

        protected void DoFinancialAnalysis()
        {
            object objCurrentYearSpend, objCurrentYearBenefits, objCurrentYearTangible, objCurrentYearIntangible;
            object objTotalSpend, objTotalBenefits, objTotalTangible, objTotalIntangible;
            decimal dTotalBenefits, dTotalSpend, dROI;

            objCurrentYearSpend = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                        "(CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND " +
                                        "Period = '" + m_currentYear.ToString() + "'");

            objCurrentYearBenefits = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                        "(CategoryID=1) AND " +
                                        "Period = '" + m_currentYear.ToString() + "'");

            objCurrentYearTangible = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                        "(CategoryID=1) AND (Type='Revenue Generation' OR Type='Cost Reduction') AND " +
                                        "Period = '" + m_currentYear.ToString() + "'");

            objCurrentYearIntangible = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                        "(CategoryID=1) AND " +
                                        "(Type='Risk Reduction' OR Type='Cost Avoidance' OR Type='Revenue Loss Avoidance') AND " +
                                        "Period = '" + m_currentYear.ToString() + "'");

            objTotalSpend = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                        "(CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14)");

            objTotalBenefits = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                        "(CategoryID=1)");

            objTotalTangible = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                        "(CategoryID=1) AND (Type='Revenue Generation' OR Type='Cost Reduction')");

            objTotalIntangible = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                        "(CategoryID=1) AND " +
                                        "(Type='Risk Reduction' OR Type='Cost Avoidance' OR Type='Revenue Loss Avoidance')");

            dTotalBenefits = (objTotalBenefits != DBNull.Value) ? (decimal)objTotalBenefits : 0.0m;
            dTotalSpend = (objTotalSpend != DBNull.Value) ? (decimal)objTotalSpend : 0.0m;

            dROI = (dTotalSpend != 0.0m) ? (dTotalBenefits / dTotalSpend) : 0.0m;

            tdFA_CurrentYearBenefits.InnerText = objCurrentYearBenefits != DBNull.Value ? ((Decimal)objCurrentYearBenefits).ToString("N2") : "0.00";
            tdFA_CurrentYearSpend.InnerText = objCurrentYearSpend != DBNull.Value ? ((Decimal)objCurrentYearSpend).ToString("N2") : "0.00";

            if (objCurrentYearBenefits != DBNull.Value && (Decimal)objCurrentYearBenefits != 0.0m)
            {
                tdFA_CurrentYearTangible.InnerText = ((objCurrentYearTangible != DBNull.Value ? (Decimal)objCurrentYearTangible : 0.0m) * 100.0m / (Decimal)objCurrentYearBenefits).ToString("N2") + "%";
                tdFA_CurrentYearIntangible.InnerText = ((objCurrentYearIntangible != DBNull.Value ? (Decimal)objCurrentYearIntangible : 0.0m) * 100.0m / (Decimal)objCurrentYearBenefits).ToString("N2") + "%";
            }
            else
            {
                tdFA_CurrentYearTangible.InnerText = "0.0%";
                tdFA_CurrentYearIntangible.InnerText = "0.0%";
            }

            tdFA_TotalBenefits.InnerText = objTotalBenefits != DBNull.Value ? ((Decimal)objTotalBenefits).ToString("N2") : "0.00";
            tdFA_TotalSpend.InnerText = objTotalSpend != DBNull.Value ? ((Decimal)objTotalSpend).ToString("N2") : "0.00";

            if (objTotalBenefits != DBNull.Value && (Decimal)objTotalBenefits != 0.0m)
            {
                tdFA_TotalTangible.InnerText = ((objTotalTangible != DBNull.Value ? (Decimal)objTotalTangible : 0.0m) * 100.0m / (Decimal)objTotalBenefits).ToString("N2") + "%";
                tdFA_TotalIntangible.InnerText = ((objTotalIntangible != DBNull.Value ? (Decimal)objTotalIntangible : 0.0m) * 100.0m / (Decimal)objTotalBenefits).ToString("N2") + "%";
            }
            else
            {
                tdFA_TotalTangible.InnerText = "0.0%";
                tdFA_TotalIntangible.InnerText = "0.0%";
            }

            tdFA_ROI.InnerText = dROI.ToString("N2");
        }


        private void LoadInitiative()
        {

            DataRow drInitiative = SectionB_BenefitsAnalysis_DB.GetInitiativeDetails(m_nInitiativeID);

            if (drInitiative != null)
            {
                if (!Page.IsPostBack)
                {
                    ddlPayBackPeriod.Text = drInitiative["PayBackPeriod"].ToString();
                    ddlCompletionDate.Text = drInitiative["CompletionDate"].ToString();
                }

                m_currentYear = drInitiative["SubmissionDate"] != DBNull.Value ? ((DateTime)drInitiative["SubmissionDate"]).Year : 2006;
            }
            else
            {
                m_currentYear = 2006;
            }

        }
	}
}
