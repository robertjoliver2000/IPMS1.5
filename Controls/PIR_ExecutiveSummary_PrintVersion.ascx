<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_ExecutiveSummary_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_ExecutiveSummary_PrintVersion" %>
<%@ Register Src="Status_DDL_PrintVersion.ascx" TagName="Status_DDL" TagPrefix="uc2" %>
<div style="border:solid 1px #cccccc; width:280mm; padding:0px; margin:0px; xheight:170mm;">
<table style="width:100%; margin:0px;" cellpadding="0" cellspacing="0"><tr class="ms-WPHeader"><td class="controltitle">Executive Summary</td></tr></table>
<div style="xborder-style:none none solid none; border-width:1px; border-color:black; background-color:#dddddd; padding:2px;">
<table style="width:278mm;" class="PIR_Executive_Header">
    <colgroup>
        <col style="width:30mm;" />
        <col style="width:67mm;" />
        <col style="width:30mm;" />
        <col style="width:67mm;" />
        <col style="width:15mm;" />
        <col style="width:15mm;" />
        <col style="width:22mm;" />
    </colgroup>
    <tr style="vertical-align:top;">
        <td>
            Initiative Name:
        </td>
        <td>
            <asp:Label ID="txtName" runat="server"></asp:Label></td>
        <td>
            IG Impact Category:</td>
        <td>
            <asp:Label ID="ddlImpactCategory" runat="server"></asp:Label>
		</td>
        <td style="text-align: right;">
            Spend</td>
        <td style="text-align: right;">
            Plan:</td>
        <td style="text-align: right;">
            <asp:Label ID="lblSpendPlanned" runat="server" Text="0.00"></asp:Label></td>
    </tr>
    <tr style="vertical-align:top;">
        <td class="summarylabel">
            Business Sponsor Name:
        </td>
        <td>
            <span style="display:inline-block; vertical-align:top;"><asp:Label ID="txtBusinessSponsorName" runat="server"
                ></asp:Label>
            </span>
        </td>
        <td class="summarylabel">
            Start Date:</td>
        <td>
			<asp:Label ID="txtPIRStartDate" runat="Server" Style="text-align: center"
				></asp:Label>
        </td>
        <td>
        </td>
        <td class="summarylabel" style="text-align: right;">
            Actual:</td>
        <td style="text-align: right;">
            <asp:Label ID="lblSpendActual" runat="server" Text="0.00"></asp:Label></td>
    </tr>
    <tr style="vertical-align:top;">
        <td class="summarylabel">
            GTO Initiative Manager:
        </td>
        <td>
            <span style="display:inline-block; vertical-align:top;"><asp:Label ID="txtGTOInitiativeManager" runat="server"
                ></asp:Label>
            </span>
        </td>
        <td class="summarylabel">
            End Date:</td>
        <td>
			<asp:Label ID="txtPIREndDate" runat="server" Style="text-align: center"
				></asp:Label>
        </td>
        <td>
        </td>
        <td class="summarylabel" style="text-align: right;">
            Var:</td>
        <td style="text-align: right;">
            <asp:Label ID="lblSpendVariance" runat="server" Text="0%"></asp:Label></td>
    </tr>
    <tr style="vertical-align:top;">
        <td />
        <td />
        <td />
        <td />
        <td />
        <td class="summarylabel" style="text-align: right;">
            ROI:</td>
        <td style="text-align: right;">
            <asp:Label ID="lblROI" runat="server" Text="0.00"></asp:Label></td>
    </tr>
</table>
</div>
<table style="padding:2px; margin-left:-2px; xmargin-right: -5px; width:279mm;">
<tr style="background-color:White;">
    <td>
        <table cellpadding="0" cellspacing="0" width="100%" style="margin:0px;">
            <colgroup><col style="width:35mm;" /><col /></colgroup>
            <tr style="vertical-align:bottom;">
                <td style="text-align:left; font-size:8pt; font-weight:bold; vertical-align:top;">Overall Status:&nbsp;<uc2:Status_DDL ID="sddlPIRStatus" runat="server" CssClass="PIRStatus"/></td>
                <td><asp:Label ID="txtPPRComments" runat="server" style="display:block; height:20px;" CssClass="tablegreybg"></asp:Label></td>
            </tr>
        </table>
    </td>
</tr>
<tr><td><span class="PIR_Section_Header">Initiative Business Drivers</span></td></tr>
<tr><td><asp:Label ID="txtInitiativeBusinessDrivers" runat="server" style="display:block;" CssClass="tablegreybg"></asp:Label></td></tr>
<tr><td><span class="PIR_Section_Header">Initiative Scope &amp; Objectives</span></td></tr>
<tr><td><asp:Label ID="txtInitiativeScopeAndObjectives" runat="server" style="display:block;" CssClass="tablegreybg"></asp:Label></td></tr>
<tr><td><span class="PIR_Section_Header">Initiative Benefit Calculation / Justification</span></td></tr>
<tr><td><asp:Label ID="txtInitiativeBenefitCalculation" runat="server" style="display:block;" CssClass="tablegreybg"></asp:Label></td></tr>
<tr><td><span class="PIR_Section_Header">Key Successes, New Opportunities, Innovation and Additional Benefits:</span></td></tr>
<tr><td><asp:Label ID="txtPIRSuccesses" runat="server" style="display:block;" CssClass="tablegreybg"></asp:Label></td></tr>
<tr><td><span class="PIR_Section_Header">Issues / Lessons Learned:</span></td></tr>
<tr><td style="height: 21px"><asp:Label ID="txtPIRIssues" runat="server" style="display:block;" CssClass="tablegreybg"></asp:Label></td></tr>
</table>
</div>
<br />