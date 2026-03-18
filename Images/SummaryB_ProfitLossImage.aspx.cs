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
using System.IO;
using Microsoft.Reporting.WebForms;
using DataSetFinancialsTableAdapters;

public partial class Images_SummaryB_ProfitLossImage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string deviceInfo =
          "<DeviceInfo>" +
          "  <OutputFormat>PNG</OutputFormat>" +
          "  <MarginTop>0.0in</MarginTop>" +
          "  <MarginLeft>0.0in</MarginLeft>" +
          "  <MarginBottom>0.0in</MarginBottom>" +
          "  <MarginRight>0.0in</MarginRight>" +
          "  <PageWidth>5.521in</PageWidth>" +
          "  <PageHeight>2.552in</PageHeight>" +
          "</DeviceInfo>";

        Warning[] warnings;
        string[] streams;
        string type;
        string mime;
        string extn;

        LocalReport report = new LocalReport();
        report.ReportPath = @"ProfitLossAnalysis_Print.rdlc";

        DataTableAdapter_ProfitLossAnalysis adapter = new DataTableAdapter_ProfitLossAnalysis();
        DataSetFinancials.DataTable_ProfitLossAnalysisDataTable dataTable = new DataSetFinancials.DataTable_ProfitLossAnalysisDataTable();
        adapter.Fill(dataTable, Int32.Parse(Request.QueryString["InitiativeID"]));

        report.DataSources.Add(new ReportDataSource("DataSetFinancials_DataTable_ProfitLossAnalysis", dataTable));

        byte[] imgBytes = report.Render("Image", deviceInfo, out mime, out type, out extn, out streams, out warnings);

        Response.BinaryWrite(imgBytes);
        Response.Flush();
        Response.End();
    }
}
