<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.Admin_Period" CodeFile="Admin_Period.ascx.cs" %>
<table width="100%">
	<tr class="ms-WPHeader">
		<td colspan="4" class="controltitle">Period Maintenance</td>
	</tr>
</table>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
</table>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
	    <td align="left">
				<asp:repeater id="repeaterProduct" EnableViewState="False" runat="server" OnItemDataBound="repeaterProduct_ItemDataBound" OnItemCommand="repeaterProduct_ItemCommand">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr runat="server" id="HeaderID" height="22px">
							<td class="headcell" width="70" align="center">Year</td>
							<td class="headcell" colspan="12" width="110" align="right">Periods</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20" runat="server" id="RowID">
						 <td class="incell" align="left" width="70">
						        <table>
						            <tr>
						               <td><asp:ImageButton runat="server" ID="delYear" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"PeriodYear")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td>
						               <td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "PeriodYear")%></td>
						            </tr>
						       </table>
						    </td>   
	                    </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20"  runat="server" id="AlternateRowID">
						    <td class="alternateincell" align="left" width="70">
						        <table>
						            <tr>
						               <td><asp:ImageButton runat="server" ID="delYear" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"PeriodYear")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td>
						               <td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "PeriodYear")%></td>
						            </tr>
						       </table>
						    </td> 
	                    </tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
						</table>
					</FooterTemplate>
				</asp:repeater>
			<br>
			<asp:DropDownList Runat="server" ID="ddlYear" CssClass="textselect" Width="65"> </asp:DropDownList>
			&nbsp
			&nbsp
			<asp:button runat="server" ID="btnAddYear" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana"  Text="Add Year" Width="100" OnClick="btnAddYear_Click"/>
		
		</td>
		<td>
		
		</td>
		<td></td>
		<td></td>
	</tr>
</table>
<br>
