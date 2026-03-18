//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.1       CA          08/02/2007      Code to include option "Any" in year
//                                              drop down list.
//                                              Correction to default to 2007
//                                              Might need to remove "Any" option
//                                              as it is may not be necessary here.
//
//                  GMcF        13/02/2007      For Deliverable 78, Spend Category and Committee drop-downs
//                                              converted to checkbox lists.
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

public partial class Controls_ClientViewReport : System.Web.UI.UserControl
{
    //Added 2007-02-14 GMcF for Phase 1.5 Deliverable 78
    protected DataSet m_dsApprovedStatuses;
    protected ArrayList m_alApprovedStatusIDs;
    protected DataTable m_dtSpendCateories;
    //End of code added 2007-02-15

    protected DataTable m_dtFinancialCateories;     //Added 2007-02-28 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT


    protected void Page_Load(object sender, EventArgs e)
    {
        InitialiseSpendCategories();
        InitialiseFinancialCategories(); // Added 2007-02-28 GMcF after Phase 1.5 UAT 2.3 - add financial category popup


        Page.Server.ScriptTimeout = 6000;    // temp - want to affect only this page


        GetApprovedStatuses();

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

            DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(4);

            dsIGApprovalCommittee.Tables["Reference"].Rows.RemoveAt(0);

            #region Removed 2007-02-13 GMcF for Phase 1.5 Deliverable 78
            //Removed 2007-02-13 GMcF for Phase 1.5 Deliverable 78
            //DataRow newRow = dsIGApprovalCommittee.Tables["Reference"].NewRow();
            //newRow["Description"] = "ALL";
            //newRow["ReferenceID"] = 0;
            //dsIGApprovalCommittee.Tables["Reference"].Rows.InsertAt(newRow, 0);
            //End of code removed 2007-02-13
            #endregion

            DataView dvIGApprovalCommittee = new DataView(dsIGApprovalCommittee.Tables["Reference"]);
            dvIGApprovalCommittee.Sort = "Description ASC";

            #region Removed 2007-02-13 GMcF for Phase 1.5 Deliverable 78
            //Removed 2007-02-13 GMcF for Phase 1.5 Deliverable 78
            //ddlIGApprovalCommittee.DataSource = dvIGApprovalCommittee;
            //ddlIGApprovalCommittee.DataValueField = "Description";
            //ddlIGApprovalCommittee.DataTextField = "Description";

            //ddlIGApprovalCommittee.DataBind();
            //End of code removed 2007-02-13
            #endregion
            
            //Added 2007-02-13 GMcF for Phase 1.5 Deliverable 78
            cblaCommittee.DataSource = dvIGApprovalCommittee;
            cblaCommittee.DataTextField = "Description";
            cblaCommittee.DataValueField = "ReferenceID";

            cblaCommittee.DataBind();


            //TODO: 2007-02-20 GMcF: Replace GetReferenceTable call with call to new method GetReportingStatuses
            DataSet dsStatus = Global_DB.GetReferenceTable(5);
            dsStatus.Tables["Reference"].Rows.RemoveAt(0);

            DataView dvStatus = new DataView(dsStatus.Tables["Reference"]);
            dvStatus.Sort = "Description";

            cblaStatus.DataSource = dvStatus;
            cblaStatus.DataTextField = "Description";
            cblaStatus.DataValueField = "ReferenceID";

            cblaStatus.DataBind();

            //DataView dvSpendCategory = new DataView(m_dsSpendCateories.Tables[0]);
            DataView dvSpendCategory = new DataView(m_dtSpendCateories);
            cblaSpendCategory.DataSource = dvSpendCategory;
            cblaSpendCategory.DataTextField = "Text";
            cblaSpendCategory.DataValueField = "Value";

            cblaSpendCategory.DataBind();

            //End of code added 2007-02-13


            //Added 2007-02-28 GMcF for Phase 1.5 Deliverable 78 - Rework after UAT
            DataView dvFinancialCategory = new DataView(m_dtFinancialCateories);
            cblaFinancialCategory.DataSource = dvFinancialCategory;
            cblaFinancialCategory.DataTextField = "Text";
            cblaFinancialCategory.DataValueField = "Value";

            cblaFinancialCategory.DataBind();
            //End of code added 2007-02-28

        }

    }

    //Added 2007-02-15 GMcF for Phase 1.5 Deliverable 78
    private void InitialiseSpendCategories()
    {
        //m_dsSpendCateories = new DataSet();
        //DataTable dt = m_dsSpendCateories.Tables.Add("ReferenceID");
        DataTable dt = new DataTable("ReferenceID");
        dt.Columns.Add("Value",Type.GetType("System.String"));
        dt.Columns.Add("text",Type.GetType("System.String"));
        dt.Rows.Add(new Object[] { "CTB", "CTB" });
        dt.Rows.Add(new Object[] { "MAN", "MAN" });
        dt.Rows.Add(new Object[] { "RTB", "RTB (Incremental)" });

        m_dtSpendCateories = dt;
    }
    //End of code added 2007-02-15

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


    #region Removed 2007-02-17 GMcF for Phase 1.5 Deliverable 78
    //Removed 2007-02-17 GMcF for Phase 1.5 Deliverable 78

    //protected void ddlApprovalYear_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SetReportParameters();
    //    rptvwClientViewReport.LocalReport.Refresh();
    //}

    //protected void ddlSpendCategory_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SetReportParameters();
    //    rptvwClientViewReport.LocalReport.Refresh();
    //}

    //protected void ddlIGApprovalCommittee_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SetReportParameters();
    //    rptvwClientViewReport.LocalReport.Refresh();
    //}

    //End of code removed 2007-02-14
    #endregion

    private void SetReportParameters()
    {
        ReportParameter py = new
           ReportParameter("ClientView_CurrentYear", ddlApprovalYear.SelectedValue);
        ReportParameter pt = new
           ReportParameter("ClientView_Title", GetTitle());
        rptvwClientViewReport.LocalReport.SetParameters(new ReportParameter[] { py, pt });
    }


    //Added 2007-02-13 GMcF for Phase 1.5 Deliverable 78
    protected void HandleControlParams()
    {
        bool bAll;
        string strCommittees = "";
        string strSpendCategories = "";
        string strFinancialCategories = ""; // Added 2007-02-28 GMcF after Phase 1.5 UAT 2.3 - add financial category popup


        string strStatuses = "";
        string sep = "|";

        if (!IsPostBack)
        {
            if (Session["Report_ClientView_Committees"] != null)
            {
                ddlApprovalYear.SelectedValue = Session["Report_ClientView_ApprovalYear"].ToString();

                strFinancialCategories = Session["Report_ClientView_FinancialCategories"].ToString(); // Added 2007-02-28 GMcF after Phase 1.5 UAT 2.3 - add financial category popup

                strSpendCategories = Session["Report_ClientView_SpendCategories"].ToString();
                strStatuses = Session["Report_ClientView_Statuses"].ToString();
                strCommittees = Session["Report_ClientView_Committees"].ToString();

                cblaFinancialCategory.ItemsSelected = strFinancialCategories;
                cblaSpendCategory.ItemsSelected = strSpendCategories;
                cblaStatus.ItemsSelected = strStatuses;
                cblaCommittee.ItemsSelected = strCommittees;
            }
            else
            {
                // Added 2007-02-28 GMcF after Phase 1.5 UAT 2.3 - add financial category popup
                strFinancialCategories = "ALL";
                cblaFinancialCategory.ItemsSelected = strFinancialCategories;
                // End of code added 2007-02-28

                strSpendCategories = "ALL";
                cblaSpendCategory.ItemsSelected = strSpendCategories;

                SetStatusesToDefault();
                strStatuses = cblaStatus.ItemsSelected;

                strCommittees = "ALL";
                cblaCommittee.ItemsSelected = strCommittees;
            }

        }
        else
        {
            strSpendCategories = cblaSpendCategory.ItemsSelected;
            strStatuses = cblaStatus.ItemsSelected;
            strCommittees = cblaCommittee.ItemsSelected;
            strFinancialCategories = cblaFinancialCategory.ItemsSelected; // Added 2007-02-28 GMcF after Phase 1.5 UAT 2.3 - add financial category popup


            if (cbxSaveFilter.Checked)
            {
                Session["Report_ClientView_Committees"] = strCommittees;
                Session["Report_ClientView_SpendCategories"] = strSpendCategories;
                Session["Report_ClientView_Statuses"] = strStatuses;
                Session["Report_ClientView_ApprovalYear"] = ddlApprovalYear.SelectedValue;
                Session["Report_ClientView_FinancialCategories"] = strFinancialCategories; // Added 2007-02-28 GMcF after Phase 1.5 UAT 2.3 - add financial category popup

            }
        }

        #region Removed 2007-02-28 GMcF as redundant after controls explicitly tied to parameters on page
        /*
        objDSClientView.SelectParameters["IGApprovalCommittee"].DefaultValue = strCommittees;
        objDSClientView.SelectParameters["SpendCategory"].DefaultValue = strSpendCategories;
        objDSClientView.SelectParameters["InitiativeStatus"].DefaultValue = strStatuses;
        */
        
        #endregion
        SetReportParameters();

    }
    //End of code added 2007-02-13


    //Added 2007-02-13 GMcF for Phase 1.5 Deliverable 78
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        HandleControlParams();

    }
    //End of code added 2007-02-13


    //Added 2007-02-14 GMcF for Phase 1.5 Deliverable 78
    protected string GetTitle()
    {  
        //"Client View Report - " + str
        string strTitle = "";
        bool bAll = true;

        ArrayList alStatusesSelected = new ArrayList(cblaStatus.Items.Count);

        if (cblaStatus.ItemsSelected == "ALL")
        {
            strTitle = "All statuses";
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
                strTitle = "initiatives with any status";
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
                        strTitle = "Initiatives with Status " + strTitle.Substring(2);
                    }
                }
            }

        }

        //2007-02-28 GMcF after Phase 1.5 UAT 2.3 - include selected approval year in title
        strTitle = "Client View Report - " + ddlApprovalYear.SelectedValue.ToString() + " - " + strTitle;

        return strTitle;

    }
    //End of code added 2007-02-14


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


}
