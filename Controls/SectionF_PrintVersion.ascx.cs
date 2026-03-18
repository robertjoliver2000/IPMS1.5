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

    public partial class SectionF_PrintVersion : System.Web.UI.UserControl
    {
        protected System.Web.UI.WebControls.DropDownList Dropdownlist6;

        protected int nInitiativeID;

        protected DataSet dsValue;
        protected DataSet dsPeriod;

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

            txtIESArchApprover.Attributes.Add("onfocus", "parent.focus();");
        }


        private void LoadDataSets()
        {
            //dsPeriod = Global_DB.GetPeriods(nInitiativeID);
            dsPeriod = Global_DB.GetPeriodsForDisplay(nInitiativeID);

            int nTypeID;
            nTypeID = 3; //Product

            dsValue = SectionF_DB.GetImpactValues(nInitiativeID, nTypeID);
        }


        private void BindRepeater()
        {
            repeaterProduct.DataSource = SectionF_DB.GetProducts(nInitiativeID);
            repeaterProduct.DataBind();
        }

        private void BindDropdowns()
        {
            DataSet dsYesNo = Global_DB.GetReferenceTable(7); //CategoryID = 20 for Yes,NO

            if (dsYesNo.Tables["Reference"].Rows.Count > 0)
            {
                //-----------
                /*
                ddlFullyCompliant.DataValueField = "ReferenceID";
                ddlFullyCompliant.DataTextField = "Description";

                ddlFullyCompliant.DataSource = dsYesNo.Tables["Reference"];
                ddlFullyCompliant.DataBind();
                */
            }
        }

        private void LoadInitiative()
        {

            DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                //ddlIESArchApprover.SelectedValue = drInitiative["IESArchitectureApproverID"].ToString();
                txtIESArchApprover.Text = drInitiative["IESArchitectureApprover"].ToString();
                hiddenIESArchApprover.Value = drInitiative["IESArchitectureApproverID"].ToString();

                txtIESArchApDate.Text = (drInitiative["IESArchitectureApprovalDate"] != DBNull.Value) ?
                    ((DateTime)drInitiative["IESArchitectureApprovalDate"]).ToShortDateString() : "";

                ddlFullyCompliant.Text = drInitiative["IESFullyCompliant"].ToString();

                txtIESFinancialJustification.Text = Global.TextToHTML(drInitiative["IESFinancialJustification"].ToString());
            }
        }


        public int UpdateInitiative()
        {
            return -1;             
        }


        protected void repeaterProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
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

                int nProductID = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "InitiativeProductID"));

                row = (e.Item.ItemType == ListItemType.Item) ? (HtmlTableRow)e.Item.FindControl("RowID") : (HtmlTableRow)e.Item.FindControl("AlternateRowID");
                string strClass = (e.Item.ItemType == ListItemType.Item) ? "incell" : "alternateincell";

                if (row != null)
                {
                    for (int index = 1; index <= dsPeriod.Tables["Period"].Rows.Count; index++)
                    {

                        strCondition = "ReferenceID=" + nProductID.ToString() + " AND PeriodID=" + dsPeriod.Tables["Period"].Rows[index - 1]["PeriodID"].ToString();
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

                    strCondition = "ReferenceID=" + nProductID.ToString();

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

                    HtmlTableCell tdEmpty = new HtmlTableCell();
                    tdEmpty.Attributes.Add("class", "totalcell");

                    row.Cells.Add(tdEmpty);

                    tdEmpty = new HtmlTableCell();
                    tdEmpty.Attributes.Add("class", "emptytotal");
                    tdEmpty.Attributes.Add("style", "border-top: 1px solid;");

                    row.Cells.Add(tdEmpty);
                }

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

                    HtmlTableCell itemCellRemediation = new HtmlTableCell();
                    itemCellRemediation.Attributes.Add("align", "left");
                    row.Cells.Add(itemCellRemediation);
                }



            }
            //..footer
        }

    }
}
