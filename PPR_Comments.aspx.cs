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

public partial class PPR_Comments : System.Web.UI.Page
{
    protected int intInitiativeId = -1;

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
                    lblInitiativeName.InnerHtml = Server.HtmlEncode( Global_DB.GetInitiativeName(intInitiativeId) );
                    txtComments.Text = Global_DB.GetInitiativeComments(intInitiativeId);
                }
            }
        }
        catch (Exception)
        {
            intInitiativeId = -1;
        }

        if (intInitiativeId <= 0)
        {
            txtComments.Visible = false;
            btnSave.Visible = false;
            lblInitiativeName.Style["display"] = "none";
            lblMessage.Text = "Invalid Initiative ID";
            lblMessage.Visible = true;
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (intInitiativeId > 0)
        {
            Global_DB.UpdateInitiativeComments( intInitiativeId,
                                                txtComments.Text,
                                                Session["Username"].ToString(),
                                                System.Convert.ToInt32(Session["ContactID"].ToString())
                                                );

            Page.ClientScript.RegisterStartupScript(this.GetType(),
                                                    "saveandclose",
                                                    "window.returnValue = \""
                                                        + ( txtComments.Text.Length > 0? "Y": "N" )
                                                        // Added for Phase 2.1 UAT Feedback Item 13 - Comments as tooltip [Base64 encoding would be preferable]
                                                        + Server.HtmlEncode( txtComments.Text ).Replace("\r","\\n\\\r")
                                                        + "\";"
                                                        + "window.close();"
                                                    ,true);
        }
    }

}
