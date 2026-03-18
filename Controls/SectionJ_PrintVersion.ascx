<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SectionJ_PrintVersion.ascx.cs" Inherits="SectionJ_PrintVersion" %>

<style><!--
.def td { font-size:8px; } 
--></style>
<table class="def" width="100%">
	<tr class="ms-WPHeader">
		<td class="controltitle" colSpan="3">J) Initiative Financial BEN Reconciliation</td>
	</tr>
	<tr>
		<td colSpan="3" height="5"></td>
	</tr>
	<tr>
	    <td align="left">
				<asp:repeater id="repeaterProject" EnableViewState="False" runat="server" OnItemDataBound="repeaterProject_ItemDataBound">
					<HeaderTemplate>
					<table cellSpacing="0" cellPadding="2" style="border-collapse: collapse; border-color: #CCCCCC;">
						<tr height="20">
						    <td class="headcell" style="border-left: 1px solid #CCCCCC;  border-top: 1px solid #CCCCCC;" width="90"><asp:Label id="lblProjectID" runat="server"></asp:Label></td>
							<td class="headcell" style="border-top: 1px solid #CCCCCC; text-align:left;" width="175"><asp:Label id="lblProjectName" runat="server"></asp:Label></td>
							<td class="headcell" style="border-top: 1px solid #CCCCCC;" width="175"><asp:Label id="lblProjectDesc" runat="server"></asp:Label></td>
							<td class="headcell" style="border-top: 1px solid #CCCCCC;" width="175"><asp:Label id="lblProgramName" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;"><asp:Label id="lblProjectType" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;"><asp:Label id="lblIGAmount" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;"><asp:Label id="lblTotalEUR" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;"><asp:Label id="lblIGApproval" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;"><asp:Label id="lblTotalLocal" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;"><asp:Label id="lblBaseCurrency" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC;"><asp:Label id="lblFXRate" runat="server"></asp:Label></td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20">
						    <td class="incell"><%# DataBinder.Eval(Container.DataItem,"ExternalProjectID")%></td>
							<td class="incell"><%# DataBinder.Eval(Container.DataItem,"ProjectName")%></td>
							<td class="incell"><%# DataBinder.Eval(Container.DataItem,"ProjectDescription")%></td>
							<td class="incell"><%# DataBinder.Eval(Container.DataItem,"ProgramName")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"ProjectType")%></td>
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "IGAmountRequested", "{0:C}")%></td>
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "TotalPlanEUR", "{0:C}")%></td>						
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem,"PercentRequired").ToString()+" %"%></td>					
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "TotalPlanLocalCurrency", "{0:C}")%></td>	
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"BaseCurrency")%></td>	
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem,"FXRate")%></td>	
	                </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20">
						    <td class="alternateincell"><%# DataBinder.Eval(Container.DataItem,"ExternalProjectID")%></td>
							<td class="alternateincell"><%# DataBinder.Eval(Container.DataItem,"ProjectName")%></td>
							<td class="alternateincell"><%# DataBinder.Eval(Container.DataItem,"ProjectDescription")%></td>
							<td class="alternateincell"><%# DataBinder.Eval(Container.DataItem,"ProgramName")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"ProjectType")%></td>
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "IGAmountRequested", "{0:C}")%></td>
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "TotalPlanEUR", "{0:C}")%></td>						
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem,"PercentRequired").ToString()+" %"%></td>					
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "TotalPlanLocalCurrency","{0:C}")%></td>	
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"BaseCurrency")%></td>	
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem,"FXRate")%></td>	
						</tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
					    <tr height="20px">
					        <td colspan="5" class="emptycell" style="border-left: 1px solid #CCCCCC;  border-bottom: 1px solid #CCCCCC; background-color:#ffcc00; font-weight:bold;" ></td>
					        <td class="totalcell" align="right"><%# GetIGAmountRequested() %></td>
					        <td class="totalcell" align="right"><%# GetTotalPlan() %></td>
					        <td colspan="4" class="emptycell" style="border-right: 1px solid #CCCCCC;  border-bottom: 1px solid #CCCCCC; background-color:#ffcc00; font-weight:bold;"></td>
					    </tr>
						<tr>
						    <td class="empty" height="0px" colspan="11"></td>
						</tr>					
					</table>
					</FooterTemplate>
				</asp:repeater>
		</td>
	</tr>
</table>

