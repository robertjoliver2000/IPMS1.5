<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionD_PrintVersion" CodeFile="SectionD_PrintVersion.ascx.cs" %>
<table class="def" width="100%">
	<tr class="ms-WPHeader">
		<td colspan="8" class="controltitle">D) Initiative Investment Governance Summary</td>
	</tr>
	<tr>
		<td colspan="8" height="10px"></td>
	</tr>
	<tr valign="middle">
		<td class="summarylabel" width="150px">IG APPROVAL COMMITTEE:</td>
		<td class="tablegreybg">
            <asp:Label ID="ddlIGApprovalCommittee" runat="server"></asp:Label></td>
		<td width="48px">&nbsp;</td>
		<td class="summarylabel" width="130px">IG IDENTIFIER:</td>
		<td class="tablegreybg" width="150px">
            <asp:Label ID="txtIGIdentifier" runat="server"></asp:Label></td>
		<td width="48px">&nbsp;</td>
		<td class="summarylabel" width="280px">ALIGNED TO BUSINESS STRATEGY/STRATEGIES?
		</td>
		<td class="tablegreybg">
            <asp:Label ID="ddlAlignedToBusinessStrategy" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colspan="8" height="7px"></td>
	</tr>
	<tr valign="middle">
		<td class="summarylabel" width="150px">IG APPROVAL DATE:</td>
        <td class="tablegreybg">
            <asp:Label ID="txtIGApprovalDate" runat="server"></asp:Label></td>
		<td></td>
		<td class="summarylabel" width="130px">IG IMPACT CATEGORY:</td>
		<td class="tablegreybg">
            <asp:Label ID="ddlImpactCategory" runat="server"></asp:Label></td>
		<td></td>
		<td class="summarylabel" width="280px">FIRST TIME INITIATIVE?
		<td class="tablegreybg" >
            <asp:Label ID="ddlFirstTimeInitiative" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colspan="8" height="7px"></td>
	</tr>
	<tr valign="middle">
		<td class="summarylabel" width="150px">IG APPROVAL STATUS:</td>
		<td class="tablegreybg">
            <asp:Label ID="ddlIGApprovalStatus" runat="server"></asp:Label></td>
		<td></td>
		<td class="summarylabel" width="130px">GTO REVIEW LEVEL:</td>
		<td class="tablegreybg">
            <asp:Label ID="ddlGTOReviewLevel" runat="server"></asp:Label></td>
		<td></td>
		<td class="summarylabel" width="280px">NON DUPLICATION OF EXISTING INITIATIVE?</td>
		<td class="tablegreybg">
            <asp:Label ID="ddlNonDuplication" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colspan="8" height="10px"></td>
	</tr>
</table>
