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
	public partial class NewServer : System.Web.UI.Page
	{
        protected int nInitiativeID;
		
        protected void Page_Load(object sender, System.EventArgs e)
		{
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            
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

            string strServerName = txtServerName.Text;
            string strServerNodeID = txtServerNodeID.Text;
            string strServerID = "";

            if (strServerName != "")
                strServerID = Global_DB.InsertItem(3, strServerName, strServerNodeID).ToString();

            RegisterStartupScript("closeScript",
                "<script language=JavaScript> updateItem(\"" + strServerName + "\",\"" + strServerNodeID + "\",\"" + strServerID + "\"); </script>");	  

		}
	}
}
