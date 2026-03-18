<%@ Page language="c#" Inherits="ProjectPortfolio.Product" CodeFile="Product.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title id="pageTitle" runat="server">Additional Spend and Remediation for Non-Compliant Applications</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<BASE target="_self">
	</HEAD>
	<body>
		<form id="frmNewApp" method="post" runat="server">
			<table border="0">
				<tr>
					<td></td>
					<td class="summarylabel" width="100">Product Name</td>
					<td><asp:RequiredFieldValidator ID="rvProductName" runat="server" Text="*" ControlToValidate="txtProductName"></asp:RequiredFieldValidator></td>
					<td><asp:TextBox Runat="server" ID="txtProductName" CssClass="textinput" Width="200"></asp:TextBox></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Technology Vendor</td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtTVendor" CssClass="textinput" Width="200"></asp:TextBox></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Product Type</td>
					<td ><asp:CustomValidator ID="rvType" runat="server" Text="*" ClientValidationFunction="validateType"></asp:CustomValidator></td>
					<td><asp:DropDownList Runat="server" ID="ddlProductType" CssClass="textselect" Width="100%"></asp:DropDownList></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">CTB/RTB</td>
					<td></td>
					<td><asp:DropDownList Runat="server" ID="ddlCTBRTB" CssClass="textselect" Width="100%"></asp:DropDownList></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">ITA/ITI</td>
					<td></td>
					<td><asp:DropDownList Runat="server" ID="ddlCIOIES" CssClass="textselect" Width="100%"></asp:DropDownList></td>
				</tr>
				<tr>
				    <td colspan="4" height="4">
				</tr>
				<tr>
				    <td> </td>
				    <td align="left" colspan="3">
			            <asp:repeater id="repeaterPeriods" EnableViewState="False" runat="server" OnItemDataBound="repeaterPeriods_ItemDataBound">
					        <HeaderTemplate>
					            <table class="datatable" cellSpacing="0" cellPadding="0" style="border:0px">
					        </HeaderTemplate>
					        <ItemTemplate>
						        <tr height="25" runat="server" id="RowID">
						             <td class="summarylabel" width="70"><%# DataBinder.Eval(Container.DataItem, "Name")%></td>
						         </tr>
					        </ItemTemplate>
					        <AlternatingItemTemplate>
					            <tr height="25" runat="server" id="AlternateRowID">
						             <td class="summarylabel" width="70"><%# DataBinder.Eval(Container.DataItem, "Name")%></td>
						         </tr>
					        </AlternatingItemTemplate>
					        <FooterTemplate>
					            </table>
					        </FooterTemplate>
				    </asp:repeater>
		            </td>
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Remediation</td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtRemediation" CssClass="textinput" Width="200" TextMode="MultiLine" Height="40px"></asp:TextBox></td>
				</tr>
				<tr>
					<td colspan="4" height="10"></td>
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
				<asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
            HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
            ShowMessageBox="True" ShowSummary="False" />
			</table>
		</form>
	</body>
</HTML>

