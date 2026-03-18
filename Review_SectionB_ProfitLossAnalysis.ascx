<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_SectionB_ProfitLossAnalysis.ascx.cs" Inherits="ProjectPortfolio.Controls.Review_SectionB_ProfitLossAnalysis" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<table border="0" cellpadding="0">
    <tr>
        <td valign="top" style="border: 1px solid #CCCCCC; ">
            <table border="0" cellpadding="0">
	            <tr>
		            <td class="summarytitlecell">PROFIT & LOSS ANALYSIS</td>
	            </tr>
	            <tr>
		            <td>
                        <rsweb:ReportViewer ID="reportViewerProfitLossAnalysis" runat="server" Font-Names="Verdana" Font-Size="8pt" 
                                    ShowDocumentMapButton="False" ShowExportControls="False" ShowFindControls="False" 
                                    ShowPageNavigationControls="False" ShowPrintButton="False" ShowPromptAreaButton="False" 
                                    ShowRefreshButton="False" ShowToolBar="False" ShowZoomControl="False" SizeToReportContent="True" 
                                    Height="320px" Width="980px" BorderStyle="None" BorderWidth="2px" InternalBorderStyle="None">
                            <LocalReport ReportPath="Review_ProfitLossAnalysis.rdlc">
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
                                <asp:ControlParameter ControlID="hiddenPreviousInitiativeID" Name="PreviousInitiativeID"
                                    PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:HiddenField id="hiddenCurrentInitiativeID" runat="server" />
                        <asp:HiddenField id="hiddenPreviousInitiativeID" runat="server" />
		            </td>
		        </tr>
		   </table>
        </td>
        <td></td>
        <td valign="top" style="border: 1px solid #CCCCCC; ">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td class="financialanalysistitle" align="center" colspan="3">FINANCIAL ANALYSIS</td>
                </tr>
                <tr height="10px">
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td runat="Server" id="tdCurrentYearSpendTitle" class="financialanalysislabel" style="font-weight:bold;" width="110px">2006 Spend</td>
                    <td runat="Server" id="tdFA_CurrentYearSpend" class="financialanalysis" width="50px">0.00</td>
                    <td width="20px"></td>
                </tr>
                <tr>
                    <td runat="Server" id="tdCurrentYearBenefitsTitle" class="financialanalysislabel" style="font-weight:bold;">2006 Benefits</td>
                    <td runat="Server" id="tdFA_CurrentYearBenefits" class="financialanalysis" width="50px">0.00</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-style:italic;">&nbsp;&nbsp;&nbsp;Tangible</td>
                    <td runat="Server" id="tdFA_CurrentYearTangible" class="financialanalysis" width="50px">0.00</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-style:italic;">&nbsp;&nbsp;&nbsp;Intangible</td>
                    <td runat="Server" id="tdFA_CurrentYearIntangible" class="financialanalysis" width="50px">0.00</td>
                </tr>
                <tr height="10px">
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-weight:bold;">Total Spend</td>
                    <td runat="Server" id="tdFA_TotalSpend" class="financialanalysis" width="50px">0.00</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-weight:bold;">Total Benefits</td>
                    <td runat="Server" id="tdFA_TotalBenefits" class="financialanalysis" width="50px">0.00</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-style:italic;">&nbsp;&nbsp;&nbsp;Tangible</td>
                    <td runat="Server" id="tdFA_TotalTangible" class="financialanalysis" width="50px">0.00</td>
                    <td></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-style:italic;">&nbsp;&nbsp;&nbsp;Intangible</td>
                    <td runat="Server" id="tdFA_TotalIntangible" class="financialanalysis" width="50px">0.00</td>
                    <td></td>
                </tr>
                <tr height="10px">
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-weight:bold;">ROI</td>
                    <td runat="Server" id="tdFA_ROI" class="financialanalysis" width="50px">0.00</td>
                    <td></td>
                </tr>
                <tr height="10px">
                    <td colspan="3"></td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td class="financialanalysislabel" style="font-weight:bold;" width="100px">Pay Back Period</td>
                    <td colspan="2" style="width: 85px">
                        <asp:DropDownList runat="Server" ID="ddlPayBackPeriod" CssClass="textselect" Width="74px">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RVsectionB_rvPayBackPeriodDDL" runat="server" ControlToValidate="ddlPayBackPeriod"
                            ErrorMessage="Payback Period must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr height="10px">
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-weight:bold;">Completion Date</td>
                    <td colspan="2" style="width: 85px">
                        <asp:DropDownList runat="Server" ID="ddlCompletionDate" CssClass="textselect" Width="74px">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RVsectionB_CompletionDateDDL" runat="server" ControlToValidate="ddlCompletionDate"
                            ErrorMessage="Completion Date must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>        
        </td>
    </tr>
</table>