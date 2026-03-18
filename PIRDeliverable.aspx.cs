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

public partial class PIRDeliverable : System.Web.UI.Page
{
    protected int m_nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {

        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        try
        {
            m_nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            m_nInitiativeID = -1;
        }

        lnkPIRPlanDate.HRef = "#";
        lnkPIRPlanDate.Attributes.Add("onclick",
                                    "javascript:popupWindowDatePicker('" + txtPIRPlanDate.ClientID + "');" +
                                    "return false;"
                                  );

        lnkPIRActualDate.HRef = "#";
        lnkPIRActualDate.Attributes.Add("onclick",
                                    "javascript:popupWindowDatePicker('" + txtPIRActualDate.ClientID + "');" +
                                    "return false;"
                                  );

        /*
        string strPirDateVarianceFunc = "function PirDateVariance( firstDate, secondDate )" + "\n" +
                                        "{" + "\n" +
                                        "    if( firstDate == null || secondDate == null || )" + "\n" +
                                        "        return '';" + "\n" +
                                        "    else" + "\n" +
                                        "    {" + "\n" +
                                        "        var firstInMs = Date.parse( firstDate );" + "\n" +
                                        "        var secondInMs = Date.parse( firstDate );" + "\n" +
                                        "        if ( isNan( firstInMs ) || isNaN( secondInMs )" + "\n" +
                                        "        {" + "\n" +
                                        "            return '';" + "\n" +
                                        "        }" + "\n" +
                                        "        else" + "\n" +
                                        "        {" + "\n" +
                                        "            return Math.floor( ( secondInMs - firstInMs ) / ( 1000 * 60 * 60 * 24 ) );" + "\n" +
                                        "        }" + "\n" +
                                        "    }" + "\n" +
                                        "}";

        //Page.ClientScript.RegisterStartupScript(Page.GetType(), "PIRDateVariance", strPirDateVarianceFunc,true);
        */

        if (!Page.IsPostBack)
        {
            btnCancel.Attributes.Add("onClick", "javascript:window.close()");

            FillDropdowns();

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


    protected void FillDropdowns()
    {
        DataSet dsStatus = Global_DB.GetReferenceTable(57); //PIRStatus
        ddlPIRStatus.DataSource = dsStatus;
        ddlPIRStatus.DataMember = dsStatus.Tables[0].TableName;
        ddlPIRStatus.DataValueField = "ReferenceID";
        ddlPIRStatus.DataTextField = "Description";
        ddlPIRStatus.DataBind();

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

            PIR_Deliverables_DB.UpdatePIRDeliverable(
                                            intInitiativeDeliverableID, 
                                            m_nInitiativeID,
                                            txtName.Text,
                                            txtPIRCommentary.Text,
                                            ddlPIRStatus.SelectedItem.Text,
                                            System.Convert.ToInt32(ddlPIRStatus.SelectedValue),
                                            (txtPIRPlanDate.Text != String.Empty) ? (object)DateTime.Parse(txtPIRPlanDate.Text) : DBNull.Value,
                                            (txtPIRActualDate.Text != String.Empty) ? (object)DateTime.Parse(txtPIRActualDate.Text) : DBNull.Value
                                            );

        }
        else
        {
            PIR_Deliverables_DB.InsertPIRDeliverable(
                                            m_nInitiativeID,
                                            txtName.Text,
                                            txtPIRCommentary.Text,
                                            ddlPIRStatus.SelectedItem.Text,
                                            System.Convert.ToInt32(ddlPIRStatus.SelectedValue),
                                            (txtPIRPlanDate.Text != String.Empty) ? (object)DateTime.Parse(txtPIRPlanDate.Text) : DBNull.Value,
                                            (txtPIRActualDate.Text != String.Empty) ? (object)DateTime.Parse(txtPIRActualDate.Text) : DBNull.Value
                                            );
        }

        Page.ClientScript.RegisterStartupScript(Page.GetType(), "closeScript",
                "<script language=JavaScript>window.returnValue=1; window.close();</script>");

    }


    protected void LoadInitiativeDeliverable()
    {
        int intInitiativeDeliverableID = Convert.ToInt32(Request.QueryString["record"]);

        DataRow drDeliverable = PIR_Deliverables_DB.GetPIRDeliverableDetails(intInitiativeDeliverableID);

        txtName.Text = drDeliverable["Name"].ToString();
        txtPIRCommentary.Text = drDeliverable["PIRCommentary"].ToString();
        ddlPIRStatus.SelectedValue = drDeliverable["PIRStatusID"].ToString();
        txtPIRPlanDate.Text = (drDeliverable["PIRPlanDate"] != DBNull.Value) ? ((DateTime)drDeliverable["PIRPlanDate"]).ToShortDateString() : "";
        txtPIRActualDate.Text = (drDeliverable["PIRActualDate"] != DBNull.Value) ? ((DateTime)drDeliverable["PIRActualDate"]).ToShortDateString() : "";
    }
}
