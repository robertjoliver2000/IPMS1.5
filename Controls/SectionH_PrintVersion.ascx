<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionH_PrintVersion" CodeFile="SectionH_PrintVersion.ascx.cs" %>


<table class="def" cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr class="ms-WPHeader">
		<td class="controltitle" width="100%">H) IT policy and Standard Compliance</td>
	</tr>
	<tr>
		<td height="10px"></td>
	</tr>
	<tr>
	    <td align="left" width="100%">
			<asp:repeater id="repeaterITPolicy" EnableViewState="False" runat="server" OnItemDataBound="repeaterITPolicy_ItemDataBound">
					<HeaderTemplate>
					    <table class="datatable" cellSpacing="0" cellPadding="0" width="100%">
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20px">
					        <td height="20px" class="incell" align="left" width="700" runat="server" id="FirstCellID"><%# DataBinder.Eval(Container.DataItem, "ITPolicyText")%></td>
					        <td class="incell" runat="server" valign="middle" id="CellID" width="20%" align="center">
					        </td>
					    </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
					    <tr height="20px">
						    <td height="20px" class="alternateincell" align="left" width="700" runat="server" id="AlternateFirstCellID"><%# DataBinder.Eval(Container.DataItem, "ITPolicyText")%></td>
					        <td class="alternateincell" runat="server" valign="middle" id="AlternateCellID" width="20%" align="center">
					        </td>
					      </tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
					    </table>
					</FooterTemplate>
				</asp:repeater>
		</td>
	</tr>
</table>

<br>
