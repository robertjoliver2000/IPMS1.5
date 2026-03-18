<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionB_ProfitLossAnalysis_PrintVersion" CodeFile="Sectionb_profitlossanalysis_PrintVersion.ascx.cs" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<table style="width: 540px; ">
	<tr>
		<td class="summarytitlecell" style="width: 540px">PROFIT & LOSS ANALYSIS</td>
	</tr>
	<tr>
		<td valign="top" style="width: 540px">
            <%-- <rsweb:ReportViewer ID="reportViewerProfitLossAnalysis" runat="server" Font-Names="Verdana" Font-Size="8pt" ShowDocumentMapButton="False" ShowExportControls="False" ShowFindControls="False" ShowPageNavigationControls="False" ShowPrintButton="False" ShowPromptAreaButton="False" ShowRefreshButton="False" ShowToolBar="False" ShowZoomControl="False" SizeToReportContent="True" Height="249px" Width="415px" BorderStyle="None" BorderWidth="2px" InternalBorderStyle="None" DocumentMapCollapsed="True" ZoomMode="PageWidth">
                <LocalReport ReportPath="ProfitLossAnalysis_Print.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="objProfitLossAnalysisDataSource" Name="DataSetFinancials_DataTable_ProfitLossAnalysis" />
                    </DataSources>                
                </LocalReport>
            </rsweb:ReportViewer>
            <asp:ObjectDataSource ID="objProfitLossAnalysisDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="DataSetFinancialsTableAdapters.DataTableAdapter_ProfitLossAnalysis">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hiddenCurrentInitiativeID" Name="InitiativeID" PropertyName="Value"
                        Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="hiddenCurrentInitiativeID" runat="server" /> --%>
            <img height="210px" width="530px" src="images/SummaryB_ProfitLossImage.aspx?InitiativeID=<%=Request.QueryString["InitiativeID"]%>" />
		</td>
	</tr>
</table>