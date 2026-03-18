
/*
 * ERW 10 Jun 2008
 * 
 * Consider combining this page with PPR_Comments.  They are used in the same siutation, and have very similar 
 * functionality.
 * 
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

public partial class PPR_RagStatusSelect : System.Web.UI.Page
{

    protected int intInitiativeId = -1;
    protected string[] pprElements =  { "Overall", "Cost", "Deliverables", "Time", "Risks", "Benefits" };

    protected void Page_Load(object sender, EventArgs e)
    {
       
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            try
            {
                intInitiativeId = System.Convert.ToInt32(Page.Request.QueryString["InitiativeId"].ToString());
                if (!IsPostBack)
                {
                    if (intInitiativeId > 0)
                    {
                        lblInitiativeName.InnerHtml = Server.HtmlEncode(Global_DB.GetInitiativeName(intInitiativeId));
                        //  txtComments.Text = Global_DB.GetInitiativeComments(intInitiativeId);
                    }
                }
            }
            catch (Exception)
            {
                intInitiativeId = -1;
            }

            if (intInitiativeId <= 0)
            {
                // txtComments.Visible = false;
                btnSave.Visible = false;
                lblInitiativeName.Style["display"] = "none";
                lblMessage.Text = "Invalid Initiative ID";
                lblMessage.Visible = true;
            }

        if (!this.IsPostBack)
        {
            DataRow drInitiative = SectionA_DB.GetInitiativeDetails(intInitiativeId);

            if (drInitiative != null)
            {
                // Rev 2.1.7, GMcF
                System.Web.UI.WebControls.Image imgPPRStatus;
                HiddenField hdnPPRStatus,
                            hdnPPRStatusId;
                string PPRStatus,
                        newSrc,
                        newAlt;
                //foreach (string idPart in new string[] { "Overall", "Cost", "Deliverables", "Time", "Risks", "Benefits" })
                foreach (string idPart in pprElements)
                {
                    hdnPPRStatus = (HiddenField)FindControl("hdnPPR_" + idPart + "Status");
                    hdnPPRStatusId = (HiddenField)FindControl("hdnPPR_" + idPart + "StatusID");

                    if (drInitiative["PPR_" + idPart + "Status"] == DBNull.Value
                            || drInitiative["PPR_" + idPart + "Status"].ToString() == "")
                    {
                        hdnPPRStatus.Value = "Please select";
                        hdnPPRStatusId.Value = "0";
                    }
                    else
                    {
                        hdnPPRStatus.Value = drInitiative["PPR_" + idPart + "Status"].ToString();
                        hdnPPRStatusId.Value = drInitiative["PPR_" + idPart + "StatusId"].ToString();
                    }

                    switch (hdnPPRStatusId.Value)
                    {
                        case "3": newSrc = "~/Images/PPR_red.gif"; newAlt = "R - Red"; break;
                        case "2": newSrc = "~/Images/PPR_amber.gif"; newAlt = "A - Amber"; break;
                        case "1": newSrc = "~/Images/PPR_green.gif"; newAlt = "G - Green"; break;
                        default: newSrc = "~/Images/PPR_grey.gif"; newAlt = "- - Please select"; break;

                    }

                    imgPPRStatus = (System.Web.UI.WebControls.Image)FindControl("imgPPR_" + idPart);
                    imgPPRStatus.ImageUrl = newSrc;
                    imgPPRStatus.ToolTip = newAlt;
                }
            }

        }
    }

    
    protected void  btnSave_Click(object sender, EventArgs e)
    {
        if (intInitiativeId > 0)
        {   
            Global_DB.UpdateInitiativePPR_RAG_Indicators(intInitiativeId, 
                                                          hdnPPR_OverallStatus.Value,
                                                          Int32.Parse(hdnPPR_OverallStatusID.Value),
                                                          hdnPPR_CostStatus.Value,
                                                          Int32.Parse(hdnPPR_CostStatusID.Value),
                                                          hdnPPR_DeliverablesStatus.Value,
                                                          Int32.Parse(hdnPPR_DeliverablesStatusID.Value),
                                                          hdnPPR_TimeStatus.Value,
                                                          Int32.Parse(hdnPPR_TimeStatusID.Value),
                                                          hdnPPR_RisksStatus.Value,
                                                          Int32.Parse(hdnPPR_RisksStatusID.Value),
                                                          hdnPPR_BenefitsStatus.Value,
                                                          Int32.Parse(hdnPPR_BenefitsStatusID.Value),
                                                          Session["Username"].ToString(),
                                                          System.Convert.ToInt32(Session["ContactID"].ToString()));



            //ERW 9 Jun 2008            
            //build simple csv string to return to the browser
            //would be nice to do with xml. Attempt made, but 
            //time pressure meant this method was adopted.
            string valuesString;
            
            valuesString = "";
            HiddenField hdnPPRStatus,
                        hdnPPRStatusId;
            
            foreach (string idPart in pprElements)
            {
                hdnPPRStatus = (HiddenField)FindControl("hdnPPR_" + idPart + "Status");
                hdnPPRStatusId = (HiddenField)FindControl("hdnPPR_" + idPart + "StatusID");
               
                valuesString += "|" + idPart + ", " + ProjectPortfolio.Global.PPRStatusImageFromId(hdnPPRStatusId.Value).Replace(".gif", ".png") + "|";   
             }
            

            string dataToReturn;
            dataToReturn = valuesString;             

            Page.ClientScript.RegisterStartupScript(this.GetType(),
                                                    "saveandclose",
                                                    "window.returnValue = \""
                                                          + Server.HtmlEncode(dataToReturn)           
                                                        + "\";"
                                                        + "window.close();"
                                                    , true);
    }
}
}
