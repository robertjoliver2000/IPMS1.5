/*
 *      Rev     Date        By      Description
 * 
 *      1.9.8   2008-02-29  GMcF    Added code to use the first initiative version instead of previous one
 *                                  when the initiative has a PIR status
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
using System.IO;
using Microsoft.Reporting.WebForms;
using DataSetFinancialsTableAdapters;

using ProjectPortfolio.Classes;

public partial class Images_SummaryB_Review_ProfitLossImage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Start of Rev 1.9.8, 2008-02-29
        int nInitiativeID = Int32.Parse(Request.QueryString["InitiativeID"]);
        int nPrevInitiativeID;

        if (Global_DB.IsPIR(Global_DB.GetInitiativeStatusID(nInitiativeID)))
        {
            nPrevInitiativeID = Global_DB.GetEarliestVersionInitiativeID(nInitiativeID);
        }
        else
        {
            nPrevInitiativeID = Global_DB.GetPreviousVersionInitiativeID(nInitiativeID);
        }
        // End of Rev 1.9.8

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
        report.ReportPath = @"Review_ProfitLossAnalysis_Print.rdlc";

        DataTableAdapter_Review_ProfitLossAnalysis adapter = new DataTableAdapter_Review_ProfitLossAnalysis();
        DataSetFinancials.DataTable_Review_ProfitLossAnalysisDataTable dataTable = new DataSetFinancials.DataTable_Review_ProfitLossAnalysisDataTable();


        /* Rev 1.9.8, 2008-02-29, GMcF. Code replaced.
        adapter.Fill(dataTable, Int32.Parse(Request.QueryString["InitiativeID"]),
                        Global_DB.GetPreviousVersionInitiativeID(Int32.Parse(Request.QueryString["InitiativeID"])));
        */

        adapter.Fill(dataTable, nInitiativeID, nPrevInitiativeID);      // Rev 1.9.8


        report.DataSources.Add(new ReportDataSource("DataSetFinancials_DataTable_Review_ProfitLossAnalysis", dataTable));

        byte[] imgBytes = report.Render("Image", deviceInfo, out mime, out type, out extn, out streams, out warnings);

        Response.BinaryWrite(imgBytes);
        Response.Flush();
        Response.End();

    }

}
