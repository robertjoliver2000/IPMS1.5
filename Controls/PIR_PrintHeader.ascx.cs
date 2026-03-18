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

public partial class Controls_PIR_PrintHeader : System.Web.UI.UserControl
{
    public string Text
    {
        get { return lbl.Text; }
        set { lbl.Text = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}
