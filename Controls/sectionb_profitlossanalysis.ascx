<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionB_ProfitLossAnalysis" CodeFile="SectionB_ProfitLossAnalysis.ascx.cs" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, publicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<table style="border: 1px solid #CCCCCC;">
	<tr>
		<td class="summarytitlecell">PROFIT & LOSS ANALYSIS</td>
	</tr>
	<tr>
		<td valign="top" >
            <rsweb:ReportViewer ID="reportViewerProfitLossAnalysis" runat="server" Font-Names="Verdana" Font-Size="8pt" ShowDocumentMapButton="False" ShowExportControls="False" ShowFindControls="False" ShowPageNavigationControls="False" ShowPrintButton="False" ShowPromptAreaButton="False" ShowRefreshButton="False" ShowToolBar="False" ShowZoomControl="False" SizeToReportContent="True" Height="350px" Width="1200px" BorderStyle="None" BorderWidth="2px" InternalBorderStyle="None">
                <LocalReport ReportPath="ProfitLossAnalysis.rdlc">
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
            <asp:HiddenField ID="hiddenCurrentInitiativeID" runat="server" />
		</td>
	</tr>
</table>