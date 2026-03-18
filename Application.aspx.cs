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

	public partial class Application : System.Web.UI.Page
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

		
		    hRefAppInstanceName.HRef = "javascript:popupWindowSelectApplication(" + 
                                        nInitiativeID.ToString() + ",'" +
                                        txtAppInstanceName.ClientID + "','" +
                                        txtAppID.ClientID  +"','" +
                                        hiddenAppID.ClientID + "','" +
                                        txtInvestmentStrategy.ClientID + "','" +
                                        hiddenInvestmentStrategy.ClientID + "')";

            if (!Page.IsPostBack)
            {
                object objInitiativeAppID = Request.QueryString["AppID"];
                if (objInitiativeAppID != null)
                    EditApp(objInitiativeAppID);
            }

            txtAppInstanceName.Attributes.Add("onfocus", "parent.focus();");
		}

        protected void EditApp(object objAppID)
        {
            int nInitiativeAppID;

            try
            {
                nInitiativeAppID = Int32.Parse(objAppID.ToString());
            }
            catch (Exception e1)
            {
                nInitiativeAppID = 0;
            }

            DataSet dsApp = SectionE_DB.GetApplication(nInitiativeAppID);
            DataRow dRow = dsApp.Tables["Application"].Rows[0];
            
            txtAppInstanceName.Text = dRow["ApplicationInstanceName"].ToString();
            hiddenAppID.Value = dRow["ApplicationID"].ToString(); ;
            txtAppID.Text = dRow["ExternalApplicationID"].ToString();
            txtImpact.Text = dRow["Impact"].ToString();

            //2006 version
            //DateTime dtDec = Convert.ToDateTime(dRow["DecommisioningDate"]);
            //txtDate.Text = dtDec.ToShortDateString();
        }


		protected void btnOK_Click(object sender, System.EventArgs e)
		{
            object objAppID = Request.QueryString["AppID"];
            int nInitiativeAppID;
            
            if (objAppID == null)
            {
                if(hiddenAppID.Value!="")
			    {
				    SectionE_DB.InsertInitiativeApp(nInitiativeID,
                                                Convert.ToInt32(hiddenAppID.Value),
                                                DateTime.Now,//Convert.ToDateTime(txtDate.Text), //2006 version
                                                txtImpact.Text,
                                                hiddenInvestmentStrategy.Value);
			    }
		    }
            else
            {
                try
                {
                    nInitiativeAppID = Int32.Parse(objAppID.ToString());
                }
                catch(Exception e1)
                {
                    nInitiativeAppID=0;
                }

                SectionE_DB.UpdateInitiativeApp(nInitiativeAppID,
                                                Convert.ToInt32(hiddenAppID.Value),
                                                DateTime.Now,//Convert.ToDateTime(txtDate.Text), //2006 version
                                                txtImpact.Text,
                                                hiddenInvestmentStrategy.Value);
            }

            RegisterStartupScript("closeScript",
                "<script language=JavaScript> window.returnValue=1; window.close(); </script>");	
		}

	}
}
