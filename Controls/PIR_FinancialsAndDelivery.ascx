<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_FinancialsAndDelivery.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_FinancialsAndDelivery" %>
<%@ Register Src="PIR_ScopeChanges.ascx" TagName="PIR_ScopeChanges" TagPrefix="uc6" %>
<%@ Register Src="PIR_Deliverables.ascx" TagName="PIR_Deliverables" TagPrefix="uc3" %>
<%@ Register Src="PIR_FinancialComments.ascx" TagName="PIR_FinancialComments" TagPrefix="uc4" %>
<%@ Register Src="sectionb_sponsorallocations.ascx" TagName="sectionb_sponsorallocations"
    TagPrefix="uc5" %>
<%@ Register Src="sectionb_benefitsanalysis.ascx" TagName="sectionb_benefitsanalysis"
    TagPrefix="uc2" %>
<%@ Register Src="PIR_ProfitLossAnalysis.ascx" TagName="PIR_ProfitLossAnalysis" TagPrefix="uc1" %>
<div style="margin:0px; padding:0px; xwidth:100%; width:1245px; xborder:dashed 1px black;" class="PIR">
    <table style="width:100%;" cellpadding="0" cellspacing="0">
        <tr style="vertical-align:top;">
            <td>
                <uc1:PIR_ProfitLossAnalysis id="ctlPIR_ProfitLossAnalysis" runat="server" />
            </td>
            <td style="text-align:right; xwidth:395px;">
                <table cellpadding="0" style="border: 1px solid #CCCCCC; xwidth:100%;">
                    <tr><td><uc2:sectionb_benefitsanalysis ID="crlSectionb_benefitsanalysis" runat="server" /></td></tr>
                </table>
            </td>
        </tr>
    </table>
    <table style="width:100%; margin-top:2px;" cellpadding="0" cellspacing="0">
        <tr style="vertical-align:top;">
            <td>
                <uc4:PIR_FinancialComments ID="ctlPIR_FinancialComments" runat="server" />
            </td>
            <td style="text-align:right;">
                <uc5:sectionb_sponsorallocations ID="ctlSectionb_sponsorallocations" runat="server" />
            </td>
        </tr>
    </table>
    <table style="width:100%; margin-top:2px;" cellpadding="0" cellspacing="0">
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