/*
 * 
 * 
 * 
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

	using ProjectPortfolio.Classes;

	public partial class SectionB_BenefitsAnalysis_PrintVersion : System.Web.UI.UserControl
	{
        private DataSet m_dsInitiativeValues;
        private DataSet m_dsPeriod;

        private int     m_currentYear;

        private const string DefaultCellWidth = "30px";
        private const string Pre2006CellWidth = "40px";

        protected int nInitiativeID;
        protected int nInitiativeStatusID;  // Rev 1.9.2, GMcF
        protected bool bIsPIR; // Rev 1.9.2, GMcF

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

            // Rev 1.9.2, GMcF
            nInitiativeStatusID = Global_DB.GetInitiativeStatusID(nInitiativeID);
            bIsPIR = Global_DB.IsPIR(nInitiativeStatusID);
            // End of Rev 1.9.2
            LoadInitiative();


            tdCurrentYearBenefitsTitle.InnerText = m_currentYear.ToString() + " Benefits";
            tdCurrentYearSpendTitle.InnerText = m_currentYear.ToString() + " Spend";

            //m_dsPeriod = Global_DB.GetPeriods(nInitiativeID);
            m_dsPeriod = Global_DB.GetPeriodsForDisplay(nInitiativeID);
            m_dsInitiativeValues = SectionB_DB.GetInitiativeValues(nInitiativeID);

            DataView dvBenefitsAnalysis = new DataView(m_dsInitiativeValues.Tables["InitiativeValue"]);
            dvBenefitsAnalysis.RowFilter = "";

            rptBenefitsAnalysis.DataSource = dvBenefitsAnalysis;
            rptBenefitsAnalysis.DataBind();

            DataView dvSpendAnalysis = new DataView(m_dsInitiativeValues.Tables["InitiativeValue"]);
            dvSpendAnalysis.RowFilter = "";

            rptSpendAnalysis.DataSource = dvSpendAnalysis;
            rptSpendAnalysis.DataBind();

            // Rev 1.9.2, 2008-01-14, GMcF
            if (bIsPIR)
            {
                rptRTBExisting.Visible = false;
            }
            else
            {
                rptRTBExisting.Visible = true;
	            // End of Rev 1.9.2
	
	            DataView dvRTBExisting = new DataView(m_dsInitiativeValues.Tables["InitiativeValue"]);
	            dvRTBExisting.RowFilter = "";
	
	            rptRTBExisting.DataSource = dvRTBExisting;
	            rptRTBExisting.DataBind();
	
	            // Rev 1.9.2, 2008-01-14, GMcF
	            }
	            // End of Rev 1.9.2

            DoFinancialAnalysis();
       }

        protected void rptBenefitsAnalysis_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Header:
                    repeaters_DoDefaultHeaderBind(sender, e, "", "analysisheadcell");
                    break;

                case ListItemType.Footer:
                    repeaters_DoDefaultFooterBind(sender, e, "((CategoryID=1) AND Type='Revenue Generation')", "trSubTotal1", "", "analysisgreencell", "analysiswhitecell");
                    repeaters_DoDefaultFooterBind(sender, e, "((CategoryID=1) AND Type='Cost Reduction')", "trSubTotal2", "", "analysisgreencell", "analysiswhitecell");
                    repeaters_DoDefaultFooterBind(sender, e, "((CategoryID=1) AND Type='Risk Reduction')", "trSubTotal3", "", "analysisgreencell", "analysiswhitecell");
                    repeaters_DoDefaultFooterBind(sender, e, "((CategoryID=1) AND Type='Cost Avoidance')", "trSubTotal4", "", "analysisgreencell", "analysiswhitecell");
                    repeaters_DoDefaultFooterBind(sender, e, "((CategoryID=1) AND Type='Revenue Loss Avoidance')", "trSubTotal5", "", "analysisgreencell", "analysiswhitecell");
                    repeaters_DoDefaultFooterBind(sender, e, "(CategoryID=1)", "trTotal", "", "analysistotalcell", "analysistotalcell");
                    break;
            }
        }


        protected void rptSpendAnalysis_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Header:
                    repeaters_DoDefaultHeaderBind(sender, e, "", "analysisheadcell");
                    break;

                case ListItemType.Footer:
                    repeaters_DoDefaultFooterBind(sender, e, "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='CTB')", "trSubTotal1", "", "analysisgreencell", "analysiswhitecell");
                    repeaters_DoDefaultFooterBind(sender, e, "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='MAN')", "trSubTotal2", "", "analysisgreencell", "analysiswhitecell");
                    repeaters_DoDefaultFooterBind(sender, e, "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='RTB')", "trSubTotal3", "", "analysisgreencell", "analysiswhitecell");

                    repeaters_DoDefaultFooterBind(sender, e, "(CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14)", "trTotal", "", "analysistotalcell", "analysistotalcell");
                    break;
            }
        }


        protected void rptRTBExisting_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Footer:
                    repeaters_DoDefaultFooterBind(sender, e, "(CategoryID in (9, 16, 17))", "trRTBExisting", "border: 1px solid #000000", "analysisgreencell", "analysiswhitecell");
                    break;
            }
        }


        protected void DoFinancialAnalysis()
        {
            object objCurrentYearSpend, objCurrentYearBenefits, objCurrentYearTangible, objCurrentYearIntangible;
            object objTotalSpend, objTotalBenefits, objTotalTangible, objTotalIntangible;
            decimal dTotalBenefits, dTotalSpend, dROI;

            // Rev 1.9.2, 2008-01-14, GMcF
            if (bIsPIR)
            {
                tdSpacer.Visible = false;
                tdFinancialAnalysis.Visible = false;
            }
            else
            {
            // End of Rev 1.9.2
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
	                tdFA_CurrentYearTangible.InnerText = ((objCurrentYearTangible != DBNull.Value ? (Decimal)objCurrentYearTangible : 0.0m) * 100.0m / (Decimal)objCurrentYearBenefits).ToString("G4") + "%";
	                tdFA_CurrentYearIntangible.InnerText = ((objCurrentYearIntangible != DBNull.Value ? (Decimal)objCurrentYearIntangible : 0.0m) * 100.0m / (Decimal)objCurrentYearBenefits).ToString("G4") + "%";
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
	                tdFA_TotalTangible.InnerText = ((objTotalTangible != DBNull.Value ? (Decimal)objTotalTangible : 0.0m) * 100.0m / (Decimal)objTotalBenefits).ToString("G4") + "%";
	                tdFA_TotalIntangible.InnerText = ((objTotalIntangible != DBNull.Value ? (Decimal)objTotalIntangible : 0.0m) * 100.0m / (Decimal)objTotalBenefits).ToString("G4") + "%";
	            }
	            else
	            {
	                tdFA_TotalTangible.InnerText = "0.0%";
	                tdFA_TotalIntangible.InnerText = "0.0%";
	            }
	
	            tdFA_ROI.InnerText = dROI.ToString("N2");

            // Rev 1.9.2, 2008-01-14, GMcF
            }
            // End of Rev 1.9.2

        }


        protected void repeaters_DoDefaultHeaderBind(object sender, RepeaterItemEventArgs e, string style, string cssClass)
        {
            if (e.Item.ItemType == ListItemType.Header)
            {
                HtmlTableRow trHeaderRow = (HtmlTableRow)e.Item.FindControl("trHeader");
                HtmlTableCell tdTitleCell;

                HtmlTableCell tdBigTitle = (HtmlTableCell)e.Item.FindControl("tdBigTitle");

                if (tdBigTitle != null)
                {
                    // Rev 1.9.2, GMcF
                    int nQuarterCount = 0;
                    if ( bIsPIR )
                    {
                        nQuarterCount = 0;
                    }
                    else
                    {
                        nQuarterCount = (int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)*4", "HasQuarters=1");
                    }
                    // End of Rev 1.9.2

                    tdBigTitle.Attributes["colspan"] = ((int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)", "") +
                                                        // Rev 1.9.2, GMcF
                                                        //(int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)*4", "HasQuarters=1")
                                                        nQuarterCount
                                                        // End of Rev 1.9.2
                                                        + 2).ToString();
                }

                foreach (DataRow drPeriod in m_dsPeriod.Tables["Period"].Rows)
                {
                    //if ((bool)drPeriod["HasQuarters"])

                    if ((Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                            && !bIsPIR // Rev 1.9.2, GMcF
                        )
                    {
                        for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                        {
                            tdTitleCell = new HtmlTableCell();
                            tdTitleCell.InnerText = "Q" + quarterIndex.ToString() + " " + drPeriod["Name"].ToString();
                            tdTitleCell.Attributes.Add("Class", cssClass);
                            tdTitleCell.Attributes.Add("Width", DefaultCellWidth);
                            tdTitleCell.Attributes.Add("Align", "center");
                            trHeaderRow.Cells.Add(tdTitleCell);
                        }
                    }

                    tdTitleCell = new HtmlTableCell();
                    tdTitleCell.InnerText = drPeriod["Name"].ToString();
                    tdTitleCell.Attributes.Add("Class", cssClass);
                    tdTitleCell.Attributes.Add("Width", drPeriod["Name"].ToString().StartsWith("PRE") ? Pre2006CellWidth : DefaultCellWidth);
                    tdTitleCell.Attributes.Add("Align", "center");
                    trHeaderRow.Cells.Add(tdTitleCell);
                }

                tdTitleCell = new HtmlTableCell();
                tdTitleCell.InnerText = "TOTAL";
                tdTitleCell.Attributes.Add("Class", cssClass);
                tdTitleCell.Attributes.Add("Width", DefaultCellWidth);
                tdTitleCell.Attributes.Add("Align", "center");
                tdTitleCell.Attributes.Add("style", "border-right: 1px solid #CCCCCC;");
                trHeaderRow.Cells.Add(tdTitleCell);

                // Rev 1.9.2, 2008-01-14, GMcF
                HtmlTableRow trPIRHeader = (HtmlTableRow)e.Item.FindControl("trPIRHeader");
                if (bIsPIR)
                {
                    trPIRHeader.Visible = true;

                    HtmlTableCell tdTopLeft = new HtmlTableCell();
                    tdTopLeft.Attributes["style"] = "border:1px solid #CCCCCC;";
                    trPIRHeader.Cells.Add(tdTopLeft);

                    HtmlTableCell tdPIRActual = new HtmlTableCell();
                    tdPIRActual.InnerHtml = "Actual";
                    tdPIRActual.ColSpan = 2;
                    tdPIRActual.Attributes["style"] = "border:1px solid #CCCCCC; text-align:center; color:black; background-color:#FFCC99; font-weight:bold;";
                    trPIRHeader.Cells.Add(tdPIRActual);

                    HtmlTableCell tdPIRProjected = new HtmlTableCell();
                    tdPIRProjected.InnerHtml = "Projected";
                    tdPIRProjected.ColSpan = (int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)", "") + 1;
                    tdPIRProjected.Attributes["style"] = "border:1px solid #CCCCCC; text-align:center; color:black; background-color:#CCCCFF; font-weight:bold;";
                    trPIRHeader.Cells.Add(tdPIRProjected);
                }
                else
                {
                    trPIRHeader.Visible = false;
                }
                // End of Rev 1.9.2
            }
        }


        private void repeaters_DoDefaultFooterBind(object sender, RepeaterItemEventArgs e, string categoryFilter,
                                                    string rowID, string style, string cssClass1, string cssClass2)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                HtmlTableCell tdTotalCell;
                object objTotal;
                HtmlTableRow trItemRow = (HtmlTableRow)e.Item.FindControl(rowID);

                foreach (DataRow drPeriod in m_dsPeriod.Tables["Period"].Rows)
                {
                    //if ((bool)drPeriod["HasQuarters"])
                    if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1
                        && !bIsPIR  // Rev 1.9.2, GMcF
                        )
                    {
                        for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                        {
                            tdTotalCell = new HtmlTableCell();

                            objTotal = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                                                categoryFilter + " AND " +
                                                                "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                                                "QuarterNo=" + quarterIndex.ToString());

                            tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                            tdTotalCell.Attributes.Add("Class", cssClass2);
                            tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                            tdTotalCell.Attributes.Add("Align", "center");
                            tdTotalCell.Attributes.Add("style", style);
                            trItemRow.Cells.Add(tdTotalCell);
                        }

                        tdTotalCell = new HtmlTableCell();

                        objTotal = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                                            categoryFilter + " AND " +
                                                            "PeriodID=" + drPeriod["PeriodID"].ToString());

                        tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                        tdTotalCell.Attributes.Add("Class", cssClass1);
                        tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                        tdTotalCell.Attributes.Add("Align", "center");
                        tdTotalCell.Attributes.Add("style", style);
                        trItemRow.Cells.Add(tdTotalCell);

                    }
                    else
                    {
                        tdTotalCell = new HtmlTableCell();

                        objTotal = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                                            categoryFilter + " AND " +
                                                            "PeriodID=" + drPeriod["PeriodID"].ToString() +
                                                            (bIsPIR ? "" : " AND QuarterNo IS NULL")        //Rev 1.9.2, 2008-01-14, GMcF
                                                            );

                        tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                        tdTotalCell.Attributes.Add("Class", cssClass1);
                        tdTotalCell.Attributes.Add("Width", drPeriod["Name"].ToString().StartsWith("PRE") ? Pre2006CellWidth : DefaultCellWidth);
                        tdTotalCell.Attributes.Add("Align", "center");
                        tdTotalCell.Attributes.Add("style", style);
                        trItemRow.Cells.Add(tdTotalCell);
                    }
                }

                tdTotalCell = new HtmlTableCell();

                objTotal = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                                    categoryFilter);

                tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");
                tdTotalCell.Attributes.Add("Class", cssClass1);
                tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                tdTotalCell.Attributes.Add("Align", "center");
                tdTotalCell.Attributes.Add("style", style);

                trItemRow.Cells.Add(tdTotalCell);
            }
        }


        private void LoadInitiative()
        {
            
            DataRow drInitiative = SectionB_BenefitsAnalysis_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                ddlPayBackPeriod.Text = drInitiative["PayBackPeriod"].ToString();
                ddlCompletionDate.Text = drInitiative["CompletionDate"].ToString();

                m_currentYear = drInitiative["SubmissionDate"] != DBNull.Value ? ((DateTime)drInitiative["SubmissionDate"]).Year : 2006;
            }
            else
            {
                m_currentYear = 2006;
            }

       }


        public int UpdateInitiative()
        {
            int intReturnValue = -1;
            
            return intReturnValue;
        }

    }
}
