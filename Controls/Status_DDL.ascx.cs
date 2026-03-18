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

namespace ProjectPortfolio.Controls
{
    [ValidationPropertyAttribute("SelectedValue")]
    public partial class Status_DDL : System.Web.UI.UserControl
    {
        public string SelectedValue
        {
            get
            {
                string _selectedValue = ddl.Items[0].Value;
                int i = 0;
                Boolean bFound = false;
                while (i < ddl.Items.Count && !bFound)
                {
                    if (ddl.Items[i].Selected)
                    {
                        _selectedValue = ddl.Items[i].Value;
                        bFound = true;
                    }
                    else
                    {
                        i++;
                    }
                }
                return _selectedValue;
            }

            set
            {
                Boolean bFound = false;
                for (int i = 0; i < ddl.Items.Count; i++)
                {
                    ddl.Items[i].Selected = (ddl.Items[i].Value == value);
                }
            }
        }

        public string Text
        {
            get
            {
                string _Text = "";
                int i = 0;
                Boolean bFound = false;
                while (i < ddl.Items.Count && !bFound)
                {
                    if (ddl.Items[i].Selected)
                    {
                        _Text = ddl.Items[i].Attributes["Title"];
                        bFound = true;
                    }
                    else
                    {
                        i++;
                    }
                }
                return _Text;
            }
        }

        public string CssClass
        {
            get
            {
                return ddl.Attributes["class"];
            }
            set
            {
                ddl.Attributes["class"] = value;
            }
        }

        public string Size
        {
            get
            {
                return ddl.Style["font-size"];
            }
            set
            {
                ddl.Style["font-size"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

    }

}