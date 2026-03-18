/*
 *  Rev         By          Date            Description
 * 
 *  1.8.2       GMcF        2007-10-05      Added for Detailed Functional Domains
 * 
 */


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

public partial class DetailedFunctionalDomain : System.Web.UI.Page
{
    protected int nInitiativeID;

    protected void Page_Load(object sender, EventArgs e)
    {
        int intInitiativeDetailedFunctionalDomainID;

        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
        {
            try
            {
                intInitiativeDetailedFunctionalDomainID = Int32.Parse(Request.QueryString["InitiativeDetailedFunctionalDomainID"]);
            }
            catch (Exception)
            {
                intInitiativeDetailedFunctionalDomainID = -1;
            }

            if (intInitiativeDetailedFunctionalDomainID > 0)
            {
                DataSet ds = SectionE_DB.GetInitiativeDetailedFunctionalDomain(intInitiativeDetailedFunctionalDomainID);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables[0].Rows[0];
                    nInitiativeID = System.Convert.ToInt32(dr.ItemArray[1]);
                    hdnInitiativeDetailedFunctionalDomainID.Value = dr.ItemArray[0].ToString();
                    hdnInitiativeID.Value = nInitiativeID.ToString("0");
                    hdnReferenceID.Value = dr.ItemArray[2].ToString();
                    txtDescription.Text = dr.ItemArray[3].ToString();
                    txtAllocation.Text = (System.Convert.ToDecimal(dr.ItemArray[4])).ToString("0.00");
                    txtComments.Text = dr.ItemArray[5].ToString();
                }
            }
            else
            {
                try
                {
                    nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
                    hdnInitiativeID.Value = nInitiativeID.ToString("0");
                    hdnInitiativeDetailedFunctionalDomainID.Value = "0";
                    hdnReferenceID.Value = "";
                    txtDescription.Text = "";
                }
                catch (Exception)
                {
                    nInitiativeID = -1;
                }
            }

            if (nInitiativeID > 0)
            {
                hRefDetailedFunctionalDomain.HRef = "javascript:popupWindowSelectDFD(" +
                                            nInitiativeID.ToString() + ",'" +
                                            txtDescription.ClientID + "','" +
                                            hdnReferenceID.ClientID + "')";

                btnSave.Enabled = true;
            }

            pageTitle.InnerHtml = Global_DB.GetInitiativeName(nInitiativeID);

        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            SectionE_DB.UpdateInitiativeDetailedFunctionalDomain(
                    System.Convert.ToInt32(hdnInitiativeDetailedFunctionalDomainID.Value),
                    System.Convert.ToInt32(hdnInitiativeID.Value),
                    System.Convert.ToInt32(hdnReferenceID.Value),
                    System.Convert.ToDecimal(txtAllocation.Text),
                    txtComments.Text
                );
        }
        catch( SystemException se)
        {
        }

        string strCSScript = "<script language='JavaScript' type='text/javascript'>window.returnValue = 1; window.close();</script>";
        string strCSKey = "CloseDetailedFunctionalDomain";

        ClientScriptManager cs = Page.ClientScript;

        Type t = Page.GetType();

        if (!cs.IsStartupScriptRegistered(t, strCSKey))
        {
            cs.RegisterClientScriptBlock(t, strCSKey, strCSScript, false);
        }

    }

}
