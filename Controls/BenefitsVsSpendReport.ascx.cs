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
using System.Data.SqlClient;
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

public partial class Controls_BenefitsVsSpendReport : System.Web.UI.UserControl
{
    protected DataTable m_dtBenefitCateories;
    protected DataSet m_dsApprovedStatuses;
    protected ArrayList m_alApprovedStatusIDs;

    protected void RegisterPopupScript()
    {
        ClientScriptManager cs = Page.ClientScript;
        Type cstype = this.GetType();

        if (!cs.IsStartupScriptRegistered(cstype, "PopupBubbleInfoScript"))
        {
            String cstext = "<script language=\"javascript\">" +
                              "function popupWindowBubbleInfo(initiativeID)" + 
                                "{" + 
                                    "if (initiativeID == null || initiativeID == \"\")" + 
                                    "{" + 
                                        "return;" + 
                                    "}" + 
    
                                    "var link = \"BubbleInfo.aspx?InitiativeID=\" + initiativeID;" +  
    
                                    "var returnCode;" + 
	                                "returnCode = window.showModalDialog(link, \"bubble_dialog\", " + 
	                                            "\"dialogWidth:875px;dialogHeight:200px;status:no;resizable:no;scroll:no\");" + 
                                "}" + 
                            "</script>";

            cs.RegisterStartupScript(cstype, "PopupBubbleInfoScript", cstext);
        }
    }
    

    protected void Page_Load(object sender, EventArgs e)
    {
        GetApprovedStatuses();
        if (!Page.IsPostBack)
        {
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

            DataSet dsImpactCategory = Global_DB.GetReferenceTable(8);
            //dsImpactCategory.Tables["Reference"].Rows.RemoveAt(0);
            //rev new field on select criteria CA
            //DataRow drReference_PleaseSelect = dsImpactCategory.Tables["Reference"].NewRow();
            //drReference_PleaseSelect["ReferenceID"] = 0;
            //drReference_PleaseSelect["Description"] = "None - No Impact Category Set";
            //dsImpactCategory.Tables["Reference"].Rows.InsertAt(drReference_PleaseSelect, 0);
            //end rev
            DataView dvImpactCategory = new DataView(dsImpactCategory.Tables["Reference"]);
            dvImpactCategory.Sort = "Description ASC";
            cblaImpactCategory.DataSource = dvImpactCategory;
            cblaImpactCategory.DataTextField = "Description";
            cblaImpactCategory.DataValueField = "ReferenceID";
            cblaImpactCategory.DataBind();

            DataSet dsStatus = Global_DB.GetReferenceTable(5);
            dsStatus.Tables["Reference"].Rows.RemoveAt(0);
            DataView dvStatus = new DataView(dsStatus.Tables["Reference"]);
            dvStatus.Sort = "Description";
            cblaStatus.DataSource = dvStatus;
            cblaStatus.DataTextField = "Description";
            cblaStatus.DataValueField = "ReferenceID";
            cblaStatus.DataBind();

            DataView dvBenefitCategory = new DataView(m_dtBenefitCateories);
            cblaBenefit.DataSource = dvBenefitCategory;
            cblaBenefit.DataTextField = "Text";
            cblaBenefit.DataValueField = "Value";
            cblaBenefit.DataBind();
          

        }

    }

    /// <summary>
    /// Jason K - Added in response to Prodcution bug 22
    /// </summary>
    private void SetReportParameters()
    {
        
        
    }


