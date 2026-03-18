<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_FinancialsAndDelivery_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_FinancialsAndDelivery_PrintVersion" %>
<%@ Register Src="PIR_ScopeChanges_PrintVersion.ascx" TagName="PIR_ScopeChanges" TagPrefix="uc6" %>
<%@ Register Src="PIR_Deliverables_PrintVersion.ascx" TagName="PIR_Deliverables" TagPrefix="uc3" %>
<%@ Register Src="PIR_FinancialComments_PrintVersion.ascx" TagName="PIR_FinancialComments" TagPrefix="uc4" %>
<%@ Register Src="sectionb_sponsorallocations_PrintVersion.ascx" TagName="sectionb_sponsorallocations"
    TagPrefix="uc5" %>
<%@ Register Src="sectionb_benefitsanalysis_PrintVersion.ascx" TagName="sectionb_benefitsanalysis"
    TagPrefix="uc2" %>
<%@ Register Src="PIR_ProfitLossAnalysis_PrintVersion.ascx" TagName="PIR_ProfitLossAnalysis" TagPrefix="uc1" %>
<div style="margin:0px; padding:0px;" class="PIR">
    <table style="width:280mm;" cellpadding="0" cellspacing="0">
        <tr style="vertical-align:top; width: 64.5%; height: 100%;">
            <td>
                <uc1:PIR_ProfitLossAnalysis id="ctlPIR_ProfitLossAnalysis" runat="server" />
            </td>
            <td style="text-align:right; width: 35%; height: 100%;">
                <table cellpadding="0" style="border: 1px solid #CCCCCC; width: 100%">
                    <tr><td><uc2:sectionb_benefitsanalysis ID="crlSectionb_benefitsanalysis" runat="server" /></td></tr>
                </table>
            </td>
        </tr>
    </table>
    <table style="width:280mm; margin:0px;">
        <tr style="vertical-align:top;">
            <td style="width:200mm; margin:0px; border:solid 1px #cccccc; padding:0px;" >
                <uc4:PIR_FinancialComments ID="ctlPIR_FinancialComments" runat="server" />
            </td>
            <td style="text-align:right; margin:0px; border:solid 1px #cccccc; padding:0px; width: 79mm;">
                <uc5:sectionb_sponsorallocations ID="ctlSectionb_sponsorallocations" runat="server" />
            </td>
        </tr>
    </table>
    <table style="width:280mm; margin-top:0px;" cellpadding="0" cellspacing="0">
        <tr style="vertical-align:top;">
            <td>
                <uc3:PIR_Deliverables ID="ctlPIR_Deliverables" runat="server" />
            </td>
            <td style="text-align:right; padding-left:2px;">
                <uc6:PIR_ScopeChanges ID="ctlPIR_ScopeChanges" runat="server" />
            </td>
        </tr>
    </table>
</div>