using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using Corda;

public partial class CordaPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/text";
        //Response.Write("This is a test");
        
        HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create("http://10.10.10.110/projectportfolio2006/TestingForm_Printing.aspx?InitiativeID=18");
        req.Credentials = System.Net.CredentialCache.DefaultCredentials;
        WebResponse resp = req.GetResponse();
        //Request.LogonUserIdentity

        Stream outputStream = resp.GetResponseStream();
        StreamReader streamReader = new StreamReader(outputStream, Encoding.UTF8);
        string pageHtml = streamReader.ReadToEnd();

        //Do the Corda stuff
        CordaEmbedder myImage = new CordaEmbedder();
        myImage.externalServerAddress = "10.10.10.16:2001";
        myImage.internalCommPortAddress = "10.10.10.16:2002";
        myImage.setDoc(pageHtml, "");

        //Get the response back 
        byte[] pdfImageArray = myImage.getBytes();

        Response.Write("Image returns: " + (pdfImageArray == null ? "Null" : pdfImageArray.Length + " bytes"));
//        Response.BinaryWrite(pdfImageArray);

    }
}
