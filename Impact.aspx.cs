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
    public partial class Impact : System.Web.UI.Page
    {
        protected DataSet dsPeriod;
        protected int nInitiativeID;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            
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
               

                object objImpactID = Request.QueryString["ImpactID"];
                if (objImpactID != null)
                    EditImpact(objImpactID);

            }
        }

        protected void LoadDataSets()
        {
            //dsPeriod = Global_DB.GetPeriods(nInitiativeID);
            dsPeriod = Global_DB.GetPeriodsForDisplay(nInitiativeID);
        }
        
        protected void BindDropdowns()
        {

            DataSet dsNonComplianceType = Global_DB.GetReferenceTable(22); //CategoryID = 22 for noncompliancetype
            DataSet dsCTBRTB = Global_DB.GetReferenceTable(23);//CategoryID = 23 for CTBRTB
            DataSet dsCIOCTO = Global_DB.GetReferenceTable(24);//CategoryID = 23 for CIOCTO

            if (dsNonComplianceType.Tables["Reference"].Rows.Count > 0)
            {
                ddlNonComplianceType.DataValueField = "ReferenceID";
                ddlNonComplianceType.DataTextField = "Description";

                ddlNonComplianceType.DataSource = dsNonComplianceType.Tables["Reference"];
                ddlNonComplianceType.DataBind();


            }

            if (dsCTBRTB.Tables["Reference"].Rows.Count > 0)
            {
                ddlCTBRTB.DataValueField = "ReferenceID";
                ddlCTBRTB.DataTextField = "Description";

                ddlCTBRTB.DataSource = dsCTBRTB.Tables["Reference"];
                ddlCTBRTB.DataBind();

            }


            if (dsCIOCTO.Tables["Reference"].Rows.Count > 0)
            {
                ddlCIOCT0.DataValueField = "ReferenceID";
                ddlCIOCT0.DataTextField = "Description";

                ddlCIOCT0.DataSource = dsCIOCTO.Tables["Reference"];
                ddlCIOCT0.DataBind();

            }
        
        }

        protected void BindRepeater()
        {
            repeaterPeriods.DataSource = dsPeriod;
            repeaterPeriods.DataBind();
        }

        protected void EditImpact(object objImpactID)
        {
            ////editing

            int nImpactID;
            
            try
            {
                nImpactID = Int32.Parse(objImpactID.ToString());
            }
            catch (Exception e1)
            {
                nImpactID = 0;
            }

            decimal dcAmount;

            DataSet dsImpact = SectionG_DB.GetImpact(nInitiativeID, nImpactID, 1);

            DataRow dRow = dsImpact.Tables["Impact"].Rows[0];

            ddlNonComplianceType.SelectedIndex = Convert.ToInt32(dRow["NonComplianceTypeID"]);
            ddlCTBRTB.SelectedIndex = Convert.ToInt32(dRow["CTB_RTBID"]);
            ddlCIOCT0.SelectedIndex = Convert.ToInt32(dRow["CIO_CTOID"]);

            txtAgreedAlternative.Text = dRow["AgreedAlternative"].ToString();
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
                    strCondition="PeriodID="+nPeriodID.ToString();


                    try
                    {
                        dcAmount = Convert.ToDecimal(
                            dsImpact.Tables["Impact"].Select(strCondition)[0]["Amount"].ToString());
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

            object objImpactID = Request.QueryString["ImpactID"];

            
            int nImpactID;
            
            if (objImpactID == null)
            {
                nImpactID = SectionG_DB.InsertInitiativeImpact(nInitiativeID,
                                                    ddlNonComplianceType.SelectedItem.Text,
                                                    txtAgreedAlternative.Text,
                                                    ddlCTBRTB.SelectedItem.Text,
                                                    ddlCIOCT0.SelectedItem.Text,
                                                    txtRemediation.Text,
                                                    Convert.ToInt32(ddlNonComplianceType.SelectedValue),
                                                    Convert.ToInt32(ddlCTBRTB.SelectedValue),
                                                    Convert.ToInt32(ddlCIOCT0.SelectedValue));

            }
            else
            { 
                nImpactID = Int32.Parse(objImpactID.ToString());
                SectionG_DB.UpdateInitiativeImpact(nImpactID,
                                                    nInitiativeID,
                                                    ddlNonComplianceType.SelectedItem.Text,
                                                    txtAgreedAlternative.Text,
                                                    ddlCTBRTB.SelectedItem.Text,
                                                    ddlCIOCT0.SelectedItem.Text,
                                                    txtRemediation.Text,
                                                    Convert.ToInt32(ddlNonComplianceType.SelectedValue),
                                                    Convert.ToInt32(ddlCTBRTB.SelectedValue),
                                                    Convert.ToInt32(ddlCIOCT0.SelectedValue));
            
            }

            
            foreach(RepeaterItem item in repeaterPeriods.Items)
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
                    catch(Exception e1)
                    {
                        nPeriodID = 0;
                        dcAmount = 0;
                    }

                    //typeID=1 for impact
                    if(objImpactID==null)
                        SectionG_DB.InsertInitiativeValue(nInitiativeID, nImpactID, nPeriodID, 1, dcAmount);
                    else
                        Global_DB.UpdateInitiativeValue(nImpactID,nInitiativeID,1, nPeriodID, System.DBNull.Value, dcAmount);
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
                    itemCell1.Attributes.Add("Width", "80");
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
