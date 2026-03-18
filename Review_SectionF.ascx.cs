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

    public partial class Review_SectionF : System.Web.UI.UserControl
    {
        protected int nInitiativeID;
        protected int nPreviousVersion_InitiativeID;
        
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

            nPreviousVersion_InitiativeID = Global_DB.GetPreviousVersionInitiativeID(nInitiativeID);

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
            dsTotals = Review_SectionF_DB.GetTotalRisks(nInitiativeID);

        }


        private void BindRepeater()
        {
            repeaterRisk.DataSource = Review_SectionF_DB.GetRisks(nInitiativeID);
            repeaterRisk.DataBind();
        }


        protected string GetRiskTotal(int nTotalType)
        {
            string strReturn = "0";

            switch (nTotalType)
            {
                case 1://Euros at risk
                    {
                        decimal dcTotal = 0;
                        if (dsTotals.Tables["Total"].Rows[0]["TotalEuros"] != System.DBNull.Value)
                            dcTotal = Convert.ToDecimal(dsTotals.Tables["Total"].Rows[0]["TotalEuros"]);
                        else
                            dcTotal = 0;

                        strReturn = dcTotal.ToString("C");
                    }
                    break;

                case 2://calculated risk
                    {
                        decimal dcTotal = 0;
                        if (dsTotals.Tables["Total"].Rows[0]["TotalCalculated"] != System.DBNull.Value)
                            dcTotal = Convert.ToDecimal(dsTotals.Tables["Total"].Rows[0]["TotalCalculated"]);
                        else
                            dcTotal = 0;
                        strReturn = dcTotal.ToString("N2");
                    }
                    break;
            }

            return strReturn;

        }

        protected void repeaterRisk_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Header)
            {
                HtmlTableCell tdCurrentReviewDate, tdLastReviewDate; 

                DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

                if (drInitiative != null)
                {
                    tdCurrentReviewDate = (HtmlTableCell)e.Item.FindControl("tdCurrentReviewDate");

                    //tdCurrentReviewDate.InnerText = (drInitiative["IGReviewDate"] != DBNull.Value) ? ((DateTime)drInitiative["IGReviewDate"]).ToShortDateString() : "";
                    tdCurrentReviewDate.InnerText = (drInitiative["IGApprovalDate"] != DBNull.Value) ? ((DateTime)drInitiative["IGApprovalDate"]).ToShortDateString() : "";
                }

                DataRow drPreviousVersion_Initiative = SectionA_DB.GetInitiativeDetails(nPreviousVersion_InitiativeID);

                if (drPreviousVersion_Initiative != null)
                {
                    tdLastReviewDate = (HtmlTableCell)e.Item.FindControl("tdLastReviewDate");
                    
                    //tdLastReviewDate.InnerText = (drPreviousVersion_Initiative["IGReviewDate"] != DBNull.Value) ? ((DateTime)drPreviousVersion_Initiative["IGReviewDate"]).ToShortDateString() : "";
                    tdLastReviewDate.InnerText = (drPreviousVersion_Initiative["IGApprovalDate"] != DBNull.Value) ? ((DateTime)drPreviousVersion_Initiative["IGApprovalDate"]).ToShortDateString() : "";
                }
            }

            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ImageButton imgButt = (ImageButton)e.Item.FindControl("delRiskID");
                if (imgButt != null)
                {
                    imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this risk ?')) AllowOneTimeSubmit(); else return false; ");
                }
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

                    Review_SectionF_DB.DeleteInitiativeRisk(nRiskID);
                }
            }

            LoadDataSets();
            BindRepeater();
        }


        public int UpdateInitiative()
        {
            return Review_SectionF_DB.UpdateInitiative(nInitiativeID,
                                txtRisksIssuesDeps.Text, txtOverallIGComment.Text);
        }

    }
}
