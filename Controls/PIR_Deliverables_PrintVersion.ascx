<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_Deliverables_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_Deliverables_PrintVersion" %>
<table style="border: 1px solid #CCCCCC; width:100%;">
	<tr>
		<td class="PIRTitle">Major Program Deliverables</td>
	</tr>
	<tr>
	    <td>
			<asp:repeater id="rptProgramDeliverables" EnableViewState="False" runat="server" OnItemDataBound="rptProgramDeliverables_ItemDataBound">
				<HeaderTemplate>
		            <table class="datatable" cellspacing="0" cellpadding="3" rules="all" style="width:100%;">
		            <colgroup>
		                <col style="width:380px; text-align:left;" xclass="incell" />
		                <col style="width:250px; text-align:left;" xclass="incell" />
		                <col style="width:80px; text-align:center;" xclass="incell" />
		                <col style="width:80px; text-align:center;" xclass="incell" />
		                <col style="width:80px; text-align:center;" xclass="incell" />
		                <col style="width:80px; text-align:center;" xclass="incell" />
		            </colgroup>
					<tr runat="Server" id="trHeader" style="height:2.5em;">
						<td class="headcell">Key Deliverables</td>
						<td class="headcell">Commentary</td>
						<td class="headcell">Status</td>
						<td class="headcell">Plan</td>
						<td class="headcell">Actual</td>
						<td class="headcell">Variance<br />(in days)</td>
					</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr runat="Server" id="trItem">
						<td runat="Server" id="tdName">
						    <%# DataBinder.Eval(Container.DataItem,"Name")%></a>
					    </td>
						<td><%# DataBinder.Eval(Container.DataItem,"PIRCommentary")%></td>
						<td runat="server" id="tdStatus" class="PIRRagText"><%# DataBinder.Eval(Container.DataItem,"PIRStatus")%></td>
						<td><%# DataBinder.Eval(Container.DataItem,"PIRPlanDate", "{0:d}")%></td>
						<td><%# DataBinder.Eval(Container.DataItem,"PIRActualDate", "{0:d}")%></td>
						<td><%# DataBinder.Eval(Container.DataItem,"PIRDateVariance", "{0}")%></td>
					</tr>
				</ItemTemplate>
				<FooterTemplate>
				    </table>
				</FooterTemplate>
            </asp:repeater>	    
	    </td>
	</tr>
</table>