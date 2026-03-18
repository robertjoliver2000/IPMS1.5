<%@ Page language="c#" Inherits="ProjectPortfolio.Project" CodeFile="Project.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title id="pageTitle" runat="server">Project</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<BASE target="_self">
	</HEAD>
	<body>
		<form id="frmNewApp" method="post" runat="server">
			<table border="0">
			    <tr>
			        <td colspan="5" height="10px"></td>
			    </tr>
				<tr>
					<td></td>
					<td class="summarylabel">Project ID</td>
					<td>
					    <asp:RequiredFieldValidator ID="rqvProjectID" runat="server" Text="*"  Display="Dynamic" ControlToValidate="txtProjectID"></asp:RequiredFieldValidator>
					    <asp:RangeValidator ID="rvProjectID" runat="server"  Display="Dynamic" ControlToValidate="txtProjectID" MinimumValue="0" Type="Double" >*</asp:RangeValidator>
					</td>
					<td><asp:TextBox Runat="server" ID="txtProjectID" CssClass="textinput" Width="200"></asp:TextBox></td>
					<td></td>
				</tr>
				<tr>
				    <td colspan="5" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Project Name</td>
					<td><asp:RequiredFieldValidator ID="rvProjectName" runat="server" Text="*" ControlToValidate="txtProjectName"></asp:RequiredFieldValidator></td>
					<td><asp:TextBox Runat="server" ID="txtProjectName" CssClass="textinput" Width="200"></asp:TextBox></td>
					<td></td>
				</tr>
				<tr>
				    <td colspan="5" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Project Description</td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtProjectDescr" CssClass="textinput" Width="200" TextMode="MultiLine" Height="80"></asp:TextBox></td>
					<td></td>
				</tr>
				<tr>
				    <td colspan="5" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Program Name</td>
					<td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtProgramName"
                            Text="*"></asp:RequiredFieldValidator></td>
					<td><asp:TextBox Runat="server" ID="txtProgramName" CssClass="textInput" Width="200"></asp:TextBox></td>
					<td></td>
				</tr>
				<tr>
				    <td colspan="5" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Project Type</td>
					<td >
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlProjectType"
                            InitialValue="0" Text="*"></asp:RequiredFieldValidator></td>
					<td style="height: 21px"><asp:DropDownList Runat="server" ID="ddlProjectType" CssClass="textselect" Width="200"></asp:DropDownList></td>
					<td></td>
				</tr>
				<tr>
				    <td colspan="5" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">IG Amount Requested in Euros</td>
					<td>
					    <asp:RangeValidator ID="rvAmountRequested" runat="server" Display="Dynamic" ControlToValidate="txtAmountRequested" MinimumValue="0" Type="Double" >*</asp:RangeValidator>
					    <asp:RequiredFieldValidator ID="rqvAmountRequested"  Display="Dynamic" runat="server" ControlToValidate="txtAmountRequested">*</asp:RequiredFieldValidator>
					</td>
					<td><asp:TextBox Runat="server" ID="txtAmountRequested" CssClass="textinput" Width="200"></asp:TextBox></td>
					<td></td>
				</tr>
				<tr>
				    <td colspan="5" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel"><asp:Label id="lblTotalLocal" runat="server"></asp:Label></td>
					<td>
					    <asp:RangeValidator ID="rvTotalPlanLC" runat="server" Display="Dynamic" ControlToValidate="txtTotalPlanLC" MinimumValue="0" Type="Double" >*</asp:RangeValidator>
					    <asp:RequiredFieldValidator ID="rqvTotalPlanLC" runat="server" Display="Dynamic" ControlToValidate="txtTotalPlanLC">*</asp:RequiredFieldValidator>
				    </td>
					<td><asp:TextBox Runat="server" ID="txtTotalPlanLC" CssClass="textinput" Width="200"></asp:TextBox></td>
					<td></td>
				</tr>
				<tr>
				    <td colspan="5" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Base Currency (as per BEN project)</td>
					<td></td>
					<td><asp:DropDownList Runat="server" ID="ddlBaseCurrency" CssClass="textselect" Width="100%"></asp:DropDownList></td>
					<td></td>
				</tr>
				<tr>
				    <td colspan="5" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">FX Rate (for non-EURO projects)</td>
					<td><asp:RangeValidator ID="rvFXRate" runat="server" ControlToValidate="txtFXRate" MinimumValue="0" Type="Double" >*</asp:RangeValidator></td>
					<td><asp:TextBox Runat="server" ID="txtFXRate" CssClass="textinput" Width="200"></asp:TextBox></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="5" height="10"></td>
				<tr>
					<td height="20"></td>
					<td></td>
					<td></td>
					<td align="right">
						<table>
							<tr>
								<td><asp:Button id="btnOK" runat="server" Width="70" Text="OK" CssClass="def" OnClick="btnOK_Click"></asp:Button></td>
								<td width="20"></td>
								<td><INPUT class="def" style="WIDTH: 70px" onclick="window.close()" type="button" value="Cancel"></td>
							</tr>
						</table>
					</td>
					<td></td>
				</tr>
			<asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
            HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
            ShowMessageBox="True" ShowSummary="False" />
			</table>
		</form>
	</body>
</HTML>
