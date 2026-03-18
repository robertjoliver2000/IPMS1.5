<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionH" CodeFile="SectionH.ascx.cs" %>

<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitle" width="1015px">H) IT policy and Standard Compliance</td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
	    <td align="left">
			<asp:repeater id="repeaterITPolicy" EnableViewState="False" runat="server" OnItemDataBound="repeaterITPolicy_ItemDataBound">
					<HeaderTemplate>
					    <table class="datatable" cellSpacing="0" cellPadding="0">
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="25">
					        <td class="incell" align="left" width="700" runat="server" id="FirstCellID"><%# DataBinder.Eval(Container.DataItem, "ITPolicyText")%></td>
					        <td class="incell" runat="server" id="CellID" width="200" align="center">
					        </td>
					    </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
					    <tr height="25">
						    <td class="alternateincell" align="left" width="700"  runat="server" id="AlternateFirstCellID"><%# DataBinder.Eval(Container.DataItem, "ITPolicyText")%></td>
					        <td class="alternateincell" runat="server" id="AlternateCellID" width="200" align="center">
					        </td>
					      </tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
					    </table>
					</FooterTemplate>
				</asp:repeater>
		</td>
		<td></td>
		<td></td>
		<td><td>
	</tr>
	
</table>
