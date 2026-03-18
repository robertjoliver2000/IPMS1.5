//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1         CA          25/01/2007      Variable nInitiative 
//                                              To pass to InitiativeStatusGetReferenceTable
//                                              
//      1.9.3       GMcF        21/01/2008      Added handling of PIR statuses.
//
//      1.9.11      GMcF        07/03/2008      For 1.9 UAT Bug 9, if initiative has a PIR status
//                                              must limit new status list to PIR ones.
//
//*****************************************************************************************************


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

using ProjectPortfolio.Controls;
using ProjectPortfolio.Classes;
using System.Net.Mail;

namespace ProjectPortfolio.Controls
{
    public partial class section_status : System.Web.UI.UserControl
    {
        int nInitiativeID;

        public bool IsForReview
        {
            get
            {
                return SubmitTable.Visible;
            }
        }

        public delegate void SubmitClickEventHandler(object sender, EventArgs e);
        public event SubmitClickEventHandler SubmitClick;
        public delegate void NewStatusClickEventHandler(object sender, EventArgs e);
        public event NewStatusClickEventHandler NewStatusClick;

        protected virtual void OnSubmitClick(EventArgs e)
        {
            if (SubmitClick != null) SubmitClick(this, e);
        }

        protected virtual void OnNewStatusClick(EventArgs e)
        {
            if (NewStatusClick != null) NewStatusClick(this, e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
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
                FillDropDowns();

                LoadInitiative();
            }

            int intContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;
            string strPermissionName = Security_DB.GetInitiativeAccessRights(intContactID, nInitiativeID);

            if (strPermissionName.ToLower() == "modify")
            {
                //ddlIGApprovalStatus.Enabled = false;
            }

            GenerateJavaScripts();            
                                
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

                ddlIGApprovalStatus.SelectedValue = drInitiative["IGApprovalStatusID"].ToString();
                if (drInitiative["IGApprovalStatus"].Equals("IG Draft")
                        || drInitiative["IGApprovalStatus"].Equals("In Review")
                        || drInitiative["IGApprovalStatus"].Equals("Budget Request")
                        || drInitiative["IGApprovalStatus"].Equals("In PIR")    //
                    )
                {
                    ApprovalTable.Visible = false;
                    SubmitTable.Visible = true;

                  //  btnSubmit.ValidationGroup = "";
                }
                else
                {
                    ApprovalTable.Visible = true;
                    SubmitTable.Visible = false;
                }
            }
        }

        private void FillDropDowns()
        {
            ////rem CA
            //DataSet dsIGApprovalStatus = Global_DB.GetReferenceTable(5);
            ////end rem

            //rev 1.1 CA
            DataSet dsIGApprovalStatus = Global_DB.GetInitiativeStatusReferenceTable(5, nInitiativeID);
            //end rev 1.1

            ddlIGApprovalStatus.DataSource = dsIGApprovalStatus.Tables["Reference"];
            ddlIGApprovalStatus.DataValueField = "ReferenceID";
            ddlIGApprovalStatus.DataTextField = "Description";

            // Rev 1.9.11, 2008-03-07, GMcF
            if (Global_DB.IsPIR((Global_DB.GetInitiativeStatusID(nInitiativeID))))
            {
                DataTable stats = dsIGApprovalStatus.Tables["Reference"];
                for (int i = stats.Rows.Count - 1; i >= 0; i-- )
                {
                    if (!Global_DB.IsPIR(int.Parse(stats.Rows[i].ItemArray[0].ToString())))
                    {
                        stats.Rows[i].Delete();
                    }
                }
            }
            // End of Rev 1.9.11

            ddlIGApprovalStatus.DataBind();
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            OnSubmitClick(new EventArgs());
        }


        protected void btnNewStatus_Click(object sender, EventArgs e)
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

