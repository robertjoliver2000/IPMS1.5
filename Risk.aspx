<%@ Page language="c#" Inherits="ProjectPortfolio.Risk" CodeFile="Risk.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title id="pageTitle" runat="server">Initiative Risk</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<BASE target="_self">
	</HEAD>
	<body >
		<form id="frmNewApp" method="post" runat="server">
			<table border="0">
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Risk Category</td>
					<td style="width: 10px"><asp:CustomValidator ID="rvType" runat="server" Text="*" ClientValidationFunction="validateType"></asp:CustomValidator></td>
					<td width="270"><asp:DropDownList Runat="server" ID="ddlRiskCateg" CssClass="textselect" Width="100%"></asp:DropDownList></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Calculated Risk %</td>
					<td style="width: 10px"><asp:RangeValidator ID="rvCalculatedRisk" runat="server" ControlToValidate="txtCalculatedRisk" MinimumValue="0" MaximumValue="100" Type="Double" >*</asp:RangeValidator></td>
					<td><asp:TextBox Runat="server" ID="txtCalculatedRisk" CssClass="textinput" Width="100%"></asp:TextBox></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Adjusted Risk %</td>
					<td style="width: 10px"><asp:RangeValidator ID="rvAdjustedRisk" runat="server" ControlToValidate="txtAdjustedRisk" MinimumValue="0" MaximumValue="100" Type="Double" >*</asp:RangeValidator></td>
					<td><asp:TextBox Runat="server" ID="txtAdjustedRisk" CssClass="textinput" Width="100%"></asp:TextBox></td>
				</tr>
				<tr>
				    <td colspan="4" height="20">
				</tr>
				<tr>
					<td height="20"></td>
					<td style="width: 102px"></td>
					<td style="width: 10px"></td>
					<td align="right">
						<table>
							<tr>
								<td><asp:Button id="btnOK" runat="server" Width="70" Text="OK" CssClass="def" OnClick="btnOK_Click"></asp:Button></td>
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

