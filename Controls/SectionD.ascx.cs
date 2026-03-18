namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using ProjectPortfolio.Classes;


    public partial class SectionD : System.Web.UI.UserControl
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
            
            lnkIGApprovalDate.HRef ="#";
            lnkIGApprovalDate.Attributes.Add("onclick",
                                        "javascript:popupWindowDatePicker('" + txtIGApprovalDate.ClientID + "');"+
                                        "return false;"
                                        );


            if (!Page.IsPostBack)
            {
                FillDropDowns();

                LoadInitiative();
            }		

            int intContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;
            string strPermissionName = Security_DB.GetInitiativeAccessRights(intContactID, nInitiativeID);
            string strRole = Security_DB.GetUserRole(intContactID);

            if (strRole.ToLower() == "ig programme manager")
            {
                lnkIGApprovalDate.Visible = false;
                txtIGApprovalDate.ReadOnly = true;
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
                ddlIGApprovalCommittee.SelectedValue = drInitiative["IGApprovalCommitteeID"].ToString();

                txtIGApprovalDate.Text = (drInitiative["IGApprovalDate"] != DBNull.Value) ? ((DateTime)drInitiative["IGApprovalDate"]).ToShortDateString() : String.Empty;

                txtIGApprovalStatus.Text = drInitiative["IGApprovalStatus"].ToString();
                txtIGApprovalStatusID.Value  = drInitiative["IGApprovalStatusID"].ToString();
                txtIGIdentifier.Text = drInitiative["IGBusinessAreaCode"].ToString() + "-" + drInitiative["IGIdentifierCode"].ToString() + "-" + drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0'); //drInitiative["IGIdentifier"].ToString();
                ddlImpactCategory.SelectedValue = drInitiative["InitiativeImpactCategoryID"].ToString();
                ddlGTOReviewLevel.SelectedValue = drInitiative["InitiativeGTOReviewLevelID"].ToString();

                ddlAlignedToBusinessStrategy.SelectedValue = drInitiative["AlignedToBusinessStrategyID"].ToString();
                ddlFirstTimeInitiative.SelectedValue = drInitiative["FirstTimeInitiativeID"].ToString();
                ddlNonDuplication.SelectedValue = drInitiative["NonDuplicationID"].ToString();

            }
        }


        public int UpdateInitiative()
        {
            int intReturnValue = -1;
            
            if (nInitiativeID > 0)
            {
                intReturnValue = SectionD_DB.UpdateInitiative(
                                    nInitiativeID,  
                                    ddlIGApprovalCommittee.SelectedItem.Text, 
                                    Convert.ToInt32(ddlIGApprovalCommittee.SelectedValue), 
                                    txtIGApprovalDate.Text != String.Empty ? (object)DateTime.Parse(txtIGApprovalDate.Text) : DBNull.Value, 
                                    ddlImpactCategory.SelectedItem.Text,
                                    Convert.ToInt32(ddlImpactCategory.SelectedValue),
                                    ddlGTOReviewLevel.SelectedItem.Text,
                                    Convert.ToInt32(ddlGTOReviewLevel.SelectedValue),
                                    ddlAlignedToBusinessStrategy.SelectedItem.Text,
                                    Convert.ToInt32(ddlAlignedToBusinessStrategy.SelectedValue),
                                    ddlFirstTimeInitiative.SelectedItem.Text,
                                    Convert.ToInt32(ddlFirstTimeInitiative.SelectedValue),
                                    ddlNonDuplication.SelectedItem.Text,
                                    Convert.ToInt32(ddlNonDuplication.SelectedValue));
            }

            return intReturnValue;
        }


        private void FillDropDowns()
        {
            DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(4);

            ddlIGApprovalCommittee.DataSource = dsIGApprovalCommittee.Tables["Reference"];
            ddlIGApprovalCommittee.DataValueField = "ReferenceID";
            ddlIGApprovalCommittee.DataTextField = "Description";

            ddlIGApprovalCommittee.DataBind();

            DataSet dsImpactCategory = Global_DB.GetReferenceTable(8);

            ddlImpactCategory.DataSource = dsImpactCategory.Tables["Reference"];
            ddlImpactCategory.DataValueField = "ReferenceID";
            ddlImpactCategory.DataTextField = "Description";

            ddlImpactCategory.DataBind();

            DataSet dsGTOReviewLevel = Global_DB.GetReferenceTable(6);

            ddlGTOReviewLevel.DataSource = dsGTOReviewLevel.Tables["Reference"];
            ddlGTOReviewLevel.DataValueField = "ReferenceID";
            ddlGTOReviewLevel.DataTextField = "Description";

            ddlGTOReviewLevel.DataBind();

            DataSet dsSummaryQuestion = Global_DB.GetReferenceTable(7);

            ddlAlignedToBusinessStrategy.DataSource = dsSummaryQuestion.Tables["Reference"];
            ddlAlignedToBusinessStrategy.DataValueField = "ReferenceID";
            ddlAlignedToBusinessStrategy.DataTextField = "Description";

            ddlAlignedToBusinessStrategy.DataBind();


            ddlFirstTimeInitiative.DataSource = dsSummaryQuestion.Tables["Reference"];
            ddlFirstTimeInitiative.DataValueField = "ReferenceID";
            ddlFirstTimeInitiative.DataTextField = "Description";

            ddlFirstTimeInitiative.DataBind();


            ddlNonDuplication.DataSource = dsSummaryQuestion.Tables["Reference"];
            ddlNonDuplication.DataValueField = "ReferenceID";
            ddlNonDuplication.DataTextField = "Description";

            ddlNonDuplication.DataBind();
        }
	}
}
