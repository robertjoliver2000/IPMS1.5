<%@ Page language="c#" Inherits="ProjectPortfolio.NewInitiative" CodeFile="NewInitiative.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	
	<HEAD>
		<title id="pageTitle" runat="server">New Initiative</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<BASE target="_self">
	</HEAD>
	<body >
		<form id="frmNewInitiative" method="post" runat="server">
			<table border="0" id="TABLE1">
				<tr>
				    <td colspan="4" height="10px"></td>
				</tr>
				<tr>
					<td ></td>
					<td class="summarylabel" width="200">Initiative Name</td>
					<td><asp:RequiredFieldValidator ID="rvAdminIGName" runat="server" Text="*" ControlToValidate="txtIGName"></asp:RequiredFieldValidator></td>
					<td style="width: 203px">
					    <asp:TextBox Runat="server" ID="txtIGName" CssClass="textinput" Width="200"></asp:Textbox>
					</td>
		             <td width="20">	                
		             </td>
				</tr>
				<tr>
					<td ></td>
					<td class="summarylabel" width="200">Business Area Code</td>
					<td><asp:RequiredFieldValidator ID="rvAdminBusinessAreaCode" runat="server" Text="*" ControlToValidate="txtBusinessAreaCode"></asp:RequiredFieldValidator></td>
					<td style="width: 203px">
					    <asp:TextBox Runat="server" ID="txtBusinessAreaCode" CssClass="textinput" Width="200"></asp:Textbox>
					</td>
		             <td width="20">	                
		             </td>
				</tr>
				<tr>
					<td ></td>
					<td class="summarylabel" width="200">IG Identifier Code</td>
					<td><asp:RequiredFieldValidator ID="rvAdminIGIdentifierCode" runat="server" Text="*" ControlToValidate="txtIGIdentifierCode"></asp:RequiredFieldValidator></td>
					<td style="width: 203px">
					    <asp:TextBox Runat="server" ID="txtIGIdentifierCode" CssClass="textinput" Width="200"></asp:Textbox>
					</td>
		             <td width="20">	                
		             </td>
				</tr>
				<tr>
					<td ></td>
					<td class="summarylabel" width="200">Approval Committee</td>
					<td></td>
					<td style="width: 203px">
					    <asp:DropDownList Runat="server" ID="ddlApprovalCommittee" CssClass="textinput" Width="200"></asp:DropDownList>
					</td>
		             <td width="20">	                
		             </td>
				</tr>
				<tr>
					<td ></td>
					<td class="summarylabel" width="200">Year of the Next Approval</td>
					<td></td>
					<td style="width: 203px">
					    <asp:DropDownList Runat="server" ID="ddlPeriod" CssClass="textinput" Width="200"></asp:DropDownList>
					</td>
		             <td width="20">	                
		             </td>
				</tr>
				<tr>
					<td ></td>
					<td class="summarylabel" width="200">Initial IG Approval Status</td>
					<td></td>
					<td style="width: 203px">
					    <asp:DropDownList Runat="server" ID="ddlStatus" CssClass="textinput" Width="200"></asp:DropDownList>
					</td>
		             <td width="20">	                
		             </td>
				</tr>
				<tr>
					<td colspan="4" height="10"></td>
				<tr>
					<td height="20"></td>
					<td></td>
					<td></td>
					<td align="right" style="width: 203px">
						<table>
							<tr>
								<td><asp:Button id="btnOK" runat="server" Width="70" Text="OK" CssClass="def" onclick="btnOK_Click"></asp:Button></td>
								<td width="20"></td>
								<td><INPUT class="def" style="WIDTH: 70px" onclick="window.close()" type="button" value="Cancel"></td>
							</tr>
						</table>
					</td>
				</tr>
				<asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
                HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
                ShowMessageBox="True" ShowSummary="False" />
			</table>
		</form>
	</body>
</HTML>
