/***************************************************************************************************
 *  Rev     Date        By      Description
 *  1.9.3   2008-01-21  GMcF    For Post-Implementation Review, added option to create new vn as PIR
 * 
 ***************************************************************************************************/

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

	public partial class NewReview : System.Web.UI.Page
	{
        protected int nInitiativeID;
        protected bool bIsForPIR = false;

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

            // Added 
            if ((Request.QueryString["ForPIR"]!=null) && (Request.QueryString["ForPIR"].ToString().ToLower() == "yes"))
            {
                bIsForPIR = true;
                Page.Title = "New Post-Implementation Review";
            }

            if (!Page.IsPostBack)
            {
                DataSet dsYear = Global_DB.GetYears();
                ddlPeriod.DataSource = dsYear;
                ddlPeriod.DataValueField = "PeriodYear";
                ddlPeriod.DataTextField = "PeriodYear";

                ddlPeriod.DataBind();
                ddlPeriod.SelectedValue = DateTime.Now.Year.ToString();
            }

       
            //false avoids submit
            btnOK.Attributes.Add("onclick", "click_count+=1;document.getElementById('divWait').style.visibility='visible'; document.getElementById('btnCancel').disabled=true;if (click_count>1) { alert('IPMS is now creating the review.Please wait.'); return false; } else { return true; }");
        }
        

		protected void btnOK_Click(object sender, System.EventArgs e) 
		{
            

            int nResponse=0;
           
            DateTime dt = new DateTime(Convert.ToInt32(ddlPeriod.SelectedItem.Value), 1, 1, 0, 1,1);
            int nContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;
            int nActiveUserID = Security_DB.GetActiveUserID(nInitiativeID);


            string strPermissionName = Security_DB.GetInitiativeAccessRights(nContactID, nInitiativeID);


            if (strPermissionName.ToLower() != "modify" &&
                strPermissionName.ToLower() != "admin" &&
                strPermissionName.ToLower() != "superuser")
            {
                Session["cmd"] = "showNoAccess";
                nResponse = 0; 
                //Response.Redirect("~/default.aspx");
           
                RegisterStartupScript("closeScript",
                    "<script language=JavaScript> window.returnValue=0; window.close(); </script>");	
           
                return;
            }

            else if (nActiveUserID > 0 && nActiveUserID != nContactID)
            {
                Session["cmd"] = "showRecordLocked";
                nResponse = 0;
                //Response.Redirect("~/default.aspx");
                RegisterStartupScript("closeScript",
                 "<script language=JavaScript> window.returnValue=0; window.close(); </script>");
             
                return;
            }


            int nNewVersion_InitiativeID;

            if (bIsForPIR)
            {
                nNewVersion_InitiativeID = MyProjects_DB.InsertInitiative_CreateNewVersionForPIR(nInitiativeID,
                                                                                    nContactID, dt);
            }
            else
            {
                nNewVersion_InitiativeID = MyProjects_DB.InsertInitiative_CreateNewVersion(nInitiativeID,
                                                                                    nContactID, dt);
            }

            //Response.Redirect("~/default.aspx?section=1&InitiativeID=" + nNewVersion_InitiativeID.ToString());
            RegisterStartupScript("closeScript",
                   "<script language=JavaScript> window.returnValue=" + nNewVersion_InitiativeID.ToString() + "; window.close(); </script>");	
                           

            
		}
	}
}
