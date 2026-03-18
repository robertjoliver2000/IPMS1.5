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

using System.Net.Mail;
using System.Net;

public partial class testSMTP : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SendTestEMail();
    }

    protected void SendTestEMail()
    {
        /**/
        DateTime sendTime = DateTime.Now;

        MailMessage message = new MailMessage();
        message.From = new MailAddress(ConfigurationSettings.AppSettings["ApplicationEmailAddress"]);
        message.To.Add(new MailAddress("robertjoliver@outlook.com"));

        message.IsBodyHtml = true;
        //message.IsBodyHtml = false;
        
        message.Subject = "test message at " + sendTime.ToLongDateString() + " " + sendTime.ToLongTimeString();

        message.Body = "test message body";

        SmtpClient client = new SmtpClient();

        try
        {
            client.Send(message);
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.ToString();
        }
        /**/

        /*
        string from = ConfigurationSettings.AppSettings["ApplicationEmailAddress"];

        {
            MailMessage message = new MailMessage();
            message.From = new MailAddress(from);

            message.To.Add(new MailAddress("robertjoliver@outlook.com"));

            string strSubject, strBody;

            strSubject = "test subject";
            strBody = "test body";

            message.IsBodyHtml = false;

            message.Subject = strSubject;
            message.Body = strBody;

            SmtpClient client = new SmtpClient();

            try
            {
                client.Send(message);
            }
            catch (Exception ex)
            {

            }
        }
        */

    }
}
