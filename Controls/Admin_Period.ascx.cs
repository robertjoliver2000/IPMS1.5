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


	public partial class Admin_Period : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.DropDownList Dropdownlist6;

        protected int nInitiativeID;

        protected DataSet dsYear;
        protected DataSet dsPeriod;

		protected void Page_Load(object sender, System.EventArgs e)
		{
            LoadDataSets();
            BindRepeater();
            FillDropdowns();          
		}


        private void FillDropdowns()
        {
            try
            {
                ddlYear.Items.Clear();

                int nYear;
                nYear = Convert.ToInt32(dsYear.Tables["PeriodYears"].Compute("MAX(PeriodYear)", string.Empty));

                if (nYear <= 0)
                {
                    nYear = DateTime.Now.Year;
                }

                for (int i = 1; i <= 10; i++)
                {
                    ddlYear.Items.Add(Convert.ToString(nYear + i));
                }
            }
            catch (Exception ex)
            {
            }
        }

        private void LoadDataSets()
        {
            dsYear = Global_DB.GetYears( false );
            dsPeriod = Admin_DB.GetAllPeriods();
        }


        private void BindRepeater()
        {
            repeaterProduct.DataSource = dsYear;
            repeaterProduct.DataBind();        
        }


        protected void repeaterProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            HtmlTableRow row;

            
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                int nYear = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "PeriodYear"));
                string strCondition;
                
                
                ImageButton imgButt = (ImageButton)e.Item.FindControl("delYear");
                if (imgButt != null)
                {
                    //if(DateTime.Now.Year>=nYear)
                    if (Admin_DB.GetInitiativesPerYear(nYear) > 0)
                        imgButt.Attributes.Add("onClick", "javascript: alert('This year can not be deleted.There still are initiatives from this year!'); return false; ");
                    else
                        imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this year ?')) return true; else return false; ");
                }
                

                row = (e.Item.ItemType == ListItemType.Item) ? (HtmlTableRow)e.Item.FindControl("RowID") : (HtmlTableRow)e.Item.FindControl("AlternateRowID");
                string strClass = (e.Item.ItemType == ListItemType.Item) ? "incell" : "alternateincell";



                if (row != null)
                {
                    
                    strCondition = "PeriodYear=" + nYear.ToString();

                    
                    DataRow[] dRows;
                    dRows = dsPeriod.Tables["AllPeriods"].Select(strCondition);
                    
                    for (int index = 1; index <= dRows.Length; index++)
                    {
                        bool bQ = Convert.ToBoolean(dRows[index-1]["HasQuarters"]);

                        if (bQ == true)
                        {
                            for (int q = 1; q <= 4; q++)
                            {
                                HtmlTableCell itemCell = new HtmlTableCell();
                                itemCell.Attributes.Add("align", "center");
                                itemCell.Attributes.Add("class", strClass);
                                itemCell.Attributes.Add("width", "55");

                                itemCell.InnerHtml = "Q" + q.ToString() + " " + dRows[index-1]["Name"].ToString();
                                row.Cells.Add(itemCell);
                            }
                        }
                        else
                        {
                            HtmlTableCell itemCell = new HtmlTableCell();
                            itemCell.Attributes.Add("align", "center");
                            itemCell.Attributes.Add("class", strClass);
                            itemCell.Attributes.Add("width", "55");

                            itemCell.InnerHtml = dRows[index-1]["Name"].ToString();
                            row.Cells.Add(itemCell);
                        }

                    }

                    
                }

            }
            //..items

           

        }

        protected void repeaterProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int nYear;

            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "Delete")
                {
                    try
                    {
                        nYear = Convert.ToInt32(e.CommandArgument);
                    }
                    catch (Exception e1)
                    {
                        nYear= -1;
                    }

                    Admin_DB.DeletePeriodYear(nYear);
                }
            }

            LoadDataSets();
            BindRepeater();
            FillDropdowns();
             
        }
        
        protected void btnAddYear_Click(object sender, EventArgs e)
        {
            int nYear = Convert.ToInt32(ddlYear.SelectedItem.Value);
            Admin_DB.InsertPeriodYear(nYear);

            LoadDataSets();
            BindRepeater();
            FillDropdowns();
        }
}
}
