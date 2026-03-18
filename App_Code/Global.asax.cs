//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.6.1       GMcF        15/08/2007      Added code to Session _End, Application_Start,
//                                              Application_End to clear down temp editing table used
//                                              for Initiative Sponsor UBR allocations
//
//      1.9.6       GMcF        15/02/2008      For PIR, added function GetImageURLForStatus()
//
//*****************************************************************************************************

using System;
using System.Data;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using System.Threading;
using System.Globalization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ProjectPortfolio.Classes;

namespace ProjectPortfolio 
{
	public class Global : System.Web.HttpApplication
	{        

        public  enum ReferenceCategoryID : int
	    {
                PrimarySponsoringArea = 59	         
	    }

        public Global()
		{
             
		}

        public static void ValidateControl(Control control, int nInitiativeID,DataTable dtValidation)
        {
            DataRow[] foundRows;
            string strValidator;
            int nRows=0;
            foreach (Control childControl in control.Controls)
            {
                BaseValidator webControl = childControl as BaseValidator;

                if (webControl != null)
                {
                    strValidator = webControl.ID;
                    foundRows=dtValidation.Select("ControlID='" + strValidator + "'");

                    if (foundRows.Length > 0)
                    {
                        webControl.Enabled = Convert.ToBoolean(foundRows[0]["ControlStatus"]);
                        foundRows = null;
                    }
                }

                ValidateControl(childControl, nInitiativeID,dtValidation);
            }
        }
        
        public static void DisableControl(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                WebControl webControl = childControl as WebControl;

                if (webControl != null)
                {
                    webControl.Attributes.Add("readonly", "true");
                    webControl.Attributes.Add("disabled", "true");
                }

                HtmlButton htmlButton = childControl as HtmlButton;

                if (htmlButton != null)
                {
                    htmlButton.Attributes.Add("readonly", "true");
                    htmlButton.Attributes.Add("disabled", "true");
                }

                HtmlSelect htmlSelect = childControl as HtmlSelect;

                if (htmlSelect != null)
                {
                    htmlSelect.Attributes.Add("readonly", "true");
                    htmlSelect.Attributes.Add("disabled", "true");
                }

                HtmlInputText htmlInputText = childControl as HtmlInputText;

                if (htmlInputText != null)
                {
                    htmlInputText.Attributes.Add("readonly", "true");
                    htmlInputText.Attributes.Add("disabled", "true");
                }

                HtmlAnchor htmlAnchor = childControl as HtmlAnchor;

                if (htmlAnchor != null)
                {
                    htmlAnchor.HRef = "";
                    htmlAnchor.Attributes.Add("onclick", "");
                }

                DisableControl(childControl);
            }
        }

