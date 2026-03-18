
/*
 *  2.2.2.8          ERW         2 Oct 2008      (Phase 2.2 Point 2.8) 
 *                                              Allow admin users to alter more Initiative Details.
                                                Give users choice of applying to Current Init or ALL Inits
                                                Added method GetAdminInitiative
 */

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

namespace ProjectPortfolio
{
    public partial class InitiativeDetails : System.Web.UI.Page
    {
        protected int nInitiativeID;

        protected void Page_Load(object sender, EventArgs e)
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

            if (!Page.IsPostBack)
            {
                //txtInitiativeName.Text = Global_DB.GetInitiativeName(nInitiativeID);
                LoadData(nInitiativeID);  
            }
        }
        
    
        protected void btnOK_Click(object sender, EventArgs e)
        {
            //Admin_DB.UpdateInitiative(nInitiativeID, txtInitiativeName.Text);            

            //ERW 9 Oct 2008
            // work out who the user is
            if (Session["ContactID"] != null && Session["ContactID"].ToString() != String.Empty)
            {
                //lblWelcomeMessage.Text = "Welcome, " + Global_DB.GetContactName((int)Session["ContactID"]) + "!";

                //ERW - put the current user in as active user
                // would be best if we checked again that the initiative wasn't locked, before going ahead, but 
                // this is probably a fairly small chance - this is already checked when the window first loads
                // consider adding this to SetActiveUserID - i.e. it could return a true or false value
                // 
                Security_DB.SetActiveUserID(nInitiativeID, Convert.ToInt32( Session["ContactID"]));

                Admin_DB.UpdateInitiative(nInitiativeID,
                                            txtInitiativeName.Text, cbxNameAAV.Checked,
                                            txtIGIdentifier.Text, cbxIGIdentifierAAV.Checked,
                                            ddlPrimarySBU.SelectedItem.Text, Convert.ToInt32(ddlPrimarySBU.SelectedItem.Value), cbxPrimarySBUAAV.Checked);

                //remove current user from as ActiveUser
                Security_DB.ClearActiveUserID(nInitiativeID);  


                RegisterStartupScript("closeScript",
                                                 "<script language=JavaScript>  window.returnValue=1; window.close();  </script>");

            }
            else 
            {
                ShowMessage("There was a problem - refresh the Admin screen and try again.");
            }
            
        }
            
        private void LoadData(int InitiativeID)
        {
            bool showMsg = false;
            string msg = msg = "There was a problem - either no Initiative could be found, or no identifier was passed.\nClick Cancel and try again. If the problem persists contact support."; 

            if (nInitiativeID > 0)
            {
                DataSet ds = Admin_DB.GetAdminInitiative(nInitiativeID);
                if (ds.Tables[0].Rows.Count  > 0)
                {
                    if (ds.Tables[0].Rows[0]["ActiveUserID"].ToString() == null || ds.Tables[0].Rows[0]["ActiveUserID"].ToString() == String.Empty)
                    {
                        txtInitiativeName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                        txtIGIdentifier.Text = ds.Tables[0].Rows[0]["IGBusinessAreaCode"].ToString() + "-" + ds.Tables[0].Rows[0]["IGIdentifierCode"].ToString();

                        //txtPrimarySBU.Text = ds.Tables[0].Rows[0]["PrimarySponsoringArea"].ToString();

                        DataSet dsPrimarySBUs = Global_DB.GetReferenceTable(Convert.ToInt32(Global.ReferenceCategoryID.PrimarySponsoringArea));
                        ddlPrimarySBU.DataSource = dsPrimarySBUs.Tables["Reference"];
                        ddlPrimarySBU.DataValueField = "ReferenceId";
                        ddlPrimarySBU.DataTextField = "Description";
                        ddlPrimarySBU.DataBind();

                        // Match a value in the drop down
                        if (ds.Tables[0].Rows[0]["PrimarySBUID"].ToString() != String.Empty)
                        {
                            ddlPrimarySBU.SelectedValue = ds.Tables[0].Rows[0]["PrimarySBUID"].ToString();//drInitiative["PrimarySBUID"].ToString();
                        }
                    }
                    else 
                    {
                        showMsg = true;
                        string initiativeName = ds.Tables[0].Rows[0]["Name"].ToString();
                        string IGIdentifier = ds.Tables[0].Rows[0]["IGBusinessAreaCode"].ToString() + "-" + ds.Tables[0].Rows[0]["IGIdentifierCode"].ToString();
                        msg = "Initiative <strong>" + initiativeName + " (" + IGIdentifier + ")</strong> is locked by another user and cannot be edited just now.";
                    }
                }
                else
                {
                    showMsg = true;
                    //msg = "There was a problem - either no Initiative could be found, or no identifier was passed.\nClick Cancel and try again. If the problem persists contact support."; 
                }
            }
            else 
            {
                showMsg = true;
               // msg = "There was a problem - either no Initiative could be found, or no identifier was passed.\nClick Cancel and try again. If the problem persists contact support."; 
            }


            if (showMsg)
            {
                ShowMessage(msg);
            }

            
        }


        //Hides the other controls
        //shows user the parameter message
        // and allows them to cancel only
        private void ShowMessage(string message)
        {

            //show an error message - something has gone wrong
            // InitiativeID not passed
            // OR   No Initiative data found

            // display a message and only give the option to cancel the box?
            // I don't expect this message to be raised
            pnlDetails.Visible = false;
            pnlMessage.Visible = true;
            txtMessage.Text = message; //"There was a problem - either no Initiative could be found, or no identifier was passed.\nClick Cancel and try again. If the problem persists contact support."; 
        }
    }
}
