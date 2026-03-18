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
using ProjectPortfolio.Controls;


public partial class Report : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        switch(Request.QueryString["report"])
        {
            case "1":

                /*
                 * Control ctlSummary = Page.LoadControl("Controls/Review_Summary.ascx");
                    ctlSummary.ID = "ctlReview_Summary";
                    ctlPlaceHolder.Controls.Add(ctlSummary);
                 */

                Control ctlReportProviderView = Page.LoadControl(@"Controls/ProviderViewReport.ascx");
                ctlReportProviderView.ID = "ctlReport_ProviderViewReport";
                ctlPlaceHolder.Controls.Add(ctlReportProviderView);
               
                break;

            case "2":

                Control ctlReportClientView = Page.LoadControl(@"Controls/ClientViewReport.ascx");
                ctlReportClientView.ID = "ctlReport_ClientViewReport";
                ctlPlaceHolder.Controls.Add(ctlReportClientView);

                //ReportFrameSrc.Text = "/ReportServer$SQL2005/Pages/ReportViewer.aspx?%2fIG+Reporting%2fClient+View&rs:Command=Render";
                break;

            case "3":

                
                Control ctlReportCommitteeView = Page.LoadControl(@"Controls/CommitteeViewReport.ascx");
                ctlReportCommitteeView.ID = "ctlReport_CommitteeViewReport";
                ctlPlaceHolder.Controls.Add(ctlReportCommitteeView);
                
                //ReportFrameSrc.Text = "/ReportServer$SQL2005/Pages/ReportViewer.aspx?%2fIG+Reporting%2fBenefits+Report&rs:Command=Render";
                break;

            case "4":

                Control ctlReportBenefitsReport = Page.LoadControl(@"Controls/BenefitsReport.ascx");
                ctlReportBenefitsReport.ID = "ctlReport_BenefitsReport";
                ctlPlaceHolder.Controls.Add(ctlReportBenefitsReport);


                //ReportFrameSrc.Text = "/ReportServer$SQL2005/Pages/ReportViewer.aspx?%2fIG+Reporting%2fBubble+Chart&rs:Command=Render";
                break;

            case "5":
                
                Control ctlReportBenefitsVsSpend = Page.LoadControl(@"Controls/BenefitsVsSpendReport.ascx");
                ctlReportBenefitsVsSpend.ID = "ctlReport_BenefitVsSpendReport";
                ctlPlaceHolder.Controls.Add(ctlReportBenefitsVsSpend);

                break;
            
            default:

                Control ctlReportProviderVw = Page.LoadControl(@"Controls/ProviderViewReport.ascx");
                ctlReportProviderVw.ID = "ctlReport_ProviderViewReport";
                ctlPlaceHolder.Controls.Add(ctlReportProviderVw);
    
                //ReportFrameSrc.Text = "/ReportServer$SQL2005/Pages/ReportViewer.aspx?%2fIG+Reporting%2fCommittee+View&rs:Command=Render";
                break;
        }

    }


}
