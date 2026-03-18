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
	public partial class Admin_Header : System.Web.UI.UserControl
	{
        protected int m_nInitiativeID;

		protected void Page_Load(object sender, System.EventArgs e)
		{
			switch (Request.QueryString["section"])
            {
                case "1":
                    lnkInitiatives.Attributes["Class"] = "mapactive";
                    break;

                case "2":
                    lnkStaticData.Attributes["Class"] = "mapactive";
                    break;

                case "3":
                    lnkUBR.Attributes["Class"] = "mapactive";
                    break;

                case "4":
                    lnkPeriods.Attributes["Class"] = "mapactive";
                    break;

                case "5":
                    lnkAudit.Attributes["Class"] = "mapactive";
                    break;

                case "6":
                    lnkNotification.Attributes["Class"] = "mapactive";
                    break;

                case "7":
                    lnkDeletedInitiatives.Attributes["Class"] = "mapactive";
                    break;

                default:
                    lnkInitiatives.Attributes["Class"] = "mapactive";
                    break;
            }

            if (Session["ContactID"] != null && Session["ContactID"].ToString() != String.Empty)
            {
                lblWelcomeMessage.Text = "Welcome, " + Global_DB.GetContactName((int)Session["ContactID"]) + "!";
            }
            else
                lblWelcomeMessage.Text = " Welcome!";

		}
	}
}
