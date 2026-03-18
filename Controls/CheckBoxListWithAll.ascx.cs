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

public partial class Controls_CheckBoxListWithAll : System.Web.UI.UserControl
{
    public ListItemCollection Items
    {
        get
        {
            return cblItems.Items;
        }
    }

    public string ItemsSelected
    {
        get
        {
            string retval = "";

            string sep = "|";

            bool bAll;

            if (cbxAll.Checked)
            {
                retval = "ALL";
            }
            else
            {
                bAll = true;
                foreach (ListItem li in cblItems.Items)
                {
                    if (li.Selected == true)
                    {
                        retval += sep + li.Value;
                    }
                    else
                    {
                        bAll = false;
                    }
                }
                if (bAll)
                {
                    retval = "ALL";
                }
            }
            return retval;
        }
        set
        {
            bool bAll;

            char[] cSeps = { '|' };

            if (value == "ALL")
            {
                cbxAll.Checked = true;

                foreach (ListItem li in cblItems.Items)
                {
                    li.Selected = true;
                }
            }
            else
            {
                string[] aryValues = value.Split(cSeps, System.StringSplitOptions.RemoveEmptyEntries);

                bAll = true;

                foreach (ListItem li in cblItems.Items)
                {
                    if (value == "ALL" || (Array.IndexOf(aryValues, li.Value) >= 0))
                    {
                        li.Selected = true;
                    }
                    else
                    {
                        bAll = false;
                    }
                }
                cbxAll.Checked = bAll;
            }

        }
    }

    public int RepeatColumns
    {
        set
        {
            cblItems.RepeatColumns = value;
        }
    }

    public object DataSource
    {
        set
        {
            cblItems.DataSource = value;
        }
    }

    public string DataTextField
    {
        set
        {
            cblItems.DataTextField = value;
        }
    }

    public string DataValueField
    {
        set
        {
            cblItems.DataValueField = value;
        }
    }

    public void DataBind()
    {
        cblItems.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected override void OnPreRender(EventArgs e)
    {
        if (cbxAll.Checked)
        {
            foreach (ListItem li in cblItems.Items)
            {
                li.Selected = true;
            }
        }
        else
        {
            bool bAll = true;
            foreach (ListItem li in cblItems.Items)
            {
                if (!li.Selected)
                {
                    bAll = false;
                    break;
                }
            }
            if (bAll)
            {
                cbxAll.Checked = true;
            }
        }
    }
}
