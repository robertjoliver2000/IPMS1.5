using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using ProjectPortfolio.Classes;

namespace ProjectPortfolio
{
	/// <summary>
	/// Summary description for Server.
	/// </summary>
	public partial class Server : System.Web.UI.Page
	{
        protected int nInitiativeID;
		
        protected void Page_Load(object sender, System.EventArgs e)
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

			pageTitle.InnerHtml=Global_DB.GetInitiativeName(nInitiativeID);


            hRefServerName.HRef = "#";
            hRefServerName.Attributes.Add("onclick",
                                        "javascript:popupWindowSelectServer(" +
                                        nInitiativeID.ToString() + ",'" +
                                        txtServerName.ClientID + "','" +
                                        txtServerNodeID.ClientID + "','" +
                                        hiddenServerID.ClientID + "');" +
                                        "return false;"
                                        );
		    
            if (!Page.IsPostBack)
            {
                object objInitiativeServerID = Request.QueryString["ServerID"];
                if (objInitiativeServerID != null)
                    EditServer(objInitiativeServerID);
                
            }

            txtServerName.Attributes.Add("onfocus", "parent.focus();");
		}

        protected void EditServer(object objServerID)
        {
            int nInitiativeServerID;

            try
            {
                nInitiativeServerID = Int32.Parse(objServerID.ToString());
            }
            catch (Exception e1)
            {
                nInitiativeServerID = 0;
            }

            DataSet dsServer = SectionE_DB.GetServer(nInitiativeServerID);
            DataRow dRow = dsServer.Tables["Server"].Rows[0];

            txtServerName.Text = dRow["ServerNodeName"].ToString();
            hiddenServerID.Value = dRow["ServerID"].ToString();
            txtServerNodeID.Text = dRow["ExternalServerNodeID"].ToString();
            txtImpact.Text = dRow["Impact"].ToString(); ;
            
            //..2006 version
            //DateTime dtDec = Convert.ToDateTime(dRow["DecommissioningDate"]);
            //txtDate.Text = dtDec.ToShortDateString();
        }
        	


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion

		
		protected void btnOK_Click(object sender, System.EventArgs e)
		{
            object objServerID = Request.QueryString["ServerID"];
            int nInitiativeServerID;

            if (objServerID == null)
            {

                if (hiddenServerID.Value != "")
                {
                    SectionE_DB.InsertInitiativeServer(nInitiativeID,
                    Convert.ToInt32(hiddenServerID.Value),
                    DateTime.Now, //Convert.ToDateTime(txtDate.Text)); //2006 version
                    txtImpact.Text);

                }
            }
            else
            {
                try
                {
                    nInitiativeServerID = Int32.Parse(objServerID.ToString());
                }
                catch (Exception e1)
                {
                    nInitiativeServerID = 0;
                }


                SectionE_DB.UpdateInitiativeServer(nInitiativeServerID,
                                                Convert.ToInt32(hiddenServerID.Value),
                                                DateTime.Now, //Convert.ToDateTime(txtDate.Text)); //2006 version
                                                txtImpact.Text);

    				
            }
            
            RegisterStartupScript("closeScript",
             "<script language=JavaScript> window.returnValue=1; window.close(); </script>");	
              

		}
	}
}
