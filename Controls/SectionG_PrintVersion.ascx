<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionG_PrintVersion" CodeFile="SectionG_PrintVersion.ascx.cs" %>

<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitle" style="height: 19px">G) ITA Conformity</td>
	</tr>
	<tr>
		<td colspan="5" style="height: 15px"></td>
	</tr>
	<tr>
		<td class="summarylabel" width="250px">ITA ARCHITECTURE APPROVER:
		</td>
		<td class="tablegreybg" width="100px">
            <asp:Label ID="txtCIOArchApprover" runat="server"></asp:Label>
            <!--
            <a runat="server" ID="hRefCIOArchApproverID"></a>
            <asp:HiddenField runat="server" id="hiddenCIOArchApprover"></asp:HiddenField>
            -->
         </td>
        <td class="summarylabel">
        </td>
		<td class="summarylabel" width="250px">ITA ARCHITECTURE - APPROVAL DATE:
		</td>
		<td class="tablegreybg" width="100px">
            <asp:Label ID="txtCIOArchApDate" runat="server"></asp:Label>
        </td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
		<td class="summarylabel" >Uses Approved 3rd party Software?</td>
		<td class="tablegreybg">
            &nbsp;<asp:Label ID="ddlUsesAproved3rdParty" runat="server"></asp:Label></td>
		<td width="50"></td>
		<td class="summarylabel">Application Architecture(Roadmap)compliant?
		</td>
		<td class="tablegreybg">
            &nbsp;<asp:Label ID="ddlApplicationArchCompliant" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
		<td class="summarylabel" >Technical Architecture compliant?</td>
		<td class="tablegreybg">
            &nbsp;<asp:Label ID="ddlTechnicalArchCompliant" runat="server"></asp:Label></td>
		<td width="50"></td>
		<td class="summarylabel" >Technical Architecture requirement satisfied?
		</td>
		<td class="tablegreybg">
            &nbsp;<asp:Label ID="ddlTechnicalArchSatisfied" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
		<td class="summarylabel">Business Architecture Information provided?</td>
		<td class="tablegreybg">
            &nbsp;<asp:Label ID="ddlBusinessArchInfo" runat="server"></asp:Label></td>
		<td width="50"></td>
		<td class="summarylabel">Development Architecture compliant?
		</td>
		<td class="tablegreybg">
            &nbsp;<asp:Label ID="ddlDevelopmentArchCompl" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
		<td class="summarylabel" >Approved by Corporate and/or Business Unit Architecture Comittee (CIO)?</td>
		<td class="tablegreybg">
            &nbsp;<asp:Label ID="txtApprovedByCorporate" runat="server"></asp:Label></td>
		<td width="50"></td>
		<td>
		    <asp:Label Runat="server" ID="lblErr" Width="100%" Font-Bold="True" BorderStyle="None" ForeColor="Red" Visible="False">Initiative is not fully compliant - please complete section below.</asp:Label>
	   </td>				
	</tr>
</table>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitlesmall">Justification for Deviation from GTO Blue Print / Other Comments</td>
	</tr>
	<tr height="5">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td colspan="5" class="tablegreybg" width="900px">
            <asp:Label ID="txtJustificationForDeviation" runat="server"></asp:Label></td>
	</tr>
</table>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitlesmall">Financial impact of Non-Compliant Applications - Exceptions Only</td>
	</tr>
	<tr height="5">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td width="0px"></td>
	    <td align="left">
			    <asp:repeater id="repeaterImpact" EnableViewState="False" runat="server" OnItemDataBound="repeaterImpact_ItemDataBound">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr height="20" runat="server" id="HeaderID">
							<td class="headcell" width="180" align="left">Non-compliance Type</td>
							<td class="headcell" width="140" align="center">Agreed Alternative</td>
							<td class="headcell" width="50" align="center">CTB/RTB</td>
							<td class="headcell" width="50" align="center">ITI/ITA</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="RowID">
							<td class="incell" align="left">
                                <%# DataBinder.Eval(Container.DataItem, "NonComplianceType")%>
							 </td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "AgreedAlternative")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "CTB_RTB")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "CIO_CTO")%></td>
	                </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20" runat="server" id="AlternateRowID">
						    <td class="alternateincell" align="left">
                                <%# DataBinder.Eval(Container.DataItem, "NonComplianceType")%>
							</td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "AgreedAlternative")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "CTB_RTB")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "CIO_CTO")%></td>
						</tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
					    <tr runat="server" id="FooterID1">
					        <td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;" colspan="2">Total</td>
					        <td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;"></td>
					        <td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;"></td>
						</tr>
						 <tr runat="server" id="FooterID2">
					        <td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;" colspan="10" align="left">Grand Total</td>
						</tr>
						<tr>
						    <td class="empty" height="0px" colspan="25"></td>
						</tr>					
						</table>
					</FooterTemplate>
				</asp:repeater>
		</td>
		<td></td>
		<td></td>
		<td><td>
	</tr>
</table>
<br>
