/* *************************************************************************************************
 * 
 *      Rev         By          Date            Description
 * 
 *      1.9.9       GMcF        03/03/2008      Altered handling of PIR printing to force page breaks
 * 
 * ************************************************************************************************* */

namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

    using ProjectPortfolio.Classes;

	public partial class Header : System.Web.UI.UserControl
	{
        protected int m_nInitiativeID;

		protected void Page_Load(object sender, System.EventArgs e)
		{
            int nInitiativeStatusID =-1;
            bool bIsPIR = false;

            if (Request.QueryString["InitiativeID"] == String.Empty || Request.QueryString["InitiativeID"] == null)
            {
                m_nInitiativeID = -1;
            }
            else
            {
                try
                {
                    m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);

                    // Rev 1.9.1, GMcF, 2008-01-09
                    nInitiativeStatusID = Global_DB.GetInitiativeStatusID(m_nInitiativeID);
                    bIsPIR = Global_DB.IsPIR( nInitiativeStatusID );
                	if ( bIsPIR )
                    {
                        notPIR.Visible = false;
                    }
 
                }
                catch (FormatException)
                {
                    m_nInitiativeID = -1;
                }
            }

            //removing Reports link when the logged in user is an ig programme manager
            int intContactID = Session["ContactID"] != null ? (int)Session["ContactID"] : -1;
            string strRole = Security_DB.GetUserRole(intContactID);

            if (strRole.ToLower() == "ig programme manager")
                lnkReports.Visible = false;
            //..

            if (Request.QueryString["section"] != null && Request.QueryString["section"] != String.Empty)
            {
                lnkSummary.HRef = "~/default.aspx?section=1" + "&InitiativeID=" + m_nInitiativeID.ToString();
                lnkFinancial.HRef = "~/default.aspx?section=2" + "&InitiativeID=" + m_nInitiativeID.ToString();
                lnkArchitectureAndRisk.HRef = "~/default.aspx?section=3" + "&InitiativeID=" + m_nInitiativeID.ToString();
                lnkProjects.HRef = "~/default.aspx?section=4" + "&InitiativeID=" + m_nInitiativeID.ToString();
                lnkWorkflow.HRef = "~/default.aspx?section=5" + "&InitiativeID=" + m_nInitiativeID.ToString();
                lnkAudit.HRef = "~/default.aspx?section=6" + "&InitiativeID=" + m_nInitiativeID.ToString();

                
                lnkReports.HRef = "~/Report.aspx?InitiativeID=" + m_nInitiativeID.ToString();


                if (bIsPIR)
                {
                    //Rev 1.9.9, 2008-03-03, GMcF
                    lnkPrintForm.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString() + "&SummaryOnly=yes";
                }
                else
                {
                    lnkPrintForm.HRef = "~/TestingForm_Printing.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    //lnkPrintForm.Target = "_blank";
                }

                lnkPrintForm.Visible = false;
            }

            string strMaxPermission;

            if (Session["ContactID"] != null && Session["ContactID"] != String.Empty)
            {
                strMaxPermission = Security_DB.GetMaxAccessRights((int)Session["ContactID"]);
            }
            else
            {
                strMaxPermission = "None";
            }


			switch (Request.QueryString["section"])
            {
                case "1":
                    lnkSummary.Attributes["Class"] = "mapactive";

                    // Rev 1.9.7, 2008-02-25, GMcF, added handling of PIR in summary page
                    if (Global_DB.IsPIR(Global_DB.GetInitiativeStatusID(m_nInitiativeID)))
                    {
                        // Rev 1.9.9, 2008-03-03, GMcF
                        //lnkPrintForm.HRef = "~/PIRSummary_Printing.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                        lnkPrintForm.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString() + "&SummaryOnly=yes";
                        // End of Rev 1.9.9
                    }
                    else
                    {
                        lnkPrintForm.HRef = "~/TestingForm_Printing.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    }
                    // End of Rev 1.9.7

                    lnkPrintForm.Visible = true;

                    lnkPrintFull.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    lnkPrintFull.Visible = true;
                    break;

                case "2":
                    lnkFinancial.Attributes["Class"] = "mapactive";

                    lnkPrintForm.HRef = "~/Financial_Printing.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    lnkPrintForm.Visible = true;
                    lnkPrintFull.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    lnkPrintFull.Visible = true;
                    break;

                case "3":
                    if (bIsPIR) // Rev 1.9.7, 2008-02-25, GMcF
                    {
                        Response.Redirect("~/default.aspx?InitiativeID=" + m_nInitiativeID.ToString() + "&section=1");
                    }
                    else
                    {
                        lnkArchitectureAndRisk.Attributes["Class"] = "mapactive";

                        lnkPrintForm.HRef = "~/ArchitectureAndRisk_Printing.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                        lnkPrintForm.Visible = true;
                        lnkPrintFull.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                        lnkPrintFull.Visible = true;
                    }
                    break;

                case "4":
                    if (bIsPIR) // Rev 1.9.3, 2008-01-18, GMcF
                    {
                        Response.Redirect("~/default.aspx?InitiativeID=" + m_nInitiativeID.ToString() + "&section=1");
                    }
                    else
                    {
                        lnkProjects.Attributes["Class"] = "mapactive";

                        lnkPrintForm.HRef = "~/Projects_Printing.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                        lnkPrintForm.Visible = true;
                        lnkPrintFull.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                        lnkPrintFull.Visible = true;
                    }
                    break;

                case "5":
                    lnkWorkflow.Attributes["Class"] = "mapactive";

                    lnkPrintForm.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    lnkPrintForm.Visible = true;
                    lnkPrintFull.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    lnkPrintFull.Visible = true;
                    break;

                case "6":
                    lnkAudit.Attributes["Class"] = "mapactive";

                    lnkPrintForm.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    lnkPrintForm.Visible = true;
                    lnkPrintFull.HRef = "~/FullPDF.aspx?InitiativeID=" + m_nInitiativeID.ToString();
                    lnkPrintFull.Visible = true;
                    break;


                default:
                    tdLinks.InnerHtml = "";
                    tdLinks.InnerText = "My Initiatives";
                    lnkPrintForm.Visible = false;
                    lnkPrintFull.Visible = false;

                    if (strMaxPermission.ToLower() == "superuser")
                    {
                        lnkAdmin.Visible = true;
                    }

                    break;
            }

            if (Request.QueryString["section"] == "1" && m_nInitiativeID == 0)
            {
                tdLinks.InnerHtml = "";
                tdLinks.InnerText = "New Initiative";
                lnkPrintForm.Visible = false;
            }

            if (m_nInitiativeID >= 0)
            {
                try
                {
                    DataRow drInitiative = Header_DB.GetInitiativeDetails(m_nInitiativeID);
                    lblTitle.Text = "IPMS - " + drInitiative["IGBusinessAreaCode"].ToString() + "-" + 
                                drInitiative["IGIdentifierCode"].ToString() + "-" + 
                                drInitiative["IGVersionNumber"].ToString().PadLeft(2, '0') + ": " + 
                                "Initiative " + drInitiative["Name"].ToString();
                }
                catch
                {
                }
            }

            if (Session["ContactID"] != null && Session["ContactID"].ToString() != String.Empty)
            {
                lblWelcomeMessage.Text = "Welcome, " + Global_DB.GetContactName((int)Session["ContactID"]) + "!";
            }
            else
                lblWelcomeMessage.Text = " Welcome!";

		}

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            int nActiveUserID;

            if (m_nInitiativeID > 0)
            {
                //clear the active user id only if the current user is the one who locked the iniative
                nActiveUserID = Security_DB.GetActiveUserID(m_nInitiativeID);
                if (nActiveUserID == (int)(Session["ContactID"]))
                {
                    Security_DB.ClearActiveUserID(m_nInitiativeID);
                }

                Session["ActiveInitiativeID"] = null;
            }

            Response.Redirect("http://ig.gto.intranet.db.com", true);
        }
}
}
