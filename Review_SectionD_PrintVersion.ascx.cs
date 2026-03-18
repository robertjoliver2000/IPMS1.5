namespace ProjectPortfolio.Controls
{
    using System;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using ProjectPortfolio.Classes;

    public partial class Review_SectionD_PrintVersion : System.Web.UI.UserControl
    {
        protected int nInitiativeID;

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
                LoadInitiative();
            }
        }

        private void LoadInitiative()
        {
            try
            {
                nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
            }
            catch (Exception)
            {
                nInitiativeID = -1;
            }

            DataRow drInitiative = SectionD_DB.GetInitiativeDetails(nInitiativeID);

            if (drInitiative != null)
            {
                ddlIGApprovalCommittee.Text = drInitiative["IGApprovalCommittee"].ToString();

                txtIGApprovalDate.Text = (drInitiative["IGApprovalDate"] != DBNull.Value) ? ((DateTime)drInitiative["IGApprovalDate"]).ToShortDateString() : String.Empty;

                ddlIGApprovalStatus.Text = drInitiative["IGApprovalStatus"].ToString();
                txtIGIdentifier.Text = drInitiative["IGBusinessAreaCode"].ToString() + "-" + drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'); //drInitiative["IGIdentifier"].ToString();
                ddlImpactCategory.Text = drInitiative["InitiativeImpactCategory"].ToString();
                ddlGTOReviewLevel.Text = drInitiative["InitiativeGTOReviewLevel"].ToString();

                ddlAlignedToBusinessStrategy.Text = drInitiative["AlignedToBusinessStrategy"].ToString();
                ddlFirstTimeInitiative.Text = drInitiative["FirstTimeInitiative"].ToString();
                ddlNonDuplication.Text = drInitiative["NonDuplication"].ToString();
            }
        }  
    }
}
