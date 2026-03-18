//*****************************************************************************************************
//      Rev         By          Date            Description
//
//      1.6.1       GMcF        15/08/2007      Created for Phase 1.6 Deliverable 93 - Sponsor allocations hierarchy
//
//*****************************************************************************************************

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

public partial class AllocateSponsorUBRWrapper : System.Web.UI.Page
{
    int nInitiativeID = -1;
    int nPreviousVersion_InitiativeID = -1;
    int sponsorID = -1;
    int storeSponsorLevel = 0;
    string sponsorType = "";
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

        nPreviousVersion_InitiativeID = Global_DB.GetPreviousVersionInitiativeID(nInitiativeID);

        object objSponsorId = Request.QueryString["SponsorId"];
        if (objSponsorId != null)
        {
            try
            {
                sponsorID = Convert.ToInt32(objSponsorId);
            }
            catch (Exception e1)
            {
                sponsorID = -1;
            }
        }

        object objStoreSponsorLevel = Request.QueryString["StoreSponsorLevel"];
        if (objStoreSponsorLevel != null)
        {
            try
            {
                storeSponsorLevel = Convert.ToInt32(objStoreSponsorLevel);
            }
            catch (Exception e1)
            {
                storeSponsorLevel = 0;
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
            string strCSScript;
            if (nPreviousVersion_InitiativeID > 0)
            {
                strCSScript = "var elt = document.getElementById( 'wrappedForm'); elt.src = 'Review_AllocateUBR.aspx?InitiativeID=" + nInitiativeID + "&SponsorId=" + sponsorID + "&StoreSponsorLevel=" + storeSponsorLevel + "&ReadOnly=" + strReadOnly + "';\n";
            }

            else
            {
                strCSScript = "var elt = document.getElementById( 'wrappedForm'); elt.src = 'AllocateUBR.aspx?InitiativeID=" + nInitiativeID + "&SponsorId=" + sponsorID + "&StoreSponsorLevel=" + storeSponsorLevel + "&ReadOnly=" + strReadOnly + "';\n";
            }

            ClientScriptManager cs = Page.ClientScript;
            Type t = Page.GetType();
            cs.RegisterStartupScript(t, strCSKey, strCSScript, true);
        }
    }
}
