<%@ Page language="c#" Inherits="ProjectPortfolio.Impact" CodeFile="Impact.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title id="pageTitle" runat="server">Financial Impact of Non-Compliant Applications</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<BASE target="_self">
	</HEAD>
	<body>
		<form id="frmNewApp" method="post" runat="server">
			<table border="0" runat="server" id="TableID">
				<tr>
					<td></td>
					<td class="summarylabel" width="70">Non Compliance Type</td>
					<td width="30"></td>
					<td><asp:DropDownList Runat="server" ID="ddlNonComplianceType" CssClass="textselect" Width="100%"></asp:DropDownList></td>
				</tr>
				<tr>
				    <td colspan="4" height="4"> </td>
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Agreed Alternative</td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtAgreedAlternative" CssClass="textinput" Width="200"></asp:TextBox></td>
				</tr>
				<tr>
				    <td colspan="4" height="4"> </td>
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">CTB/RTB</td>
					<td></td>
					<td><asp:DropDownList Runat="server" ID="ddlCTBRTB" CssClass="textselect" Width="100%"></asp:DropDownList></td>
				</tr>
				<tr>
				    <td colspan="4" style="height: 4px"> </td>
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">CIO/IES</td>
					<td></td>
					<td><asp:DropDownList Runat="server" ID="ddlCIOCT0" CssClass="textselect" Width="100%"></asp:DropDownList></td>
				</tr>
				<tr>
				    <td colspan="4" height="4"></td>
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
		</form>
	</body>
</HTML>

