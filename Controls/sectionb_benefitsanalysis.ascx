<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionB_BenefitsAnalysis" CodeFile="SectionB_BenefitsAnalysis.ascx.cs" %>

<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td>
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:Repeater runat="Server" ID="rptBenefitsAnalysis" EnableViewState="false" OnItemDataBound="rptBenefitsAnalysis_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="3" style="border-collapse: collapse; border-color: #CCCCCC;">
	                                <tr>
		                                <td runat="Server" id="tdBigTitle" class="analysisheadcell" style="text-align:center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
		                                    BENEFITS ANALYSIS</td>
	                                </tr>
	                                <tr runat="Server" id="trHeader">
		                                <td class="analysisheadcell" style="border-left: 1px solid #CCCCCC;"></td>
	                                </tr>
	                                <tr runat="Server" id="trPIRHeader"></tr>
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr>
	                                    <td class="analysiswhitecell" style="font-weight: bold; border: 1px solid #CCCCCC;">Tangible Benefits</td>
	                                    <td class="analysiswhitecell" colspan="15"></td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal1">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="130px">Revenue Generation</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal2">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="130px">Cost Reduction</td>
	                                </tr>
	                                <tr>
	                                    <td class="analysiswhitecell" style="font-weight: bold; border: 1px solid #CCCCCC;">Intangible Benefits</td>
	                                    <td class="analysiswhitecell" colspan="15"></td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal3">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="130px">Risk Reduction</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal4">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="130px">Cost Avoidance</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal5">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="130px">Rev. Loss Avoidance</td>
	                                </tr>
	                                <tr runat="Server" id="trTotal">
		                                <td class="analysistotalcell" style="border-left: 1px solid #000000; text-align: center">Total Benefits</td>
	                                </tr>
                                </table>
	                        </FooterTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                    </td>
                </tr>
                <tr>
                   <td>
                        <asp:Repeater runat="Server" ID="rptSpendAnalysis" EnableViewState="false" OnItemDataBound="rptSpendAnalysis_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="3" style="border-collapse: collapse; border-color: #CCCCCC;">
	                                <tr>
		                                <td runat="Server" id="tdBigTitle" class="analysisheadcell" style="text-align:center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
		                                    SPEND ANALYSIS</td>
	                                </tr>
	                                <tr runat="Server" id="trHeader">
		                                <td class="analysisheadcell" style="border-left: 1px solid #CCCCCC;"></td>
	                                </tr>
	                                <tr runat="Server" id="trPIRHeader"></tr>
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr runat="Server" id="trSubTotal1">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="130px">CTB</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal2">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="130px">MAN</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal3">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="130px">RTB (incremental)</td>
	                                </tr>
	                                <tr runat="Server" id="trTotal">
		                                <td class="analysistotalcell" style="border-left: 1px solid #000000; text-align: center">Total Cost</td>
                                    </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                   </td>
                </tr>
                <tr>
                    <td>&nbsp;
                    </td>
                </tr>
                <tr>
                   <td>
                        <asp:Repeater runat="Server" ID="rptRTBExisting" EnableViewState="false" OnItemDataBound="rptRTBExisting_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="3" style="border-collapse: collapse; border-color: #CCCCCC;">
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr runat="Server" id="trRTBExisting">
		                                <td class="analysisgreencell" style="border: 1px solid #000000;" width="130px">RTB (existing)</td>
	                                </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                   </td>
                </tr>
            </table>
        </td>
        <td runat="server" id="tdSpacer" style="width: 10px">        
        </td>
        <td valign="top" style="border: 1px solid #CCCCCC; " runat="server" id="tdFinancialAnalysis">
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
                    <td colspan="2" style="width: 86px">
                        <asp:DropDownList runat="Server" ID="ddlPayBackPeriod" CssClass="textselect" Width="74px">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="sectionB_rvPayBackPeriodDDL" runat="server" ControlToValidate="ddlPayBackPeriod"
                            ErrorMessage="Payback Period must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr height="10px">
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td class="financialanalysislabel" style="font-weight:bold;">Completion Date</td>
                    <td colspan="2" style="width: 86px">
                        <asp:DropDownList runat="Server" ID="ddlCompletionDate" CssClass="textselect" Width="74px">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="sectionB_rvCompletionDateDDL" runat="server" ControlToValidate="ddlCompletionDate"
                            ErrorMessage="Completion Date must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>&nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>    

