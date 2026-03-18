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
    public partial class Product : System.Web.UI.Page
    {
        protected int nInitiativeID;
        protected DataSet dsPeriod;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Page.RegisterStartupScript("validateType",
                          "<script language=\"javascript\"> " +
                               "function validateType(source, arguments) {" +
                                   "if (document.getElementById(\"" + ddlProductType.ClientID + "\").selectedIndex > 0)" +
                                   "arguments.IsValid=true; " +
                                   "else " +
                                   "arguments.IsValid=false; " +
                               "} " +
                          "</script>");
            
            try
            {
                nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                nInitiativeID = -1;
            }

            LoadDataSets();
            BindRepeater();

            if (!Page.IsPostBack)
            {
                BindDropdowns();
                
                object objProductID = Request.QueryString["ProductID"];
                if (objProductID != null)
                    EditProduct(objProductID);
            }
        }
        
        protected void LoadDataSets()
        {
            //dsPeriod = Global_DB.GetPeriods(nInitiativeID);
            dsPeriod = Global_DB.GetPeriodsForDisplay(nInitiativeID);
        }

        protected void BindRepeater()
        {
            repeaterPeriods.DataSource = dsPeriod;
            repeaterPeriods.DataBind();
        }

        private void BindDropdowns()
        {
            DataSet dsProductType = Global_DB.GetReferenceTable(25); //CategoryID = 22 for noncompliancetype
            DataSet dsCTBRTB = Global_DB.GetReferenceTable(23);//CategoryID = 23 for CTBRTB
            DataSet dsCIOIES = Global_DB.GetReferenceTable(24);//CategoryID = 24 for CIOIES

            if (dsProductType.Tables["Reference"].Rows.Count > 0)
            {
                ddlProductType.DataValueField = "ReferenceID";
                ddlProductType.DataTextField = "Description";

                ddlProductType.DataSource = dsProductType.Tables["Reference"];
                ddlProductType.DataBind();


            }

            if (dsCTBRTB.Tables["Reference"].Rows.Count > 0)
            {
                ddlCTBRTB.DataValueField = "ReferenceID";
                ddlCTBRTB.DataTextField = "Description";

                ddlCTBRTB.DataSource = dsCTBRTB.Tables["Reference"];
                ddlCTBRTB.DataBind();

            }


            if (dsCIOIES.Tables["Reference"].Rows.Count > 0)
            {
                ddlCIOIES.DataValueField = "ReferenceID";
                ddlCIOIES.DataTextField = "Description";

                ddlCIOIES.DataSource = dsCIOIES.Tables["Reference"];
                ddlCIOIES.DataBind();

            }

        }

        private void EditProduct(object objProductID)
        {
            int nProductID;

            try
            {
                nProductID = Int32.Parse(objProductID.ToString());
            }
            catch (Exception e1)
            {
                nProductID = 0;
            }

            decimal dcAmount;

            
            //typeID=3 for product 
            DataSet dsProduct = SectionF_DB.GetProduct(nInitiativeID, nProductID, 3);
            DataRow dRow = dsProduct.Tables["Product"].Rows[0];

            txtProductName.Text = dRow["ProductName"].ToString();
            txtTVendor.Text = dRow["TVendor"].ToString();

            ddlProductType.SelectedIndex = Convert.ToInt32(dRow["ProductTypeID"]);
            ddlCTBRTB.SelectedIndex = Convert.ToInt32(dRow["CTB_RTBID"]);
            ddlCIOIES.SelectedIndex = Convert.ToInt32(dRow["CIO_IESID"]);

            txtRemediation.Text = dRow["Remediation"].ToString();

            int nPeriodID;
            string strCondition;

            foreach (RepeaterItem item in repeaterPeriods.Items)
            {

                HtmlTableRow row;
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    row = (item.ItemType == ListItemType.Item) ? (HtmlTableRow)item.FindControl("RowID") : (HtmlTableRow)item.FindControl("AlternateRowID");

                    HtmlTableCell cell;
                    cell = (HtmlTableCell)row.FindControl("cellTxt");

                    TextBox txtBox;
                    txtBox = (TextBox)cell.FindControl("txt");
                    HtmlInputHidden hidden;
                    hidden = (HtmlInputHidden)cell.FindControl("hidden");

                    try
                    {
                        nPeriodID = Convert.ToInt32(hidden.Value);
                    }
                    catch (Exception e1)
                    {
                        nPeriodID = 0;
                    }
                    strCondition = "PeriodID=" + nPeriodID.ToString();


                    try
                    {
                        dcAmount = Convert.ToDecimal(
                            dsProduct.Tables["Product"].Select(strCondition)[0]["Amount"].ToString());
                    }
                    catch (Exception e2)
                    {
                        dcAmount = 0;
                    }


                    txtBox.Text = dcAmount.ToString("N2");


                }

            }


        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            object objProductID = Request.QueryString["ProductID"];

            int nProductID;

            if (objProductID== null) 
            {
                nProductID=SectionF_DB.InsertInitiativeProduct(
                                                    nInitiativeID,
                                                    txtProductName.Text,
                                                    txtTVendor.Text,
                                                    ddlProductType.SelectedItem.Text,
                                                    ddlCTBRTB.SelectedItem.Text,
                                                    ddlCIOIES.SelectedItem.Text,
                                                    txtRemediation.Text,                                                    Convert.ToInt32(ddlProductType.SelectedValue),
                                                    Convert.ToInt32(ddlCTBRTB.SelectedValue),
                                                    Convert.ToInt32(ddlCIOIES.SelectedValue));
                            
            }
            else
            {
                try
                {
                    nProductID = Int32.Parse(objProductID.ToString());
                }
                catch(Exception e1)
                {
                    nProductID=0;
                }

                SectionF_DB.UpdateInitiativeProduct(nProductID,
                                                    nInitiativeID,
                                                    txtProductName.Text,
                                                    txtTVendor.Text,
                                                    ddlProductType.SelectedItem.Text,
                                                    ddlCTBRTB.SelectedItem.Text,
                                                    ddlCIOIES.SelectedItem.Text,
                                                    txtRemediation.Text,
                                                    Convert.ToInt32(ddlProductType.SelectedValue),
                                                    Convert.ToInt32(ddlCTBRTB.SelectedValue),
                                                    Convert.ToInt32(ddlCIOIES.SelectedValue));
            }

            foreach (RepeaterItem item in repeaterPeriods.Items)
            {
                int nPeriodID;
                decimal dcAmount;

                HtmlTableRow row;
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    row = (item.ItemType == ListItemType.Item) ? (HtmlTableRow)item.FindControl("RowID") : (HtmlTableRow)item.FindControl("AlternateRowID");

                    HtmlTableCell cell;
                    cell = (HtmlTableCell)row.FindControl("cellTxt");

                    TextBox txtBox;
                    txtBox = (TextBox)cell.FindControl("txt");
                    HtmlInputHidden hidden;
                    hidden = (HtmlInputHidden)cell.FindControl("hidden");

                    try
                    {
                        nPeriodID = Convert.ToInt32(hidden.Value);
                        dcAmount = Convert.ToDecimal(txtBox.Text);
                    }
                    catch (Exception e1)
                    {
                        nPeriodID = 0;
                        dcAmount = 0;
                    }
                    //typeID=3 for product
                    if (objProductID == null)
                        SectionF_DB.InsertInitiativeValue(nInitiativeID, nProductID, nPeriodID, 3, dcAmount);
                    else
                        Global_DB.UpdateInitiativeValue(nProductID, nInitiativeID, 3, nPeriodID, System.DBNull.Value, dcAmount);
                }
            }



            RegisterStartupScript("closeScript",
                "<script language=JavaScript>  window.returnValue=1; window.close();  </script>");
            
        }

        protected void repeaterPeriods_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            HtmlTableRow row;

            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                row = (e.Item.ItemType == ListItemType.Item) ? (HtmlTableRow)e.Item.FindControl("RowID") : (HtmlTableRow)e.Item.FindControl("AlternateRowID");

                if (row != null)
                {
                    HtmlTableCell itemCell1 = new HtmlTableCell();
                    itemCell1.Attributes.Add("Width", "45");
                    row.Cells.Add(itemCell1);

                    TextBox txtBox = new TextBox();
                    txtBox.ID = "txt";
                    txtBox.Attributes.Add("Class", "textinput");
                    txtBox.Width = 200;

                    HtmlInputHidden hidden = new HtmlInputHidden();
                    hidden.ID = "hidden";
                    hidden.Value = DataBinder.Eval(e.Item.DataItem, "PeriodID").ToString();

                    HtmlTableCell itemCellTxt = new HtmlTableCell();
                    itemCellTxt.ID = "cellTxt";

                    itemCellTxt.Controls.Add(hidden);
                    itemCellTxt.Controls.Add(txtBox);

                    row.Cells.Add(itemCellTxt);

                }
            }
        }
}
}
