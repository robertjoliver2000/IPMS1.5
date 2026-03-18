<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_ScopeChanges_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_ScopeChanges_PrintVersion" %>
<table style="border: 1px solid #CCCCCC; width:100%;">
	<tr>
		<td xclass="sponsorallocationtitle" class="PIRTitle">Scope Changes</td>
	</tr>
	<!--
	<tr>
		<td height="5px">
		</td>
	</tr>
	-->
	<tr>
	    <td>
			<asp:repeater id="rptScopeChanges" EnableViewState="False" runat="server" OnItemDataBound="rptScopeChanges_ItemDataBound">
				<HeaderTemplate>
		            <table class="datatable" cellspacing="0" cellpadding="3" rules="all" style="width:100%;">
		            <colgroup>
		                <col class="incell" style="width:250px; text-align:left;"/>
		                <col class="incell" style="width:380px; text-align:left;"/>
		                <col class="incell" style="width:80px; text-align:center;"/>
		            </colgroup>
					<tr runat="Server" id="trHeader" style="height:2.5em;">
						<td class="headcell" style="border-left: 0px">Scope Change</td>
						<td class="headcell">Commentary</td>
						<td class="headcell" style="border-right: 0px">Status</td>
					</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr runat="Server" id="trItem">
						<td runat="Server" id="tdScopeChange">
						    <%# DataBinder.Eval(Container.DataItem,"ScopeChange")%>
					    </td>
						<td><%# DataBinder.Eval(Container.DataItem,"Commentary")%></td>
						<td runat="server" id="tdStatus" class="PIRMajorMinor"><%# DataBinder.Eval(Container.DataItem,"Status")%></td>
					</tr>
				</ItemTemplate>
				<FooterTemplate>
				    </table>
				</FooterTemplate>
            </asp:repeater>	    
	    </td>
	</tr>
</table>