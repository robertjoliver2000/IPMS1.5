//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.1.1       CA          08/02/2007      Code to include option "Any" in year
//                                              drop down list.
//                                              Correction to default to 2007
//                                              Probably need to remove "Any" option
//                                              as it is may not be necessary here.
//
//      1.1.5       CA          08/02/2007      Code to add Approval Status
//                                              drop down list.
//
//      1.1.5       CA          13/02/2007      Code to add Approval Status
//                                              drop down list.
//
//      -----       GMcF        28/01/2008      For AP maint request 2008-01-02, made approval year default to current
//
//*****************************************************************************************************

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

	public partial class NewInitiative : System.Web.UI.Page
	{
        protected int nInitiativeID;

        int iApprovalID;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            if (!Page.IsPostBack)
            {
                DataSet dsIGApprovalCommittee = Global_DB.GetReferenceTable(4);

                dsIGApprovalCommittee.Tables["Reference"].Rows.RemoveAt(0);

                DataView dvIGApprovalCommittee = new DataView(dsIGApprovalCommittee.Tables["Reference"]);
                dvIGApprovalCommittee.Sort = "Description ASC";

                ddlApprovalCommittee.DataSource = dvIGApprovalCommittee;
                ddlApprovalCommittee.DataValueField = "Description";
                ddlApprovalCommittee.DataTextField = "Description";

                ddlApprovalCommittee.DataBind();


                // Changed 2008-01-28, GMcF, for AP maint request 2008-01-02, followed up 2008-01-28. Added bwithAll = false to method call.
                DataSet dsYear = Global_DB.GetYears(false);

                ddlPeriod.DataSource = dsYear;
                ddlPeriod.DataValueField = "PeriodYear";
                ddlPeriod.DataTextField = "PeriodYear";

                ddlPeriod.DataBind();

                //rem CA
                //ddlPeriod.SelectedValue = DateTime.Now.Year.ToString();
                //end rem

                ////rev 1.1.1 CA
                //ddlPeriod.SelectedIndex = 3;
                ////end rev

                // Added 2008-01-28, GMcF, for AP maint request 2008-01-02, followed up 2008-01-28
                ddlPeriod.SelectedValue = DateTime.Now.Year.ToString();


                //rev 1.1.5 CA

                //not required at the moment
                //DataSet dsIGApprovalStatus = Global_DB.GetReferenceTable(5);

                ////dsIGApprovalStatus.Tables["Reference"].Rows[0]["Description"] = "Any";

                //ddlStatus.DataSource = dsIGApprovalStatus.Tables["Reference"];
                //ddlStatus.DataValueField = "ReferenceID";
                //ddlStatus.DataTextField = "Description";

                //ddlStatus.DataBind();
                //*

                ddlStatus.Items.Add("IG Draft");
                ddlStatus.Items.Add("Budget Request");

                //end rev 

            }
		}
        

		protected void btnOK_Click(object sender, System.EventArgs e)
		{

            string strIGName = txtIGName.Text;
            string strBusinessAreaCode = txtBusinessAreaCode.Text;
            string strIGIdentifierCode = txtIGIdentifierCode.Text;
            string strApprovalCommiteee = ddlApprovalCommittee.SelectedItem.Value;
            DateTime dt = new DateTime(Convert.ToInt32(ddlPeriod.SelectedItem.Value), 1, 1, 0, 1,1);

            //rev 1.1.8 CA
            string strApprovalStatus = ddlStatus.SelectedItem.Value;

            if (strApprovalStatus == "IG Draft")
                iApprovalID = 1;
            else if (strApprovalStatus == "Budget Request")
                iApprovalID = 20;

            //end rev

            //rem CA
            //int nResult = Admin_DB.InsertInitiative(strIGName, 
            //                                    strBusinessAreaCode, 
            //                                    strIGIdentifierCode, 
            //                                    strApprovalCommiteee,
            //                                    dt);
            //end rem

            //rev 1.1.8 CA
            int nResult = Admin_DB.InsertInitiative(strIGName,
                                                strBusinessAreaCode,
                                                strIGIdentifierCode,
                                                strApprovalCommiteee,
                                                dt, strApprovalStatus, 
                                                iApprovalID);
            //end rev

            if (nResult < 0)
            {
                RegisterStartupScript("errScript",
                    "<script language=JavaScript> alert('Initiative " +strBusinessAreaCode+"-"+strIGIdentifierCode+" already exists in IPMS!'); </script>");

                //re-set
                /*
                txtIGName.Text = "";
                txtBusinessAreaCode.Text = "";
                txtIGIdentifierCode.Text = "";
                ddlApprovalCommittee.SelectedIndex = 0;
                */
                //the controls

            }
            else
            {
                //for non modal windows
                //RegisterStartupScript("closeScript",
                //        "<script language=JavaScript> opener.document.forms[0].submit(); window.close(); </script>");

                //but this is a mopdal window
                RegisterStartupScript("closeScript",
                    "<script language=JavaScript> window.returnValue=1; window.close(); </script>");	
                                
            }

            
		}
	}
}
