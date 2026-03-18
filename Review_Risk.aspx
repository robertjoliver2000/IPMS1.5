<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Review_Risk.aspx.cs" Inherits="Review_Risk" %>
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
					<td width="10"><asp:CustomValidator ID="rvType" runat="server" Text="*" ClientValidationFunction="validateType"></asp:CustomValidator></td>
					<td width="270"><asp:DropDownList Runat="server" ID="ddlRiskCateg" CssClass="textselect" Width="100%"></asp:DropDownList></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Projected Over-run (Under-run) in Euros</td>
					<td width="10"><asp:RangeValidator ID="rvCalculatedRisk" runat="server" ControlToValidate="txtProjectedOverRun" MinimumValue="0" Type="Double" >*</asp:RangeValidator></td>
					<td><asp:TextBox Runat="server" ID="txtProjectedOverRun" CssClass="textinput" Width="100%"></asp:TextBox></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Calculated Risk %</td>
					<td width="10"><asp:RangeValidator ID="rvAdjustedRisk" runat="server" ControlToValidate="txtCalculatedRisk" MinimumValue="0" MaximumValue="100" Type="Double" >*</asp:RangeValidator></td>
					<td><asp:TextBox Runat="server" ID="txtCalculatedRisk" CssClass="textinput" Width="100%"></asp:TextBox></td>
				</tr>
				<tr>
				    <td colspan="4" height="20">
				</tr>
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
				</tr>
			</table>
		    <asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
            HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
            ShowMessageBox="True" ShowSummary="False" />	
		</form>
	</body>
</HTML>