            if (drInitiative["InitiativeID"] != DBNull.Value)
            {
                Header_DB.UpdateInitiativeStatus(nInitiativeID, ddlIGApprovalStatus.SelectedItem.Text, Int32.Parse(ddlIGApprovalStatus.SelectedItem.Value));

                OnNewStatusClick(new EventArgs());
            }
            else
            {
                //GenerateApprovalDateScripts();
            }

        }


        protected override void OnPreRender(EventArgs e)
        {
            if (btnNewStatus.Visible)
            {
                /*
                Page.RegisterStartupScript(btnNewStatus.ClientID + "_onclick",
                                "<script language=\"javascript\">" +
                                "Events_chainEvent(" +
                                    "document.getElementById(\"" + btnNewStatus.ClientID + "\"), " +
                                    "\"onclick\", \"ClearDirtyFlag();\");" +
                                "</script>");
                 */

                Page.RegisterStartupScript("",
                                "<script language=\"javascript\">" +
                                "function submitChangeStatus() {" +
                                    "ClearDirtyFlag();" + 
                                    "if (document.getElementById(\"" + ddlIGApprovalStatus.ClientID + "\").options[" +
                                        "document.getElementById(\"" + ddlIGApprovalStatus.ClientID + "\").selectedIndex].text == \"IG Draft\" ||" +
                                        "document.getElementById(\"" + ddlIGApprovalStatus.ClientID + "\").options[document.getElementById(\"" + ddlIGApprovalStatus.ClientID + "\").selectedIndex].text == \"In Review\"  " +
                                        ") " + 
                                    "{" +
                                        "document.getElementById(\"" + btnDraftStatus.ClientID + "\").click(); " +
                                    "}" +
                                    "else {" +
                                        "if(confirmStatus()==true){" +    
                                            "document.getElementById(\"" + btnNewStatus.ClientID + "\").click(); " +
                                        "}"+
                                    "}" +
                                "}" +
                                "</script>");
            }

            if (btnSubmit.Visible)
            {
                Page.RegisterStartupScript(btnSubmit.ClientID + "_onclick",
                                "<script language=\"javascript\">" +
                                "Events_chainEvent(" +
                                    "document.getElementById(\"" + btnSubmit.ClientID + "\"), " +
                                    "\"onclick\", \"ClearDirtyFlag();\");" +
                                "</script>");
            }
        }

        protected void GenerateJavaScripts()
        {
            DataSet dsAppStatus = Global_DB.GetApprovedStatus();
 
            string strCondition = " ( ";
            for (int i = 0; i < dsAppStatus.Tables["ApprovedStatus"].Rows.Count-1; i++)
                strCondition += "(strStatus=='" + dsAppStatus.Tables["ApprovedStatus"].Rows[i]["Description"].ToString() + "') || ";
            strCondition += "(strStatus=='" + dsAppStatus.Tables["ApprovedStatus"].Rows[dsAppStatus.Tables["ApprovedStatus"].Rows.Count-1]["Description"].ToString() + "') ) ";

            
            Page.RegisterStartupScript("confirmStatus",
                                   "<script language=\"javascript\"> " +
                                   "function confirmStatus()" +
                                   "{" +
                                        "var strStatus;" +
                                        "strStatus=document.getElementById(\"" + ddlIGApprovalStatus.ClientID + "\").options[" +
                                        "document.getElementById(\"" + ddlIGApprovalStatus.ClientID + "\").selectedIndex].text; " +
                                        "if " + strCondition +" {" +
                                             "return confirm('Are you sure you want to APPROVE this Initiative?'); " +
                                        "}else{"+
                                            "return true;"+
                                        "}"+
                                   "}" +
                                    "</script>");

        }

        protected void GenerateApprovalDateScripts()
        {
            Page.RegisterStartupScript("MessageRequestSent",
                            "<script language=\"javascript\"> " +
                                   "alert(\"Please enter an IG Approval Date.\");" +
                            "</script>");
        }

    }
}