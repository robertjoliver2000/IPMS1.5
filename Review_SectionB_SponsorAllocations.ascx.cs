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

    public partial class Review_SectionB_SponsorAllocations : System.Web.UI.UserControl
    {
        protected int m_nInitiativeID;
        protected int m_nPreviousVersion_InitiativeID;
        protected DataSet m_dsSponsors;
        protected DataSet m_dsSponsorValues;
        protected DataSet m_dsPrevious_SponsorValues;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            string strCSValidation = "function fn_cvBasisForAllocationDescription( src, args )\n" +
                                            "{\n" +
                                            "args.IsValid = ( args.Value.length <= 50 );\n" +
                                            "}\n";
            string strCSKey = "fn_cvBasisForAllocationDescription";
            ClientScriptManager cs = Page.ClientScript;
            Type t = Page.GetType();
            if(!cs.IsClientScriptBlockRegistered(t, strCSKey))
            {
                cs.RegisterClientScriptBlock(t, strCSKey, strCSValidation, true);
            }

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

            //txtBasisForAllocationDescription.Attributes["onkeydown"] = "if(value.length>=50&&){ value=value.substring(0, 50);}";

            if (!Page.IsPostBack)
            {
                ClearTempEditingTables();
                FillDropDowns();
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
                ddlAllocationAgreed.SelectedValue = drInitiative["AllocationsAgreedID"].ToString();
                ddlInitiativeBudget.SelectedValue = drInitiative["InitiativeBudgetedID"].ToString();
                ddlBasisForAllocation.SelectedValue = drInitiative["BasisForAllocationID"].ToString();
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

                        TextBox txtValue = (TextBox)rptItem.FindControl("txtValue");
                        txtValue.Text = ((Decimal)drSponsorValue["Allocation"]).ToString("G6");

                        HtmlInputHidden hiddenStoreSponsorLevel = (HtmlInputHidden)rptItem.FindControl("StoreSponsorLevel");
                        hiddenStoreSponsorLevel.Value = drSponsorValue["StoreSponsorLevel"].ToString();
                    }

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

        private void UpdateSponsorValues(int m_nInitiativeID, Repeater rptValues)
        {
            foreach (RepeaterItem rptItem in rptValues.Items)
            {
                if (rptItem.ItemType == ListItemType.Item || rptItem.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlInputHidden hiddenSponsorID = (HtmlInputHidden)rptItem.FindControl("sponsorID");
                    TextBox txtValue = (TextBox)rptItem.FindControl("txtValue");
                    HtmlInputHidden hiddenStoreSponsorLevel = (HtmlInputHidden)rptItem.FindControl("StoreSponsorLevel");

                    int intSponsorID;
                    Decimal dValue;
                    bool bStoreSponsorLevel;

                    try
                    {
                        intSponsorID = Int32.Parse(hiddenSponsorID.Value);
                        dValue = (txtValue.Text != String.Empty) ? Decimal.Parse(txtValue.Text) : 0.0m;
                        bStoreSponsorLevel = (hiddenStoreSponsorLevel.Value == "1" || hiddenStoreSponsorLevel.Value.ToLower() == "true");

                        SectionB_SponsorAllocations_DB.UpdateSponsorValue(m_nInitiativeID, intSponsorID, dValue, bStoreSponsorLevel,Session.SessionID);
                    }
                    catch (FormatException)
                    {

                    }
                }
            }
        }

        private void FillDropDowns()
        {
            DataSet dsSummaryQuestion = Global_DB.GetReferenceTable(7);

            ddlAllocationAgreed.DataSource = dsSummaryQuestion.Tables["Reference"];
            ddlAllocationAgreed.DataValueField = "ReferenceID";
            ddlAllocationAgreed.DataTextField = "Description";

            ddlAllocationAgreed.DataBind();


            ddlInitiativeBudget.DataSource = dsSummaryQuestion.Tables["Reference"];
            ddlInitiativeBudget.DataValueField = "ReferenceID";
            ddlInitiativeBudget.DataTextField = "Description";

            ddlInitiativeBudget.DataBind();


            DataSet dsBasisForAllocation = Global_DB.GetReferenceTable(35);

            ddlBasisForAllocation.DataSource = dsBasisForAllocation.Tables["Reference"];
            ddlBasisForAllocation.DataValueField = "ReferenceID";
            ddlBasisForAllocation.DataTextField = "Description";

            ddlBasisForAllocation.DataBind();

        }

        public int UpdateInitiative()
        {
            int intReturnValue = -1;

            if (m_nInitiativeID > 0)
            {
                intReturnValue = SectionB_SponsorAllocations_DB.UpdateInitiative(
                        m_nInitiativeID,
                        ddlAllocationAgreed.SelectedItem.Text, Convert.ToInt32(ddlAllocationAgreed.SelectedValue),
                        ddlInitiativeBudget.SelectedItem.Text, Convert.ToInt32(ddlInitiativeBudget.SelectedValue),
                        ddlBasisForAllocation.SelectedItem.Text, Convert.ToInt32(ddlBasisForAllocation.SelectedValue),
                        txtBasisForAllocationDescription.Text
                    );
            }

            UpdateSponsorValues(m_nInitiativeID, rptBusiness);
            UpdateSponsorValues(m_nInitiativeID, rptGTO);
            UpdateSponsorValues(m_nInitiativeID, rptCF);
            SectionB_SponsorAllocations_DB.DeleteInitiativeSponsorUBRAllocationsForEdit(Session.SessionID, m_nInitiativeID, -1);
            LoadInitiative();

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
            string sLabel = "";

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlTableCell tdLabel = (HtmlTableCell)e.Item.FindControl("tdLabel");
                tdLabel.InnerText = DataBinder.Eval(e.Item.DataItem, "Shortname").ToString();
                sLabel = tdLabel.InnerText;

                HtmlTableCell tdValue = (HtmlTableCell)e.Item.FindControl("tdValue");

                HtmlInputHidden hiddenStoreSponsorLevel = new HtmlInputHidden();
                hiddenStoreSponsorLevel.ID = "StoreSponsorLevel";
                tdValue.Controls.Add(hiddenStoreSponsorLevel);

                TextBox txtValue = new TextBox();

                txtValue.ID = "txtValue";
                txtValue.CssClass = "textinput";
                txtValue.Attributes.Add("style", "width: 50px; text-align: center;");
                HtmlInputHidden flagElt = (HtmlInputHidden)e.Item.FindControl("StoreSponsorLevel");
                txtValue.Attributes.Add("onchange", "validateText(this); setStoreSponsorLevel( '" + flagElt.ClientID.ToString() + "', 'True'); computeTotals();");
                txtValue.Attributes.Add("onkeyup", "validateText(this); computeTotals();");

                tdValue.Controls.Add(txtValue);

                RangeValidator rvAmount = new RangeValidator();
                rvAmount.Type = ValidationDataType.Double;
                rvAmount.MinimumValue = "0";
                rvAmount.MaximumValue = "1000000";
                rvAmount.Text = "*";
                rvAmount.ControlToValidate = txtValue.ID;
                tdValue.Controls.Add(rvAmount);

                HtmlInputHidden hiddenSponsorID = new HtmlInputHidden();
                hiddenSponsorID.Value = DataBinder.Eval(e.Item.DataItem, "SponsorID").ToString();
                hiddenSponsorID.ID = "sponsorID";
                tdValue.Controls.Add(hiddenSponsorID);

                HtmlTableCell tdLink = (HtmlTableCell)e.Item.FindControl("tdLink");

                HyperLink lnkValue = new HyperLink();
                lnkValue.ID = "lnkValue";
                lnkValue.Text = "";
                lnkValue.ImageUrl = "../images/pick.jpg";
                TextBox valElt = (TextBox)e.Item.FindControl("txtValue");
                lnkValue.NavigateUrl = "javascript: bAllowSubmit = false; void 0;";
                lnkValue.Attributes.Add("onclick", "bAllowSubmit = true; popupWindowSelectUBR(" + m_nInitiativeID + ",'" + hiddenSponsorID.Value.ToString() + "', '" + flagElt.ClientID.ToString() + "', '" + valElt.ClientID.ToString() + "');");

                tdLink.Controls.Add(lnkValue);

                HtmlTableCell tdPreviousValue = (HtmlTableCell)e.Item.FindControl("tdPreviousValue");

                TextBox txtPreviousValue = new TextBox();

                txtPreviousValue.ID = "txtPreviousValue";
                txtPreviousValue.ReadOnly = true;
                txtPreviousValue.CssClass = "textinput";
                txtPreviousValue.Attributes.Add("style", "width: 50px; text-align: center;");

                tdPreviousValue.Controls.Add(txtPreviousValue);

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
                strJScript += "totalBusiness = Math.round(totalBusiness*100)/100;";

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
                strJScript += "totalGTO = Math.round(totalGTO*100)/100;";

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
                strJScript += "totalCF = Math.round(totalCF*100)/100;";

                strJScript += "document.getElementById(\"" + txtBusiness.ClientID + "\").value=totalBusiness;";
                strJScript += "document.getElementById(\"" + txtGTO.ClientID + "\").value=totalGTO;";
                strJScript += "document.getElementById(\"" + txtCF.ClientID + "\").value=totalCF;";

                strJScript += "} ";

                strJScript += "function validatePercents(source, arguments)";
                strJScript += "{";

                strJScript += "var totalBusiness, totalGTO, totalCF, totalAllocation;";

                strJScript += "totalBusiness = parseFloat(document.getElementById(\"" + txtBusiness.ClientID + "\").value);";
                strJScript += "totalBusiness = isNaN(totalBusiness) ? 0 : totalBusiness;";
                strJScript += "totalGTO = parseFloat(document.getElementById(\"" + txtGTO.ClientID + "\").value);";
                strJScript += "totalGTO = isNaN(totalGTO) ? 0 : totalGTO;";
                strJScript += "totalCF = parseFloat(document.getElementById(\"" + txtCF.ClientID + "\").value);";
                strJScript += "totalCF = isNaN(totalCF) ? 0 : totalCF;";

                strJScript += "totalAllocation = Math.round((totalBusiness + totalGTO + totalCF)*100)/100;";

                strJScript += "if ((totalAllocation != 100) && (totalAllocation != 0))";
                strJScript += "{ ";
                strJScript += "arguments.IsValid = false;";
                //strJScript += "alert('Percentages must add up to 100%!');";
                strJScript += "} ";

                strJScript += "} ";

                strJScript += "function validatePercentsOnSubmitForReview(source, arguments)";
                strJScript += "{";

                strJScript += "var totalBusiness, totalGTO, totalCF, totalAllocation;";

                strJScript += "totalBusiness = parseFloat(document.getElementById(\"" + txtBusiness.ClientID + "\").value);";
                strJScript += "totalBusiness = isNaN(totalBusiness) ? 0 : totalBusiness;";
                strJScript += "totalGTO = parseFloat(document.getElementById(\"" + txtGTO.ClientID + "\").value);";
                strJScript += "totalGTO = isNaN(totalGTO) ? 0 : totalGTO;";
                strJScript += "totalCF = parseFloat(document.getElementById(\"" + txtCF.ClientID + "\").value);";
                strJScript += "totalCF = isNaN(totalCF) ? 0 : totalCF;";

                strJScript += "totalAllocation = Math.round((totalBusiness + totalGTO + totalCF)*100)/100;";

                strJScript += "if (totalAllocation != 100)";
                strJScript += "{ ";
                strJScript += "arguments.IsValid = false;";
                //strJScript += "alert('Percentages must add up to 100%!');";
                strJScript += "} ";

                strJScript += "} ";


                strJScript += "function validateText(textBox)";
                strJScript += "{";
                strJScript += "if  (!isNaN(parseFloat(textBox.value)) && ";
                strJScript += "textBox.value.lastIndexOf('.') >= 0 && ";
                strJScript += "textBox.value.length - textBox.value.lastIndexOf('.') > 3)";
                strJScript += "{";
                strJScript += "textBox.value = textBox.value.substr(0, (textBox.value.lastIndexOf('.') + 3)); ";
                strJScript += "}";
                strJScript += "}";


                strJScript += "computeTotals(); ";
                strJScript += "</script>";

                Page.RegisterStartupScript("computeTotals", strJScript);
            }
        }


        protected void ClearTempEditingTables()
        {
            SectionB_SponsorAllocations_DB.DeleteInitiativeSponsorUBRAllocationsForEdit(Session.SessionID, m_nInitiativeID, -1);
        }

    }

}