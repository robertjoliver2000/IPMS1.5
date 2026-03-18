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


namespace ProjectPortfolio
{
    public partial class FinancialValues : System.Web.UI.Page
    {
        protected int m_nInitiativeID;
        DataSet m_dsPeriod;

        //test

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            try
            {
                m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                m_nInitiativeID = -1;
            }

            lnkStartDate.HRef = "#";
            lnkStartDate.Attributes.Add("onclick",
                                        "javascript:popupWindowDatePicker('" + txtStartDate.ClientID + "');" +
                                        "return false;"
                                        );

            switch (Request.QueryString["category"])
            {
                case "9":
                    lblAmountsTitle.Text = "Spend - RTB Existing";

                    lblStartDate.Visible = false;
                    lblDateInfo.Visible = false;
                    txtStartDate.Visible = false;
                    lnkStartDate.Visible = false;
                    rvStartDate.Enabled = false;
                    rqvStartDate.Enabled = false;

                    Page.Title = "Update RTB Existing Expenses";
                    break;
                       
                default:
                    lblAmountsTitle.Text = "DEPRECIATION";
                    Page.Title = "Update Depreciation Values";
                    break;
            }

            m_dsPeriod = Global_DB.GetPeriods(m_nInitiativeID);

            LoadControls(); 

            if (!Page.IsPostBack)
            {
                btnCancel.Attributes.Add("onClick", "javascript:window.close()");

                if (m_nInitiativeID > 0 && 
                    Request.QueryString["record"] != null && Request.QueryString["record"] != String.Empty)
                {
                    btnOK.Text = "Update";
                    LoadInitiativeFinancial();
                }
            }
        }


        protected void LoadInitiativeFinancial()
        {
            int intInitiativeFinancialID = Convert.ToInt32(Request.QueryString["record"]);

            DataSet dsInitiativeValues = SectionC_DB.GetInitiativeValues(m_nInitiativeID);

            DataRow drFinancialRecord = SectionC_DB.GetInitiativeFinancialDetails(
                                            m_nInitiativeID, intInitiativeFinancialID);

            txtStartDate.Text = (drFinancialRecord["StartDate"] != DBNull.Value) ? ((DateTime)drFinancialRecord["StartDate"]).ToShortDateString() : "";

           
            foreach (RepeaterItem rptItem in rptControls.Items)
            {
                HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                object objValue;

                if ((bool)drPeriod["HasQuarters"])
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                        DataRow[] drValues = dsInitiativeValues.Tables["InitiativeValue"].Select(
                                          "ReferenceID = " + intInitiativeFinancialID.ToString() + " AND " +
                                          "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                          "QuarterNo=" + quarterIndex.ToString());

                        if (drValues.Length > 0) objValue = drValues[0]["Amount"]; else objValue = DBNull.Value;

                        txtValue.Text = (objValue == DBNull.Value) ? "0.00" : ((Decimal)objValue).ToString("N6");
                    }
                }
                else
                {
                    TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));
                

                    DataRow[] drValues = dsInitiativeValues.Tables["InitiativeValue"].Select(
                                             "ReferenceID = " + intInitiativeFinancialID.ToString() + " AND " +
                                             "PeriodID=" + drPeriod["PeriodID"].ToString() + " AND " +
                                             "QuarterNo IS NULL");

                    if (drValues.Length > 0) objValue = drValues[0]["Amount"]; else objValue = DBNull.Value;

