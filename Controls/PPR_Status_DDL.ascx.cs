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

public partial class Controls_PPR_Status_DDL : System.Web.UI.UserControl
{
    protected string _PPR_Title;
    public string PPR_Title
    {
        get { return _PPR_Title; }
        set {
                _PPR_Title = value;
                PPRHeader.InnerHtml = value;

                string strNewTitle;

                switch( value.ToLower() )
                {
                    case "c":   strNewTitle = "C - Cost";               break;
                    case "d":   strNewTitle = "D - Deliverables";       break;
                    case "t":   strNewTitle = "T - Time";               break;
                    case "r/i": strNewTitle = "R/I - Risks / Issues";   break;
                    case "b":   strNewTitle = "B - Benefits";           break;
                    case "o":   strNewTitle = "O - Overall";            break;
                    default:strNewTitle="? - status not recognised";    break;
                }

                PPRHeader.Attributes[ "title" ] = strNewTitle;

            }
    }

    protected string _PPR_Status;
    public string PPR_Status {
        get { return _PPR_Status; }
        set {
                _PPR_Status = value;
                string strNewSrc;
                string strNewTitle;
                int intNewIdx;
                switch( value.ToLower() )
                {
                    case "r": strNewSrc = "red"; strNewTitle = "R - Red"; intNewIdx = 1; break;
                    case "a": strNewSrc = "amber"; strNewTitle = "A - Amber"; intNewIdx = 2; break;
                    case "g": strNewSrc = "green"; strNewTitle = "G - Green"; intNewIdx = 3; break;
                    default: strNewSrc = "grey"; strNewTitle = "- - Please select"; intNewIdx = 0; break;
                }
                img.Src = "~/images/PPR_" + strNewSrc + ".png";
                img.Alt = strNewTitle + " - click to edit";
                ddl.SelectedIndex = intNewIdx;
            }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }
}
