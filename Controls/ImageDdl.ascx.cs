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

public partial class Controls_ImageDdl : System.Web.UI.UserControl
{
    public string Status
    {
        get
        {
            return hdnStatus.Value;
        }
        set
        {
            hdnStatus.Value = value;
        }
    }

    public string StatusId
    {
        get
        {
            return hdnStatusId.Value;
        }
        set
        {
            hdnStatusId.Value = value;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {

    }
}
