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

public partial class GenericError : System.Web.UI.Page
{
    protected void RegisterScrollScript()
    {
        ClientScriptManager cs = Page.ClientScript;
        Type cstype = this.GetType();

        if (!cs.IsOnSubmitStatementRegistered(cstype, "SaveScrollPosition"))
        {
            String cstext = "document.getElementById('" + hiddenScrollY.ClientID + "').value = contentLayer.scrollTop;";
            cs.RegisterOnSubmitStatement(cstype, "SaveScrollPosition", cstext);
        }

        if (!cs.IsStartupScriptRegistered(cstype, "RestoreScrollPosition"))
        {
            String cstext = "<script language=\"javascript\">" +
                                "function restoreScroll() {" +
                                    "var scrollTop = parseInt(document.getElementById('" + hiddenScrollY.ClientID + "').value);" +
                                    "if (!isNaN(scrollTop))" +
                                    "contentLayer.scrollTop = scrollTop;" +
                                "}" +
                            "</script>";
            cs.RegisterStartupScript(cstype, "RestoreScrollPosition", cstext);
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterScrollScript();

        string lastURL = (Session["LastPageLoaded"] == null ? String.Empty : Session["LastPageLoaded"].ToString());

        if (Session["LastErrorMessage"] != null)
        {
            String message = "<font face=verdana color=red>"
                                + "<BR>"
                                + " <h2>" + lastURL + "</h2>"
                                + "<BR>"
                                + "<code><pre><span bgcolor='#ffffcc' class='errortext'><font color='black'>"
                                + Session["LastErrorMessage"].ToString() + "</pre></code>"
                                + "</font></span>";

            ltContent.InnerHtml = message;

            lnkBack.NavigateUrl = lastURL;
            lnkBack.Text = "Click here to go back to the last page you were visiting.";
        }

    }
}
