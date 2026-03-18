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
using System.Net.Mail;
using System.Net;

using ProjectPortfolio;
using ProjectPortfolio.Classes;
using ProjectPortfolio.Controls;


public partial class Admin : System.Web.UI.Page
{
    protected int m_nInitiativeID;
    protected int m_nActiveUserID;

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
            String cstext = "<script language='javascript'>" +
                                "function restoreScroll() {" +
                                    "var scrollTop = parseInt(document.getElementById('" + hiddenScrollY.ClientID + "').value);" +
                                    "if (!isNaN(scrollTop))" +
                                    "contentLayer.scrollTop = scrollTop;" +
                                "}" +
                            "</script>";
            cs.RegisterStartupScript(cstype, "RestoreScrollPosition", cstext);
        }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        // Moved the controls to be in the onInit event, so we can use their values in their own OnLoad event
        // Otherwise, we cannot access their postback values, until the whole OnLoad event is complete

        switch (Request.QueryString["section"])
        {
            case "1":
                {
                    if (m_nInitiativeID > 0)
                    {
                        Control ctlAdmin_InitiativeHistory = Page.LoadControl("Controls/Admin_Review.ascx");
                        ctlAdmin_InitiativeHistory.ID = "ctlAdmin_InitiativeHistory";
                        ctlPlaceHolder.Controls.Add(ctlAdmin_InitiativeHistory);
                    }
                    else
                    {
                        Control ctlAdmin_Initiative = Page.LoadControl("Controls/Admin_Initiative.ascx");
                        ctlAdmin_Initiative.ID = "ctlAdmin_Initiative";
                        ctlPlaceHolder.Controls.Add(ctlAdmin_Initiative);
                    }
                }
                break;

            case "2":
                {
                    Control ctlAdmin_StaticData = Page.LoadControl("Controls/Admin_StaticData.ascx");
                    ctlAdmin_StaticData.ID = "ctlAdmin_StaticData";
                    ctlPlaceHolder.Controls.Add(ctlAdmin_StaticData);
                }
                break;

            case "3":
                {
                    Control ctlAdmin_UBR = Page.LoadControl("Controls/Admin_UBR.ascx");
                    ctlAdmin_UBR.ID = "ctlAdmin_UBR";
                    ctlPlaceHolder.Controls.Add(ctlAdmin_UBR);
                }
                break;

            case "4":
                {
                    Control ctlAdmin_Period = Page.LoadControl("Controls/Admin_Period.ascx");
                    ctlAdmin_Period.ID = "ctlAdmin_Period";
                    ctlPlaceHolder.Controls.Add(ctlAdmin_Period);
                }
                break;

            case "5":
                {
                    Control ctlIGAudit = Page.LoadControl("Controls/IGAudit.ascx");
                    ctlIGAudit.ID = "ctlReview_IGAudit";
                    ctlPlaceHolder.Controls.Add(ctlIGAudit);
                }
                break;

            case "6":
                {
                    Control ctlNotification = Page.LoadControl("Controls/Admin_Notification.ascx");
                    ctlNotification.ID = "ctlAdmin_Notification";
                    ctlPlaceHolder.Controls.Add(ctlNotification);
                }
                break;

            case "7":
                {
                    Control ctlAdmin_Initiative = Page.LoadControl("Controls/Admin_DeletedInitiative.ascx");
                    ctlAdmin_Initiative.ID = "ctlAdmin_Initiative";
                    ctlPlaceHolder.Controls.Add(ctlAdmin_Initiative);
                }
                break;

            default:
                {
                    if (m_nInitiativeID > 0)
                    {
                        Control ctlAdmin_InitiativeHistory = Page.LoadControl("Controls/Admin_Review.ascx");
                        ctlAdmin_InitiativeHistory.ID = "ctlAdmin_InitiativeHistory";
                        ctlPlaceHolder.Controls.Add(ctlAdmin_InitiativeHistory);
                    }
                    else
                    {
                        Control ctlAdmin_Initiative = Page.LoadControl("Controls/Admin_Initiative.ascx");
                        ctlAdmin_Initiative.ID = "ctlAdmin_Initiative";
                        ctlPlaceHolder.Controls.Add(ctlAdmin_Initiative);
                    }
                }
                break;
        } // end of switch


    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        RegisterScrollScript();

        try
        {
            m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch
        {
            m_nInitiativeID = -1;
        }

        if (Session["ContactID"] != null && Session["ContactID"].ToString() != String.Empty)
        {
            string strMaxPermission = Security_DB.GetMaxAccessRights((int)Session["ContactID"]);

            if (! Global.HasSuperUserRights(strMaxPermission))
            {
                Response.ClearContent();
                Response.Write("You are not allowed to see this page. Please contact your IPMS Administrator for more information");
                Response.End();
            }
        }
        else
        {
            Response.ClearContent();
            Response.Write("You are not allowed to see this page. Please contact your IPMS Administrator for more information");
            Response.End();
        }
    }

    protected void SendNotificationEmail()
    {
        string to = ConfigurationSettings.AppSettings["NotificationRecipientEmailAddress"];
        string from = ConfigurationSettings.AppSettings["NotificationSenderEmailAddress"];

        MailMessage message = new MailMessage(from, to);

        message.Subject = "";
        message.Body = "";

        SmtpClient client = new SmtpClient();

        try
        {
            client.Send(message);
        }
        catch (Exception ex)
        {

        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
    }

    //ERW 15 Mar 2009
    // Moved to Global.asax.cs 
    //protected bool HasSuperUserRights(string strPermissionName)
    //{
    //    bool bHasSuperUserRights;

    //    switch (strPermissionName.ToLower())
    //    {
    //        case "read-only":
    //        case "modify":
    //        case "admin":
    //            bHasSuperUserRights = false;
    //            break;

    //        case "superuser":
    //            bHasSuperUserRights = true;
    //            break;

    //        default:
    //            bHasSuperUserRights = false;
    //            break;
    //    }

    //    return bHasSuperUserRights;
    //}
}
