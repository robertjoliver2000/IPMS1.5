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

using ProjectPortfolio.Classes;

public partial class Deliverable : System.Web.UI.Page
{
    protected int m_nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            m_nInitiativeID = -1;
        }

        lnkDueDate.HRef = "#";
        lnkDueDate.Attributes.Add("onclick",
                                    "javascript:popupWindowDatePicker('" + txtDueDate.ClientID + "');" +
                                    "return false;"
                                  );

        if (!Page.IsPostBack)
        {
            btnCancel.Attributes.Add("onClick", "javascript:window.close()");

            if (m_nInitiativeID > 0  &&
                Request.QueryString["record"] != null && Request.QueryString["record"] != String.Empty)
            {
                lblTitle.Text = "Edit Program Deliverable";
                Page.Title = "Edit Deliverable Record";

                btnOK.Text = "Update";
                LoadInitiativeDeliverable();
            }
        }
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        int intInitiativeDeliverableID;

        if (m_nInitiativeID <= 0)
        {
            return;
        }

        if (Request.QueryString["record"] != null && Request.QueryString["record"] != String.Empty)
        {
            intInitiativeDeliverableID = Convert.ToInt32(Request.QueryString["record"]);

            SectionB_ProgramDeliverables_DB.UpdateDeliverable(
                                            intInitiativeDeliverableID, 
                                            m_nInitiativeID,
                                            txtName.Text, 
                                            (txtDueDate.Text != String.Empty) ? (object)DateTime.Parse(txtDueDate.Text) : DBNull.Value,
                                            txtCost.Text != String.Empty ? Decimal.Parse(txtCost.Text) : 0.00m,
                                            txtAffectedApplications.Text);

        }
        else
        {
            SectionB_ProgramDeliverables_DB.InsertDeliverable(
                                            m_nInitiativeID,
                                            txtName.Text,
                                            (txtDueDate.Text != String.Empty) ? (object)DateTime.Parse(txtDueDate.Text) : DBNull.Value,
                                            txtCost.Text != String.Empty ? Decimal.Parse(txtCost.Text) : 0.00m,
                                            txtAffectedApplications.Text);                    
        }

        RegisterStartupScript("closeScript",
                "<script language=JavaScript>  window.returnValue=1; window.close();  </script>");

    }


    protected void LoadInitiativeDeliverable()
    {
        int intInitiativeDeliverableID = Convert.ToInt32(Request.QueryString["record"]);

        DataRow drDeliverable = SectionB_ProgramDeliverables_DB.GetDeliverableDetails(
                                        m_nInitiativeID, intInitiativeDeliverableID);

        txtName.Text = drDeliverable["Name"].ToString();           
       
        txtDueDate.Text = (drDeliverable["DueDate"] != DBNull.Value) ? ((DateTime)drDeliverable["DueDate"]).ToShortDateString() : "";
        txtCost.Text = (drDeliverable["Cost"] != DBNull.Value) ? ((Decimal)drDeliverable["Cost"]).ToString("N2") : "0.00";

        txtAffectedApplications.Text = drDeliverable["AffectedApplications"].ToString();
    }
}
