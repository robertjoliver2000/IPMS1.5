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
    public partial class RagPicker : System.Web.UI.UserControl
    {
        public string Status
        {
            get { return ragStatus.Value; }
            set { ragStatus.Value = value; }
        }

        public int StatusID
        {
            get { return System.Convert.ToInt32(ragStatusID.Value); }
            set { ragStatusID.Value = value.ToString(); }
        }
    }
}