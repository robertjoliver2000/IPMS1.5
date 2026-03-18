//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.1       CA          08/02/2007      Code to include option "Any" in year
//                                              drop down list.
//                                              Correction to default to 2007
//                                              Might need to remove "Any" option
//                                              as it is may not be necessary here.
//
//      1.1.2       KI          21/02/2007      Added a fair amount of new functionality
//                                              for dev 78
//
//      -----       GMcF        03/02/2008      For AP maint request 2008-01-02, made approval year default to current
//
//*****************************************************************************************************

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

using ProjectPortfolio.Classes;

public partial class Reports_BenefitsReport : System.Web.UI.UserControl
{
    protected DataTable m_dtSpendCateories;
    protected DataTable m_dtBenefitCateories;
    protected DataTable m_dtFinancialCateories;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            InitialiseFinancialCategories();
            InitialiseSpendCategories();
            InitialiseBenefitCategories();

            DataSet dsYear = Global_DB.GetYears(false);
            ddlApprovalYear.DataSource = dsYear;
            ddlApprovalYear.DataValueField = "PeriodYear";
            ddlApprovalYear.DataTextField = "PeriodYear";     
            ddlApprovalYear.DataBind();

            #region Removed 2008-01-03, GMcF, for AP maint request 2008-01-02
            //ddlApprovalYear.SelectedIndex = 2;
            #endregion

            //Added 2008-01-03, GMcF, for AP maint request 2008-01-02
            ddlApprovalYear.SelectedValue = DateTime.Now.Year.ToString();

            DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(4);
            dsIGApprovalCommittee.Tables["Reference"].Rows.RemoveAt(0);
            DataView dvIGApprovalCommittee = new DataView(dsIGApprovalCommittee.Tables["Reference"]);
            dvIGApprovalCommittee.Sort = "Description ASC";
            cblaCommittee.DataSource = dvIGApprovalCommittee;
            cblaCommittee.DataValueField = "ReferenceID";
            cblaCommittee.DataTextField = "Description";
            cblaCommittee.DataBind();

            DataView dvSpendCategory = new DataView(m_dtSpendCateories);
            cblaSpendCategory.DataSource = dvSpendCategory;
            cblaSpendCategory.DataTextField = "Text";
            cblaSpendCategory.DataValueField = "Value";
            cblaSpendCategory.DataBind();

            DataView dvBenefitCategory = new DataView(m_dtBenefitCateories);
            cblaBenefit.DataSource = dvBenefitCategory;
            cblaBenefit.DataTextField = "Text";
            cblaBenefit.DataValueField = "Value";
            cblaBenefit.DataBind();

            DataView dvFinancialCategory = new DataView(m_dtFinancialCateories);
            cblaFinancialCategory.DataSource = dvFinancialCategory;
            cblaFinancialCategory.DataTextField = "Text";
            cblaFinancialCategory.DataValueField = "Value";
            cblaFinancialCategory.DataBind();

