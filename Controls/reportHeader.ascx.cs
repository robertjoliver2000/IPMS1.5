namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

    using ProjectPortfolio.Classes;

	/// <summary>
	///		Summary description for Header.
	/// </summary>
	public partial class ReportHeader : System.Web.UI.UserControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			switch (Request.QueryString["report"])
            {
                case "1":
                    lnkProvider.Attributes["Class"] = "mapactive";
                    break;

                case "2":
                    lnkClient.Attributes["Class"] = "mapactive";
                    break;

                case "3":
                    lnkCommittee.Attributes["Class"] = "mapactive";
                    break;

                case "4":
                    lnkBenefits.Attributes["Class"] = "mapactive";
                    break;

                case "5":
                    lnkBubble.Attributes["Class"] = "mapactive";
                    break;

                default:
                    lnkProvider.Attributes["Class"] = "mapactive";
                    break;
            }
		}
	}
}
