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

public partial class PIRScopeChange : System.Web.UI.Page
{
    protected int m_nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {

        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        try
        {
            m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            m_nInitiativeID = -1;
        }

        if (!Page.IsPostBack)
        {
            btnCancel.Attributes.Add("onClick", "javascript:window.close()");

            FillDropdowns();

            if (m_nInitiativeID > 0  &&
                Request.QueryString["record"] != null && Request.QueryString["record"] != String.Empty)
            {
                lblTitle.Text = "Edit Scope Change";
                Page.Title = "Edit Scope Change Record";

                btnOK.Text = "Update";
                LoadInitiativeScopeChange();
            }
        }
    }


    protected void FillDropdowns()
    {
        DataSet dsStatus = Global_DB.GetReferenceTable(58); //Scope Change Status
        ddlStatus.DataSource = dsStatus;
        ddlStatus.DataMember = dsStatus.Tables[0].TableName;
        ddlStatus.DataValueField = "ReferenceID";
        ddlStatus.DataTextField = "Description";
        ddlStatus.DataBind();

    }


    protected void btnOK_Click(object sender, EventArgs e)
    {
        int intInitiativeScopeChangeID;

        if (m_nInitiativeID <= 0)
        {
            return;
        }

        if (Request.QueryString["record"] != null && Request.QueryString["record"] != String.Empty)
        {
            intInitiativeScopeChangeID = Convert.ToInt32(Request.QueryString["record"]);

            PIR_ScopeChanges_DB.UpdateScopeChange(
                                            intInitiativeScopeChangeID, 
                                            m_nInitiativeID,
                                            txtScopeChange.Text,
                                            txtCommentary.Text,
                                            ddlStatus.SelectedItem.Text,
                                            System.Convert.ToInt32(ddlStatus.SelectedValue)
                                            );

        }
        else
        {
            PIR_ScopeChanges_DB.InsertScopeChange(
                                            m_nInitiativeID,
                                            txtScopeChange.Text,
                                            txtCommentary.Text,
                                            ddlStatus.SelectedItem.Text,
                                            System.Convert.ToInt32(ddlStatus.SelectedValue)
                                            );
        }

        Page.ClientScript.RegisterStartupScript(Page.GetType(), "closeScript",
                "<script language=JavaScript>window.returnValue=1; window.close();</script>");

    }


    protected void LoadInitiativeScopeChange()
    {
        int intInitiativeScopeChangeID = Convert.ToInt32(Request.QueryString["record"]);

        DataRow drScopeChange = PIR_ScopeChanges_DB.GetScopeChangeDetails(intInitiativeScopeChangeID);

        txtScopeChange.Text = drScopeChange["ScopeChange"].ToString();
        txtCommentary.Text = drScopeChange["Commentary"].ToString();
        ddlStatus.SelectedValue = drScopeChange["StatusID"].ToString();
    }
}
