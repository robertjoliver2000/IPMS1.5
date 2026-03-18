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

    public partial class Review_SectionB_SponsorAllocations_PrintVersion : System.Web.UI.UserControl
    {
        protected int m_nInitiativeID;
        protected int m_nPreviousVersion_InitiativeID;

        protected DataSet m_dsSponsors;

        protected DataSet m_dsSponsorValues;
        protected DataSet m_dsPrevious_SponsorValues;

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

            m_dsSponsors = SectionB_SponsorAllocations_DB.GetSponsors();

            LoadControls();

            if (!Page.IsPostBack)
            {
//                FillDropDowns();
                LoadInitiative();
            }
            else
            {
                LoadPreviousInitiative();
            }
        }


        private void LoadInitiative()
        {

            DataRow drInitiative = SectionB_SponsorAllocations_DB.GetInitiativeDetails(m_nInitiativeID);

            if (drInitiative != null)
            {
                ddlAllocationAgreed.Text = drInitiative["AllocationsAgreed"].ToString();
                ddlInitiativeBudget.Text = drInitiative["InitiativeBudgeted"].ToString();
                ddlBasisForAllocation.Text = drInitiative["BasisForAllocation"].ToString();
                txtBasisForAllocationDescription.Text = drInitiative["BasisForAllocationDescription"].ToString();
            }

            m_dsSponsorValues = SectionB_SponsorAllocations_DB.GetSponsorValues(m_nInitiativeID);
            m_dsPrevious_SponsorValues = SectionB_SponsorAllocations_DB.GetSponsorValues(m_nPreviousVersion_InitiativeID);

            LoadSponsorValues(rptBusiness);
            LoadSponsorValues(rptGTO);
            LoadSponsorValues(rptCF);

            object objBusinessAllocation, objGTOAllocation, objCFAllocation;

            objBusinessAllocation = m_dsSponsorValues.Tables["SponsorValue"].Compute("SUM(Allocation)",
                                                "Owner='Business'");
            txtBusiness.Text = (objBusinessAllocation != DBNull.Value) ? ((Decimal)objBusinessAllocation).ToString("G6") : "0";

            objGTOAllocation = m_dsSponsorValues.Tables["SponsorValue"].Compute("SUM(Allocation)",
                                                "Owner='GTO'");
            txtGTO.Text = (objGTOAllocation != DBNull.Value) ? ((Decimal)objGTOAllocation).ToString("G6") : "0";

            objCFAllocation = m_dsSponsorValues.Tables["SponsorValue"].Compute("SUM(Allocation)",
                                                "Owner='CF'");
            txtCF.Text = (objCFAllocation != DBNull.Value) ? ((Decimal)objCFAllocation).ToString("G6") : "0";


            objBusinessAllocation = m_dsPrevious_SponsorValues.Tables["SponsorValue"].Compute("SUM(Allocation)",
                                                "Owner='Business'");
            txtPreviousBusiness.Text = (objBusinessAllocation != DBNull.Value) ? ((Decimal)objBusinessAllocation).ToString("G6") : "0";

            objGTOAllocation = m_dsPrevious_SponsorValues.Tables["SponsorValue"].Compute("SUM(Allocation)",
                                                "Owner='GTO'");
            txtPreviousGTO.Text = (objGTOAllocation != DBNull.Value) ? ((Decimal)objGTOAllocation).ToString("G6") : "0";

            objCFAllocation = m_dsPrevious_SponsorValues.Tables["SponsorValue"].Compute("SUM(Allocation)",
                                                "Owner='CF'");
            txtPreviousCF.Text = (objCFAllocation != DBNull.Value) ? ((Decimal)objCFAllocation).ToString("G6") : "0";

        }

        private void LoadPreviousInitiative()
        {
            m_dsPrevious_SponsorValues = SectionB_SponsorAllocations_DB.GetSponsorValues(m_nPreviousVersion_InitiativeID);

            LoadPreviousSponsorValues(rptBusiness);
            LoadPreviousSponsorValues(rptGTO);
            LoadPreviousSponsorValues(rptCF);
        }


        private void LoadPreviousSponsorValues(Repeater rptValues)
        {
            DataRow[] drResults;

            foreach (RepeaterItem rptItem in rptValues.Items)
            {
                if (rptItem.ItemType == ListItemType.Item || rptItem.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlTableCell tdLabel = (HtmlTableCell)rptItem.FindControl("tdLabel");
                    HtmlInputHidden hiddenSponsorID = (HtmlInputHidden)rptItem.FindControl("sponsorID");

                    drResults = m_dsPrevious_SponsorValues.Tables["SponsorValue"].Select(
                                    "SponsorID=" + hiddenSponsorID.Value);

                    if (drResults.Length > 0)
                    {
                        DataRow drPrevious_SponsorValue = drResults[0];

                        TextBox txtValue = (TextBox)rptItem.FindControl("txtPreviousValue");
                        txtValue.Text = ((Decimal)drPrevious_SponsorValue["Allocation"]).ToString("G6");
                    }
                }
            }
        }


        private void LoadSponsorValues(Repeater rptValues)
        {
            DataRow[] drResults;

            foreach (RepeaterItem rptItem in rptValues.Items)
            {
                if (rptItem.ItemType == ListItemType.Item || rptItem.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlTableCell tdLabel = (HtmlTableCell)rptItem.FindControl("tdLabel");
                    HtmlInputHidden hiddenSponsorID = (HtmlInputHidden)rptItem.FindControl("sponsorID");

                    drResults = m_dsSponsorValues.Tables["SponsorValue"].Select(
                                    "SponsorID=" + hiddenSponsorID.Value);

                    if (drResults.Length > 0)
                    {
                        DataRow drSponsorValue = drResults[0];

                        Label txtValue = (Label)rptItem.FindControl("txtValue");
                        txtValue.Text = ((Decimal)drSponsorValue["Allocation"]).ToString("G6");
                    }

                    drResults = m_dsPrevious_SponsorValues.Tables["SponsorValue"].Select(
                                    "SponsorID=" + hiddenSponsorID.Value);

                    if (drResults.Length > 0)
                    {
                        DataRow drPrevious_SponsorValue = drResults[0];

                        Label txtValue = (Label)rptItem.FindControl("txtPreviousValue");
                        txtValue.Text = ((Decimal)drPrevious_SponsorValue["Allocation"]).ToString("G6");
                    }
                }
            }
        }


        private void UpdateSponsorValues(int m_nInitiativeID, Repeater rptValues)
        {
            foreach (RepeaterItem rptItem in rptValues.Items)
            {
                if (rptItem.ItemType == ListItemType.Item || rptItem.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlInputHidden hiddenSponsorID = (HtmlInputHidden)rptItem.FindControl("sponsorID");
                    Label txtValue = (Label)rptItem.FindControl("txtValue");

                    int intSponsorID;
                    Decimal dValue;
                    bool bStoreSponsorLevel;

                    try
                    {
                        intSponsorID = Int32.Parse(hiddenSponsorID.Value);
                        dValue = (txtValue.Text != String.Empty) ? Decimal.Parse(txtValue.Text) : 0.0m;
                        bStoreSponsorLevel = true;

                        SectionB_SponsorAllocations_DB.UpdateSponsorValue(m_nInitiativeID, intSponsorID, dValue, bStoreSponsorLevel,Session.SessionID);
                    }
                    catch (FormatException)
                    {

                    }
                }
            }
        }

        public int UpdateInitiative()
        {
            int intReturnValue = -1;

            return intReturnValue;
        }


        protected void rptBusiness_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                repeater_LoadControls(sender, e);
            }
        }


        protected void rptGTO_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                repeater_LoadControls(sender, e);
            }
        }


        protected void rptCF_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                repeater_LoadControls(sender, e);
            }
        }


        protected void repeater_LoadControls(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlTableCell tdLabel = (HtmlTableCell)e.Item.FindControl("tdLabel");
                tdLabel.InnerText = DataBinder.Eval(e.Item.DataItem, "Shortname").ToString();
                tdLabel.Attributes.Add("class", "sponsorallocationlabel");

                HtmlTableCell tdValue = (HtmlTableCell)e.Item.FindControl("tdValue");

                Label txtValue = new Label();

                txtValue.ID = "txtValue";
                txtValue.CssClass = "sponsorallocationtext";
                txtValue.Attributes.Add("style", "width: 18px; text-align: center;");
                //txtValue.Attributes.Add("onchange", "computeTotals()");

                tdValue.Controls.Add(txtValue);
                tdValue.Attributes.Add("class", "tablegreybg");
                tdValue.Attributes.Add("style", @"TEXT-ALIGN: center");

                HtmlInputHidden hiddenSponsorID = new HtmlInputHidden();
                hiddenSponsorID.Value = DataBinder.Eval(e.Item.DataItem, "SponsorID").ToString();
                hiddenSponsorID.ID = "sponsorID";

                tdValue.Controls.Add(hiddenSponsorID);

                /*RangeValidator rvAmount = new RangeValidator();
                rvAmount.Type = ValidationDataType.Double;
                rvAmount.MinimumValue = "0";
                rvAmount.MaximumValue = "1000000";
                rvAmount.Text = "*";
                rvAmount.ControlToValidate = txtValue.ID;

                tdValue.Controls.Add(rvAmount);*/

                HtmlTableCell tdPreviousValue = (HtmlTableCell)e.Item.FindControl("tdPreviousValue");

                Label txtPreviousValue = new Label();

                txtPreviousValue.ID = "txtPreviousValue";
                //txtPreviousValue.ReadOnly = true;
                txtPreviousValue.CssClass = "sponsorallocationtext";
                txtPreviousValue.Attributes.Add("style", "width: 18px; text-align: center;");

                tdPreviousValue.Controls.Add(txtPreviousValue);
                tdPreviousValue.Attributes.Add("class", "tablegreybg");
                tdPreviousValue.Attributes.Add("style", @"TEXT-ALIGN: center");


            }
        }


        protected void LoadControls()
        {
            DataView dvBusinessSponsors = new DataView(m_dsSponsors.Tables["Sponsor"]);
            dvBusinessSponsors.RowFilter = "Owner = 'Business'";

            rptBusiness.DataSource = dvBusinessSponsors;
            rptBusiness.DataBind();


            DataView dvGTOSponsors = new DataView(m_dsSponsors.Tables["Sponsor"]);
            dvGTOSponsors.RowFilter = "Owner = 'GTO'";

            rptGTO.DataSource = dvGTOSponsors;
            rptGTO.DataBind();


            DataView dvCFSponsors = new DataView(m_dsSponsors.Tables["Sponsor"]);
            dvCFSponsors.RowFilter = "Owner = 'CF'";

            rptCF.DataSource = dvCFSponsors;
            rptCF.DataBind();

            GenerateJavaScripts();
        }


        protected void GenerateJavaScripts()
        {
            if (!Page.IsStartupScriptRegistered("computeTotals"))
            {
                string strJScript;

                strJScript = "<script language=\"javascript\"> ";
                strJScript += "function computeTotals() { ";
                strJScript += "var totalBusiness, totalGTO, totalCF; ";

                strJScript += "totalBusiness = 0;";
                foreach (RepeaterItem item in rptBusiness.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox txtValue = item.FindControl("txtValue") as TextBox;
                        if (txtValue != null)
                        {
                            strJScript += "percent=";
                            strJScript += "parseFloat(document.getElementById(\"" + txtValue.ClientID + "\").value); ";

                            strJScript += "if (!isNaN(percent)) totalBusiness += percent;";
                        }
                    }
                }

                strJScript += "totalGTO = 0;";
                foreach (RepeaterItem item in rptGTO.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox txtValue = item.FindControl("txtValue") as TextBox;
                        if (txtValue != null)
                        {
                            strJScript += "percent=";
                            strJScript += "parseFloat(document.getElementById(\"" + txtValue.ClientID + "\").value); ";

                            strJScript += "if (!isNaN(percent)) totalGTO += percent;";
                        }
                    }
                }

                strJScript += "totalCF = 0;";
                foreach (RepeaterItem item in rptCF.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox txtValue = item.FindControl("txtValue") as TextBox;
                        if (txtValue != null)
                        {
                            strJScript += "percent=";
                            strJScript += "parseFloat(document.getElementById(\"" + txtValue.ClientID + "\").value); ";

                            strJScript += "if (!isNaN(percent)) totalCF += percent;";
                        }
                    }
                }

                strJScript += "document.getElementById(\"" + txtBusiness.ClientID + "\").value=totalBusiness;";
                strJScript += "document.getElementById(\"" + txtGTO.ClientID + "\").value=totalGTO;";
                strJScript += "document.getElementById(\"" + txtCF.ClientID + "\").value=totalCF;";

                strJScript += "} ";

                strJScript += "function validatePercents(source, arguments)";
                strJScript += "{";

                strJScript += "var totalBusiness, totalGTO, totalCF;";

                strJScript += "totalBusiness = parseFloat(document.getElementById(\"" + txtBusiness.ClientID + "\").value);";
                strJScript += "totalBusiness = isNaN(totalBusiness) ? 0 : totalBusiness;";
                strJScript += "totalGTO = parseFloat(document.getElementById(\"" + txtGTO.ClientID + "\").value);";
                strJScript += "totalGTO = isNaN(totalGTO) ? 0 : totalGTO;";
                strJScript += "totalCF = parseFloat(document.getElementById(\"" + txtCF.ClientID + "\").value);";
                strJScript += "totalCF = isNaN(totalCF) ? 0 : totalCF;";

                strJScript += "if (((totalBusiness + totalGTO + totalCF) != 100) && ((totalBusiness + totalGTO + totalCF) != 0))";
                strJScript += "{ ";
                strJScript += "arguments.IsValid = false;";
                //strJScript += "alert('Percentages must add up to 100%!');";
                strJScript += "} ";

                strJScript += "} ";

                strJScript += "function validatePercentsOnSubmitForReview(source, arguments)";
                strJScript += "{";

                strJScript += "var totalBusiness, totalGTO, totalCF;";

                strJScript += "totalBusiness = parseFloat(document.getElementById(\"" + txtBusiness.ClientID + "\").value);";
                strJScript += "totalBusiness = isNaN(totalBusiness) ? 0 : totalBusiness;";
                strJScript += "totalGTO = parseFloat(document.getElementById(\"" + txtGTO.ClientID + "\").value);";
                strJScript += "totalGTO = isNaN(totalGTO) ? 0 : totalGTO;";
                strJScript += "totalCF = parseFloat(document.getElementById(\"" + txtCF.ClientID + "\").value);";
                strJScript += "totalCF = isNaN(totalCF) ? 0 : totalCF;";

                strJScript += "if ((totalBusiness + totalGTO + totalCF) != 100)";
                strJScript += "{ ";
                strJScript += "arguments.IsValid = false;";
                //strJScript += "alert('Percentages must add up to 100%!');";
                strJScript += "} ";

                strJScript += "} ";

                strJScript += "computeTotals(); ";
                strJScript += "</script>";

                Page.RegisterStartupScript("computeTotals", strJScript);
            }
        }

    }
}