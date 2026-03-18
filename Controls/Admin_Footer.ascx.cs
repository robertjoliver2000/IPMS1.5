namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

    using ProjectPortfolio.Classes;

	public partial class Admin_Footer : System.Web.UI.UserControl
	{

        protected void Page_Load(object sender, System.EventArgs e)
		{
        }


        protected override void OnPreRender(EventArgs e)
        {
        }


        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("default.aspx");
        }

    }
}
