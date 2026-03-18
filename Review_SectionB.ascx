<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_SectionB.ascx.cs" Inherits="ProjectPortfolio.Controls.Review_SectionB" %>
<%@ Register Src="Review_SectionB_ProfitLossAnalysis.ascx" TagName="Review_SectionB_ProfitLossAnalysis"
    TagPrefix="uc4" %>
<%@ Register Src="Review_SectionB_ProgramDeliverables.ascx" TagName="Review_SectionB_ProgramDeliverables"
    TagPrefix="uc2" %>
<%@ Register Src="Review_SectionB_SponsorAllocations.ascx" TagName="Review_SectionB_SponsorAllocations"
    TagPrefix="uc3" %>
<%@ Register Src="Review_SectionB_BenefitsAnalysis.ascx" TagName="Review_SectionB_BenefitsAnalysis"
    TagPrefix="uc1" %>
<table width="1200px">
	<tr class="ms-WPHeader">
		<td colspan="3" class="controltitle">B) Initiative Summary: in M Euros</td>
	</tr>
	<tr>
		<td colspan="3" height="5"></td>
	</tr>
	<tr>
		<td colspan="3" >
            <uc4:Review_SectionB_ProfitLossAnalysis ID="ctlReview_SectionB_ProfitLossAnalysis"
                runat="server" />
		</td>
	</tr>
	<tr>
		<td colspan="3" height="20"></td>
	</tr>
	<tr>
		<td colspan="3" >
            <uc1:Review_SectionB_BenefitsAnalysis ID="ctlReview_SectionB_BenefitsAnalysis" runat="server" />
		</td>
	</tr>
	<tr>
	    <td colspan="3" height="10px"></td>
	</tr>
	<tr>
	    <td valign="top">
            <uc2:Review_SectionB_ProgramDeliverables ID="ctlReview_SectionB_ProgramDeliverables"
                runat="server" />
        </td>
        <td width="5px"></td>
		<td valign="top">
            <uc3:Review_SectionB_SponsorAllocations ID="ctlReview_SectionB_SponsorAllocations"
                runat="server" />
		</td>
	</tr>
</table>