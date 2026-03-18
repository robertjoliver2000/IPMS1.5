<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionB_BenefitsAnalysis_PrintVersion"
    CodeFile="sectionb_benefitsanalysis_PrintVersion.ascx.cs" %>
<table cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
    <tr style="width: 100%;">
        <td style="width: 100%;">
            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
                <tr style="width: 100%;">
                    <td style="width: 100%;">
                        <asp:Repeater runat="Server" ID="rptBenefitsAnalysis" EnableViewState="false" OnItemDataBound="rptBenefitsAnalysis_ItemDataBound">
                            <HeaderTemplate>
                                <table cellspacing="0" cellpadding="1" style="border-collapse: collapse; border-color: #CCCCCC; width: 100%;">
                                    <tr>
                                        <td runat="Server" id="tdBigTitle" class="analysisheadcell" style="text-align: center;
                                            border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
                                            BENEFITS ANALYSIS</td>
                                    </tr>
                                    <tr runat="Server" id="trHeader">
                                        <td class="analysisheadcell" style="border-left: 1px solid #CCCCCC;">
                                        </td>
                                    </tr>
	                                <tr runat="Server" id="trPIRHeader"></tr>
                            </HeaderTemplate>
                            <FooterTemplate>
                                <tr>
                                    <td class="analysiswhitecell" style="font-weight: bold; border: 1px solid #CCCCCC;" width="95px">
                                        Tangible Benefits</td>
                                    <td class="analysiswhitecell" colspan="15">
                                    </td>
                                </tr>
                                <tr runat="Server" id="trSubTotal1">
                                    <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        Revenue Generation</td>
                                </tr>
                                <tr runat="Server" id="trSubTotal2">
                                    <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        Cost Reduction</td>
                                </tr>
                                <tr>
                                    <td class="analysiswhitecell" style="font-weight: bold; border: 1px solid #CCCCCC;" width="95px">
                                        Intangible Benefits</td>
                                    <td class="analysiswhitecell" colspan="15">
                                    </td>
                                </tr>
                                <tr runat="Server" id="trSubTotal3">
                                    <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        Risk Reduction</td>
                                </tr>
                                <tr runat="Server" id="trSubTotal4">
                                    <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        Cost Avoidance</td>
                                </tr>
                                <tr runat="Server" id="trSubTotal5">
                                    <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        Rev. Loss Avoidance</td>
                                </tr>
                                <tr runat="Server" id="trTotal">
                                    <td class="analysistotalcell" style="border-left: 1px solid #000000; text-align: center" width="95px">
                                        Total Benefits</td>
                                </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr style="width: 100%;">
                    <td style="width: 100%;">
                        <asp:Repeater runat="Server" ID="rptSpendAnalysis" EnableViewState="false" OnItemDataBound="rptSpendAnalysis_ItemDataBound">
                            <HeaderTemplate>
                                <table cellspacing="0" cellpadding="1" style="border-collapse: collapse; border-color: #CCCCCC; width: 100%;">
                                    <tr>
                                        <td runat="Server" id="tdBigTitle" class="analysisheadcell" style="text-align: center;
                                            border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
                                            SPEND ANALYSIS</td>
                                    </tr>
                                    <tr runat="Server" id="trHeader">
                                        <td class="analysisheadcell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        </td>
                                    </tr>
	                                <tr runat="Server" id="trPIRHeader"></tr>
                            </HeaderTemplate>
                            <FooterTemplate>
                                <tr runat="Server" id="trSubTotal1">
                                    <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        CTB</td>
                                </tr>
                                <tr runat="Server" id="trSubTotal2">
                                    <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        MAN</td>
                                </tr>
                                <tr runat="Server" id="trSubTotal3">
                                    <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="95px">
                                        RTB (incremental)</td>
                                </tr>
                                <tr runat="Server" id="trTotal">
                                    <td class="analysistotalcell" style="border-left: 1px solid #000000; text-align: center" width="95px">
                                        Total Cost</td>
                                </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Repeater runat="Server" ID="rptRTBExisting" EnableViewState="false" OnItemDataBound="rptRTBExisting_ItemDataBound">
                            <HeaderTemplate>
                                <table cellspacing="0" cellpadding="1" style="border-collapse: collapse; border-color: #CCCCCC; width:100%">
                            </HeaderTemplate>
                            <FooterTemplate>
                                <tr runat="Server" id="trRTBExisting">
                                    <td class="analysisgreencell" style="border: 1px solid #000000; width:95px">
                                        RTB (existing)</td>
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
        <td valign="top" runat="server" id="tdFinancialAnalysis">
            <table cellpadding="0" cellspacing="0" border="0" id="tblFinancialAnalysis">
                <tr>
                    <td valign="top" style="border: 1px solid #CCCCCC;">
                        <table cellpadding="2" cellspacing="2">
                            <tr>
                                <td class="financialanalysistitle" align="center" colspan="3">
                                    FINANCIAL ANALYSIS</td>
                            </tr>
                            <tr height="10px">
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td runat="Server" id="tdCurrentYearSpendTitle" class="financialanalysislabel" style="font-weight: bold;" width="80px">
                                    2006 Spend</td>
                                <td runat="Server" id="tdFA_CurrentYearSpend" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td width="10px">
                                </td>
                            </tr>
                            <tr>
                                <td runat="Server" id="tdCurrentYearBenefitsTitle" class="financialanalysislabel" style="font-weight: bold;">
                                    2006 Benefits</td>
                                <td runat="Server" id="tdFA_CurrentYearBenefits" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-style: italic;">
                                    &nbsp;&nbsp;&nbsp;Tangible</td>
                                <td runat="Server" id="tdFA_CurrentYearTangible" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-style: italic;">
                                    &nbsp;&nbsp;&nbsp;Intangible</td>
                                <td runat="Server" id="tdFA_CurrentYearIntangible" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td>
                                </td>
                            </tr>
                            <tr height="10px">
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-weight: bold;">
                                    Total Spend</td>
                                <td runat="Server" id="tdFA_TotalSpend" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-weight: bold;">
                                    Total Benefits</td>
                                <td runat="Server" id="tdFA_TotalBenefits" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-style: italic;">
                                    &nbsp;&nbsp;&nbsp;Tangible</td>
                                <td runat="Server" id="tdFA_TotalTangible" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-style: italic;">
                                    &nbsp;&nbsp;&nbsp;Intangible</td>
                                <td runat="Server" id="tdFA_TotalIntangible" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td>
                                </td>
                            </tr>
                            <tr height="10px">
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-weight: bold;">
                                    ROI</td>
                                <td runat="Server" id="tdFA_ROI" class="financialanalysis" width="50px">
                                    0.00</td>
                                <td>
                                </td>
                            </tr>
                            <tr height="10px">
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-weight: bold;">
                                    Pay Back Period</td>
                                <td cols class="tablegreybg">
                                    <%-- <asp:DropDownList runat="Server" ID="ddlPayBackPeriod2" CssClass="textselect" Width="80px">
                                    </asp :DropDownList> --%>
                                    <asp:Label ID="ddlPayBackPeriod" runat="server"></asp:Label>
                                </td>
                                 <td>
                                </td>
                           </tr>
                            <tr height="10px">
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td class="financialanalysislabel" style="font-weight: bold;">
                                    Completion Date</td>
                                <td class="tablegreybg">
                                    <%-- <asp:DropDownList runat="Server" ID="ddlCompletionDate2" CssClass="textselect" Width="80px">
                                    </asp:DropDownList> --%>
                                    <asp:Label ID="ddlCompletionDate" runat="server"></asp:Label>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
