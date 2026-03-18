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
    public partial class Status_DDL_PrintVersion : System.Web.UI.UserControl
    {
        string _selectedValue;
        string _Text;

        public string SelectedValue
        {
            get
            {
               return _selectedValue;
            }

            set
            {
                string newColour;

                _selectedValue = value;

                switch (value)
                {
                    case "1": newColour = "green"; _Text = "Green"; break;
                    case "2": newColour = "orange"; _Text = "Amber"; break;
                    case "3": newColour = "red"; _Text = "Red"; break;
                    default: newColour = "gray"; _Text = "Please select"; _selectedValue="4"; break;
                }

                ddl.Style["color"] = newColour;

            }
        }

        public string Text
        {
            get
            {
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