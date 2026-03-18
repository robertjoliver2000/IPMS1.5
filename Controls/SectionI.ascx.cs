namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
    using ProjectPortfolio.Classes;

	/// <summary>
	///		Summary description for SectionI.
	/// </summary>
	public partial class SectionI : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.DropDownList Dropdownlist6;

        protected int nInitiativeID;
        protected DataSet dsTotals;

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
            
            btnAddRisk.Attributes.Add("onclick", "javascript:popupWindowRisk(" + nInitiativeID.ToString() + ", 0)");

            if (!Page.IsPostBack)
            {
                LoadInitiative();
            }

            LoadDataSets();
            BindRepeater();

        }


        private void LoadInitiative()
        {

            DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                txtRisksIssuesDeps.Text = drInitiative["RisksIssuesDeps"].ToString();
                txtOverallIGComment.Text = drInitiative["OverallIGComment"].ToString();
            }
        }

        protected void LoadDataSets()
        {
            dsTotals = SectionI_DB.GetTotalRisks(nInitiativeID);

        }


        private void BindRepeater()
        {
            repeaterRisk.DataSource = SectionI_DB.GetRisks(nInitiativeID);
            repeaterRisk.DataBind();
        }


        protected string GetRiskTotal(int nTotalType)
        {
            string strReturn="0";
            
            switch (nTotalType)
            {
                case 1://calculated risk
                    {
                        decimal dcTotal=0;
                        if (dsTotals.Tables["Total"].Rows[0]["TotalCalculated"] != System.DBNull.Value)
                            dcTotal = Convert.ToDecimal(dsTotals.Tables["Total"].Rows[0]["TotalCalculated"]);
                        else
                            dcTotal = 0;
                        strReturn = dcTotal.ToString("N2");
                        break;
                    }
                case 2://adjusted risk
                    {
                        decimal dcTotal = 0;
                        if (dsTotals.Tables["Total"].Rows[0]["TotalAdjusted"] != System.DBNull.Value)
                            dcTotal = Convert.ToDecimal(dsTotals.Tables["Total"].Rows[0]["TotalAdjusted"]);
                        else
                            dcTotal = 0;
                        strReturn = dcTotal.ToString("N2");
                        
                        break;
                    }
                case 3://Euros at risk
                    {
                        decimal dcTotal = 0;
                        if (dsTotals.Tables["Total"].Rows[0]["TotalEuros"] != System.DBNull.Value)
                            dcTotal = Convert.ToDecimal(dsTotals.Tables["Total"].Rows[0]["TotalEuros"]);
                        else
                            dcTotal = 0;

                        strReturn = dcTotal.ToString("C");
                        
                        break;
                    }
                case 4://probability
                    {
                        if (dsTotals.Tables["Total"].Rows[0]["TotalProbability"] != System.DBNull.Value)
                            strReturn = dsTotals.Tables["Total"].Rows[0]["TotalProbability"].ToString();
                        else
                            strReturn = "";
                                                
                        break;
                    }
                
            }

            return strReturn;

        }

        protected void repeaterRisk_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ImageButton imgButt = (ImageButton)e.Item.FindControl("delRiskID");
                if (imgButt != null)
                    imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this risk ?')) AllowOneTimeSubmit(); else return false; ");
            }

        }
        
        protected void repeaterRisk_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int nRiskID;
            
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "Delete")
                {
                    try
                    {
                        nRiskID = Convert.ToInt32(e.CommandArgument);
                    }
                    catch (Exception e1)
                    {
                        nRiskID = 0;
                    }

                    SectionI_DB.DeleteInitiativeRisk(nRiskID);
                }
            }

            LoadDataSets();
            BindRepeater();
        }


        public int UpdateInitiative()
        {
            return SectionI_DB.UpdateInitiative(nInitiativeID, 
                                txtRisksIssuesDeps.Text,txtOverallIGComment.Text);
        }

    }
}
