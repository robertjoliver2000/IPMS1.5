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


public partial class Review_Risk : System.Web.UI.Page
{
    protected int nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        Page.RegisterStartupScript("validateType",
                         "<script language=\"javascript\"> " +
                              "function validateType(source, arguments) {" +
                                  "if (document.getElementById(\"" + ddlRiskCateg.ClientID + "\").selectedIndex > 0)" +
                                  "arguments.IsValid=true; " +
                                  "else " +
                                  "arguments.IsValid=false; " +
                              "} " +
                         "</script>");

        try
        {
            nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            nInitiativeID = -1;
        }

        if (!Page.IsPostBack)
        {
            DataSet dsRiskCateg = Global_DB.GetReferenceTable(26); //CategoryID = 26 for riskcategory

            if (dsRiskCateg.Tables["Reference"].Rows.Count > 0)
            {
                ddlRiskCateg.DataValueField = "ReferenceID";
                ddlRiskCateg.DataTextField = "Description";

                ddlRiskCateg.DataSource = dsRiskCateg.Tables["Reference"];
                ddlRiskCateg.DataBind();
            }


            object objRiskID = Request.QueryString["RiskID"];
            if (objRiskID != null)
            {
                //editing
                int riskID = Int32.Parse(objRiskID.ToString());
                DataRow dRow = Review_SectionF_DB.GetRisk(riskID).Tables["Risk"].Rows[0];

                ddlRiskCateg.SelectedIndex = Convert.ToInt32(dRow["RiskCategoryID"]);

                txtProjectedOverRun.Text = dRow["EurosAtRisk"] != DBNull.Value ? ((decimal)dRow["EurosAtRisk"]).ToString("N2") : "0.00";
                txtCalculatedRisk.Text = dRow["CalculatedRisk"].ToString();
            }
        }
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        object objRiskID = Request.QueryString["RiskID"];

        decimal dcCalculatedRisk, dcProjectedOverRun;

        try
        {
            dcCalculatedRisk = Convert.ToDecimal(txtCalculatedRisk.Text);
        }
        catch (Exception e1)
        {
            dcCalculatedRisk = 0;
        }

        try
        {
            dcProjectedOverRun = Convert.ToDecimal(txtProjectedOverRun.Text);
        }
        catch (Exception e1)
        {
            dcProjectedOverRun = 0;
        }


        if (objRiskID == null)
        {
            Review_SectionF_DB.InsertInitiativeRisk(nInitiativeID,
                                            Convert.ToInt32(ddlRiskCateg.SelectedValue),
                                            ddlRiskCateg.SelectedItem.Text,
                                            dcCalculatedRisk,
                                            dcProjectedOverRun);

        }
        else
        {
            int riskID = Int32.Parse(objRiskID.ToString());
            Review_SectionF_DB.UpdateInitiativeRisk(riskID, nInitiativeID,
                                            Convert.ToInt32(ddlRiskCateg.SelectedValue),
                                            ddlRiskCateg.SelectedItem.Text,
                                            dcCalculatedRisk,
                                            dcProjectedOverRun);
        }

        RegisterStartupScript("closeScript",
                "<script language=JavaScript>  window.returnValue=1; window.close();  </script>");

    }
}
