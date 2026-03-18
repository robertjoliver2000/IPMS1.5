<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SectionB_ProgramDeliverables_PrintVersion.ascx.cs" Inherits="Controls_SectionB_ProgramDeliverables_PrintVersion" %>

<table cellpadding="0" cellspacing="0">
    <tr>
        <td runat="Server" id="tdBigTitle" height="16px" class="analysisheadcell" style="text-align: center; font-size:8px; border: 1px solid #CCCCCC; ">
           MAJOR PROGRAM DELIVERABLES</td>
    </tr>
	<tr>
		<td height="5px">
		</td>
	</tr>
	<tr>
	    <td>
			<asp:repeater id="rptProgramDeliverables" EnableViewState="False" runat="server" OnItemDataBound="rptProgramDeliverables_ItemDataBound" OnItemCommand="rptProgramDeliverables_ItemCommand">
				<HeaderTemplate>
		            <table class="datatable" cellSpacing="0" cellPadding="3" width="100%" height="100%">
					<tr runat="Server" id="trHeader">
						<td class="headcell" width="398px" align="left" style="border-left: 0px">Key Deliverables</td>
						<td class="headcell" width="80px" align="center">Due Date</td>
						<td class="headcell" width="80px" align="center">Cost (€M) </td>
						<td class="headcell" width="250px" align="left" style="border-right: 0px">Affected Applications</td>
					</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr runat="Server" id="trItem">
					    <td id="tdName" runat="server" class="incell" width="398px" align="left"><%# DataBinder.Eval(Container.DataItem,"Name")%>&nbsp;</td>
						<td class="incell" width="80px" align="center"><%# DataBinder.Eval(Container.DataItem,"DueDate", "{0:d}")%>&nbsp;</td>
						<td class="incell" width="80px" align="right"><%# DataBinder.Eval(Container.DataItem,"Cost", "{0:N2}")%>&nbsp;</td>
						<td class="incell" width="250px" align="left"><%# DataBinder.Eval(Container.DataItem,"AffectedApplications")%>&nbsp;</td>
					</tr>
				</ItemTemplate>
				<AlternatingItemTemplate>
					<tr runat="Server" id="trItem">
						<td id="tdName" runat="server" class="alternateincell" width="398px" align="left"><%# DataBinder.Eval(Container.DataItem,"Name")%>&nbsp;</td>
						<td class="alternateincell" width="80px" align="center"><%# DataBinder.Eval(Container.DataItem,"DueDate", "{0:d}")%>&nbsp;</td>
						<td class="alternateincell" width="80px" align="right"><%# DataBinder.Eval(Container.DataItem,"Cost", "{0:N2}")%>&nbsp;</td>
						<td class="alternateincell" width="250px" align="left"><%# DataBinder.Eval(Container.DataItem,"AffectedApplications")%>&nbsp;</td>
					</tr>
                </AlternatingItemTemplate>	
                <FooterTemplate>
					<tr runat="Server" id="trTotal">
						<td class="totalcell">Total Cost</td>
						<td class="totalcell"></td>
						<td class="totalcell" runat="server" id="tdTotalCost" align="right"></td>
						<td class="totalcell"></td>
					</tr>
					<tr>
					    <td class="empty" height="0px" colspan="6"></td>
					</tr>					
        			</table>
                </FooterTemplate>			
            </asp:repeater>	    
	    </td>
	</tr>
	<tr height="20" valign="middle">
	    <td>
	    </td>
	</tr>	
</table>