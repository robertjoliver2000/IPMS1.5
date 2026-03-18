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

public partial class Review_AllocateSponsorUBRWrapper : System.Web.UI.Page
{
    int nInitiativeID = -1;
    string sponsorType = "";
    int sponsorID = -1;
    string strReadOnly = "1";

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        try
        {
            nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        }
        catch (Exception)
        {
            nInitiativeID = -1;
        }

        object objSponsorID = Request.QueryString["SponsorId"];
        if (objSponsorID != null)
        {
            try
            {
                sponsorID = Convert.ToInt32(objSponsorID);
                sponsorType = SectionB_SponsorAllocations_DB.GetSponsorType(sponsorID);
            }
            catch (Exception e1)
            {
                sponsorType = "";
                sponsorID = -1;
            }
        }

        object objReadOnly = Request.QueryString["ReadOnly"];
        if (objReadOnly != null)
        {
            try
            {
                strReadOnly = Convert.ToString(objReadOnly);
            }
            catch (Exception e1)
            {
                strReadOnly = "1";
            }
        }

        if ( nInitiativeID != -1 && sponsorID != -1 )
        {
            string strCSKey = "setSource";
            string strCSScript = "var elt = document.getElementById( 'wrappedForm'); elt.src = 'Review_AllocateUBR.aspx?InitiativeID=" + nInitiativeID + "&SponsorId=" + sponsorID + "&ReadOnly=" + strReadOnly + "';\n";
            ClientScriptManager cs = Page.ClientScript;
            Type t = Page.GetType();
            cs.RegisterStartupScript(t, strCSKey, strCSScript, true);
        }
    }
}
