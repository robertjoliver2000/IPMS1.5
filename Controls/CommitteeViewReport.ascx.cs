//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.1       CA          08/02/2007      Code to include option "Any" in year
//                                              drop down list.
//                                              Correction to default to 2007
//                                              Might need to remove "Any" option
//                                              as it is may not be necessary here.
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

public partial class Controls_CommitteeViewReport : System.Web.UI.UserControl
{

    protected DataTable m_dtFinancialCateories;     //Added 2007-02-28 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT

    protected void Page_Load(object sender, EventArgs e)
    {

        InitialiseFinancialCategories();    //Added 2007-02-28 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT

        if (!Page.IsPostBack)
        {
            DataSet dsYear = Global_DB.GetYears();
            ddlApprovalYear.DataSource = dsYear;
            ddlApprovalYear.DataValueField = "PeriodYear";
            ddlApprovalYear.DataTextField = "PeriodYear";

            ddlApprovalYear.DataBind();
            //rem CA
            //ddlApprovalYear.SelectedValue = DateTime.Now.Year.ToString();
            //end rem

            #region Removed 2008-01-03, GMcF, for AP maint request 2008-01-02
            //rev 1.1.1
            //ddlApprovalYear.SelectedIndex = 3;
            //end rev 
            #endregion

            //Added 2008-01-03, GMcF, for AP maint request 2008-01-02
            ddlApprovalYear.SelectedValue = DateTime.Now.Year.ToString();

            //Added 2007-02-28 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT
            DataView dvFinancialCategory = new DataView(m_dtFinancialCateories);
            cblaFinancialCategory.DataSource = dvFinancialCategory;
            cblaFinancialCategory.DataTextField = "Text";
            cblaFinancialCategory.DataValueField = "Value";

            cblaFinancialCategory.DataBind();
            //End of code added 2007-02-28


            //Added 2007-02-16 GMcF for Phase 1.5 Deliverable 78
            DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(4);

            DataView dvIGApprovalCommittee = new DataView(dsIGApprovalCommittee.Tables["Reference"]);
            dvIGApprovalCommittee.RowFilter = "ReferenceID <> 0";
            dvIGApprovalCommittee.Sort = "Description ASC";

            cblaCommittee.DataSource = dvIGApprovalCommittee;
            cblaCommittee.DataTextField = "Description";
            cblaCommittee.DataValueField = "ReferenceID";

            cblaCommittee.DataBind();
            //End of code added 2007-02-16

        }
        
        ReportParameter p = new ReportParameter("CurrentYear", ddlApprovalYear.SelectedValue);
        rptvwCommitteeViewReport.LocalReport.SetParameters(new ReportParameter[] { p });
    }


    //Added 2007-02-28 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT
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
    //End of code added 2007-02-28



    #region Removed 2007-02-19 GMcF for Phase 1.5 Deliverable 78
    //protected void ddlApprovalYear_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    ReportParameter p = new ReportParameter("CurrentYear", ddlApprovalYear.SelectedValue);
    //    rptvwCommitteeViewReport.LocalReport.SetParameters(new ReportParameter[] { p });

    //    rptvwCommitteeViewReport.LocalReport.Refresh();
    //} 
    #endregion

    protected void HandleControlParams()
    {
        if (!IsPostBack)
        {
            if (Session["Report_CommitteeView_ApprovalYear"] != null)
            {
                ddlApprovalYear.SelectedValue = Session["Report_CommitteeView_ApprovalYear"].ToString();
                cblaCommittee.ItemsSelected = Session["Report_CommitteeView_Committee"].ToString();
                //Added 2007-02-28 GMcF after Phase 1.5 UAT 2.3 - add financial category popup
                cblaFinancialCategory.ItemsSelected = Session["Report_FinancialCategory_Committee"].ToString();
            }
        }
        else
        {
            if (cbxSaveFilter.Checked)
            {
                Session["Report_CommitteeView_ApprovalYear"] = ddlApprovalYear.SelectedValue;
                Session["Report_CommitteeView_Committee"] = cblaCommittee.ItemsSelected;
                //Added 2007-02-28 GMcF after Phase 1.5 UAT 2.3 - add financial category popup
                Session["Report_FinancialCategory_Committee"] = cblaFinancialCategory.ItemsSelected;
            }
        }
    }


    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        HandleControlParams();

    }

}
