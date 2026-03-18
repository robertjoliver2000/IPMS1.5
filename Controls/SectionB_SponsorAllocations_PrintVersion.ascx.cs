
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

	/// <summary>
	///		provides database support for SectionB - Sponsor Allocations web control
	/// </summary>
	public partial class SectionB_SponsorAllocations_PrintVersion : System.Web.UI.UserControl
	{
        protected int nInitiativeID;
        protected DataSet m_dsSponsors;
        protected DataSet m_dsSponsorValues;

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
            
            m_dsSponsors = SectionB_SponsorAllocations_DB.GetSponsors();

            LoadControls();

			if (!Page.IsPostBack)
			{
				//FillDropDowns();
				LoadInitiative();
			}
        }

 		private void LoadInitiative()
		{
			
			DataRow drInitiative = SectionB_SponsorAllocations_DB.GetInitiativeDetails(nInitiativeID);

			if (drInitiative != null)
			{
				ddlAllocationAgreed.Text = drInitiative["AllocationsAgreed"].ToString();
				ddlInitiativeBudget.Text = drInitiative["InitiativeBudgeted"].ToString();
                ddlBasisForAllocation.Text = drInitiative["BasisForAllocation"].ToString();
                txtBasisForAllocationDescription.Text = drInitiative["BasisForAllocationDescription"].ToString();
			}

            m_dsSponsorValues = SectionB_SponsorAllocations_DB.GetSponsorValues(nInitiativeID);

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
        }


        private void LoadSponsorValues(Repeater rptValues)
        {
            foreach (RepeaterItem rptItem in rptValues.Items)
            {
                if (rptItem.ItemType == ListItemType.Item || rptItem.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlTableCell tdLabel = (HtmlTableCell)rptItem.FindControl("tdLabel");
                    HtmlInputHidden hiddenSponsorID = (HtmlInputHidden)rptItem.FindControl("sponsorID");

                    DataRow[] drResults = m_dsSponsorValues.Tables["SponsorValue"].Select(
                                    "SponsorID=" + hiddenSponsorID.Value);

                    if (drResults.Length > 0)
                    {
                        DataRow drSponsorValue = drResults[0];

                        Label txtValue = (Label)rptItem.FindControl("txtValue");
                        txtValue.Text = ((Decimal)drSponsorValue["Allocation"]).ToString("G6");
                    }
                }
            }
        }


        private void UpdateSponsorValues(int nInitiativeID, Repeater rptValues)
        {
            foreach (RepeaterItem rptItem in rptValues.Items)
            {
                if (rptItem.ItemType == ListItemType.Item || rptItem.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlInputHidden hiddenSponsorID = (HtmlInputHidden)rptItem.FindControl("sponsorID");
                    TextBox txtValue = (TextBox)rptItem.FindControl("txtValue");

                    int intSponsorID;
                    Decimal dValue;
                    bool bStoreSponsorLevel;

                    try
                    {
                        intSponsorID = Int32.Parse(hiddenSponsorID.Value);
                        dValue = (txtValue.Text != String.Empty) ? Decimal.Parse(txtValue.Text) : 0.0m;
                        bStoreSponsorLevel = true;

                        SectionB_SponsorAllocations_DB.UpdateSponsorValue(nInitiativeID, intSponsorID, dValue, bStoreSponsorLevel,Session.SessionID);
                    }
                    catch(FormatException)
                    {

                    }
                }
            }
        }

        public int UpdateInitiative()
        {
            return -1;
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
                
                HtmlTableCell tdValue = (HtmlTableCell)e.Item.FindControl("tdValue");

                Label txtValue = new Label();

                txtValue.ID = "txtValue";
                txtValue.CssClass = "sponsorallocationtext";
                txtValue.Attributes.Add("style", "width: 30px; text-align: center;");
                //txtValue.Attributes.Add("onchange", "computeTotals()");

                tdValue.Controls.Add(txtValue);
                tdValue.Attributes.Add("class", "tablegreybg");
                tdValue.Attributes.Add("style", @"TEXT-ALIGN: center");

                /*
                RangeValidator rvAmount = new RangeValidator();
                rvAmount.Type = ValidationDataType.Double;
                rvAmount.MinimumValue = "0";
                rvAmount.MaximumValue = "1000000";
                rvAmount.Text = "*";
                rvAmount.ControlToValidate = txtValue.ID;

                tdValue.Controls.Add(rvAmount);
                */

                HtmlInputHidden hiddenSponsorID = new HtmlInputHidden();
                hiddenSponsorID.Value = DataBinder.Eval(e.Item.DataItem, "SponsorID").ToString();
                hiddenSponsorID.ID = "sponsorID";

                tdValue.Controls.Add(hiddenSponsorID);
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
            strJScript += "alert('Percentages must add up to 100%!');";
            strJScript += "}";

            strJScript += "}";

            strJScript += "</script>";

            Page.RegisterStartupScript("computeTotals", strJScript);
        }
	}
}
