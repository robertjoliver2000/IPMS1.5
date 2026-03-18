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

	public partial class NewApplication : System.Web.UI.Page
	{
        protected int nInitiativeID;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
		}
        

		protected void btnOK_Click(object sender, System.EventArgs e)
		{
            string strAppName = txtAppInstanceName.Text;
            string strExternalAppID = txtAppID.Text;
            string strAppID="";

            if(strAppName!="")
                strAppID=Global_DB.InsertItem(2, strAppName, strExternalAppID).ToString();

            RegisterStartupScript("closeScript",
                "<script language=JavaScript> updateItem(\"" + strAppName + "\",\"" + strExternalAppID + "\",\"" + strAppID + "\"); </script>");	
		}
	}
}
