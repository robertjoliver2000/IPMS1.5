//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.7.2       GMcF        27/08/2007      Del 95 - RTB Existing governance functionality
//                                              Was assuming in the overload of repeaters_DoDefaultFooterBind
//                                              that highlights movements in reviews that a non-null total
//                                              would be returned, but that assumption no longer holds now that
//                                              RTB Existing is not added by default.
//                                              The code now deals with that null result.
//                                              
//*****************************************************************************************************


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

    public partial class Review_SectionB_BenefitsAnalysis : System.Web.UI.UserControl
    {
        private DataSet m_dsInitiativeValues;
        private DataSet m_dsPreviousVersion_InitiativeValues;

        private DataSet m_dsPeriod;
        private DataSet m_dsPreviousPeriod;

        private int m_currentYear;

        private const string DefaultCellWidth = "50px";
        private const string Pre2006CellWidth = "55px";

        protected int m_nInitiativeID;
        protected int m_nPreviousVersion_InitiativeID;

        private bool m_rolledOver;

        decimal tempTotal;
        decimal tempTotal2;

        int tempCount = 0;

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

            m_nPreviousVersion_InitiativeID = Global_DB.GetPreviousVersionInitiativeID(m_nInitiativeID);

            lnkIGReviewDate.HRef = "javascript:popupWindowDatePicker('" + txtIGReviewDate.ClientID + "');";
            lnkIGReviewDate.Visible = false;

            //m_dsPeriod = Global_DB.GetPeriods(m_nInitiativeID);
            //m_dsPreviousPeriod = Global_DB.GetPeriods(m_nPreviousVersion_InitiativeID);
            m_dsPeriod = Global_DB.GetPeriodsForDisplay(m_nInitiativeID);
            m_dsPreviousPeriod = Global_DB.GetPeriodsForDisplay(m_nPreviousVersion_InitiativeID);

            m_dsInitiativeValues = SectionB_DB.GetInitiativeValues(m_nInitiativeID);
            m_dsPreviousVersion_InitiativeValues = SectionB_DB.GetInitiativeValues(m_nPreviousVersion_InitiativeID);


            LoadInitiativeSubmissionYear();
            
            DataView dvBenefitsAnalysis = new DataView(m_dsInitiativeValues.Tables["InitiativeValue"]);
            dvBenefitsAnalysis.RowFilter = "";

            rptBenefitsAnalysis.DataSource = dvBenefitsAnalysis;
            rptBenefitsAnalysis.DataBind();

            DataView dvSpendAnalysis = new DataView(m_dsInitiativeValues.Tables["InitiativeValue"]);
            dvSpendAnalysis.RowFilter = "";

            rptSpendAnalysis.DataSource = dvSpendAnalysis;
            rptSpendAnalysis.DataBind();

            DataView dvRTBExisting = new DataView(m_dsInitiativeValues.Tables["InitiativeValue"]);
            dvRTBExisting.RowFilter = "";

            rptRTBExisting.DataSource = dvRTBExisting;
            rptRTBExisting.DataBind();


            DataView dvPreviousVersion_BenefitsAnalysis = new DataView(m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"]);
            dvPreviousVersion_BenefitsAnalysis.RowFilter = "";

            //ERW 18 Feb 2009
            // this doesn't seem right - shouldn't it be the dvPreviousVersion_... thats used?
            // ---  >     rptPreviousVersion_BenefitsAnalysis.DataSource = dvBenefitsAnalysis;
            rptPreviousVersion_BenefitsAnalysis.DataSource = dvPreviousVersion_BenefitsAnalysis;
            rptPreviousVersion_BenefitsAnalysis.DataBind();

            DataView dvPreviousVersion_SpendAnalysis = new DataView(m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"]);
            dvPreviousVersion_SpendAnalysis.RowFilter = "";

            rptPreviousVersion_SpendAnalysis.DataSource = dvPreviousVersion_SpendAnalysis;
            rptPreviousVersion_SpendAnalysis.DataBind();

            DataView dvPreviousVersion_RTBExisting = new DataView(m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"]);
            dvPreviousVersion_RTBExisting.RowFilter = "";

            rptPreviousVersion_RTBExisting.DataSource = dvPreviousVersion_RTBExisting;
            rptPreviousVersion_RTBExisting.DataBind();

            if (!Page.IsPostBack)
            {
                LoadInitiative();
            }
        }


        protected void rptBenefitsAnalysis_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Header:
                    repeaters_DoDefaultHeaderBind(sender, e, "", "analysisheadcell", m_dsPeriod);
                    repeaters_BindMovementHeader(sender, e, "", "analysisheadcell");
                    break;

                case ListItemType.Footer:
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Revenue Generation')", "trSubTotal1", "", "analysisgreencell", "analysiswhitecell", m_dsPeriod);
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Cost Reduction')", "trSubTotal2", "", "analysisgreencell", "analysiswhitecell", m_dsPeriod);
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Risk Reduction')", "trSubTotal3", "", "analysisgreencell", "analysiswhitecell", m_dsPeriod);
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Cost Avoidance')", "trSubTotal4", "", "analysisgreencell", "analysiswhitecell", m_dsPeriod);
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Revenue Loss Avoidance')", "trSubTotal5", "", "analysisgreencell", "analysiswhitecell", m_dsPeriod);
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        //only do for interim reviews... 
                        repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "(CategoryID=1)", "trTotal", "", "analysistotalcell", "analysistotalcellred", m_dsPeriod, m_dsPreviousPeriod, true);
                    }
                    else
                    {
                        repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "(CategoryID=1)", "trTotal", "", "analysistotalcell", "analysistotalcell", m_dsPeriod);
                    }

                    repeaters_BindMovementFooter(sender, e, "", "");
                    repeaters_BindMovementFooterCompute(sender, e, "RG", "((CategoryID=1) AND Type='Revenue Generation')", "trSubTotal1", "border-left: 1px solid #CCCCCC;", "analysisgreencell", "analysiswhitecell");
                    repeaters_BindMovementFooterCompute(sender, e, "CR", "((CategoryID=1) AND Type='Cost Reduction')", "trSubTotal2", "border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; ", "analysisgreencell", "analysiswhitecell");
                    repeaters_BindMovementFooterCompute(sender, e, "RR", "((CategoryID=1) AND Type='Risk Reduction')", "trSubTotal3", "border-left: 1px solid #CCCCCC;", "analysisgreencell", "analysiswhitecell");
                    repeaters_BindMovementFooterCompute(sender, e, "CA", "((CategoryID=1) AND Type='Cost Avoidance')", "trSubTotal4", "border-left: 1px solid #CCCCCC; ", "analysisgreencell", "analysiswhitecell");
                    repeaters_BindMovementFooterCompute(sender, e, "CLA", "((CategoryID=1) AND Type='Revenue Loss Avoidance')", "trSubTotal5", "border-left: 1px solid #CCCCCC; ", "analysisgreencell", "analysiswhitecell");
                    repeaters_BindMovementFooterCompute(sender, e, "RoI", "(CategoryID=1)", "trTotal", "", "analysistotalcell", "analysistotalcell");
                    break;
            }
        }


        protected void rptSpendAnalysis_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Header:
                    repeaters_DoDefaultHeaderBind(sender, e, "", "analysisheadcell", m_dsPeriod);
                    repeaters_BindMovementHeader(sender, e, "", "analysisheadcell");
                    break;

                case ListItemType.Footer:
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='CTB')", "trSubTotal1", "", "analysisgreencell", "analysiswhitecell", m_dsPeriod);
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='MAN')", "trSubTotal2", "", "analysisgreencell", "analysiswhitecell", m_dsPeriod);
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='RTB')", "trSubTotal3", "", "analysisgreencell", "analysiswhitecell", m_dsPeriod);
                    if (m_nPreviousVersion_InitiativeID > 0)
                    {
                        //only do for interim reviews...
                        repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "(CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14)", "trTotal", "", "analysistotalcell", "analysistotalcellred", m_dsPeriod, m_dsPreviousPeriod);
                    }
                    else
                    {
                        repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "(CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14)", "trTotal", "", "analysistotalcell", "analysistotalcell", m_dsPeriod);
                    }

                    repeaters_BindMovementFooterCompute(sender, e, "CTB", "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='CTB')", "trSubTotal1", "border-left: 1px solid #CCCCCC;", "analysisgreencell", "analysiswhitecell");
                    repeaters_BindMovementFooterCompute(sender, e, "MAN", "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='MAN')", "trSubTotal2", "border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC; ", "analysisgreencell", "analysiswhitecell");
                    repeaters_BindMovementFooterCompute(sender, e, "RTB inc", "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='RTB')", "trSubTotal3", "border-left: 1px solid #CCCCCC;", "analysisgreencell", "analysiswhitecell");
                    repeaters_BindMovementFooterCompute(sender, e, "", "(CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14)", "trTotal", "", "analysistotalcell", "analysistotalcell");

                    break;
            }
        }


        protected void rptRTBExisting_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Footer:
                    repeaters_DoDefaultFooterBind(sender, e, m_dsInitiativeValues.Tables["InitiativeValue"], "(CategoryID in (9, 16, 17))", "trRTBExisting", "border: 1px solid #000000", "analysisgreencell", "analysiswhitecell", m_dsPeriod);

                    repeaters_BindMovementFooterCompute(sender, e, "RTB ex", "(CategoryID in (9, 16, 17))", "trRTBExisting", "border: 1px solid #000000;", "analysisgreencell", "analysiswhitecell");
                    break;
            }
        }


        protected void rptPreviousVersion_BenefitsAnalysis_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (m_rolledOver)
            {
                switch (e.Item.ItemType)
                {
                    case ListItemType.Header:
                        repeaters_DoDefaultHeaderBind(sender, e, "", "analysisheadcell", m_dsPeriod);
                        break;

                    case ListItemType.Footer:
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Revenue Generation')", "trSubTotal1", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Cost Reduction')", "trSubTotal2", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Risk Reduction')", "trSubTotal3", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Cost Avoidance')", "trSubTotal4", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Revenue Loss Avoidance')", "trSubTotal5", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "(CategoryID=1)", "trTotal", "", "analysistotalcell", "analysistotalcell", m_dsPreviousPeriod);

                        repeaters_BindAdditionalCommentsFooter(sender, e, "", "");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal1", "RG", "txtComment_RG");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal2", "CR", "txtComment_CR");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal3", "RR", "txtComment_RR");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal4", "CA", "txtComment_CA");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal5", "RLA", "txtComment_RLA");
                        repeaters_BindAdditionalComments(sender, e, "trTotal", "RoI", "txtComment_RoI");

                        break;
                }
            }
            else
            {
                switch (e.Item.ItemType)
                {
                    case ListItemType.Header:
                        repeaters_DoDefaultHeaderBind(sender, e, "", "analysisheadcell", m_dsPreviousPeriod);
                        break;

                    case ListItemType.Footer:
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Revenue Generation')", "trSubTotal1", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Cost Reduction')", "trSubTotal2", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Risk Reduction')", "trSubTotal3", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Cost Avoidance')", "trSubTotal4", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=1) AND Type='Revenue Loss Avoidance')", "trSubTotal5", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "(CategoryID=1)", "trTotal", "", "analysistotalcell", "analysistotalcell", m_dsPreviousPeriod);

                        repeaters_BindAdditionalCommentsFooter(sender, e, "", "");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal1", "RG", "txtComment_RG");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal2", "CR", "txtComment_CR");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal3", "RR", "txtComment_RR");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal4", "CA", "txtComment_CA");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal5", "RLA", "txtComment_RLA");
                        repeaters_BindAdditionalComments(sender, e, "trTotal", "RoI", "txtComment_RoI");

                        break;
                }
            }
        }


        protected void rptPreviousVersion_SpendAnalysis_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (m_rolledOver)
            {
                switch (e.Item.ItemType)
                {
                    case ListItemType.Header:
                        repeaters_DoDefaultHeaderBind(sender, e, "", "analysisheadcell", m_dsPeriod);
                        break;

                    case ListItemType.Footer:
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='CTB')", "trSubTotal1", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='MAN')", "trSubTotal2", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='RTB')", "trSubTotal3", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "(CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14)", "trTotal", "", "analysistotalcell", "analysistotalcell", m_dsPreviousPeriod);

                        repeaters_BindAdditionalComments(sender, e, "trSubTotal1", "CTB", "txtComment_CTB");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal2", "MAN", "txtComment_MAN");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal3", "RTB inc", "txtComment_RTB");

                        break;
                }
            }
            else
            {
                switch (e.Item.ItemType)
                {
                    case ListItemType.Header:
                        repeaters_DoDefaultHeaderBind(sender, e, "", "analysisheadcell", m_dsPreviousPeriod);
                        break;

                    case ListItemType.Footer:
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='CTB')", "trSubTotal1", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='MAN')", "trSubTotal2", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "((CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14) AND Type='RTB')", "trSubTotal3", "", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "(CategoryID=2 OR CategoryID=3 OR CategoryID=4 OR CategoryID=5 OR CategoryID=11 OR CategoryID=12 OR CategoryID=13 OR CategoryID=14)", "trTotal", "", "analysistotalcell", "analysistotalcell", m_dsPreviousPeriod);

                        repeaters_BindAdditionalComments(sender, e, "trSubTotal1", "CTB", "txtComment_CTB");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal2", "MAN", "txtComment_MAN");
                        repeaters_BindAdditionalComments(sender, e, "trSubTotal3", "RTB inc", "txtComment_RTB");

                        break;
                }
            }
        }

        protected void rptPreviousVersion_RTBExisting_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            switch (e.Item.ItemType)
            {
                case ListItemType.Footer:
                    if (m_rolledOver)
                    {
                        repeaters_DoCustomFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "(CategoryID in (9, 16, 17))", "trRTBExisting", "border: 1px solid #000000", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                    }
                    else
                    {
                        repeaters_DoDefaultFooterBind(sender, e, m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"], "(CategoryID in (9, 16, 17))", "trRTBExisting", "border: 1px solid #000000", "analysisgreencell", "analysiswhitecell", m_dsPreviousPeriod);
                    }
                    repeaters_BindAdditionalComments(sender, e, "trRTBExisting", "RTB ex", "txtComment_RTB_Existing");
                    break;
            }
        }


        protected void repeaters_BindMovementHeader(object sender, RepeaterItemEventArgs e, string style, string cssClass)
        {
            if (e.Item.ItemType == ListItemType.Header)
            {
                HtmlTableRow trHeaderRow = (HtmlTableRow)e.Item.FindControl("trHeader");
                HtmlTableCell tdTitleCell;

                tdTitleCell = new HtmlTableCell();
                tdTitleCell.Attributes.Add("Class", "empty");
                trHeaderRow.Cells.Add(tdTitleCell);

                tdTitleCell = new HtmlTableCell();
                tdTitleCell.Attributes.Add("Class", "empty");
                trHeaderRow.Cells.Add(tdTitleCell);

                tdTitleCell = new HtmlTableCell();
                tdTitleCell.InnerText = m_currentYear.ToString();
                tdTitleCell.Attributes.Add("Class", cssClass);
                tdTitleCell.Attributes.Add("Width", DefaultCellWidth);
                tdTitleCell.Attributes.Add("Align", "center");
                tdTitleCell.Attributes.Add("style", "border-left: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC;");
                trHeaderRow.Cells.Add(tdTitleCell);

                tdTitleCell = new HtmlTableCell();
                tdTitleCell.InnerText = "Total";
                tdTitleCell.Attributes.Add("Class", cssClass);
                tdTitleCell.Attributes.Add("Width", DefaultCellWidth);
                tdTitleCell.Attributes.Add("Align", "center");
                tdTitleCell.Attributes.Add("style", "border-right: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC;");
                trHeaderRow.Cells.Add(tdTitleCell);
            }
        }


        protected void repeaters_BindMovementFooter(object sender, RepeaterItemEventArgs e, string style, string cssClass)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                HtmlTableRow trFooterRow;
                HtmlTableCell tdRowCell;

                tdRowCell = (HtmlTableCell)e.Item.FindControl("tdTangibleEmpty");
                if (tdRowCell != null)
                {
                    tdRowCell.Attributes.Add("colspan", ((int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)", "") +
                                                       (int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)*4", "HasQuarters=1")
                                                        + 1).ToString());
                }

                tdRowCell = (HtmlTableCell)e.Item.FindControl("tdIntangibleEmpty");
                if (tdRowCell != null)
                {
                    tdRowCell.Attributes.Add("colspan", ((int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)", "") +
                                                       (int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)*4", "HasQuarters=1")
                                                        + 1).ToString());
                }

                trFooterRow = (HtmlTableRow)e.Item.FindControl("trTangible");

                tdRowCell = new HtmlTableCell();
                tdRowCell.Attributes.Add("Class", "empty");
                trFooterRow.Cells.Add(tdRowCell);

                tdRowCell = new HtmlTableCell();
                tdRowCell.InnerText = "Tangible";
                tdRowCell.Attributes.Add("Class", "empty");
                tdRowCell.Attributes.Add("style", "font-weight: bold;");
                tdRowCell.Attributes.Add("colspan", "3");
                trFooterRow.Cells.Add(tdRowCell);

                trFooterRow = (HtmlTableRow)e.Item.FindControl("trIntangible");

                tdRowCell = new HtmlTableCell();
                tdRowCell.Attributes.Add("Class", "empty");
                trFooterRow.Cells.Add(tdRowCell);

                tdRowCell = new HtmlTableCell();
                tdRowCell.InnerText = "Intangible";
                tdRowCell.Attributes.Add("Class", "empty");
                tdRowCell.Attributes.Add("style", "font-weight: bold;");
                tdRowCell.Attributes.Add("colspan", "3");
                trFooterRow.Cells.Add(tdRowCell);

            }
        }


        protected void repeaters_BindMovementFooterCompute(object sender, RepeaterItemEventArgs e, string text,
                                                    string categoryFilter, string rowID, string style, string cssClass1, string cssClass2)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                object objTotal, objLastTotal, objMovement;
                HtmlTableRow trFooterRow = (HtmlTableRow)e.Item.FindControl(rowID);
                HtmlTableCell tdRowCell;

                tdRowCell = new HtmlTableCell();
                tdRowCell.Attributes.Add("Class", "empty");
                tdRowCell.Attributes.Add("width", "20px");
                trFooterRow.Cells.Add(tdRowCell);

                tdRowCell = new HtmlTableCell();
                tdRowCell.InnerText = text;
                tdRowCell.Attributes.Add("Class", "empty");
                tdRowCell.Attributes.Add("width", "50px");
                trFooterRow.Cells.Add(tdRowCell);

                objTotal = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                                            categoryFilter + " AND Period='" + m_currentYear.ToString() + "'");
                objLastTotal = m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)",
                                                            categoryFilter + " AND Period='" + m_currentYear.ToString() + "'");

                objMovement = ((objTotal != DBNull.Value) ? (Decimal)objTotal : 0.0m) - ((objLastTotal != DBNull.Value) ? (Decimal)objLastTotal : 0.0m);

                tdRowCell = new HtmlTableCell();
                tdRowCell.InnerText = (objMovement == DBNull.Value) ? "0.00" : ((Decimal)objMovement).ToString("N2");
                tdRowCell.Attributes.Add("Class", cssClass1);
                tdRowCell.Attributes.Add("Width", DefaultCellWidth);
                tdRowCell.Attributes.Add("Align", "center");
                tdRowCell.Attributes.Add("style", style);
                trFooterRow.Cells.Add(tdRowCell);


                objTotal = m_dsInitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)", categoryFilter);
                objLastTotal = m_dsPreviousVersion_InitiativeValues.Tables["InitiativeValue"].Compute("SUM(Amount)", categoryFilter);

                objMovement = ((objTotal != DBNull.Value) ? (Decimal)objTotal : 0.0m) - ((objLastTotal != DBNull.Value) ? (Decimal)objLastTotal : 0.0m);

                tdRowCell = new HtmlTableCell();
                tdRowCell.InnerText = (objMovement == DBNull.Value) ? "0.00" : ((Decimal)objMovement).ToString("N2");
                tdRowCell.Attributes.Add("Class", cssClass1);
                tdRowCell.Attributes.Add("Width", DefaultCellWidth);
                tdRowCell.Attributes.Add("Align", "center");
                tdRowCell.Attributes.Add("style", style);
                trFooterRow.Cells.Add(tdRowCell);
            }
        }

        protected void repeaters_BindAdditionalCommentsFooter(object sender, RepeaterItemEventArgs e, string style, string cssClass)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                HtmlTableRow trFooterRow;
                HtmlTableCell tdRowCell;

                tdRowCell = (HtmlTableCell)e.Item.FindControl("tdTangibleEmpty");
                if (tdRowCell != null)
                {
                    tdRowCell.Attributes.Add("colspan", ((int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)", "") +
                                                       (int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)*4", "HasQuarters=1")
                                                        + 1).ToString());
                }

                tdRowCell = (HtmlTableCell)e.Item.FindControl("tdIntangibleEmpty");
                if (tdRowCell != null)
                {
                    tdRowCell.Attributes.Add("colspan", ((int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)", "") +
                                                       (int)m_dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)*4", "HasQuarters=1")
                                                        + 1).ToString());
                }

                trFooterRow = (HtmlTableRow)e.Item.FindControl("trTangible");

                tdRowCell = new HtmlTableCell();
                tdRowCell.Attributes.Add("Class", "empty");
                trFooterRow.Cells.Add(tdRowCell);

                tdRowCell = new HtmlTableCell();
                tdRowCell.InnerText = "Tangible";
                tdRowCell.Attributes.Add("Class", "empty");
                tdRowCell.Attributes.Add("style", "font-weight: bold;");
                tdRowCell.Attributes.Add("colspan", "2");
                trFooterRow.Cells.Add(tdRowCell);

                trFooterRow = (HtmlTableRow)e.Item.FindControl("trIntangible");

                tdRowCell = new HtmlTableCell();
                tdRowCell.Attributes.Add("Class", "empty");
                trFooterRow.Cells.Add(tdRowCell);

                tdRowCell = new HtmlTableCell();
                tdRowCell.InnerText = "Intangible";
                tdRowCell.Attributes.Add("Class", "empty");
                tdRowCell.Attributes.Add("style", "font-weight: bold;");
                tdRowCell.Attributes.Add("colspan", "2");
                trFooterRow.Cells.Add(tdRowCell);

            }
        }


        protected void repeaters_BindAdditionalComments(object sender, RepeaterItemEventArgs e, string rowID, string text, string id)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                HtmlTableRow trFooterRow = (HtmlTableRow)e.Item.FindControl(rowID);
                HtmlTableCell tdRowCell;

                tdRowCell = new HtmlTableCell();
                tdRowCell.Attributes.Add("Class", "empty");
                tdRowCell.Attributes.Add("width", "20px");
                trFooterRow.Cells.Add(tdRowCell);

                tdRowCell = new HtmlTableCell();
                tdRowCell.InnerText = text;
                tdRowCell.Attributes.Add("Class", "empty");
                tdRowCell.Attributes.Add("width", "50px");
                trFooterRow.Cells.Add(tdRowCell);

                tdRowCell = new HtmlTableCell();
                tdRowCell.Attributes.Add("Class", "emptynopadding");
                tdRowCell.Attributes.Add("Width", "115px");
                tdRowCell.Attributes.Add("Align", "center");

                TextBox txtComment = new TextBox();
                txtComment.CssClass = "textinput";
                txtComment.Width = new Unit("110px");
                txtComment.ID = id;
                tdRowCell.Controls.Add(txtComment);

                trFooterRow.Cells.Add(tdRowCell);
            }
        }

        protected void repeaters_DoDefaultHeaderBind(object sender, RepeaterItemEventArgs e, string style, string cssClass, DataSet dsPeriod)
        {
            if (e.Item.ItemType == ListItemType.Header)
            {
                HtmlTableRow trHeaderRow = (HtmlTableRow)e.Item.FindControl("trHeader");
                HtmlTableCell tdTitleCell;

                HtmlTableCell tdBigTitle = (HtmlTableCell)e.Item.FindControl("tdBigTitle");

                if (tdBigTitle != null)
                {
                    tdBigTitle.Attributes["colspan"] = ((int)dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)", "") +
                                                       (int)dsPeriod.Tables["Period"].Compute("COUNT(PeriodID)*4", "HasQuarters=1")
                                                        + 2).ToString();
                }

                foreach (DataRow drPeriod in dsPeriod.Tables["Period"].Rows)
                {
                    //if ((bool)drPeriod["HasQuarters"])
                    if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
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
            }
        }


        private void repeaters_DoDefaultFooterBind(object sender, RepeaterItemEventArgs e, DataTable dtInitiativeValues, string categoryFilter,
                                                    string rowID, string style, string cssClass1, string cssClass2, DataSet dsPeriod)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                HtmlTableCell tdTotalCell;
                object objTotal;
                HtmlTableRow trItemRow = (HtmlTableRow)e.Item.FindControl(rowID);

                foreach (DataRow drPeriod in dsPeriod.Tables["Period"].Rows)
                {
                    //if ((bool)drPeriod["HasQuarters"])
                    if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                    {
                        for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                        {
                            tdTotalCell = new HtmlTableCell();

                            objTotal = dtInitiativeValues.Compute("SUM(Amount)",
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

                        objTotal = dtInitiativeValues.Compute("SUM(Amount)",
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

                        objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                            categoryFilter + " AND " +
                                                            "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                                            "QuarterNo IS NULL");

                        tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                        tdTotalCell.Attributes.Add("Class", cssClass1);
                        tdTotalCell.Attributes.Add("Width", drPeriod["Name"].ToString().StartsWith("PRE") ? Pre2006CellWidth : DefaultCellWidth);
                        tdTotalCell.Attributes.Add("Align", "center");
                        tdTotalCell.Attributes.Add("style", style);
                        trItemRow.Cells.Add(tdTotalCell);
                    }
                }

                tdTotalCell = new HtmlTableCell();

                objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                    categoryFilter);

                tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");
                tdTotalCell.Attributes.Add("Class", cssClass1);
                tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                tdTotalCell.Attributes.Add("Align", "center");
                tdTotalCell.Attributes.Add("style", style);

                trItemRow.Cells.Add(tdTotalCell);
            }
        }

        private void repeaters_DoDefaultFooterBind(object sender, RepeaterItemEventArgs e, DataTable dtInitiativeValues, DataTable dtPrevInitValues,
                                            string categoryFilter, string rowID, string style, string cssClass1, string cssClass2,
                                                DataSet dsPeriod, DataSet dsPrevPeriod)
        {
            //KI currently this overload only written and used for Interim  
            //Review totals for spend when highlighting movement between review numbers...


            if (e.Item.ItemType == ListItemType.Footer)
            {
                HtmlTableCell tdTotalCell;
                object objTotal;
                object objLRTotal;
                HtmlTableRow trItemRow = (HtmlTableRow)e.Item.FindControl(rowID);
                int n_rowCounter = 0;
                int n_periodCounter = 0;
                int n_periodID = 0;
                int n_prevperiodID = 0;
                bool b_moved1 = false;
                bool b_moved2 = false;
                decimal dMovement = 0;
                decimal dMovementTotal = 0;

                foreach (DataRow drPeriod in dsPeriod.Tables["Period"].Rows)
                {
                    b_moved1 = false;
                    b_moved2 = false;
                    dMovement = 0;
                    if (Convert.ToInt32(drPeriod["PeriodID"]) != n_periodID)
                    {
                        //new period?
                        n_periodID = Convert.ToInt32(drPeriod["PeriodID"]);
                        n_periodCounter++;
                        n_prevperiodID = Convert.ToInt32(dsPrevPeriod.Tables["Period"].Rows[n_rowCounter]["PeriodID"]);
                        if (m_rolledOver) n_prevperiodID++;
                    }

                    if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                    {
                        for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                        {
                            tdTotalCell = new HtmlTableCell();

                            objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                        categoryFilter + " AND " +
                                                        "PeriodID=" + n_periodID.ToString() + " AND " +
                                                        "QuarterNo=" + quarterIndex.ToString());

                            //KI for rollovers here we need to dynamically calculate
                            //quarters for the 3th period in dataset to align with current review...
                            if (m_rolledOver && n_periodCounter == 3)
                            {
                                objLRTotal = dtPrevInitValues.Compute("SUM(Amount)/4",
                                                        categoryFilter + " AND (" +
                                                        "PeriodID=" + (n_prevperiodID).ToString() +
                                                        ") AND (QuarterNo IS NULL)");
                            }
                            else
                            {
                                objLRTotal = dtPrevInitValues.Compute("SUM(Amount)",
                                                        categoryFilter + " AND " +
                                                        "PeriodID=" + (n_prevperiodID).ToString()
                                                        + " AND QuarterNo=" + quarterIndex.ToString());
                            }

                            tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                            // Rev 1.7.2, GMcF: references to objLRTotal and objTotal replaced by local vars lramount and curamount respectively to handle cases when either obj is null
                            decimal lramount = (objLRTotal == DBNull.Value) ? 0 : ((Decimal)objLRTotal);
                            decimal curamount = (objTotal == DBNull.Value) ? 0 : (Decimal)objTotal;

                            if (curamount > lramount) //more...
                            {
                                tdTotalCell.Attributes.Add("Class", cssClass2);
                                b_moved1 = true;
                                dMovement += (curamount - lramount);
                            }
                            else if (curamount < lramount) //less...
                            {
                                tdTotalCell.Attributes.Add("Class", cssClass1);
                                //2007-04-16 Deliverable 47.2 Modified line to correctly add the movement when negative
                                dMovement += (curamount - lramount);
                            }
                            else //same...
                            {
                                tdTotalCell.Attributes.Add("Class", cssClass1);
                            }
                            //End of Rev 1.7.2, GMcF


                            tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                            tdTotalCell.Attributes.Add("Align", "center");
                            tdTotalCell.Attributes.Add("style", style);
                            trItemRow.Cells.Add(tdTotalCell);
                        }
                        //2007-04-16 Deliverable 47.2 Jason K. Added MovementTotal Check outside of the quarter loop as
                        // it was affecting the total movement incorrectly. In fact it wasn't even adding
                        // to the TotalMovement correctly to begin with. 
                        dMovementTotal += dMovement;
                        tdTotalCell = new HtmlTableCell();

                        objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                categoryFilter + " AND " +
                                                "PeriodID=" + drPeriod["PeriodID"].ToString());

                        tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");
                        if (b_moved1 && (dMovement > 0)) //movement must also be postive overall for total
                        {
                            tdTotalCell.Attributes.Add("Class", cssClass2);
                        }
                        else
                        {
                            tdTotalCell.Attributes.Add("Class", cssClass1);
                        }
                        tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                        tdTotalCell.Attributes.Add("Align", "center");
                        tdTotalCell.Attributes.Add("style", style);
                        trItemRow.Cells.Add(tdTotalCell);

                    }
                    else
                    {
                        tdTotalCell = new HtmlTableCell();

                        objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                            categoryFilter + " AND " +
                                            "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                            "QuarterNo IS NULL");

                        //do for PRE total...
                        if (n_periodCounter == 1 && m_rolledOver)
                        {
                            objLRTotal = dtPrevInitValues.Compute("SUM(Amount)",
                                                        categoryFilter + " AND (" +
                                                        "PeriodID=" + n_prevperiodID.ToString() + " OR " +
                                                        "PeriodID=" + (n_prevperiodID - 1).ToString() + ")");
                        }
                        else //else we must now on totals past the 3rd period...
                        {
                            objLRTotal = dtPrevInitValues.Compute("SUM(Amount)",
                                                        categoryFilter + " AND (" +
                                                        "PeriodID=" + (n_prevperiodID).ToString() +
                                                        ") AND (QuarterNo IS NULL)");
                        }

                        tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");
                        decimal lramount = (objLRTotal == DBNull.Value) ? 0 : ((Decimal)objLRTotal);
                        decimal curamount = (objTotal == DBNull.Value) ? 0 : (Decimal)objTotal; //Rev 1.7.2, GMcF
                        if (decimal.Round(curamount, 2) > 0 && decimal.Round(curamount, 2) > decimal.Round(lramount, 2)) //Rev 1.7.2, GMcF
                        {
                            tdTotalCell.Attributes.Add("Class", cssClass2);
                            b_moved2 = true;
                            //to try
                            dMovementTotal += (curamount - lramount); //Rev 1.7.2, GMcF
                        }
                        else
                        {
                            tdTotalCell.Attributes.Add("Class", cssClass1);
                            dMovementTotal += (curamount - lramount); //Rev 1.7.2, GMcF
                        }
                        tdTotalCell.Attributes.Add("Width", drPeriod["Name"].ToString().StartsWith("PRE") ? Pre2006CellWidth : DefaultCellWidth);
                        tdTotalCell.Attributes.Add("Align", "center");
                        tdTotalCell.Attributes.Add("style", style);
                        trItemRow.Cells.Add(tdTotalCell);
                    }
                    n_rowCounter++;
                }

                tdTotalCell = new HtmlTableCell();

                objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                    categoryFilter);

                tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                //if (objTotal != DBNull.Value)
                //{
                //    tempTotal2 = (Decimal)objTotal;
                //}
                //put back in CA? here 2
                //if ((b_moved1 || b_moved2) || (tempTotal < tempTotal2))
                if ((b_moved1 || b_moved2) || (dMovementTotal > 0))
                {
                    tdTotalCell.Attributes.Add("Class", cssClass2);
                }
                else
                {
                    tdTotalCell.Attributes.Add("Class", cssClass1); //leave this in if rem back out
                }
                //end 

                tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                tdTotalCell.Attributes.Add("Align", "center");
                tdTotalCell.Attributes.Add("style", style);

                trItemRow.Cells.Add(tdTotalCell);
            }
        }

        private void repeaters_DoDefaultFooterBind(object sender, RepeaterItemEventArgs e, DataTable dtInitiativeValues, DataTable dtPrevInitValues,
                                                    string categoryFilter, string rowID, string style, string cssClass1, string cssClass2,
                                                 DataSet dsPeriod, DataSet dsPrevPeriod, bool isBen)
        {
            if (!isBen)
            {
                repeaters_DoDefaultFooterBind(sender, e, dtInitiativeValues, dtPrevInitValues,
                                                    categoryFilter, rowID, style, cssClass1, cssClass2,
                                                        dsPeriod, dsPrevPeriod);
            }
            else
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    HtmlTableCell tdTotalCell;
                    object objTotal;
                    object objLRTotal;
                    HtmlTableRow trItemRow = (HtmlTableRow)e.Item.FindControl(rowID);
                    int n_rowCounter = 0;
                    int n_periodCounter = 0;
                    int n_periodID = 0;
                    int n_prevperiodID = 0;
                    bool b_moved1 = false;
                    bool b_moved2 = false;
                    decimal dMovement = 0;
                    decimal dMovementTotal = 0;

                    foreach (DataRow drPeriod in dsPeriod.Tables["Period"].Rows)
                    {
                        b_moved1 = false;
                        b_moved2 = false;
                        dMovement = 0;
                        if (Convert.ToInt32(drPeriod["PeriodID"]) != n_periodID)
                        {
                            //new period?
                            n_periodID = Convert.ToInt32(drPeriod["PeriodID"]);
                            n_periodCounter++;
                            n_prevperiodID = Convert.ToInt32(dsPrevPeriod.Tables["Period"].Rows[n_rowCounter]["PeriodID"]);
                            if (m_rolledOver) n_prevperiodID++;
                        }

                        if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                        {
                            for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                            {
                                tdTotalCell = new HtmlTableCell();

                                objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                            categoryFilter + " AND " +
                                                            "PeriodID=" + n_periodID.ToString() + " AND " +
                                                            "QuarterNo=" + quarterIndex.ToString());

                                //KI for rollovers here we need to dynamically calculate
                                //quarters for the 3th period in dataset to align with current review...
                                if (m_rolledOver && n_periodCounter == 3)
                                {
                                    objLRTotal = dtPrevInitValues.Compute("SUM(Amount)/4",
                                                            categoryFilter + " AND (" +
                                                            "PeriodID=" + (n_prevperiodID).ToString() +
                                                            ") AND (QuarterNo IS NULL)");
                                }
                                else
                                {
                                    objLRTotal = dtPrevInitValues.Compute("SUM(Amount)",
                                                            categoryFilter + " AND " +
                                                            "PeriodID=" + (n_prevperiodID).ToString()
                                                            + " AND QuarterNo=" + quarterIndex.ToString());
                                }

                                tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                                //rev 1.1.14 
                                //if ((objLRTotal == DBNull.Value) || (objTotal == DBNull.Value)) //change for delete all benefit bug
                                if (objLRTotal == DBNull.Value)
                                {
                                    tdTotalCell.Attributes.Add("Class", cssClass1);
                                }
                                else
                                {
                                    if (objTotal == DBNull.Value) //start
                                    {
                                        // 2007-04-16 Deliverable 47.2 Jason K. Added null check to objLRTotal
                                        if ((objLRTotal != DBNull.Value) && (Decimal)objLRTotal > 0)
                                        {
                                            tdTotalCell.Attributes.Add("Class", cssClass2);
                                            b_moved1 = true;
                                            dMovement += (0 - (Decimal)objLRTotal);
                                            // 2007-04-16 Deliverable 47.2 Jason K. removed add here
                                            //dMovementTotal = dMovement;
                                        }
                                        //else if ((Decimal)objTotal > (Decimal)objLRTotal)
                                        //{
                                        //    tdTotalCell.Attributes.Add("Class", cssClass1);
                                        //    dMovement += ((Decimal)objTotal - (Decimal)objLRTotal);
                                        //    dMovementTotal = dMovement;

                                        //}
                                        else
                                        {
                                            tdTotalCell.Attributes.Add("Class", cssClass1);
                                        }
                                    }
                                    else
                                    {
                                        if ((Decimal)objTotal < (Decimal)objLRTotal)
                                        {
                                            tdTotalCell.Attributes.Add("Class", cssClass2);
                                            b_moved1 = true;
                                            dMovement += ((Decimal)objTotal - (Decimal)objLRTotal);
                                            // 2007-04-16 Deliverable 47.2 Jason K. removed add here
                                            //dMovementTotal = dMovement;
                                        }
                                        else if ((Decimal)objTotal > (Decimal)objLRTotal)
                                        {
                                            tdTotalCell.Attributes.Add("Class", cssClass1);
                                            dMovement += ((Decimal)objTotal - (Decimal)objLRTotal);
                                            // 2007-04-16 Deliverable 47.2 Jason K. removed add here
                                            //dMovementTotal = dMovement;

                                        }
                                        else
                                        {
                                            tdTotalCell.Attributes.Add("Class", cssClass1);
                                        }
                                    } //finish
                                }
                                //end rev 1.1.14

                                tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                                tdTotalCell.Attributes.Add("Align", "center");
                                tdTotalCell.Attributes.Add("style", style);
                                trItemRow.Cells.Add(tdTotalCell);
                            }
                            // 2007-04-16 Deliverable 47.2 Jason K. Moved adds to Total Movement outside 
                            // quarter processing loop. 
                            dMovementTotal += dMovement;
                            tdTotalCell = new HtmlTableCell();

                            objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                    categoryFilter + " AND " +
                                                    "PeriodID=" + drPeriod["PeriodID"].ToString());

                            tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                            if (b_moved1 && (dMovement < 0)) //movement must also be neg overall for total
                            {
                                tdTotalCell.Attributes.Add("Class", cssClass2);
                            }
                            else
                            {
                                tdTotalCell.Attributes.Add("Class", cssClass1);
                            }

                            tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                            tdTotalCell.Attributes.Add("Align", "center");
                            tdTotalCell.Attributes.Add("style", style);
                            trItemRow.Cells.Add(tdTotalCell);

                        }
                        else
                        {
                            tdTotalCell = new HtmlTableCell();

                            objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                categoryFilter + " AND " +
                                                "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                                "QuarterNo IS NULL");

                            //do for PRE total...
                            if (n_periodCounter == 1 && m_rolledOver)
                            {
                                objLRTotal = dtPrevInitValues.Compute("SUM(Amount)",
                                                        categoryFilter + " AND (" +
                                                        "PeriodID=" + n_prevperiodID.ToString() + " OR " +
                                                        "PeriodID=" + (n_prevperiodID - 1).ToString() + ")");
                            }
                            else //else we must now on totals past the 3rd period...
                            {
                                objLRTotal = dtPrevInitValues.Compute("SUM(Amount)",
                                                            categoryFilter + " AND (" +
                                                            "PeriodID=" + (n_prevperiodID).ToString() +
                                                            ") AND (QuarterNo IS NULL)");
                            }

                            tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                            if (objLRTotal == DBNull.Value)
                            {
                                tdTotalCell.Attributes.Add("Class", cssClass1);
                            }
                            else
                            {
                                // 2007-04-16 Deliverable 47.2 Jason K New Check for movement detection on benefit Deliverable 47.2
                                if (objTotal != DBNull.Value)
                                {
                                    if ((decimal)objTotal < (Decimal)objLRTotal)
                                    {
                                        tdTotalCell.Attributes.Add("Class", cssClass2);
                                        b_moved2 = true;
                                        dMovementTotal += (((decimal)objTotal - (decimal)objLRTotal));
                                    }
                                    else
                                    {
                                        tdTotalCell.Attributes.Add("Class", cssClass1);
                                        dMovementTotal += (((decimal)objTotal - (decimal)objLRTotal));
                                    }
                                }
                                else
                                {
                                    if (0 < (Decimal)objLRTotal)
                                    {
                                        tdTotalCell.Attributes.Add("Class", cssClass2);
                                        b_moved2 = true;
                                        dMovementTotal += ((0 - (decimal)objLRTotal));
                                    }
                                    else
                                    {
                                        tdTotalCell.Attributes.Add("Class", cssClass1);
                                        dMovementTotal += ((0 - (decimal)objLRTotal));
                                    }
                                }

                                //rem ca
                                ////if (objTotal != DBNull.Value && ((Decimal)objTotal < (Decimal)objLRTotal)) //tweak to JK's code (CA)
                                //if ((Decimal)objTotal < (Decimal)objLRTotal)
                                ////if (objLRTotal == DBNull.Value) //change for delete all benefit bug
                                ////if  ((objTotal == DBNull.Value) && ((decimal)objLRTotal != 0))
                                //{
                                //    tdTotalCell.Attributes.Add("Class", cssClass2);
                                //    b_moved2 = true;
                                //    //to try
                                //    //dMovementTotal = ((0- (decimal)objLRTotal));
                                //    dMovementTotal += (((decimal)objTotal - (decimal)objLRTotal));
                                //}
                                //else
                                //{
                                //    //if (objTotal == DBNull.Value)
                                //    //{
                                //    //    objTotal == 0.00;
                                //    //}

                                //    tdTotalCell.Attributes.Add("Class", cssClass1);
                                //    dMovementTotal += (((decimal)objTotal - (decimal)objLRTotal));
                                //}
                            }

                            tdTotalCell.Attributes.Add("Width", drPeriod["Name"].ToString().StartsWith("PRE") ? Pre2006CellWidth : DefaultCellWidth);
                            tdTotalCell.Attributes.Add("Align", "center");
                            tdTotalCell.Attributes.Add("style", style);
                            trItemRow.Cells.Add(tdTotalCell);
                        }
                        n_rowCounter++;
                    }

                    tdTotalCell = new HtmlTableCell();

                    objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                        categoryFilter);

                    tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                    //if (objTotal != DBNull.Value)
                    //{
                    //    tempTotal = (Decimal)objTotal;
                    //}
                    //put back in CA? here 1
                    if ((b_moved1 || b_moved2) || (dMovementTotal < 0))
                    {
                        tdTotalCell.Attributes.Add("Class", cssClass2);
                    }
                    else
                    {
                        tdTotalCell.Attributes.Add("Class", cssClass1); //leave in if rem back out
                    }
                    //end 

                    tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                    tdTotalCell.Attributes.Add("Align", "center");
                    tdTotalCell.Attributes.Add("style", style);

                    trItemRow.Cells.Add(tdTotalCell);
                }
            }
        }

        private void repeaters_DoCustomFooterBind(object sender, RepeaterItemEventArgs e, DataTable dtInitiativeValues, string categoryFilter,
                                                    string rowID, string style, string cssClass1, string cssClass2, DataSet dsPeriod)
        {
            //KI this procedure has been written to dynamically display last reviews in a more readable
            //format in relation to a current review where a year has been crossed over e.g. 2006 to 2007 (dev 73)

            if (e.Item.ItemType == ListItemType.Footer)
            {
                HtmlTableCell tdTotalCell;
                object objTotal;
                HtmlTableRow trItemRow = (HtmlTableRow)e.Item.FindControl(rowID);
                int n_periodCounter = 0;
                int n_periodID = 0;
                int currentPeriodID = 0;

                //ERw 18 Feb 2009
                // calculate the current year PeriodID
                DataRow [] drCurrentPeriodArray;
                DataRow drCurrentPeriod;
                drCurrentPeriodArray = dsPeriod.Tables["period"].Select("Name=" + m_currentYear);
                drCurrentPeriod = drCurrentPeriodArray[0];
                currentPeriodID = Convert.ToInt32(drCurrentPeriod["PeriodID"]); 


                foreach (DataRow drPeriod in dsPeriod.Tables["Period"].Rows)
                {
                    if (Convert.ToInt32(drPeriod["PeriodID"]) != n_periodID)
                    {
                        //new period?
                        n_periodID = Convert.ToInt32(drPeriod["PeriodID"]);
                        n_periodCounter++;

                        
                    }

                    if (Convert.ToInt16(drPeriod["HasQuarters"]) == 1)
                    {
                        for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                        {
                            tdTotalCell = new HtmlTableCell();

                            //we need to dynamically display quarters for the 3th period in dataset to relect new current review...
                            if (n_periodCounter == 3)
                            {
                                objTotal = dtInitiativeValues.Compute( "SUM(Amount)/4", 
                                                        categoryFilter + " AND (" +
                                                        "PeriodID=" + (n_periodID + 1).ToString() +
                                                        ") AND (QuarterNo IS NULL)");
                            }
                            else
                            {
                                objTotal = dtInitiativeValues.Compute("SUM(Amount)", 
                                                        categoryFilter + " AND " +
                                                        "PeriodID=" + (n_periodID + 1).ToString() + " AND " +
                                                        "QuarterNo=" + quarterIndex.ToString());
                            }

                            tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                            tdTotalCell.Attributes.Add("Class", cssClass2);
                            tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                            tdTotalCell.Attributes.Add("Align", "center");
                            tdTotalCell.Attributes.Add("style", style);
                            trItemRow.Cells.Add(tdTotalCell);
                        }

                        tdTotalCell = new HtmlTableCell();

                        objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                        categoryFilter + " AND " +
                                                        "PeriodID=" + (n_periodID + 1).ToString());

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

                        //only do it this way for the first period in the dataset as we are playing catch up...
                        if (n_periodCounter == 1)
                        {
                            // ERW 
                            //  18 Feb 2009
                            // OTA 785 - Financial Error Interim Review
                            //  The idea is correct - we are "playing catch-up here"
                            // but we need to SUM everything that is less than the current year here, not
                            // just n_periodID and n_periodID + 1 (which probably worked the first year this was tried - i.e. 2007/08)
                            // replaced with AND "...PeriodID < " + m_currentPeriodID + "'"
                            //-------------------------------------------------------------------
                            //objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                            //                            categoryFilter + " AND (" +
                            //                            "PeriodID=" + n_periodID.ToString() + " OR " +
                            //                            "PeriodID=" + (n_periodID + 1).ToString() + ")");

                            objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                        categoryFilter + " AND (" +
                                                        "PeriodID < " + currentPeriodID.ToString() + ")");


                        }
                        else
                        {
                            // ERW 18 Feb 2009 - I think this may be an error.  I can't see why we want to sum
                            // where PeriodID = PeriodID +1,  I think it should be the sum of the actual
                            // period, not the next period we are doing here.
                            //  NO!!  Can't quite get my head around this,  but it'll be something to do with 
                            // the headers being this years (i.e. one ahead) while the data is last years.  So you need to add
                            // one to each period so the headers and values tie up.  (And you effectively "skip" one forward (above) when you do the first column
                            // leave as n_periodID + 1
                            objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                        categoryFilter + " AND (" +
                                                        "PeriodID=" + (n_periodID + 1).ToString() +
                                                        ") AND (QuarterNo IS NULL)");

                        }

                        tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");

                        tdTotalCell.Attributes.Add("Class", cssClass1);
                        tdTotalCell.Attributes.Add("Width", drPeriod["Name"].ToString().StartsWith("PRE") ? Pre2006CellWidth : DefaultCellWidth);
                        tdTotalCell.Attributes.Add("Align", "center");
                        tdTotalCell.Attributes.Add("style", style);
                        trItemRow.Cells.Add(tdTotalCell);
                    }
                }

                tdTotalCell = new HtmlTableCell();

                objTotal = dtInitiativeValues.Compute("SUM(Amount)",
                                                    categoryFilter);

                //here 3
                //tempCount ++;

                //if (tempCount == 10)
                //{
                //    if (objTotal != DBNull.Value)
                //    {
                //        tempTotal = (Decimal)objTotal;
                //    }
                //}

                tdTotalCell.InnerText = (objTotal == DBNull.Value) ? "0.00" : ((Decimal)objTotal).ToString("N2");
                tdTotalCell.Attributes.Add("Class", cssClass1);
                tdTotalCell.Attributes.Add("Width", DefaultCellWidth);
                tdTotalCell.Attributes.Add("Align", "center");
                tdTotalCell.Attributes.Add("style", style);

                trItemRow.Cells.Add(tdTotalCell);
            }
        }



        public TextBox GetComment(string strID)
        {
            TextBox txtComment;

            txtComment = rptPreviousVersion_BenefitsAnalysis.Controls[rptPreviousVersion_BenefitsAnalysis.Controls.Count - 1].
                                                            FindControl("txtComment_" + strID) as TextBox;

            if (txtComment != null)
            {
                return txtComment;
            }

            txtComment = rptPreviousVersion_SpendAnalysis.Controls[rptPreviousVersion_SpendAnalysis.Controls.Count - 1].
                                                            FindControl("txtComment_" + strID) as TextBox;

            if (txtComment != null)
            {
                return txtComment;
            }

            txtComment = rptPreviousVersion_RTBExisting.Controls[rptPreviousVersion_RTBExisting.Controls.Count - 1].
                                                            FindControl("txtComment_" + strID) as TextBox;

            if (txtComment != null)
            {
                return txtComment;
            }

            return null;
        }


        public int UpdateInitiative()
        {
            int intReturnValue = -1;

            if (m_nInitiativeID > 0)
            {
                Review_SectionB_BenefitsAnalysis_DB.UpdateInitiative(m_nInitiativeID,
                    //(txtIGReviewDate.Text != String.Empty) ? (object)DateTime.Parse(txtIGReviewDate.Text) : DBNull.Value,
                        GetComment("RG").Text, GetComment("CR").Text,
                        GetComment("RR").Text, GetComment("CA").Text,
                        GetComment("RLA").Text, GetComment("RoI").Text,
                        GetComment("CTB").Text, GetComment("MAN").Text,
                        GetComment("RTB").Text, GetComment("RTB_Existing").Text
                        );

                txtIGReviewDate.Text = DateTime.Today.ToShortDateString();
            }

            return intReturnValue;
        }


        private void LoadInitiative()
        {
            DataRow drInitiative = Review_SectionB_BenefitsAnalysis_DB.GetInitiativeDetails(m_nInitiativeID);

            if (drInitiative != null)
            {
                //txtIGReviewDate.Text = (drInitiative["IGReviewDate"] != DBNull.Value) ? ((DateTime)drInitiative["IGReviewDate"]).ToShortDateString() : "";
                txtIGReviewDate.Text = (drInitiative["IGApprovalDate"] != DBNull.Value) ? ((DateTime)drInitiative["IGApprovalDate"]).ToShortDateString() : "";
            }

            DataRow drPreviousVersion_Initiative = Review_SectionB_BenefitsAnalysis_DB.GetInitiativeDetails(m_nPreviousVersion_InitiativeID);

            if (drInitiative != null)
            {
                //txtIGLastReviewDate.Text = (drPreviousVersion_Initiative["IGReviewDate"] != DBNull.Value) ? ((DateTime)drPreviousVersion_Initiative["IGReviewDate"]).ToShortDateString() : "";
                txtIGLastReviewDate.Text = (drPreviousVersion_Initiative["IGApprovalDate"] != DBNull.Value) ? ((DateTime)drPreviousVersion_Initiative["IGApprovalDate"]).ToShortDateString() : "";
            }

            DataRow drComments = Review_SectionB_BenefitsAnalysis_DB.GetInitiativeReviewDetails(m_nInitiativeID);

            if (drComments != null)
            {
                GetComment("RG").Text = drComments["Comment_RG"].ToString();
                GetComment("CR").Text = drComments["Comment_CR"].ToString();
                GetComment("RR").Text = drComments["Comment_RR"].ToString();
                GetComment("CA").Text = drComments["Comment_CA"].ToString();
                GetComment("RLA").Text = drComments["Comment_RLA"].ToString();
                GetComment("RoI").Text = drComments["Comment_RoI"].ToString();
                GetComment("CTB").Text = drComments["Comment_CTB"].ToString();
                GetComment("MAN").Text = drComments["Comment_MAN"].ToString();
                GetComment("RTB").Text = drComments["Comment_RTB"].ToString();
                GetComment("RTB_Existing").Text = drComments["Comment_RTB_Existing"].ToString();
            }
        }


        private void LoadInitiativeSubmissionYear()
        {
            DataRow drInitiative = Review_SectionB_BenefitsAnalysis_DB.GetInitiativeDetails(m_nInitiativeID);

            if (drInitiative != null && drInitiative["SubmissionDate"] != DBNull.Value)
            {
                m_currentYear = ((DateTime)drInitiative["SubmissionDate"]).Year;
                
            }
            else
            {
                m_currentYear = 2006;
            }

            DataRow drInit = Review_SectionB_BenefitsAnalysis_DB.GetInitiativeDetails(m_nPreviousVersion_InitiativeID);
            int n_oldYear;

            if (drInit != null && drInit["SubmissionDate"] != DBNull.Value)
            {
                n_oldYear = ((DateTime)drInit["SubmissionDate"]).Year;
                m_rolledOver = (m_currentYear != n_oldYear);
            }

        }
    }
}