            ReportParameter p = new ReportParameter("CurrentYear", ddlApprovalYear.SelectedValue);
            ReportParameter p2 = new ReportParameter("Output", ddlOutput.SelectedValue);
            rptvwBenefits.LocalReport.SetParameters(new ReportParameter[] { p, p2 });
        }
        
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        if (!IsPostBack)
        {
            if (Session["Report_Benefits_Committees"] != null)
            {
                cblaCommittee.ItemsSelected = Session["Report_Benefits_Committees"].ToString();
                cblaSpendCategory.ItemsSelected = Session["Report_Benefits_SpendCategory"].ToString();
                cblaBenefit.ItemsSelected = Session["Report_Benefits_Benefit"].ToString();
                cblaFinancialCategory.ItemsSelected = Session["Report_Benefits_FinancialCategory"].ToString();
                ddlApprovalYear.SelectedValue = Session["Report_Benefits_Approval_Year"].ToString();
            }
        }
        else
        {
            if (cbxSaveFilter.Checked)
            {
                Session["Report_Benefits_Committees"] = cblaCommittee.ItemsSelected;
                Session["Report_Benefits_SpendCategory"] = cblaSpendCategory.ItemsSelected;
                Session["Report_Benefits_Benefit"] = cblaBenefit.ItemsSelected;
                Session["Report_Benefits_FinancialCategory"] = cblaFinancialCategory.ItemsSelected;
                Session["Report_Benefits_Approval_Year"] = ddlApprovalYear.SelectedValue;
            }
        }

        objDSProfitLossTable.SelectParameters["IGApprovalCommittee"].DefaultValue = cblaCommittee.ItemsSelected;
        objDSBenefitVsSpendLines.SelectParameters["IGApprovalCommittee"].DefaultValue = cblaCommittee.ItemsSelected;

        objDSProfitLossTable.SelectParameters["Spend"].DefaultValue = cblaSpendCategory.ItemsSelected;
        objDSBenefitVsSpendLines.SelectParameters["Spend"].DefaultValue = cblaSpendCategory.ItemsSelected;

        objDSProfitLossTable.SelectParameters["Benefit"].DefaultValue = cblaBenefit.ItemsSelected;
        objDSBenefitVsSpendLines.SelectParameters["Benefit"].DefaultValue = cblaBenefit.ItemsSelected;

        objDSProfitLossTable.SelectParameters["FinancialCategory"].DefaultValue = cblaFinancialCategory.ItemsSelected;
        objDSBenefitVsSpendLines.SelectParameters["FinancialCategory"].DefaultValue = cblaFinancialCategory.ItemsSelected;

        rptvwBenefits.LocalReport.Refresh();
    }
    
    protected void ddlApprovalYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        ReportParameter p = new ReportParameter("CurrentYear", ddlApprovalYear.SelectedValue);
        rptvwBenefits.LocalReport.SetParameters(new ReportParameter[] { p });
        //rptvwBenefits.LocalReport.Refresh();
    }

    protected void ddlOutput_SelectedIndexChanged(object sender, EventArgs e)
    {
        ReportParameter p = new ReportParameter("Output", ddlOutput.SelectedValue);
        rptvwBenefits.LocalReport.SetParameters(new ReportParameter[] { p });
        //rptvwBenefits.LocalReport.Refresh(); 
    }

    private void InitialiseFinancialCategories()
    {
        DataTable dt = new DataTable("ReferenceID");
        dt.Columns.Add("Value", Type.GetType("System.String"));
        dt.Columns.Add("text", Type.GetType("System.String"));
        dt.Rows.Add(new Object[] { "2", "GTO One Time Cost" });
        dt.Rows.Add(new Object[] { "3", "Business Direct One Time Cost" });
        dt.Rows.Add(new Object[] { "4", "GTO Incremental Cost" });
        dt.Rows.Add(new Object[] { "5", "Business Direct Incremental Cost" });

        m_dtFinancialCateories = dt;
    }

    private void InitialiseSpendCategories()
    {
        DataTable dt = new DataTable("ReferenceID");
        dt.Columns.Add("Value", Type.GetType("System.String"));
        dt.Columns.Add("text", Type.GetType("System.String"));
        dt.Rows.Add(new Object[] { "CTB", "CTB" });
        dt.Rows.Add(new Object[] { "MAN", "MAN" });
        dt.Rows.Add(new Object[] { "RTB", "RTB (Incremental)" });

        m_dtSpendCateories = dt;
    }

    private void InitialiseBenefitCategories()
    {
        DataTable dt = new DataTable("ReferenceID");
        dt.Columns.Add("Value", Type.GetType("System.String"));
        dt.Columns.Add("text", Type.GetType("System.String"));
        dt.Rows.Add(new Object[] { "Revenue Generation", "Revenue Generation" });
        dt.Rows.Add(new Object[] { "Cost Reduction", "Cost Reduction" });
        dt.Rows.Add(new Object[] { "Risk Reduction", "Risk Reduction" });
        dt.Rows.Add(new Object[] { "Cost Avoidance", "Cost Avoidance" });
        dt.Rows.Add(new Object[] { "Cost Reduction", "Cost Reduction" });
        dt.Rows.Add(new Object[] { "Revenue Loss Avoidance", "Revenue Loss Avoidance" });

        m_dtBenefitCateories = dt;
    }

    protected void btnRunReport_Click(object sender, EventArgs e)
    {
        //rptvwBenefits.LocalReport.Refresh();
    }
}
