//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.6.1       GMcF        15/08/2007      Created for Phase 1.6 Deliverable 93 - Sponsor allocations hierarchy
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
using ProjectPortfolio.Classes;

public partial class AllocateUBR : System.Web.UI.Page
{
    protected int nInitiativeID = -1;
    protected int sponsorID = 0;
    protected int storeSponsorLevel = 0;
    protected bool bReadOnly = true;
    protected string sponsorType = "";

    protected DataView dvItems;

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

        object objSponsorId = Request.QueryString["SponsorId"];
        if (objSponsorId != null)
        {
            try
            {
                sponsorID = Convert.ToInt32(objSponsorId);
                sponsorType = SectionB_SponsorAllocations_DB.GetSponsorType(sponsorID);
            }
            catch (Exception e1)
            {
                sponsorType = "";
                sponsorID = -1;
            }
        }

        object objReadOnly = Request.QueryString["ReadOnly"];
        if (objReadOnly != null)
        {
            try
            {
                bReadOnly = (Convert.ToString(objReadOnly) == "1");
            }
            catch (Exception e1)
            {
                bReadOnly = true;
            }
        }

        object objStoreSponsorLevel = Request.QueryString["StoreSponsorLevel"];
        if (objStoreSponsorLevel != null)
        {
            try
            {
                storeSponsorLevel = Convert.ToInt32(objStoreSponsorLevel);
            }
            catch (Exception e1)
            {
                storeSponsorLevel = 0;
            }
        }

        if (!Page.IsPostBack)
        {
            Session["InitiativeID"] = null;
            Session["SponsorType"] = "";

            LoadDataSets();
            BindDataGrid();
            lblSponsorType.Text = sponsorType;
            btnSaveSponsorUBRs.Visible = !bReadOnly;
        }

        RegisterBodyBeforeUnloadHandlerScript();

    }

    protected void LoadDataSets()
    {
        try
        {
            DataSet dsSponsorUBRItems = new DataSet();
            dsSponsorUBRItems = SectionB_SponsorAllocations_DB.GetSponsorUBRMapping(sponsorType);

            DataSet dsSponsorUBRAllocs = new DataSet();

            // Get sponsor/ubr allocation values
            dsSponsorUBRAllocs = SectionB_SponsorAllocations_DB.GetInitiativeSponsorUBRAllocationForEdit(nInitiativeID, sponsorID, Session.SessionID, storeSponsorLevel, 0);

            // Show Appropriate rows from InitiativeSponsorUBRAllocation table
            dvItems = new DataView(dsSponsorUBRAllocs.Tables["SponsorAllocations"]);
        }
        catch (Exception ex)
        {
            string s = ex.ToString();
        }

    }

    protected void BindDataGrid()
    {
        gvUBRs.DataSource = dvItems;
        gvUBRs.DataBind();
    }

    protected void gvUBRs_RowEditing1(object sender, GridViewEditEventArgs e)
    {
        /*
        String valClicked = gvUBRs.Rows[e.NewEditIndex].Cells[2].Text;

        // For this example, cancel the edit operation if the user attempts
        // to edit the record of a customer from the Unites States. 
        if (valClicked == "USA")
        {
            // Cancel the edit operation.
            e.Cancel = true;
       //     Message.Text = "You cannot edit this record.";
        }
        else
        {
      //      Message.Text = "";
        }
         */
    }

    protected void btnSaveSponsorUBRs_Click(object sender, EventArgs e)
    {
        //Label2.Text = "Save clicked at " + DateTime.Now;

        if (Page.IsValid)
        {
            string ubrCode;
            decimal ubrAllocation;
            Boolean isPercentage;

            decimal ubrAllocationSubtotal = 0;

            SectionB_SponsorAllocations_DB.DeleteInitiativeSponsorUBRAllocationsForEdit(Session.SessionID, nInitiativeID, sponsorID);

            foreach (GridViewRow gvr in gvUBRs.Rows)
            {
                ubrCode = ((System.Web.UI.WebControls.Label)gvr.FindControl("lblUBR")).Text;
                ubrAllocation = Convert.ToDecimal(((System.Web.UI.WebControls.TextBox)gvr.FindControl("txtAmount")).Text);
                isPercentage = ((System.Web.UI.WebControls.CheckBox)gvr.FindControl("cbxPercentage")).Checked;

                /*
                Label2.Text += '\n' +
                                nInitiativeID.ToString() + '|' +
                                sponsorID.ToString() + '|' +
                                ubrCode.ToString() + '|' +
                                ubrAllocation.ToString() + '|' +
                                isPercentage.ToString();
                 */

                SectionB_SponsorAllocations_DB.InsertInitiativeSponsorUBRAllocationForEdit(
                        Session.SessionID, nInitiativeID, sponsorID, ubrCode, ubrAllocation, isPercentage);

                ubrAllocationSubtotal += ubrAllocation;
            }

            string strCSScript = "window.parent.closeReturning( " + ubrAllocationSubtotal.ToString() + " );";
            string strCSKey = "SetReturnValue";

            ClientScriptManager cs = Page.ClientScript;

            Type t = Page.GetType();

            if (!cs.IsClientScriptBlockRegistered(t, strCSKey))
            {
                cs.RegisterClientScriptBlock(t, strCSKey, strCSScript, true);
            }

        }
    }

    protected void RegisterBodyBeforeUnloadHandlerScript()
    {
        ClientScriptManager cs = Page.ClientScript;
        Type cstype = this.GetType();

        if (!cs.IsStartupScriptRegistered(cstype, "add_body_onbeforeunload_handler"))
        {
            String cstext = "<script language=\"javascript\">" +
                            "Events_chainEvent(" +
                                "document.body, " +
                                "\"onbeforeunload\", \"ConfirmUnload();\");" +
                            "</script>";
            cs.RegisterStartupScript(cstype, "add_body_onbeforeunload_handler", cstext);
        }
    }

    protected bool HasEditRights(string strPermissionName, string strApprovalStatus)
    {
        // 2007-08-09, GMcF: copied from Default.aspx.cs - ?? copy to Classes.Security_DB instead and share ??
        bool bHasEditRights;

        switch (strPermissionName.ToLower())
        {
            case "read-only":
                bHasEditRights = false;
                break;

            case "modify":
                bHasEditRights = (strApprovalStatus.ToLower() == "ig draft" || strApprovalStatus.ToLower() == "in review" || strApprovalStatus.ToLower() == "budget request");
                break;

            case "admin":
            case "superuser":
                bHasEditRights = true;
                break;

            default:
                bHasEditRights = false;
                break;
        }

        return bHasEditRights;
    }

}