        public static void AddChangeHandlers(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                if (childControl != null)
                {
                    if ((childControl.GetType().ToString().Equals("System.Web.UI.WebControls.TextBox") ||
                        childControl.GetType().ToString().Equals("System.Web.UI.WebControls.DropDownList") ||
                        childControl.GetType().ToString().Equals("System.Web.UI.HtmlControls.HtmlInputText") ||
                        childControl.GetType().ToString().Equals("System.Web.UI.HtmlControls.HtmlSelect"))                        
                        && childControl.Visible == true)
                    {
                        control.Page.RegisterStartupScript(childControl.ClientID + "_onchange",
                                "<script language=\"javascript\">" +
                                "Events_chainEvent(" +
                                "document.getElementById(\"" + childControl.ClientID + "\"), " +
                                "\"onchange\", \"SetDirtyFlag();\");" +
                                "</script>");
                    }
                }

                AddChangeHandlers(childControl);
            }
        }

        public static string TextToHTML(string text)
        {
            string htmlText;

            // replace multiple spaces with &nbsp;
            htmlText = text.Replace("  ", " &nbsp;");

            //Convert the brackets into HTML equivalents
            htmlText = htmlText.Replace("<", "&lt;");
            htmlText = htmlText.Replace(">", "&gt;");

            //Convert the double quote
            htmlText = htmlText.Replace("\"", "&quot;");

            // replace line feed
            htmlText = text.Replace("\n", "<BR>");

            return htmlText;
        }
		
		protected void Application_Start(Object sender, EventArgs e)
		{
            // Rev 1.6.1, GMcF: clear temp editing table for all sessions, initiatives and sponsors
            SectionB_SponsorAllocations_DB.DeleteInitiativeSponsorUBRAllocationsForEdit("", -1, -1);

        }

		protected void Session_Start(Object sender, EventArgs e)
		{
            string username = Request.ServerVariables["LOGON_USER"];

            int pos = username.Length - 1;
            for (; pos >= 0 && username[pos] != '\\'; pos--) ;
            username = username.Substring(pos + 1, username.Length - pos - 1);

            int contactID = Global_DB.GetContactID(username);

            if (contactID > 0)
            {
                Session.Add("ContactID", contactID);
                Session.Add("Username", username);
            }
            else
            {
                //used to be displayed in case of not registered within Toolkit
                Session.Add("Username", username); ;
                               
            }
        }

		protected void Application_BeginRequest(Object sender, EventArgs e)
		{
            // set culture number and date display settings
			CultureInfo cultureInfo = new CultureInfo("en-GB");

			cultureInfo.NumberFormat.NumberDecimalSeparator = ".";
			cultureInfo.NumberFormat.NumberGroupSeparator = "";

			cultureInfo.NumberFormat.PercentDecimalSeparator = ".";
			cultureInfo.NumberFormat.PercentGroupSeparator = ",";

            cultureInfo.NumberFormat.CurrencyDecimalSeparator = ".";
            cultureInfo.NumberFormat.CurrencyGroupSeparator = ",";
            
            cultureInfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
			cultureInfo.DateTimeFormat.DateSeparator = "/";

            cultureInfo.NumberFormat.CurrencySymbol = "";

			Thread.CurrentThread.CurrentCulture = cultureInfo;
			Thread.CurrentThread.CurrentUICulture = cultureInfo;
        }

		protected void Application_EndRequest(Object sender, EventArgs e)
		{

		}        

		protected void Application_AuthenticateRequest(Object sender, EventArgs e)
		{

        }

        protected void Application_AuthorizeRequest(Object sender, EventArgs e)
        {
            /*
            // check username
            string username = Request.ServerVariables["LOGON_USER"];

            int pos = username.Length - 1;
            for (; pos >= 0 && username[pos] != '\\'; pos--) ;
            username = username.Substring(pos + 1, username.Length - pos - 1);

            if (username == null || username == String.Empty || Global_DB.GetContactID(username) <= 0)
            {
                string strMsg;

                strMsg = "<html xmlns=\"http://www.w3.org/1999/xhtml\">";
                strMsg += "<head><title>Login Error</title>";
                strMsg += "<link href=\"style.css\" type=\"text/css\" rel=\"stylesheet\" /></head>";
                strMsg += "<body>";
                strMsg += "<font size=\"4\">You are not authorised to use the IPMS System.<br>";
                strMsg += "Please contact the system administrator to request access.<br>";
                strMsg += "You are currently trying to login as : " + username + ".";
                strMsg += "</font></body>";
                strMsg += "</html>";

                Response.Write(strMsg);
                Response.End();
            }
            */
        }
        
        protected void Application_Error(Object sender, EventArgs e)
		{
            HttpRequestValidationException validationException;
            validationException = Server.GetLastError() as HttpRequestValidationException;

            if (validationException != null)
            {
                Server.ClearError();

                Response.Clear();

                string strMsg;

                strMsg = "<html xmlns=\"http://www.w3.org/1999/xhtml\">";
                strMsg += "<head><title>Login Error</title>";
                strMsg += "<link href=\"style.css\" type=\"text/css\" rel=\"stylesheet\" /></head>";
                strMsg += "<body>";
                strMsg += "<font size=\"4\">One of the text boxes on the page you were trying to save contains one of the following illegal combinations of characters:<br>";
                strMsg += "<br>";
                strMsg += "- &lt; followed by an exclamation point — for example, &lt! is not allowed.<br>";
                strMsg += "- &lt; followed by the letters a through z - for example, &lt;aword will be rejected.<br>";
                strMsg += "- &amp; followed by a pound sign — e.g. &amp;#123.<br>";
                strMsg += "<br>";
                strMsg += "Please click back on your browser to return to the page you were editing and re-enter your data.<br>";
                strMsg += "</font></body>";
                strMsg += "</html>";

                Response.Write(strMsg);
                Response.End();
            }
            else
            {
                Exception exception = Server.GetLastError();

                Session["LastErrorMessage"] = exception.ToString();
                Session["LastPageLoaded"] = Request.Url.ToString();

                Server.ClearError();

                Server.Transfer("GenericError.aspx", false);
            }
		}

		protected void Session_End(Object sender, EventArgs e)
		{
            // Rev 1.6.1, GMcF: clear temp editing table for this session for all initiatives and sponsors
            SectionB_SponsorAllocations_DB.DeleteInitiativeSponsorUBRAllocationsForEdit(Session.SessionID, -1, -1);

            if (Session["ActiveInitiativeID"] != null && Session["ActiveInitiativeID"] != String.Empty)
            {
                Security_DB.ClearActiveUserID((int)Session["ActiveInitiativeID"]);
                Session["ActiveInitiativeID"] = null;
            }
		}

		protected void Application_End(Object sender, EventArgs e)
		{
            // Rev 1.6.1, GMcF: clear temp editing table for all sessions, initiatives and sponsors
            SectionB_SponsorAllocations_DB.DeleteInitiativeSponsorUBRAllocationsForEdit("", -1, -1);

        }

        public static string GetImageURLForStatus(int intIGStatus)
        {
            string ImageUrl = "";
            switch (intIGStatus)
            {
                case 1:
                case 19:
                case 20:
                case 22:    // Rev 1.9.1, 2008-01-09, GMcF, for status "In PIR"
                    ImageUrl = @"~\Images\draft.gif";
                    break;

                case 2:
                case 23:    // Rev 1.9.1, 2008-01-09, GMcF, for status "PIR Submitted"
                    ImageUrl = @"~\Images\submitted.gif";
                    break;

                case 3:
                    ImageUrl = @"~\Images\pending.gif";
                    break;

                case 4:
                case 5:
                case 6:
                case 7:
                case 10:
                case 11:
                case 12:
                case 13:
                case 14:
                case 24:    // Rev 1.9.1, 2008-01-09, GMcF, for status "PIR Complete"
                    ImageUrl = @"~\Images\approved.gif";
                    break;

                case 8:
                case 9:
                    ImageUrl = @"~\Images\rejected.gif";
                    break;

                default:
                    ImageUrl = @"~\Images\nostatus.gif";
                    break;
            }

            return ImageUrl;

        }

        //ERW 9 Jun 2008
        // and later amend the one below, so that it doesn't return "./gif"
        public static string PPRStatusImageFromDBStatus(string PPRStatusDBCode)
        {
            string PPRStatusURL;
            //return PPRStatusImageFromId();
            switch (PPRStatusDBCode.ToLower())
            { 
                case "r":
                    PPRStatusURL = PPRStatusImageFromId("3");
                    break;
                case "a":
                    PPRStatusURL = PPRStatusImageFromId("2");
                    break;
                case "g":
                    PPRStatusURL = PPRStatusImageFromId("1");
                    break;
                default:
                    PPRStatusURL = PPRStatusImageFromId("0");
                    break;
            }

            return PPRStatusURL; 
        }

        // Added 2008-06-02, GMcF, for Phase 2.1, Deliverable 7 - Performance Status Capture
        public static string PPRStatusImageFromId( string PPRStatusID )
        {
            string PPRStatusURL;
            switch ( PPRStatusID )
            {
                case "3": PPRStatusURL = "Images/PPR_Red.gif"; break;
                case "2": PPRStatusURL = "Images/PPR_Amber.gif"; break;
                case "1": PPRStatusURL = "Images/PPR_Green.gif"; break;
                default: PPRStatusURL = "Images/PPR_Grey.gif"; break;
            }
            return PPRStatusURL;
        }
       
        public static bool HasSuperUserRights(string strPermissionName)
        {
            bool bHasSuperUserRights;

            switch (strPermissionName.ToLower())
            {
                case "read-only":
                case "modify":
                case "admin":
                    bHasSuperUserRights = false;
                    break;

                case "superuser":
                    bHasSuperUserRights = true;
                    break;

                default:
                    bHasSuperUserRights = false;
                    break;
            }

            return bHasSuperUserRights;
        }

	}
}
