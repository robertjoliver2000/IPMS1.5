/* ****************************************************************************************************
 * 
 *      Rev         By          Date            Description
 * 
 *      1.9.7       GMcF        26/02/2008      Added handling of PIR initiatives to Page_Load()
 * 
 *      1.9.9       GMcF        03/03/2008      Altered handling of PIR printing to force page breaks
 *
 * **************************************************************************************************** */

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
using org.pdfbox.pdmodel;
using System.IO;

using ProjectPortfolio.Classes;
using System.Net;
using java.util;

public partial class FullPDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "application/pdf";

        HttpWebRequest req;
        Boolean bIsPIR;

        Stream pdfStream;
        PDDocument mainDoc;

        string URLPrefix = "http://" + ConfigurationSettings.AppSettings["CordaServerAddress"] + ":2001/?@_DOC_LOAD" + ConfigurationSettings.AppSettings["BaseAppUrl"];

        bIsPIR = Global_DB.IsPIR(Global_DB.GetInitiativeStatusID(System.Convert.ToInt32(Request.QueryString["InitiativeID"])));

        if (bIsPIR)
        {
            req = (HttpWebRequest)HttpWebRequest.Create(URLPrefix + "/PIRSummary_Printing.aspx?InitiativeID=" + Request.QueryString["InitiativeID"] + "&Page=1");

            pdfStream = req.GetResponse().GetResponseStream();

            //Create the first page of the PDF to be output finally
            mainDoc = PDDocument.load(new ConvertNStream2JInputStream(pdfStream));
            pdfStream.Close();

            //Now get the other documents and add their pages
            addUrlToDocument(mainDoc, URLPrefix + "/PIRSummary_Printing.aspx?InitiativeID=" + Request.QueryString["InitiativeID"] + "&Page=2");
            addUrlToDocument(mainDoc, URLPrefix + "/PIRSummary_Printing.aspx?InitiativeID=" + Request.QueryString["InitiativeID"] + "&Page=3");

            if ((Request.QueryString["SummaryOnly"] == null) || (Request.QueryString["SummaryOnly"].ToString().ToLower() == "no"))
            {
                addUrlToDocument(mainDoc, URLPrefix + "/Financial_Printing.aspx?InitiativeID=" + Request.QueryString["InitiativeID"]);
            }

            mainDoc.save(new ConvertNStream2JOutputStream(Response.OutputStream));

        }

        else
        {
            req = (HttpWebRequest)HttpWebRequest.Create(URLPrefix + "/TestingForm_Printing.aspx?InitiativeID=" + Request.QueryString["InitiativeID"]);

            pdfStream = req.GetResponse().GetResponseStream();

            //Create the first page of the PDF to be output finally
            mainDoc = PDDocument.load(new ConvertNStream2JInputStream(pdfStream));
            pdfStream.Close();

            //Now get the other documents and add their pages
            addUrlToDocument(mainDoc, URLPrefix + "/Financial_Printing.aspx?InitiativeID=" + Request.QueryString["InitiativeID"]);
            addUrlToDocument(mainDoc, URLPrefix + "/ArchitectureAndRisk_Printing.aspx?InitiativeID=" + Request.QueryString["InitiativeID"]);
            addUrlToDocument(mainDoc, URLPrefix + "/Projects_Printing.aspx?InitiativeID=" + Request.QueryString["InitiativeID"]);

            mainDoc.save(new ConvertNStream2JOutputStream(Response.OutputStream));
        }

    }

    void addUrlToDocument(PDDocument mainDoc, string url)
    {
        HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(url);
        Stream pdfStream = req.GetResponse().GetResponseStream();

        PDDocument subDocument = PDDocument.load(new ConvertNStream2JInputStream(pdfStream));
        pdfStream.Close();
        //Get the pages from the sub document and add to the main document
        List pages = getAllPagesFromNode(subDocument.getDocumentCatalog().getPages());
        if (pages != null)
        {
            Iterator pageIter = pages.iterator();
            while (pageIter.hasNext())
            {
                mainDoc.addPage((PDPage)pageIter.next());
            }
        }
    }
    
    List getAllPagesFromNode(PDPageNode node)
    {
        List retPages = new Vector();
        List pages = node.getKids();
        if (pages != null)
        {
            Iterator listIter=pages.iterator();
            while (listIter.hasNext())
            {
                object oPage = listIter.next();
                if (oPage is PDPage)
                {
                    retPages.add(oPage);
                }
                else
                {
                    //Get the child pages from this, and add to our list
                    List subPages = getAllPagesFromNode((PDPageNode)oPage);
                    if (subPages != null)
                    {
                        Iterator subIter = subPages.iterator();
                        while (subIter.hasNext())
                        {
                            retPages.add(subIter.next());
                        }
                    }
                }
            }
        }
        return retPages;
    }

}
