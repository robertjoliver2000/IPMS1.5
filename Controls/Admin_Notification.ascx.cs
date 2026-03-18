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


	public partial class Admin_Notification : System.Web.UI.UserControl
	{

        protected DataSet dsNotification;
        // rev 1.1.11
        protected DataSet dsSponsorNotification;
        
		protected void Page_Load(object sender, System.EventArgs e)
		{
            
            lnkIGCoordinator.HRef = "#";
            lnkIGCoordinator.Attributes.Add("onclick",
                                                        "javascript:popupWindowSelectItem(1,'" +
                                                        txtIGCoordinator.ClientID + "','" +
                                                        hIGCoordinator.ClientID + "'); " +
                                                        "return false;"
                                                        );

            txtIGCoordinator.Attributes.Add("onfocus", "parent.focus();");

            if (!Page.IsPostBack)
            {
                FillDropdowns();
            }

            LoadDataSets();
            BindRepeater();

            //rev 1.1.11 CA
            lnkSponsor.HRef = "#";
            lnkSponsor.Attributes.Add("onclick",
                                                        "javascript:popupWindowSelectItem(1,'" +
                                                        txtSponsorEmail.ClientID + "','" +
                                                        hSponsor.ClientID + "'); " +
                                                        "return false;"
                                                        );

            txtSponsorEmail.Attributes.Add("onfocus", "parent.focus();");

            if (!Page.IsPostBack)
            {
                FillDropdowns();
            }

            LoadDataSets();
            BindRepeater();
            //end rev

		}


        private void FillDropdowns()
        {
            DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(4);

            //removing "Please select"
            dsIGApprovalCommittee.Tables["Reference"].Rows.RemoveAt(0);
            
            ddlIGApprovalCommittee.DataSource = dsIGApprovalCommittee.Tables["Reference"];
            ddlIGApprovalCommittee.DataValueField = "ReferenceID";
            ddlIGApprovalCommittee.DataTextField = "Description";

            ddlIGApprovalCommittee.DataBind();

            //rev 1.1.11
            DataSet dsISponsor = SectionB_SponsorAllocations_DB.GetSponsors();

            //removing "Please select"
            //dsISponsor.Tables["Name"].Rows.RemoveAt(0);

            ddlSponsor.DataSource = dsISponsor.Tables["Sponsor"];
            ddlSponsor.DataValueField = "SponsorID";
            ddlSponsor.DataTextField = "Name";

            ddlSponsor.DataBind();

        }


        private void LoadDataSets()
        {
            int nCommitteeID = 0;
            // rev 1.1.11
            int nSponsorID = 0;

            try
            {
                nCommitteeID = Convert.ToInt32(ddlIGApprovalCommittee.SelectedItem.Value);              
            }
            catch
            {
                nCommitteeID = 0;
            }

            // rev 1.1.11
            try
            {    
                nSponsorID = Convert.ToInt32(ddlSponsor.SelectedItem.Value);
            }
            catch
            {
                nSponsorID = 0;
            }

            dsNotification = Admin_DB.GetCommitteeContactList(nCommitteeID);
            // rev 1.1.11
            dsSponsorNotification = Notification_DB.GetSponsorNotificationList(nSponsorID);
        }


        private void BindRepeater()
        {
            repeaterNotification.DataSource = dsNotification;
            repeaterNotification.DataBind();
            // rev 1.1.11
            repeaterSponsor.DataSource = dsSponsorNotification;
            repeaterSponsor.DataBind();   
        }
          
      
        protected void ddlIGApprovalCommittee_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadDataSets();
            BindRepeater();
        }

        
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int nCommitteeID = 0;
            try
            {
                nCommitteeID = Convert.ToInt32(ddlIGApprovalCommittee.SelectedItem.Value);
            }
            catch
            {
                nCommitteeID = 0;
            }

            int nContactID = 0;
            try
            {
                nContactID= Convert.ToInt32(hIGCoordinator.Value);                
            }
            catch
            {
                nContactID = 0;
            }

            Admin_DB.InsertInCommitteeContactList(nCommitteeID, nContactID);

            LoadDataSets();
            BindRepeater();
        }

        // rev 1.1.11
        protected void btnAddSponsorEmail_Click(object sender, EventArgs e)
        {
            int nSponsorID = 0;
            try
            {
                nSponsorID = Convert.ToInt32(ddlSponsor.SelectedItem.Value);
            }
            catch
            {
                nSponsorID = 0;
            }

            string sEmailAddress;
            try
            {
                sEmailAddress = txtSponsorEmail.Text;

                // rev 1.1.11 ***come back to, to make better!***
                int iCommaPosition;
                string sFirstName;
                string sSurname;

                iCommaPosition = sEmailAddress.LastIndexOf(",");
                sFirstName = sEmailAddress.Substring(iCommaPosition + 2);
                sSurname = sEmailAddress.Substring(0, iCommaPosition);
                sFirstName = sFirstName.ToLower();
                sSurname = sSurname.ToLower();
                sEmailAddress = sFirstName + "." + sSurname + "@db.com";
                // end rev 1.1.11
            }
            catch
            {
                sEmailAddress = "None";
            }

            Admin_DB.InsertSponsorEmail(nSponsorID, sEmailAddress);

            LoadDataSets();
            BindRepeater();

            txtSponsorEmail.Text = "";

        }

        protected void repeaterNotification_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

             
                ImageButton imgButt = (ImageButton)e.Item.FindControl("delComCon");
                if (imgButt != null)
                {
                       imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this contact from the selected committee list?')) return true; else return false; ");
                }
            }
        }

        // rev 1.1.11
        protected void repeaterSponsor_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {


                ImageButton imgButt = (ImageButton)e.Item.FindControl("delComCon");
                if (imgButt != null)
                {
                    imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this contact from the selected committee list?')) return true; else return false; ");
                }
            }
        }
        

        protected void repeaterNotification_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int nCommitteeID,nContactID;

            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "DeleteComCon")
                {
                    try
                    {
                        nContactID = Convert.ToInt32(e.CommandArgument);
                    }
                    catch (Exception e1)
                    {
                        nContactID = -1;
                    }

                    try
                    {
                        nCommitteeID = Convert.ToInt32(ddlIGApprovalCommittee.SelectedItem.Value);
                    }
                    catch
                    {
                        nCommitteeID = 0;
                    }

                    Admin_DB.DeleteCommitteeContact(nCommitteeID,nContactID);
                }
            }

            LoadDataSets();
            BindRepeater();
        }

        // rev 1.1.11
        protected void repeaterSponsor_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int nSponsorContactID; 
            //int nContactID;

            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "DeleteComCon")
                {
                    try
                    {
                        nSponsorContactID = Convert.ToInt32(e.CommandArgument);
                    }
                    catch (Exception e1)
                    {
                        nSponsorContactID = -1;
                    }

                    //try
                    //{
                    //    nCommitteeID = Convert.ToInt32(ddlSponsor.SelectedItem.Value);
                    //}
                    //catch
                    //{
                    //    nCommitteeID = 0;
                    //}

                    Admin_DB.DeleteSponsorEmail(nSponsorContactID);
                }
            }

            LoadDataSets();
            BindRepeater();
        }
    }
}
