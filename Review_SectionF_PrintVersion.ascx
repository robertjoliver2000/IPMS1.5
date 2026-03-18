<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_SectionF_PrintVersion.ascx.cs" Inherits="Controls_Review_SectionF_PrintVersion" %>

<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitle" width="900">F) Initiative Risk Assesment  All Amount in EUROs (not million EUROs)</td>
	</tr>
	<tr>
		<td colspan="5" height="20"></td>
	</tr>
	<tr>
	    <td colspan="5" align="left">
				<asp:repeater id="repeaterRisk" EnableViewState="False" runat="server" OnItemDataBound="repeaterRisk_ItemDataBound">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="4">
						<tr>
							<td class="headcell">Review History:</td>
							<td class="headcell" align="right">I) Current Review Date:</td>
							<td runat="server" id="tdCurrentReviewDate" class="headcell" align="center"></td>
							<td class="headcell" align="right">II) Last Review Date:</td>
							<td runat="server" id="tdLastReviewDate" class="headcell" align="center"></td>
					        <td class="emptynopadding" width="0px"></td>
						</tr>
						<tr>
							<td valign="bottom" colspan="2" class="headcell" width="270" align="left">Risk Category</td>
							<td class="headcell" width="115" align="center">Projected Over-run <br>/ (Under-run)<br> - enter € amount</td>
							<td class="empty" width="140" align="center"></td>
							<td valign="bottom" class="headcell" width="140" align="center">Calculated Risk %</td>
					        <td class="emptynopadding" width="0px"></td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20">
						     <td colspan="2" class="incell" align="left">    
						     <table>
						        <tr>
						        <td></td>
						        <td class="incell" align="left"><%# DataBinder.Eval(Container.DataItem, "RiskCategory")%></td>
						        </tr>
						     </table>
						     </td>
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "EurosAtRisk", "{0:C}")%></td>
							<td class="empty" align="right"></td>
						    <td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "CalculatedRisk")%></td>
					        <td class="emptynopadding" width="0px"></td>
				        </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20">
						    <td  colspan="2" class="alternateincell" align="left">    
						     <table>
						        <tr>
						        <td></td>
						        <td class="alternateincell" align="left"><%# DataBinder.Eval(Container.DataItem, "RiskCategory")%></td>
						        </tr>
						     </table>
						     </td>
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "EurosAtRisk", "{0:C}")%></td>
							<td class="empty" align="right"></td>
						    <td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "CalculatedRisk")%></td>
					        <td class="emptynopadding" width="0px"></td>
				        </tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
						 <tr>
					        <td colspan="2" class="emptycell" style="background-color:#ffcc00; font-weight:bold;" >Initiative Risk Totals</td>
					        <td class="totalcell" align="right"><%# GetRiskTotal(1) %></td>
							<td class="empty" align="right"></td>
					        <td class="totalcell" align="right"><%# GetRiskTotal(2)+" %" %></td>
					        <td class="emptynopadding" width="0px"></td>
						</tr>
						<tr>
						    <td class="empty" height="0px" colspan="25"></td>
						</tr>					
					</table>
					</FooterTemplate>
				</asp:repeater>
		</td>
	</tr>
	<tr height="10">
		<td colspan="5" style="height: 15px"></td>
	</tr>
	<tr>
	    <td colspan="5" class="summarylabel" width="270">1) Risks,Issues and Dependencies</td>
	</tr>
	<tr height="3">
		<td colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" class="tablegreybg">
            <asp:Label ID="txtRisksIssuesDeps" runat="server"></asp:Label></td>
	</tr>
	<tr height="10px">
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
	    <td colspan="5" class="summarylabel" width="270">2) Overall IG Coordinator Comment</td>
	</tr>
	<tr height="3">
		<td colspan="5" style="height: 1px"></td>
	</tr>
	<tr>
		<td colspan="5" class="tablegreybg">
            <asp:Label ID="txtOverallIGComment" runat="server"></asp:Label></td>
	</tr>
	<tr height="10px">
		<td height="10px" colspan="5"></td>
	</tr>
</table>