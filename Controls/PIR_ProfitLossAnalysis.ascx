<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_ProfitLossAnalysis.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_ProfitLossAnalysis" %>
<table cellpadding="0" xcellspacing="2" style="border: 1px solid #CCCCCC; xwidth:533px;">
<tr><td class="PIRTitle" style="width: 533px">Profit &amp; Loss Analysis (Eur'Mn)</td></tr>
<tr><td xstyle="width: 533px">
<%--
<rsweb:ReportViewer ID="reportViewerProfitLossAnalysis" runat="server" Font-Names="Verdana" Font-Size="8pt" 
            ShowDocumentMapButton="False" ShowExportControls="False" ShowFindControls="False" 
            ShowPageNavigationControls="False" ShowPrintButton="False" ShowPromptAreaButton="False" 
            ShowRefreshButton="False" ShowToolBar="False" ShowZoomControl="False" SizeToReportContent="True" 
            Height="6.7cm" Width="14.1cm" BorderStyle="None" BorderWidth="2px" InternalBorderStyle="None">
    <LocalReport ReportPath="Review_ProfitLossAnalysis_Print.rdlc">
        <DataSources>
            <rsweb:ReportDataSource DataSourceId="objProfitLossAnalysisDataSource" Name="DataSetFinancials_DataTable_Review_ProfitLossAnalysis" />
        </DataSources>
    </LocalReport>
</rsweb:ReportViewer>
<asp:ObjectDataSource ID="objProfitLossAnalysisDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="DataSetFinancialsTableAdapters.DataTableAdapter_Review_ProfitLossAnalysis">
    <SelectParameters>
        <asp:ControlParameter ControlID="hiddenCurrentInitiativeID" Name="CurrentInitiativeID"
            PropertyName="Value" Type="Int32" />
        <asp:ControlParameter ControlID="hiddenEarliestInitiativeID" Name="PreviousInitiativeID"
            PropertyName="Value" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:HiddenField id="hiddenCurrentInitiativeID" runat="server" />
<asp:HiddenField id="hiddenEarliestInitiativeID" runat="server" />
--%>
<img src="images/SummaryB_Review_ProfitLossImage.aspx?InitiativeID=<%=Request.QueryString["InitiativeID"]%>"
    xstyle="width:130mm; height:76mm;" style="width:691px; height:356px;"/>
</td></tr></table>