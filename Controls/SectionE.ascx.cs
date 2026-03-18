/*
 *  Rev         By          Date            Description
 * 
 *  1.8.2       GMcF        2007-10-05      Added for Detailed Functional Domains
 * 
 */

namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
    using System.Web.UI;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using Classes;


    public partial class SectionE : System.Web.UI.UserControl
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

            btnAddApplication.Attributes.Add("onclick", "javascript:popupWindowApp(0, " + nInitiativeID.ToString() + ")");
            btnAddServer.Attributes.Add("onclick", "javascript:popupWindowServer(0, " + nInitiativeID.ToString() + ")");
            btnAddDFD.Attributes.Add("onclick", "javascript:popupWindowDFD(0, " + nInitiativeID.ToString() + ")");  // Rev 1.8.2 GMcF

            if (!Page.IsPostBack)
			{
				LoadInitiative();
			}

            BindAppRepeater();
            BindServerRepeater();
            BindDFDRepeater();

		}

        protected void BindAppRepeater()
        {
            repeaterApp.DataSource = SectionE_DB.GetApplications(nInitiativeID);
            repeaterApp.DataBind();
        }

        protected void BindServerRepeater()
        {
            repeaterServer.DataSource = SectionE_DB.GetServers(nInitiativeID);
            repeaterServer.DataBind();
        }

        // Rev 1.8.2 GMcF
        protected void BindDFDRepeater()
        {
            repeaterDFD.DataSource = SectionE_DB.GetDetailedFunctionalDomains(nInitiativeID);
            repeaterDFD.DataBind();
        }
        // End Rev 1.8.2
		
		private void LoadInitiative()
		{
			
			DataRow drInitiative = SectionA_DB.GetInitiativeDetails(nInitiativeID);

			if (drInitiative != null)
			{
				txtImpact.Text= drInitiative["ImpactOfNotDoingThisInvestment"].ToString();
				txtShutDownComments.Text= drInitiative["ShutdownComments"].ToString();
				txtKeyPerformance.Text= drInitiative["KeyPerformanceIndicators"].ToString();
			}
		}

		public int UpdateInitiative()
		{
            int intReturnValue = -1;
			
			if (nInitiativeID > 0)
			{
				intReturnValue = SectionE_DB.UpdateInitiative(
					nInitiativeID,txtImpact.Text,txtShutDownComments.Text,txtKeyPerformance.Text);
					
			}

			return intReturnValue;
		}

       
        protected void repeaterApp_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int nAppID;
            
       
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "Delete")
                {
                    try
                    {
                        nAppID = Convert.ToInt32(e.CommandArgument);
                    }
                    catch (Exception e1)
                    {
                        nAppID = 0;
                    }

                    SectionE_DB.DeleteInitiativeApp(nAppID);
                }
            }


            BindAppRepeater();
        }
        
        protected void repeaterServer_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int nServerID;
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "Delete")
                {
                    try
                    {
                        nServerID = Convert.ToInt32(e.CommandArgument);
                    }
                    catch (Exception e1)
                    {
                        nServerID = 0;
                    }

                    SectionE_DB.DeleteInitiativeServer(nServerID);
                }
            }

            BindServerRepeater();
        }

        protected void repeaterDFD_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int nInitiativeDetailedFunctionalDomainID;
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "Delete")
                {
                    try
                    {
                        nInitiativeDetailedFunctionalDomainID = Convert.ToInt32(e.CommandArgument);
                    }
                    catch (Exception e1)
                    {
                        nInitiativeDetailedFunctionalDomainID = 0;
                    }

                    SectionE_DB.DeleteInitiativeDetailedFunctionalDomain(nInitiativeDetailedFunctionalDomainID);
                }
            }

            BindDFDRepeater();
        }

        protected void repeaterApp_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                int nAppID = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "InitiativeApplicationID"));

                ImageButton imgButt = (ImageButton)e.Item.FindControl("delAppID");
                if (imgButt != null)
                    imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this application ?')) AllowOneTimeSubmit(); else return false; ");
            }

        }
        
        protected void repeaterServer_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                int nServerID = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "InitiativeServerID"));

                ImageButton imgButt = (ImageButton)e.Item.FindControl("delServerID");
                if (imgButt != null)
                    imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this server ?')) AllowOneTimeSubmit(); else return false; ");
            }
        }

        protected void repeaterDFD_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //items
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                int nInitiativeDetailedFunctionalDomainID = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "InitiativeDetailedFunctionalDomainID"));

                ImageButton imgButt = (ImageButton)e.Item.FindControl("delDFDID");
                if (imgButt != null)
                    imgButt.Attributes.Add("onClick", "javascript: if (confirm('Are you sure you wish to delete this detailed functional domain ?')) AllowOneTimeSubmit(); else return false; ");
            }
        }

        // Rev 1.8.2 GMcF
        protected void txtDFDTotalAllocation_PreRender(object sender, EventArgs e)
        {
            DataSet ds = SectionE_DB.GetDetailedFunctionalDomains(nInitiativeID);

            if (ds.Tables[0].Rows.Count == 0)
            {
                txtDFDTotalAllocation.Text = "100.00";
            }
            else
            {
                string strTotalAllocation = (System.Convert.ToDecimal(ds.Tables[0].Compute("sum(Allocation)", "1=1"))).ToString("0.00");
                txtDFDTotalAllocation.Text = strTotalAllocation;
            }
        }
        // End of Rev 1.8.2
    }

}