                    txtValue.Text = (objValue == DBNull.Value) ? "0.00" : ((Decimal)objValue).ToString("N6");
                }
            }

            return;
        }


        protected void btnOK_Click(object sender, EventArgs e)
        {
            int intInitiativeFinancialID;

            if (m_nInitiativeID <= 0)
			{
				return;
			}

            if (Request.QueryString["record"] != null && Request.QueryString["record"] != String.Empty)
            {
                intInitiativeFinancialID = Convert.ToInt32(Request.QueryString["record"]);

                SectionC_DB.UpdateInitiativeDepreciation(
                                                intInitiativeFinancialID,
                                                m_nInitiativeID,
                                                txtStartDate.Text != String.Empty ? (object)DateTime.Parse(txtStartDate.Text) : DBNull.Value);

                foreach (RepeaterItem rptItem in rptControls.Items)
                {
                    HtmlInputHidden hiddenPeriodID = (HtmlInputHidden)rptItem.FindControl("hiddenPeriodID");
                    DataRow drPeriod = m_dsPeriod.Tables["Period"].Rows.Find(Int32.Parse(hiddenPeriodID.Value));

                    if ((bool)drPeriod["HasQuarters"])
                    {
                        for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                        {
                            TextBox txtValue = (TextBox)rptItem.FindControl("txt" + (drPeriod["Name"] + " " + quarterIndex.ToString()).Replace(' ', '_'));

                            SectionC_DB.UpdateInitiativeValue(intInitiativeFinancialID,
                                                            m_nInitiativeID,
                                                            2,
                                                            (int)drPeriod["PeriodID"],
                                                            quarterIndex,
                                                            (txtValue.Text != String.Empty) ? Single.Parse(txtValue.Text) : 0);
                        }
                    }
                    else
                    {
                        TextBox txtValue = (TextBox)rptItem.FindControl("txt" + drPeriod["Name"].ToString().Replace(' ', '_'));

                        SectionC_DB.UpdateInitiativeValue(intInitiativeFinancialID,
                                                        m_nInitiativeID,
                                                        2,
                                                        (int)drPeriod["PeriodID"],
                                                        DBNull.Value,
                                                        (txtValue.Text != String.Empty) ? Single.Parse(txtValue.Text) : 0);
                    }
                }

                SectionC_DB.UpdateInitiative_AllRisks(m_nInitiativeID);
            }

            RegisterStartupScript("closeScript",
                    "<script language=JavaScript> window.returnValue=1; window.close(); </script>");
        }


        protected void LoadControls()
        {
            DataSet dsPeriods = Global_DB.GetPeriods(m_nInitiativeID);

            rptControls.DataSource = dsPeriods.Tables["Period"];
            rptControls.DataBind();
        }


        protected void rptControls_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("trContent");

                if ((bool)DataBinder.Eval(e.Item.DataItem, "HasQuarters"))
                {
                    for (int quarterIndex = 1; quarterIndex <= 4; quarterIndex++)
                    {
                        HtmlTableCell td = new HtmlTableCell();
                        td.Attributes.Add("class", "summarylabel");
                        td.Attributes.Add("width", "55px");
                        td.Attributes.Add("align", "right");
                        td.InnerText = "Q" + quarterIndex.ToString() + " " + DataBinder.Eval(e.Item.DataItem, "Name").ToString();
                        tr.Cells.Add(td);

                        td = new HtmlTableCell();

                        TextBox txtValue = new TextBox();
                        txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString() + " " + quarterIndex.ToString()).Replace(' ', '_');
                        txtValue.CssClass = "textinput";
                        txtValue.MaxLength = 50;
                        txtValue.Width = new Unit("50px");
                        txtValue.Attributes.Add("style", "text-align: center");

                        RangeValidator rvAmount = new RangeValidator();
                        rvAmount.Type = ValidationDataType.Double;
                        rvAmount.MinimumValue = "0";
                        rvAmount.MaximumValue = "1000000";
                        rvAmount.Text = "*";
                        rvAmount.ControlToValidate = txtValue.ID;

                        td.Controls.Add(txtValue);
                        td.Controls.Add(rvAmount);

                        tr.Cells.Add(td);
                    }

                    HtmlTableCell tdHidden = new HtmlTableCell();
                    HtmlInputHidden hiddenPeriodID = new HtmlInputHidden();
                    hiddenPeriodID.ID = "hiddenPeriodID";
                    hiddenPeriodID.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();
                    tdHidden.Controls.Add(hiddenPeriodID);
                    tr.Cells.Add(tdHidden);
                }
                else
                {
                    HtmlTableCell td = new HtmlTableCell();
                    td.Attributes.Add("class", "summarylabel");
                    td.Attributes.Add("width", "55px");
                    td.Attributes.Add("align", "right");
                    td.InnerText = DataBinder.Eval(e.Item.DataItem, "Name").ToString();
                    tr.Cells.Add(td);

                    td = new HtmlTableCell();

                    TextBox txtValue = new TextBox();
                    txtValue.ID = "txt" + (DataBinder.Eval(e.Item.DataItem, "Name").ToString()).Replace(' ', '_');
                    txtValue.CssClass = "textinput";
                    txtValue.MaxLength = 50;
                    txtValue.Width = new Unit("50px");
                    txtValue.Attributes.Add("style", "text-align: center");

                    RangeValidator rvAmount = new RangeValidator();
                    rvAmount.Type = ValidationDataType.Double;
                    rvAmount.MinimumValue = "0";
                    rvAmount.MaximumValue = "1000000";
                    rvAmount.Text = "*";
                    rvAmount.ControlToValidate = txtValue.ID;

                    td.Controls.Add(txtValue);
                    td.Controls.Add(rvAmount);

                    tr.Cells.Add(td);

                    td = new HtmlTableCell();
                    HtmlInputHidden hiddenPeriodID = new HtmlInputHidden();
                    hiddenPeriodID.ID = "hiddenPeriodID";
                    hiddenPeriodID.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();
                    td.Controls.Add(hiddenPeriodID);
                    tr.Cells.Add(td);
                }

            }
        }

    }
}
