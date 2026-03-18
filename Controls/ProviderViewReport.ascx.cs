//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.1       CA          08/02/2007      Code to include option "Any" in year
//                                              drop down list.
//                                              Correction to default to 2007
//                                              Probably need to remove "Any" option
//                                              as it is may not be necessary here.
//
//      1.1.6       CA          09/02/2007      Approval status checkbox list
//                                              
//      -----       GMcF        15/02/2007      For Phase 1.5 Deliverable 78
//                                              - check boxes for Approval Status.
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

public partial class Controls_ProviderViewReport : System.Web.UI.UserControl

{
    //Added 2007-02-15 GMcF for Phase 1.5 Deliverable 78
    protected DataSet m_dsApprovedStatuses;
    protected ArrayList m_alApprovedStatusIDs;
    protected DataTable m_dtSpendCateories;
    //End of code added 2007-02-15

    protected DataTable m_dtFinancialCateories;     //Added 2007-02-27 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT


    protected void Page_Load(object sender, EventArgs e)
    {
        //Added 2007-02-15 GMcF for Phase 1.5 Deliverable 78
        InitialiseSpendCategories();
        GetApprovedStatuses();
        //End of code added 2007-02-15

        InitialiseFinancialCategories();    //Added 2007-02-27 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT

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

            #region Taken out 2007-02-20 GMcF as now using cblaStatus instead
            //rev 1.1.5
            //DataSet dsIGApprovalStatus = Global_DB.GetReferenceTable(5);

            //foreach (DataRow drApprovalStatus in dsIGApprovalStatus.Tables["Reference"].Rows)
            //{
            //    if (drApprovalStatus["Description"].ToString() != "Please select")
            //    {
            //        cblStatus.Items.Add(drApprovalStatus["Description"].ToString());
            //    }
            //}

            //end rev
            #endregion

            DataView dvSpendCategory = new DataView(m_dtSpendCateories);
            cblaSpendCategory.DataSource = dvSpendCategory;
            cblaSpendCategory.DataTextField = "Text";
            cblaSpendCategory.DataValueField = "Value";

            cblaSpendCategory.DataBind();


            //Added 2007-02-27 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT
            DataView dvFinancialCategory = new DataView(m_dtFinancialCateories);
            cblaFinancialCategory.DataSource = dvFinancialCategory;
            cblaFinancialCategory.DataTextField = "Text";
            cblaFinancialCategory.DataValueField = "Value";

            cblaFinancialCategory.DataBind();
            //End of code added 2007-02-27


            DataSet dsIGApprovalStatus = Global_DB.GetReferenceTable(5);

            DataView dvStatus = new DataView(dsIGApprovalStatus.Tables["Reference"]);
            dvStatus.RowFilter = "ReferenceID <> 0";
            dvStatus.Sort = "Description";

            cblaStatus.DataSource = dvStatus;
            cblaStatus.DataTextField = "Description";
            cblaStatus.DataValueField = "ReferenceID";

            cblaStatus.DataBind();

        }
        SetReportParameters();
    }

    //Added 2007-02-13 GMcF for Phase 1.5 Deliverable 78
    protected void HandleControlParams()
    {
        if (!IsPostBack)
        {
            if (Session["Report_ProviderView_ApprovalYear"] != null)
            {
                cblaStatus.ItemsSelected = Session["Report_ProviderView_Statuses"].ToString();
                ddlApprovalYear.SelectedValue = Session["Report_ProviderView_ApprovalYear"].ToString();
                cblaSpendCategory.ItemsSelected = Session["Report_ProviderView_SpendCategories"].ToString();
                cblaFinancialCategory.ItemsSelected = Session["Report_ProviderView_FinancialCategories"].ToString();
            }
            else
            {
                cblaSpendCategory.ItemsSelected = "ALL";
                SetStatusesToDefault();
            }

        }
        else
        {
            if (cbxSaveFilter.Checked)
            {
                Session["Report_ProviderView_Statuses"] = cblaStatus.ItemsSelected;
                Session["Report_ProviderView_ApprovalYear"] = ddlApprovalYear.SelectedValue;
                Session["Report_ProviderView_SpendCategories"] = cblaSpendCategory.ItemsSelected;
                Session["Report_ProviderView_FinancialCategories"] = cblaFinancialCategory.ItemsSelected;
            }
        }

        //objDSReportView.SelectParameters["InitiativeStatus"].DefaultValue = cblaStatus.ItemsSelected;

        SetReportParameters();

    }
    //End of code added 2007-02-13

    
    //Added 2007-02-15 GMcF for Phase 1.5 Deliverable 78
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        HandleControlParams();

    }
    //End of code added 2007-02-13

    protected void ddlApprovalYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetReportParameters();
        rptvwProviderViewReport.LocalReport.Refresh();
    }

    private void SetReportParameters()
    {
        ReportParameter pcy = new
           ReportParameter("ProviderView_CurrentYear", ddlApprovalYear.SelectedValue);
        ReportParameter pt = new
            ReportParameter("ProviderView_Title", GetTitle());

        rptvwProviderViewReport.LocalReport.SetParameters(new ReportParameter[] { pcy, pt });
    }


    //Added 2007-02-15 GMcF for Phase 1.5 Deliverable 78
    protected string GetTitle()
    {
        //"Client View Report - " + str
        string strTitle = "";
        bool bAll = true;

        ArrayList alStatusesSelected = new ArrayList(cblaStatus.Items.Count);

        if (cblaStatus.ItemsSelected == "ALL")
        {
            strTitle = "Initiatives with Any Status";
        }
        else
        {
            strTitle = "";
            foreach (ListItem li in cblaStatus.Items)
            {
                if (li.Selected == true)
                {
                    strTitle += ", " + li.Text;
                    alStatusesSelected.Add(int.Parse(li.Value));
                }
                else
                {
                    bAll = false;
                }
            }
            if (bAll)
            {
                strTitle = "Initiatives with Any Status";
            }
            else
            {
                if (strTitle.Length > 0)
                {
                    alStatusesSelected.Sort();
                    bool bAllAndOnlyApproved = true;
                    if (alStatusesSelected.Count != m_alApprovedStatusIDs.Count)
                    {
                        bAllAndOnlyApproved = false;
                    }
                    else
                    {
                        for (int i = 0; i < m_alApprovedStatusIDs.Count; i++)
                        {
                            if ((int)m_alApprovedStatusIDs[i] != (int)alStatusesSelected[i])
                            {
                                bAllAndOnlyApproved = false;
                                break;
                            }
                        }
                    }

                    if (bAllAndOnlyApproved)
                    {
                        strTitle = "Approved Initiatives";
                    }
                    else
                    {
                        strTitle = "Inititatives with Status " + strTitle.Substring(2);
                    }
                }
            }

        }
        strTitle = "Provider View of Spend - " + ddlApprovalYear.SelectedValue.ToString() + " - " + strTitle;

        return strTitle;

    }
    //End of code added 2007-02-15


    //Added 2007-02-15 GMcF for Phase 1.5 Deliverable 78
    protected void SetStatusesToDefault()
    {
        cblaStatus.ItemsSelected = "";

        foreach (DataRow dr in m_dsApprovedStatuses.Tables[0].Rows)
        {
            ListItem li = cblaStatus.Items.FindByValue(dr.ItemArray[0].ToString());
            if (li != null)
            {
                li.Selected = true;
            }
        }

    }
    //End of code added 2007-02-15

    //Added 2007-02-15 GMcF for Phase 1.5 Deliverable 78
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
    //End of code added 2007-02-15


    //Added 2007-02-27 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT
    private void InitialiseFinancialCategories()
    {
        DataTable dt = new DataTable("ReferenceID");
        dt.Columns.Add("Value", Type.GetType("System.String"));
        dt.Columns.Add("text", Type.GetType("System.String"));
        dt.Rows.Add(new Object[] { "2", "GTO One Time Cost" });
        dt.Rows.Add(new Object[] { "3", "Business Direct One Time Cost"});
        dt.Rows.Add(new Object[] { "4", "GTO Incremental Cost" });
        dt.Rows.Add(new Object[] { "5", "Business Direct Incremental Cost" });

        m_dtFinancialCateories = dt;
    }
    //End of code added 2007-02-27


    //Added 2007-02-15 GMcF for Phase 1.5 Deliverable 78
    private void GetApprovedStatuses()
    {
        m_dsApprovedStatuses = Global_DB.GetApprovedStatus();

        DataRowCollection drcItems = m_dsApprovedStatuses.Tables[0].Rows;

        m_alApprovedStatusIDs = new ArrayList(drcItems.Count);

        foreach (DataRow dr in drcItems)
        {
            m_alApprovedStatusIDs.Add(int.Parse(dr[0].ToString()));
        }

        m_alApprovedStatusIDs.Sort();
    }
    //End of code added 2007-02-15

}