    /// <summary>
    /// Jason K - Added in response to Production bug 22
    /// </summary>
    /// <returns>Assembled string containing the title of the report</returns>
    protected string GetTitle()
    {
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
        strTitle = "ROI Analysis - " + ddlApprovalYear.SelectedValue.ToString() + " - " + strTitle;

        return strTitle;

    }
    //End of code added 2007-02-15


  




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

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        if (!IsPostBack)
        {
            if (Session["Report_BenefitsVsSpend_Committees"] != null)
            {
                cblaCommittee.ItemsSelected = Session["Report_BenefitsVsSpend_Committees"].ToString();
                cblaStatus.ItemsSelected = Session["Report_BenefitsVsSpend_Status"].ToString();
                cblaBenefit.ItemsSelected = Session["Report_BenefitsVsSpend_Benefit"].ToString();
                cblaImpactCategory.ItemsSelected = Session["Report_BenefitsVsSpend_ImpactCategory"].ToString();
                ddlApprovalYear.SelectedValue = Session["Report_BenefitsVsSpend_Approval_Year"].ToString();
            }
            else
            {
                SetStatusesToDefault();
            }
        }
        else
        {
            if (cbxSaveFilter.Checked)
            {
                Session["Report_BenefitsVsSpend_Committees"] = cblaCommittee.ItemsSelected;
                Session["Report_BenefitsVsSpend_Status"] = cblaStatus.ItemsSelected;
                Session["Report_BenefitsVsSpend_Benefit"] = cblaBenefit.ItemsSelected;
                Session["Report_BenefitsVsSpend_ImpactCategory"] = cblaImpactCategory.ItemsSelected;
                Session["Report_BenefitsVsSpend_Approval_Year"] = ddlApprovalYear.SelectedValue;
            }
        }


        objDSReport_BenefitvsSpend_ROI_Bubble.SelectParameters["IGApprovalCommittee"].DefaultValue = cblaCommittee.ItemsSelected;
        objDSBenefitVsSpendROITable.SelectParameters["IGApprovalCommittee"].DefaultValue = cblaCommittee.ItemsSelected;
        objDSBenefitVsSpendBenefitTable.SelectParameters["IGApprovalCommittee"].DefaultValue = cblaCommittee.ItemsSelected;

        objDSReport_BenefitvsSpend_ROI_Bubble.SelectParameters["InitiativeStatus"].DefaultValue = cblaStatus.ItemsSelected;
        objDSBenefitVsSpendROITable.SelectParameters["InitiativeStatus"].DefaultValue = cblaStatus.ItemsSelected;
        objDSBenefitVsSpendBenefitTable.SelectParameters["InitiativeStatus"].DefaultValue = cblaStatus.ItemsSelected;

        objDSReport_BenefitvsSpend_ROI_Bubble.SelectParameters["Benefit"].DefaultValue = cblaBenefit.ItemsSelected;
        objDSBenefitVsSpendROITable.SelectParameters["Benefit"].DefaultValue = cblaBenefit.ItemsSelected;
        objDSBenefitVsSpendBenefitTable.SelectParameters["Benefit"].DefaultValue = cblaBenefit.ItemsSelected;

        objDSReport_BenefitvsSpend_ROI_Bubble.SelectParameters["Impact"].DefaultValue = cblaImpactCategory.ItemsSelected;
        objDSBenefitVsSpendROITable.SelectParameters["Impact"].DefaultValue = cblaImpactCategory.ItemsSelected;
        objDSBenefitVsSpendBenefitTable.SelectParameters["Impact"].DefaultValue = cblaImpactCategory.ItemsSelected;

        ReportParameter p = new ReportParameter("CurrentYear", ddlApprovalYear.SelectedValue);

        ReportParameter pt = new
            ReportParameter("ROIView_Title", GetTitle());

        rptvwBenefitsvsSpendROIBubbleReport.LocalReport.SetParameters(new ReportParameter[] { p, pt });
        rptvwBenefitsvsSpendROIBubbleReport.LocalReport.Refresh();

        
    }

    protected void btnRunReport_Click(object sender, EventArgs e)
    {
        //rptvwBenefitsvsSpendROIBubbleReport.LocalReport.Refresh();
    }

    protected void ddlApprovalYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        ReportParameter p = new ReportParameter("CurrentYear", ddlApprovalYear.SelectedValue);
        rptvwBenefitsvsSpendROIBubbleReport.LocalReport.SetParameters(new ReportParameter[] { p });
    }

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
    

}
