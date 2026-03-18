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
    ///		Summary description for SectionG.
    /// </summary>
    public partial class SectionG_PrintVersion : System.Web.UI.UserControl
    {
        protected DataSet dsValue;
        protected DataSet dsPeriod;

        protected int nInitiativeID;

        protected System.Web.UI.WebControls.DropDownList Dropdownlist6;

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

            if (!Page.IsPostBack)
            {
                BindDropdowns();
                LoadInitiative();
            }

            LoadDataSets();
            BindRepeater();

            txtCIOArchApprover.Attributes.Add("onfocus", "parent.focus();");
        }

        protected void BindDropdowns()
        {
            DataSet dsYesNo = Global_DB.GetReferenceTable(7); //CategoryID = 20 for Yes,NO

            if (dsYesNo.Tables["Reference"].Rows.Count > 0)
            {
                
                /*
                ddlUsesAproved3rdParty.DataValueField = "ReferenceID";
                ddlUsesAproved3rdParty.DataTextField = "Description";

                ddlUsesAproved3rdParty.DataSource = dsYesNo.Tables["Reference"];
                ddlUsesAproved3rdParty.DataBind();

                
                ddlTechnicalArchCompliant.DataValueField = "ReferenceID";
                ddlTechnicalArchCompliant.DataTextField = "Description";

                ddlTechnicalArchCompliant.DataSource = dsYesNo.Tables["Reference"];
                ddlTechnicalArchCompliant.DataBind();

                
                ddlBusinessArchInfo.DataValueField = "ReferenceID";
                ddlBusinessArchInfo.DataTextField = "Description";

                ddlBusinessArchInfo.DataSource = dsYesNo.Tables["Reference"];
                ddlBusinessArchInfo.DataBind();

                
                ddlApplicationArchCompliant.DataValueField = "ReferenceID";
                ddlApplicationArchCompliant.DataTextField = "Description";

                ddlApplicationArchCompliant.DataSource = dsYesNo.Tables["Reference"];
                ddlApplicationArchCompliant.DataBind();

                
                ddlApplicationArchCompliant.DataValueField = "ReferenceID";
                ddlApplicationArchCompliant.DataTextField = "Description";

                ddlApplicationArchCompliant.DataSource = dsYesNo.Tables["Reference"];
                ddlApplicationArchCompliant.DataBind();

                
                ddlTechnicalArchSatisfied.DataValueField = "ReferenceID";
                ddlTechnicalArchSatisfied.DataTextField = "Description";

                ddlTechnicalArchSatisfied.DataSource = dsYesNo.Tables["Reference"];
                ddlTechnicalArchSatisfied.DataBind();

                
                ddlDevelopmentArchCompl.DataValueField = "ReferenceID";
                ddlDevelopmentArchCompl.DataTextField = "Description";

                ddlDevelopmentArchCompl.DataSource = dsYesNo.Tables["Reference"];
                ddlDevelopmentArchCompl.DataBind();
                 */
            }



        }

        protected void BindRepeater()
        {
            repeaterImpact.DataSource = SectionG_DB.GetImpacts(nInitiativeID);
            repeaterImpact.DataBind();
        }

        protected void LoadDataSets()
        {
            //dsPeriod = Global_DB.GetPeriods(nInitiativeID);
            dsPeriod = Global_DB.GetPeriodsForDisplay(nInitiativeID);

            int nTypeID = 1; //Impact
            dsValue = SectionG_DB.GetImpactValues(nInitiativeID, nTypeID);
        }


        private void LoadInitiative()
        {

            DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                txtCIOArchApprover.Text = drInitiative["CIOArchitectureApprover"].ToString();
                hiddenCIOArchApprover.Value = drInitiative["CIOArchitectureApproverID"].ToString();

                txtCIOArchApDate.Text = (drInitiative["CIOArchitectureApprovalDate"] != DBNull.Value) ?
                    ((DateTime)drInitiative["CIOArchitectureApprovalDate"]).ToShortDateString() : "";

                ddlUsesAproved3rdParty.Text = drInitiative["UsesApproved3rdPartySoftware"].ToString();
                ddlTechnicalArchCompliant.Text = drInitiative["TechnicalArchitectureCompliant"].ToString();
                ddlBusinessArchInfo.Text = drInitiative["BusinessArchitectureInfoProvided"].ToString();
                ddlApplicationArchCompliant.Text = drInitiative["ApplicationArchitetureCompliant"].ToString();
                ddlTechnicalArchSatisfied.Text = drInitiative["TechnicalArchitectureSatisfied"].ToString();
                ddlDevelopmentArchCompl.Text = drInitiative["DevelopmentArchitectureCompliant"].ToString();

                txtJustificationForDeviation.Text = Global.TextToHTML(drInitiative["GTOJustification4Deviation"].ToString());

                if ((drInitiative["UsesApproved3rdPartySoftwareID"].ToString() == "1" ||
                     drInitiative["UsesApproved3rdPartySoftwareID"].ToString() == "3") && 
                    (drInitiative["TechnicalArchitectureCompliantID"].ToString() == "1" ||
                     drInitiative["TechnicalArchitectureCompliantID"].ToString() == "3") && 
                    (drInitiative["BusinessArchitectureInfoProvidedID"].ToString() == "1" ||
                     drInitiative["BusinessArchitectureInfoProvidedID"].ToString() == "3") && 
                    (drInitiative["ApplicationArchitetureCompliantID"].ToString() == "1" ||
                     drInitiative["ApplicationArchitetureCompliantID"].ToString() == "3") && 
                    (drInitiative["TechnicalArchitectureSatisfiedID"].ToString() == "1" ||
                     drInitiative["TechnicalArchitectureSatisfiedID"].ToString() == "3") && 
                    (drInitiative["DevelopmentArchitectureCompliantID"].ToString() == "1" ||
                     drInitiative["DevelopmentArchitectureCompliantID"].ToString() == "3")) 
                {
                    txtApprovedByCorporate.Text = "Yes";
                }
                else
                {
                    txtApprovedByCorporate.Text = "No";
                }
            }
        }


        protected void repeaterImpact_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            HtmlTableRow row;
            Decimal dcAmountTotal;
            string strCondition;

            //headers
            if (e.Item.ItemType == ListItemType.Header)
            {


                row = (HtmlTableRow)e.Item.FindControl("HeaderID");
                if (row != null)
                {

                    for (int index = 1; index <= dsPeriod.Tables["Period"].Rows.Count; index++)
                    {
                        HtmlTableCell headerCell = new HtmlTableCell();
                        headerCell.Attributes.Add("width", "55");
                        headerCell.Attributes.Add("class", "headcell");
                        headerCell.Attributes.Add("align", "center");

                        headerCell.InnerHtml = dsPeriod.Tables["Period"].Rows[index - 1]["Name"].ToString();
                        row.Cells.Add(headerCell);
                    }


                    HtmlTableCell headerCellTotal = new HtmlTableCell();
                    headerCellTotal.Attributes.Add("width", "60");
                    headerCellTotal.Attributes.Add("class", "headcell");
                    headerCellTotal.Attributes.Add("align", "center");
                    headerCellTotal.InnerHtml = "Total";
                    row.Cells.Add(headerCellTotal);

                    HtmlTableCell headerCellRemediation = new HtmlTableCell();
                    headerCellRemediation.Attributes.Add("width", "125");
                    headerCellRemediation.Attributes.Add("class", "headcell");
                    headerCellRemediation.Attributes.Add("align", "left");
                    headerCellRemediation.InnerHtml = "Remediation";
                    row.Cells.Add(headerCellRemediation);
                }


            }
            //..headers


            //items
            else if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                int nImpactID = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "InitiativeImpactID"));

                row = (e.Item.ItemType == ListItemType.Item) ? (HtmlTableRow)e.Item.FindControl("RowID") : (HtmlTableRow)e.Item.FindControl("AlternateRowID");
                string strClass = (e.Item.ItemType == ListItemType.Item) ? "incell" : "alternateincell";

                if (row != null)
                {
                    for (int index = 1; index <= dsPeriod.Tables["Period"].Rows.Count; index++)
                    {

                        strCondition = "ReferenceID=" + nImpactID.ToString() + " AND PeriodID=" + dsPeriod.Tables["Period"].Rows[index - 1]["PeriodID"].ToString();
                        HtmlTableCell itemCell = new HtmlTableCell();
                        itemCell.Attributes.Add("align", "center");
                        itemCell.Attributes.Add("class", strClass);

                        DataRow[] dRows;
                        dRows = dsValue.Tables["ImpactValue"].Select(strCondition);

                        Decimal dcAmount;
                        try
                        {
                            object objAmount = dRows[0]["Amount"];
                            dcAmount = Convert.ToDecimal(objAmount);
                        }
                        catch (Exception e1)
                        {
                            dcAmount = 0;
                        }

                        itemCell.InnerHtml = dcAmount.ToString("N2");
                        row.Cells.Add(itemCell);

                    }

                    strCondition = "ReferenceID=" + nImpactID.ToString();

                    HtmlTableCell itemCellTotal = new HtmlTableCell();
                    itemCellTotal.Attributes.Add("align", "center");
                    itemCellTotal.Attributes.Add("class", strClass);

                    try
                    {
                        dcAmountTotal = Convert.ToDecimal(dsValue.Tables["ImpactValue"].Compute("SUM(Amount)", strCondition));
                    }
                    catch (Exception e1)
                    {
                        dcAmountTotal = 0;
                    }
                    itemCellTotal.InnerHtml = dcAmountTotal.ToString("N2");
                    row.Cells.Add(itemCellTotal);

                    HtmlTableCell itemCellRemediation = new HtmlTableCell();
                    itemCellRemediation.Attributes.Add("align", "left");
                    itemCellRemediation.Attributes.Add("class", strClass);
                    itemCellRemediation.InnerHtml = DataBinder.Eval(e.Item.DataItem, "Remediation").ToString();
                    row.Cells.Add(itemCellRemediation);

                }

            }
            //..items

            //footers
            if (e.Item.ItemType == ListItemType.Footer)
            {

                row = (HtmlTableRow)e.Item.FindControl("FooterID1");
                if (row != null)
                {

                    for (int index = 1; index <= dsPeriod.Tables["Period"].Rows.Count; index++)
                    {
                        strCondition = "PeriodID=" + dsPeriod.Tables["Period"].Rows[index - 1]["PeriodID"].ToString();

                        HtmlTableCell FooterCell = new HtmlTableCell();
                        FooterCell.Attributes.Add("class", "totalcell");
                        FooterCell.Attributes.Add("align", "center");

                        try
                        {
                            dcAmountTotal = Convert.ToDecimal(dsValue.Tables["ImpactValue"].Compute("SUM(Amount)", strCondition));
                        }
                        catch (Exception e1)
                        {
                            dcAmountTotal = 0;
                        }

                        FooterCell.InnerHtml = dcAmountTotal.ToString("N2");
                        row.Cells.Add(FooterCell);
                    }
                }

                HtmlTableCell tdEmpty = new HtmlTableCell();
                tdEmpty.Attributes.Add("class", "totalcell");

                row.Cells.Add(tdEmpty);

                tdEmpty = new HtmlTableCell();
                tdEmpty.Attributes.Add("class", "emptytotal");
                tdEmpty.Attributes.Add("style", "border-top: 1px solid;");

                row.Cells.Add(tdEmpty);


                row = (HtmlTableRow)e.Item.FindControl("FooterID2");
                if (row != null)
                {
                    HtmlTableCell footerCellTotal = new HtmlTableCell();
                    footerCellTotal.Attributes.Add("class", "totalcell");
                    footerCellTotal.Attributes.Add("align", "center");

                    try
                    {
                        dcAmountTotal = Convert.ToDecimal(dsValue.Tables["ImpactValue"].Compute("SUM(Amount)", ""));
                    }
                    catch (Exception e1)
                    {
                        dcAmountTotal = 0;
                    }

                    footerCellTotal.InnerHtml = dcAmountTotal.ToString("N2");
                    row.Cells.Add(footerCellTotal);

                    tdEmpty = new HtmlTableCell();
                    tdEmpty.Attributes.Add("class", "empty");

                    row.Cells.Add(tdEmpty);
                }



            }
            //..footer


        }
    }
}
