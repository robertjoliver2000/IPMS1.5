<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionI_PrintVersion" CodeFile="SectionI_PrintVersion.ascx.cs" %>

<table class="def" cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr class="ms-WPHeader">
		<td class="controltitle" width="100%">I) Initiative Risk Assesment  All Amount in EUROs(not million EUROs)</td>
	</tr>
	<tr>
		<td height="10px"></td>
	</tr>
	<tr>
	    <td align="left">
				<asp:repeater id="repeaterRisk" EnableViewState="False" runat="server">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr height="20">
							<td class="headcell" width="270" align="center">Risk Category</td>
							<td class="headcell" width="115" align="center">Calculated Risk %</td>
							<td class="headcell" width="115" align="center">Adjusted Risk %</td>
							<td class="headcell" width="140" align="center">€'s at Risk</td>
							<td class="headcell" width="110" align="center">Probability</td>
					        <td class="emptynopadding" width="0px"></td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20">
						     <td class="incell" align="left">    
                                <%# DataBinder.Eval(Container.DataItem, "RiskCategory")%>
						     </td>
						    <td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "CalculatedRisk")%></td>
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "AdjustedRisk")%></td>
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "EurosAtRisk", "{0:C}")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "Probability")%></td>
					        <td class="emptynopadding" width="0px"></td>
				        </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20">
						    <td class="alternateincell" align="left">    
                                <%# DataBinder.Eval(Container.DataItem, "RiskCategory")%>
						     </td>
						    <td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "CalculatedRisk")%></td>
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "AdjustedRisk")%></td>
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "EurosAtRisk", "{0:C}")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "Probability")%></td>
					        <td class="emptynopadding" width="0px"></td>
				        </tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
						 <tr>
					        <td class="emptycell" style="background-color:#ffcc00; font-weight:bold;" >Initiative Risk Totals</td>
					        <td class="totalcell" align="right"><%# GetRiskTotal(1)+" %" %></td>
					        <td class="totalcell" align="right"><%# GetRiskTotal(2)+" %" %></td>
					        <td class="totalcell" align="right"><%# GetRiskTotal(3) %></td>
					        <td class="totalcell" align="center"><%# GetRiskTotal(4) %></td>
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
	<tr height="10px">
		<td height="10px"></td>
	</tr>
	<tr>
	    <td class="summarylabel" width="270">1) Risks,Issues and Dependencies</td>
	</tr>
	<tr height="3">
		<td ></td>
	</tr>
	<tr>
		<td colspan="4" class="tablegreybg">
            <asp:Label ID="txtRisksIssuesDeps" runat="server"></asp:Label></td>
	</tr>
	<tr height="10px">
		<td height="10px"></td>
	</tr>
	<tr>
	    <td class="summarylabel" width="270">2) Overall IG Cordinator Comment</td>
	</tr>
	<tr height="3">
		<td ></td>
	</tr>
	<tr>
		<td class="tablegreybg">
            <asp:Label ID="txtOverallIGComment" runat="server"></asp:Label></td>
	</tr>
	<tr height="10px">
		<td height="10px"></td>
	</tr>


</table>
