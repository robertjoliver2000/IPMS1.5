namespace ProjectPortfolio.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

    using ProjectPortfolio.Classes;

	public partial class Footer : System.Web.UI.UserControl
	{
        protected int m_nInitiativeID;

        public delegate void SaveClickEventHandler(object sender, EventArgs e);
        public event SaveClickEventHandler SaveClick;


        protected virtual void OnSaveClick(EventArgs e)
        {
            if (SaveClick != null) SaveClick(this, e);
        }


        protected void Page_Load(object sender, System.EventArgs e)
		{
            if (Request.QueryString["InitiativeID"] == String.Empty || Request.QueryString["InitiativeID"] == null)
            {
                m_nInitiativeID = -1;
            }
            else
            {
                try
                {
                    m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
                }
                catch (FormatException)
                {
                    m_nInitiativeID = -1;
                }
            }

            switch (Request.QueryString["section"])
            {
                case "1":
                case "2":
                case "3":
                case "4":
                case "5":
                    btnSave.Visible = true;
                    btnBack.Visible = true;
                    break;
                case "6":
                    btnSave.Visible = false;
                    btnBack.Visible = true;
                    break;

                default:
                    btnSave.Visible = false;
                    btnBack.Visible = false;
                    break;
            }


            if (Request.QueryString["section"] == "1" && m_nInitiativeID == 0)
            {
                btnSave.Text = "Save";
            }
        }


        protected override void OnPreRender(EventArgs e)
        {
            if (btnSave.Visible)
            {
                Page.RegisterStartupScript(btnSave.ClientID + "_onclick",
                                "<script language=\"javascript\">" +
                                "Events_chainEvent(" +
                                    "document.getElementById(\"" + btnSave.ClientID + "\"), " +
                                    "\"onclick\", \"ClearDirtyFlag();\");" +
                                "</script>");
            }
        }


        protected void btnBack_Click(object sender, EventArgs e)
        {
            int nActiveUserID;    

            if (m_nInitiativeID > 0)
            {
                //clear the active user id only if the current user is the one who locked the iniative
                nActiveUserID = Security_DB.GetActiveUserID(m_nInitiativeID);
                if(nActiveUserID==(int)(Session["ContactID"]))                
                {
                    Security_DB.ClearActiveUserID(m_nInitiativeID);
                }
            
                Session["ActiveInitiativeID"] = null;
            }

            Response.Redirect("default.aspx");
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            OnSaveClick(new EventArgs());
        }


        public void HideSaveButtons()
        {
            btnSave.Visible = false;
        }

    }
}
