/*
 *  Rev         By          Date            Description
 * 
 *  1.8.1       GMcF        2007-09-18      Amended for maint of Secondary Functional Domain
 *                                          Variation with extra column for ParentReferenceId ( Primary Functional Domain )
 *  1.8.1a      GMcF        2007-10-07      UAT Bug 4 - when click new value, creates record one but then starts editing the last item in the list
 * 
 */

namespace ProjectPortfolio.Controls
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using System.Configuration;
    using System.Collections;
    using System.Web;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.WebControls.WebParts;
    using System.Web.UI.HtmlControls;

    using ProjectPortfolio.Classes;


    public partial class Admin_StaticData : System.Web.UI.UserControl
    {
        bool bEnterEditMode = false;
        string strOriginalParentReferenceId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataSet dsCategories = Reference_DB.GetReferenceCategoryTable();

                ddlCategory.DataSource = dsCategories.Tables["ReferenceCategory"];
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataTextField = "Description";

                ddlCategory.DataBind();
            }

            ShowGridView();
        }


        protected void btnNew_Click(object sender, EventArgs e)
        {
            GridView gv;

            switch (ddlCategory.SelectedItem.Text)
            {
                case "Application":
                    {
                        hInsertParameter1.Value = "New application";
                        hInsertParameter2.Value = String.Empty;
                        sdsApplications.Insert();

                        if (gvApplications.PageCount > 1 && gvApplications.PageIndex != gvApplications.PageCount - 1)
                        {
                            gvApplications.PageIndex = gvApplications.PageCount - 1;
                            bEnterEditMode = true;
                        }
                        else
                        {
                            gvApplications.EditIndex = gvApplications.Rows.Count;
                        }
                    }
                    break;

                case "Server":
                    {
                        hInsertParameter1.Value = "New server";
                        hInsertParameter2.Value = String.Empty;
                        sdsServers.Insert();

                        if (gvServers.PageCount > 1 && gvServers.PageIndex != gvServers.PageCount - 1)
                        {
                            gvServers.PageIndex = gvServers.PageCount - 1;
                            bEnterEditMode = true;
                        }
                        else
                        {
                            gvServers.EditIndex = gvServers.Rows.Count;
                        }
                    }
                    break;

                case "Sponsors":
                    {
                        hInsertParameter1.Value = "New Name";
                        hInsertParameter2.Value = "Owner";
                        hDescription.Value = "Short name";
                        sdsSponsors.Insert();

                        if (gvSponsors.PageCount > 1 && gvSponsors.PageIndex != gvSponsors.PageCount - 1)
                        {
                            gvSponsors.PageIndex = gvSponsors.PageCount - 1;
                            bEnterEditMode = true;
                        }
                        else
                        {
                            gvSponsors.EditIndex = gvSponsors.Rows.Count;
                        }
                    }
                    break;

                //rev 1.1.8 CA
                case "IG Approval Status":
                    {
                        hReferenceID.Value = (Reference_DB.GetMaxReferenceID(Convert.ToInt32(ddlCategory.SelectedValue)) + 1).ToString();
                        hDescription.Value = "New value";
                        //hApproved.Value = "0";
                        sdsApprovalStatus.Insert();

                        //SqlConnection dbConnection = new SqlConnection(Global_DB.GetConnectionString());

                        //SqlTransaction cmdInsertApprovalStatus = new SqlTransaction();
                        //cmdInsertApprovalStatus.Connection = dbConnection;

                        //cmdInsertApprovalStatus.CommandType = CommandType.Text;
                        //cmdInsertApprovalStatus.CommandText = "INSERT INTO ReferenceIGApprovalStatus(ReferenceID, IsApproved) VALUES(@ReferenceID, 20)";
                        //cmdInsertApprovalStatus.Transaction.Commit();



                        if (gvApprovalStatuses.PageCount > 1 && gvApprovalStatuses.PageIndex != gvApprovalStatuses.PageCount - 1)
                        {
                            gvApprovalStatuses.PageIndex = gvApprovalStatuses.PageCount - 1;
                            bEnterEditMode = true;
                        }
                        else
                        {
                            gvApprovalStatuses.EditIndex = gvApprovalStatuses.Rows.Count;
                        }
                    }
                    break;
                //end rev

                //rev 1.8.1 GMcF
                case "Functional Domain":
                    string strNewReferenceID = (Reference_DB.GetMaxReferenceID(Convert.ToInt32(ddlCategory.SelectedValue)) + 1).ToString("0");
                    hReferenceID.Value = strNewReferenceID;
                    hDescription.Value = "New value";

                    // Rev 1.8.1a GMcF
                    //hInsertParameter1.Value = "1"; 
                    
                    string strNewFunctionalDomainParentReference = ddlPrimaryFunctionalDomainPicker.SelectedValue;
                    if (strNewFunctionalDomainParentReference == "")
                    {
                        strNewFunctionalDomainParentReference = "null";
                    }
                    hInsertParameter1.Value = strNewFunctionalDomainParentReference;
                    // End of Rev 1.8.1a

                    sdsFunctionalDomain.Insert();

                    gv = gvFunctionalDomain;

                    gv.EditIndex = gv.Rows.Count;

                    break;

                //end rev

                default:
                    {
                        hReferenceID.Value = (Reference_DB.GetMaxReferenceID(Convert.ToInt32(ddlCategory.SelectedValue)) + 1).ToString();
                        hDescription.Value = "New value";
                        sdsReferences.Insert();

                        if (gvReferences.PageCount > 1 && gvReferences.PageIndex != gvReferences.PageCount - 1)
                        {
                            gvReferences.PageIndex = gvReferences.PageCount - 1;
                            bEnterEditMode = true;
                        }
                        else
                        {
                            gvReferences.EditIndex = gvReferences.Rows.Count;
                        }
                    }
                    break;
            }

        }


        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            ShowGridView();
        }


        protected void ShowGridView()
        {
            sdsReferences.FilterExpression = "CategoryID=" + ddlCategory.SelectedValue;

            gvReferences.Visible = false;
            gvApplications.Visible = false;
            gvServers.Visible = false;
            gvFunctionalDomain.Visible = false;    // Rev 1.8.1 GMcF
            
            // Rev 1.8.1a GMcF
            ddlPrimaryFunctionalDomainPicker.Visible = false;
            lblPrimaryFunctionalDomainPicker.Visible = false;
            // End Rev 1.8.1a

            //rev 1.1.8
            gvApprovalStatuses.Visible = false;
            //end rev

            gvSponsors.Visible = false;

            switch (ddlCategory.SelectedItem.Text)
            {
                case "Application":
                    gvApplications.Visible = true;
                    break;

                case "Server":
                    gvServers.Visible = true;
                    break;

                //rev 1.1.8
                case "IG Approval Status":
                    gvApprovalStatuses.Visible = true;
                    break;
                //end rev

                // RH 11/08
                case "Sponsors":
                    gvSponsors.Visible = true;
                    break;
                
                //rev 1.8.1 GMcF
                case "Functional Domain":
                    // Rev 1.8.1a GMcF
                    ddlPrimaryFunctionalDomainPicker.Visible = true;
                    lblPrimaryFunctionalDomainPicker.Visible = true;
                    string strPrimaryDomainId = ddlPrimaryFunctionalDomainPicker.SelectedValue;
                    if (strPrimaryDomainId == "")
                    {
                        strPrimaryDomainId = "0";
                    }

                    sdsFunctionalDomain.FilterExpression = "CategoryID=" + ddlCategory.SelectedValue +
                                                            " and IsNull(ParentReferenceID, 0) = " + strPrimaryDomainId;
                    //sdsFunctionalDomain.FilterExpression = "CategoryID=" + ddlCategory.SelectedValue;
                    // End of Rev 1.8.1a

                    gvFunctionalDomain.Visible = true;

                    break;
                //end rev

                default:
                    gvReferences.Visible = true;
                    break;
            }
        }


        protected void gvReferences_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // if it is the last added value and its name is "New value", delete it
            if (Reference_DB.GetMaxReferenceID(Convert.ToInt32(ddlCategory.SelectedValue)) == Convert.ToInt32(gvReferences.DataKeys[e.RowIndex].Values[0]))
            {
                string strDescription = Reference_DB.GetReferenceDescription(
                            Convert.ToInt32(gvReferences.DataKeys[e.RowIndex].Values[1]),
                            Convert.ToInt32(gvReferences.DataKeys[e.RowIndex].Values[0]));

                if (strDescription == "New value")
                {
                    Reference_DB.DeleteReference(
                                Convert.ToInt32(gvReferences.DataKeys[e.RowIndex].Values[1]),
                                Convert.ToInt32(gvReferences.DataKeys[e.RowIndex].Values[0]));
                }
            }
        }

        protected void gvApprovalStatuses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // if it is the last added value and its name is "New value", delete it
            if (Reference_DB.GetMaxReferenceID(Convert.ToInt32(ddlCategory.SelectedValue)) == Convert.ToInt32(gvApprovalStatuses.DataKeys[e.RowIndex].Values[0]))
            {
                string strDescription = Reference_DB.GetReferenceDescription(
                            Convert.ToInt32(gvApprovalStatuses.DataKeys[e.RowIndex].Values[1]),
                            Convert.ToInt32(gvApprovalStatuses.DataKeys[e.RowIndex].Values[0]));

                if (strDescription == "New value")
                {
                    Reference_DB.DeleteReference(
                                Convert.ToInt32(gvApprovalStatuses.DataKeys[e.RowIndex].Values[1]),
                                Convert.ToInt32(gvApprovalStatuses.DataKeys[e.RowIndex].Values[0]));
                }
            }
        }

        protected void gvApplications_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            if (Reference_DB.GetMaxApplicationID() == Convert.ToInt32(gvApplications.DataKeys[e.RowIndex].Value))
            {
                string strDescription = Reference_DB.GetApplicationName(Convert.ToInt32(gvApplications.DataKeys[e.RowIndex].Value));

                if (strDescription == "New application")
                {
                    Reference_DB.DeleteApplication(Convert.ToInt32(gvApplications.DataKeys[e.RowIndex].Value));
                }
            }
        }


        protected void gvServers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            if (Reference_DB.GetMaxServerID() == Convert.ToInt32(gvServers.DataKeys[e.RowIndex].Value))
            {
                string strDescription = Reference_DB.GetServerName(Convert.ToInt32(gvServers.DataKeys[e.RowIndex].Value));

                if (strDescription == "New server")
                {
                    Reference_DB.DeleteServer(Convert.ToInt32(gvServers.DataKeys[e.RowIndex].Value));
                }
            }
        }

        protected void gvSponsors_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            if (Reference_DB.GetMaxSponsorID() == Convert.ToInt32(gvSponsors.DataKeys[e.RowIndex].Value))
            {
                string strDescription = Reference_DB.GetSponsorName(Convert.ToInt32(gvSponsors.DataKeys[e.RowIndex].Value));

                if (strDescription == "New Name")
                {
                    Reference_DB.DeleteSponsor(Convert.ToInt32(gvSponsors.DataKeys[e.RowIndex].Value));
                }
            }
        }


        protected void sdsReferences_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            Reference_DB.UpdateReference(
                            Convert.ToInt32(e.Command.Parameters["@CategoryID"].Value),
                            Convert.ToInt32(e.Command.Parameters["@ReferenceID"].Value),
                            Convert.ToString(e.Command.Parameters["@Description"].Value));
        }


        //Added 2007-02-21 GMcF for Deliverable 77 - IG Approval Status flagged as Approved/Not Approved/Neutral
        protected void sdsApprovalStatus_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            Reference_DB.UpdateReference(
                            Convert.ToInt32(e.Command.Parameters["@CategoryID"].Value),
                            Convert.ToInt32(e.Command.Parameters["@ReferenceID"].Value),
                            Convert.ToString(e.Command.Parameters["@Description"].Value),
                            Convert.ToInt32(e.Command.Parameters["@ReportingCategory"].Value));
        }
        //End of code added 2007-02-21

        //Rev 1.8.1 GMcF
        protected void sdsFunctionalDomain_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            Reference_DB.UpdateReferenceWithParent(
                            Convert.ToInt32(e.Command.Parameters["@CategoryID"].Value),
                            Convert.ToInt32(e.Command.Parameters["@ReferenceID"].Value),
                            Convert.ToString(e.Command.Parameters["@Description"].Value),
                            Convert.ToInt32(e.Command.Parameters["@ParentReferenceID"].Value));

            if (strOriginalParentReferenceId != e.Command.Parameters["@ParentReferenceID"].Value.ToString())
            {
                if (strOriginalParentReferenceId == e.Command.Parameters["@ReferenceID"].Value.ToString())
                {
                    ddlPrimaryFunctionalDomainPicker.DataBind();
                    ddlPrimaryFunctionalDomainPicker.SelectedIndex = 0;
                }
                else if (e.Command.Parameters["@ParentReferenceID"].Value.ToString()
                            == e.Command.Parameters["@ReferenceID"].Value.ToString())
                {
                    string strCurrentPrimary = ddlPrimaryFunctionalDomainPicker.SelectedValue;
                    ddlPrimaryFunctionalDomainPicker.DataBind();
                    ddlPrimaryFunctionalDomainPicker.SelectedValue = strCurrentPrimary;
                }
                ShowGridView();
            }
        }
        //End of Rev 1.8.1

        protected void gvReferences_PreRender(object sender, EventArgs e)
        {
            if (bEnterEditMode)
            {
                gvReferences.EditIndex = gvReferences.Rows.Count - 1;
            }
        }


        protected void gvApplications_PreRender(object sender, EventArgs e)
        {
            if (bEnterEditMode)
            {
                gvApplications.EditIndex = gvApplications.Rows.Count - 1;
            }
        }


        protected void gvServers_PreRender(object sender, EventArgs e)
        {
            if (bEnterEditMode)
            {
                gvServers.EditIndex = gvServers.Rows.Count - 1;
            }
        }

        protected void gvSponsors_PreRender(object sender, EventArgs e)
        {
            if (bEnterEditMode)
            {
                gvSponsors.EditIndex = gvSponsors.Rows.Count - 1;
            }
        }

        protected void gvApprovalStatuses_PreRender(object sender, EventArgs e)
        {
            if (bEnterEditMode)
            {
                gvApprovalStatuses.EditIndex = gvApprovalStatuses.Rows.Count - 1;
            }
        }

        protected void gvReferences_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.Controls[0].Controls.Count > 0)
            {
                WebControl control = e.Row.Controls[0].Controls[0] as WebControl;

                if (control != null)
                {
                    control.Attributes.Add("onclick", "if (!confirm('Are you sure you wish to delete this value?')) return false;");
                }
            }
        }

        protected void gvApprovalStatuses_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.Controls[0].Controls.Count > 0)
            {
                WebControl control = e.Row.Controls[0].Controls[0] as WebControl;

                if (control != null)
                {
                    control.Attributes.Add("onclick", "if (!confirm('Are you sure you wish to delete this value?')) return false;");
                }

            }
        }

        protected void gvApplications_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.Controls[0].Controls.Count > 0)
            {
                WebControl control = e.Row.Controls[0].Controls[0] as WebControl;

                if (control != null)
                {
                    control.Attributes.Add("onclick", "if (!confirm('Are you sure you wish to delete this application?')) return false;");
                }
            }
        }


        protected void gvServers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.Controls[0].Controls.Count > 0)
            {
                WebControl control = e.Row.Controls[0].Controls[0] as WebControl;

                if (control != null)
                {
                    control.Attributes.Add("onclick", "if (!confirm('Are you sure you wish to delete this server?')) return false;");
                }

            }
        }


        protected void gvSponsors_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Nothing needed here as we do not allow deletions.
        }

        protected void gvFunctionalDomain_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Controls[0].Controls.Count > 0)
                {
                    WebControl control = e.Row.Controls[0].Controls[0] as WebControl;

                    if (control != null)
                    {
                        control.Attributes.Add("onclick", "if (!confirm('Are you sure you wish to delete this value?')) return false;");
                    }
                }

                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlPrimaryFunctionalDomain");
                CheckBox cbx = (CheckBox)e.Row.FindControl("cbxIsPrimary");
                string strID = ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[0].ToString();
                string strDescription = ((System.Data.DataRowView)(e.Row.DataItem)).Row.ItemArray[1].ToString();

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    ListItem liSelf = new ListItem(strDescription, strID);
                    if (!ddl.Items.Contains(liSelf))
                    {
                        ddl.Items.Add(liSelf);
                    }
                    string strCbxId = cbx.ClientID;
                    string strDdlId = ddl.ClientID;
                    string strConfirmRemovePrimaryStatusQuestion =
                                "Secondary Functional Domains might be taking this as their Primary.\\n" +
                                "Are you sure you wish take away its Primary Functional Domain status?";

                    //cbx on change
                    string strCbxOnClick =
                                    "function cbxIsPrimaryFunctionalDomain_OnClick()" +
                                    "{\n" +
                                    //"   window.alert ( 'cbxIsPrimaryFunctionalDomain_OnClick' );\n" +
                                    "   var cbx = document.getElementById( '" + strCbxId + "' );\n" +
                                    "   var ddl = document.getElementById( '" + strDdlId + "' );\n" +
                                    "   if ( cbx.checked )\n" +
				                    "   {\n" +
                                    "   	ddl.value = '" + strID + "';\n" +
                                    "   }\n" +
				                    "   else\n" +
                                    "   {\n" +
                                    "       if (!confirm( '" + strConfirmRemovePrimaryStatusQuestion + "' ) )\n" +
				                    "       {\n" +
				                    "       	cbx.checked = true;\n" +
                                    "       }\n" +
                                    "       else\n" +
                                    "       {\n" +
                                    "           ddl.selectedIndex = 0;\n" +
                                    "       }\n" +
                                    "   }\n" +
				                    "}\n";

                    //ddl on change
                    string strDdlOnChange =
                                    "function ddlPrimaryFunctionalDomain_OnChange()" +
                                    "{\n" +
                                    "   var cbx = document.getElementById( '" + strCbxId + "' );\n" +
				                    "   var ddl = document.getElementById( '" + strDdlId + "' );\n" +
				                    "   if ( ddl.value == '" + strID + "' )\n" +
				                    "   {\n" +
				                    "   	cbx.checked = true;\n" +
				                    "   }\n" +
				                    "   else\n" +
				                    "   {\n" +
				                    "   	if ( cbx.checked )\n" +
				                    "   	{\n" +
                                    "   		if (confirm( '" + strConfirmRemovePrimaryStatusQuestion + "' ) )\n" +
				                    "   		{\n" +
				                    "   			cbx.checked = false;\n" +
				                    "   		}\n" +
				                    "   		else\n" +
				                    "   		{\n" +
                                    "   			ddl.value = " + strID + ";\n" +
				                    "   		}\n" +
				                    "   	}\n" +
				                    "   }\n" +
                                    "}\n";

                    //add scripts to page
                    string strCSScript = "<script type=\"text/javascript\">\n" +
                                    strCbxOnClick +
                                    strDdlOnChange +
                                    "function setUpFunctionalDomainEditing()" +
                                    "{\n" +
                                    "Events_chainEvent(" +
                                        "document.getElementById( '" + strCbxId + "' ), " +
                                        "\"onclick\", \"cbxIsPrimaryFunctionalDomain_OnClick();\");\n" +
                                    "Events_chainEvent(" +
                                        "document.getElementById( '" + strDdlId + "' ), " +
                                        "\"onchange\", \"ddlPrimaryFunctionalDomain_OnChange();\");\n" +
                                    "}\n" +
                                    "Events_chainEvent(" +
                                        "document.body, " +
                                        "\"onload\", \"setUpFunctionalDomainEditing();\");\n" +
                                    "</script>";

                    string strCSKey = "Admin_StaticData_Edit_FunctionalDomain";

                    ClientScriptManager cs = Page.ClientScript;

                    Type t = Page.GetType();

                    if (!cs.IsClientScriptBlockRegistered(t, strCSKey))
                    {
                        cs.RegisterClientScriptBlock(t, strCSKey, strCSScript, false);
                    }
                                    
                }
            }
        }

        protected void gvFunctionalDomain_PreRender(object sender, EventArgs e)
        {
            if (bEnterEditMode)
            {
                gvFunctionalDomain.EditIndex = gvFunctionalDomain.Rows.Count - 1;
            }
        }

        // Rev 1.8.1 GMcF
        protected void gvFunctionalDomain_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView gv = gvFunctionalDomain;

            if (gv.DataKeys.Count > 0)
            {
                // if it is the last added value and its name is "New value", delete it
                if (Reference_DB.GetMaxReferenceID(Convert.ToInt32(ddlCategory.SelectedValue))
                        == Convert.ToInt32(gv.DataKeys[e.RowIndex].Values[0]))
                {
                    string strDescription = Reference_DB.GetReferenceDescription(
                                Convert.ToInt32(gv.DataKeys[e.RowIndex].Values["CategoryID"]),
                                Convert.ToInt32(gv.DataKeys[e.RowIndex].Values["ReferenceID"]));

                    if (strDescription == "New value")
                    {
                        Reference_DB.DeleteReference(
                                    Convert.ToInt32(gv.DataKeys[e.RowIndex].Values["CategoryID"]),
                                    Convert.ToInt32(gv.DataKeys[e.RowIndex].Values["ReferenceID"]));
                    }
                }
            }
        }
        // End of Rev 1.8.1

        // Rev 1.8.1a GMcF
        protected void ddlPrimaryFunctionalDomainPicker_SelectedIndexChanged(object sender, EventArgs e)
        {
            ShowGridView();
        }
        // End of Rev 1.8.1a

        // Rev 1.8.1a GMcF
        protected void gvFunctionalDomain_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            strOriginalParentReferenceId = e.OldValues["ParentReferenceId"].ToString();
        }
        // End of Rev 1.8.1a

    }

}
