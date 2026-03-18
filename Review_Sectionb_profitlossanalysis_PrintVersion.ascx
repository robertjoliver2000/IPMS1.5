<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.Review_SectionB_ProfitLossAnalysis_PrintVersion" CodeFile="Review_Sectionb_profitlossanalysis_PrintVersion.ascx.cs" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<table cellpadding="0" cellspacing="0" height="100%">
    <tr>
        <td style="border: 1px solid #CCCCCC;" valign="top" height="100%">
            <table border="0" cellpadding="0">
	            <tr>
		            <td class="summarytitlecell" style="width: 350px">PROFIT & LOSS ANALYSIS</td>
	            </tr>
	            <tr>
		            <td valign="top" style="width: 340px" >
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
                        <img src="images/SummaryB_Review_ProfitLossImage.aspx?InitiativeID=<%=Request.QueryString["InitiativeID"]%>" width="340px" height="180px"/>
		            </td>
		         </tr>
		     </table>
		</td>
        <td style="border: 1px solid #CCCCCC;" valign="top" >
            <table cellpadding="1" cellspacing="1" style="width:115px">
                <tr>
                    <td class="summarytitlecell" valign="middle" align="center" colspan="2">FINANCIAL ANALYSIS</td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="2" style="width:115px">
                <tr height="5px">
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td runat="Server" style="font-weight: bold" id="tdCurrentYearSpendTitle" class="financialanalysislabel" width="70px">2006 Spend</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_CurrentYearSpend" >0.00</td>
                </tr>
                <tr>
                    <td runat="Server" style="font-weight: bold" id="tdCurrentYearBenefitsTitle" class="financialanalysislabel">2006 Benefits</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_CurrentYearBenefits">0.00</td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-style:italic;">&nbsp;Tangible</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_CurrentYearTangible" >0.00</td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-style:italic;">&nbsp;Intangible</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_CurrentYearIntangible" >0.00</td>
                </tr>
                <tr height="5px">
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td style="font-weight: bold" class="financialanalysislabel" >Total Spend</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_TotalSpend" >0.00</td>
                </tr>
                <tr>
                    <td style="font-weight: bold" class="financialanalysislabel" >Total Benefits</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_TotalBenefits" >0.00</td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-style:italic;">&nbsp;Tangible</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_TotalTangible">0.00</td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-style:italic;">&nbsp;Intangible</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_TotalIntangible" >0.00</td>
                </tr>
                <tr height="5px">
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td style="font-weight: bold" class="financialanalysislabel">ROI</td>
                    <td runat="Server" class="financialanalysisvalue" id="tdFA_ROI"  >0.00</td>
                </tr>
                <tr height="5px">
                    <td colspan="2"></td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="1">
                <tr>
                    <td class="financialanalysislabel" width="70px">Pay Back Period</td>
                    <td class="tablegreybg" >
                        <asp:Label runat="Server" cssclass="financialanalysislabel" ID="ddlPayBackPeriod" >
                        </asp:Label>
                    </td>
                </tr>
                <tr height="5px">
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" >Completion Date</td>
                    <td class="tablegreybg" >
                        <asp:Label runat="Server" cssclass="financialanalysislabel" ID="ddlCompletionDate" >
                        </asp:Label>
                    </td>
                </tr>
            </table>        
        </td>	
     </tr>
</table>