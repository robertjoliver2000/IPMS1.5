<%@ Reference Control="~/Controls/sectionb_sponsorallocations.ascx" %>
<%@ Reference Control="~/Controls/sectionb_benefitsanalysis.ascx" %>
<%@ Reference Control="~/Controls/sectionb_profitlossanalysis.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SectionB_SponsorAllocations" Src="~/Controls/SectionB_SponsorAllocations.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SectionB_ProfitLossAnalysis" Src="~/Controls/SectionB_ProfitLossAnalysis.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SectionB_BenefitsAnalysis" Src="~/Controls/SectionB_BenefitsAnalysis.ascx" %>
<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionB" CodeFile="SectionB.ascx.cs" %>
<%@ Register Src="SectionB_ProgramDeliverables.ascx" TagName="SectionB_ProgramDeliverables" TagPrefix="uc2" %>
<table>
	<tr class="ms-WPHeader">
		<td colspan="3" class="controltitle">B) Initiative Summary: in M Euros</td>
	</tr>
	<tr>
		<td colspan="3" height="5"></td>
	</tr>
	<tr>
		<td colspan="3" >
            <uc1:SectionB_ProfitLossAnalysis id="ctlSectionB_ProfitLossAnalysis" runat="server" />
		</td>
	</tr>
	<tr>
		<td colspan="3" height="10"></td>
	</tr>
	<tr>
		<td colspan="3" >
            <uc1:SectionB_BenefitsAnalysis id="ctlSectionB_BenefitsAnalysis" runat="server" />
		</td>
	</tr>
	<tr>
		<td colspan="3" height="10"></td>
	</tr>
	<tr>
	    <td valign="top">
            <uc2:SectionB_ProgramDeliverables ID="ctlSectionB_ProgramDeliverables" runat="server" />
        </td>
        <td width="5px"></td>
		<td valign="top">
            <uc1:SectionB_SponsorAllocations id="ctlSectionB_SponsorAllocations" runat="server" />
		</td>
	</tr>
</table>
