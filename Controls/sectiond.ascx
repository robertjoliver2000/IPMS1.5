<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionD" CodeFile="SectionD.ascx.cs" %>
<table class="def"">
	<tr class="ms-WPHeader">
		<td colspan="8" class="controltitle">D) Initiative Investment Governance Summary</td>
	</tr>
	<tr>
		<td colspan="8" height="5px"></td>
	</tr>
	<tr height="40" valign="middle">
		<td class="summarylabel" width="220px">IG APPROVAL COMMITTEE:</td>
		<td width="190px"><asp:DropDownList Runat="server" ID="ddlIGApprovalCommittee" CssClass="textselect" Width="170px"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="sectionD_rvIGApprovalCommitteeDDL" runat="server" ControlToValidate="ddlIGApprovalCommittee"
                ErrorMessage="Approval Committee must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                Width="1px">*</asp:RequiredFieldValidator></td>
		<td width="48"></td>
		<td class="summarylabel" width="220px">IG IDENTIFIER:</td>
		<td><asp:TextBox Runat="server" ID="txtIGIdentifier" ReadOnly="true" CssClass="textinput" Width="140px" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="sectionD_rvIGIdentifier" runat="server" ControlToValidate="txtIGIdentifier"
                ErrorMessage="IG Identifier must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                Width="1px">*</asp:RequiredFieldValidator></td>
		<td width="48"></td>
		<td class="summarylabel" width="220px">ALIGNED TO BUSINESS STRATEGY/STRATEGIES?
		</td>
		<td><asp:DropDownList Runat="server" ID="ddlAlignedToBusinessStrategy" CssClass="textselect" Width="140px"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="sectionD_rvAlignedToBusinessStrategyDDL" runat="server" ControlToValidate="ddlAlignedToBusinessStrategy"
                ErrorMessage="Aligned to Business Strategy must not be blank" InitialValue="0"
                ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
	</tr>
	<tr height="40" valign="middle">
		<td class="summarylabel" width="220px">IG APPROVAL DATE:</td>
        <td>
	        <table align="left" border="0" cellpadding="0" cellspacing="0">
	            <tr>
	                <td><asp:TextBox Runat="server" ID="txtIGApprovalDate" style="text-align: center;" CssClass="textinput" Width="100px"></asp:TextBox>
	                </td>
	                <td width="20px" align="center" ><a runat="server" id="lnkIGApprovalDate"><img src="Images/calendar.jpg" border="0"></a></td>
	                <td style="width: 21px">
	                <asp:RangeValidator ID="sectionD_rvIGApprovalDate" runat="server" ControlToValidate="txtIGApprovalDate" Text="*" MaximumValue="1/1/2020" 
	                     ErrorMessage="Approval Date incorrect date format" MinimumValue="1/1/1900" Type="Date" ValidationGroup="SubmitForReview"></asp:RangeValidator>
	                 <asp:RequiredFieldValidator ID="sectionD_rvIGApprovalDate2" runat="server" ControlToValidate="txtIGApprovalDate"
                        ErrorMessage="Approval Date must not be blank"  ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>
	                <asp:RangeValidator ID="sectionD_rvIGApprovalDateAllCases" runat="server" ControlToValidate="txtIGApprovalDate" Text="*" MaximumValue="1/1/2020" 
	                    MinimumValue="1/1/1900" Type="Date"></asp:RangeValidator>
	               </td>
	            </tr>
	            <tr>
	                <td valign="top"><font face="verdana, arial, helvetica, sans-serif" color="#333333" size="1"><em>dd/mm/yyyy</em></font></td>
	                <td></td>
	                <td style="width: 21px"></td>
	            </tr>
	        </table>
		</td>
		<td></td>
		<td class="summarylabel" width="220px">IG IMPACT CATEGORY:</td>
		<td><asp:DropDownList Runat="server" ID="ddlImpactCategory" CssClass="textselect" Width="173px"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="sectionD_rvImpactCategoryDDL" runat="server" ControlToValidate="ddlImpactCategory"
                ErrorMessage="IG Impact Category must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                Width="1px">*</asp:RequiredFieldValidator></td>
		<td></td>
		<td class="summarylabel" width="220px">FIRST TIME INITIATIVE?
		<td><asp:DropDownList Runat="server" ID="ddlFirstTimeInitiative" CssClass="textselect" Width="140px"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="sectionD_rvFirstTimeInitiativeDDL" runat="server" ControlToValidate="ddlFirstTimeInitiative"
                ErrorMessage="First Time Initiative must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                Width="1px">*</asp:RequiredFieldValidator></td>
	</tr>
	<tr height="40" valign="middle">
		<td class="summarylabel" width="220px">IG APPROVAL STATUS:</td>
		<%-- <td><asp:DropDownList Runat="server" ID="ddlIGApprovalStatus" CssClass="textselect" Width="180px"></asp:DropDownList></td> --%>
		<td width="190px">
		    <asp:TextBox ID="txtIGApprovalStatus" CssClass="textinput" ReadOnly="true" Width="170px" runat="server"></asp:TextBox>
		     <asp:RequiredFieldValidator ID="sectionD_rvIGApprovalStatus" runat="server" ControlToValidate="txtIGApprovalStatus"
                ErrorMessage="Approval Status must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                Width="1px">*</asp:RequiredFieldValidator>
		    <asp:HiddenField ID="txtIGApprovalStatusID" runat="server" />
		</td>
		<td></td>
		<td class="summarylabel" width="220px">GTO REVIEW LEVEL:</td>
		<td><asp:DropDownList Runat="server" ID="ddlGTOReviewLevel" CssClass="textselect" Width="172px"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="sectionD_rvGTOReviewLevelDDL" runat="server" ControlToValidate="ddlGTOReviewLevel"
                ErrorMessage="GTO Review Level must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                Width="1px">*</asp:RequiredFieldValidator></td>
		<td></td>
		<td class="summarylabel" width="220px">NON DUPLICATION OF EXISTING INITIATIVE?</td>
		<td><asp:DropDownList Runat="server" ID="ddlNonDuplication" CssClass="textselect" Width="140px"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="sectionD_rvNonDuplicationDDL" runat="server" ControlToValidate="ddlNonDuplication"
                ErrorMessage="Non duplication must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                Width="1px">*</asp:RequiredFieldValidator></td>
	</tr>
	<tr>
		<td colspan="8" height="10px"></td>
	</tr>
</table>
