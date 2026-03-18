<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionF_PrintVersion" CodeFile="sectionF_PrintVersion.ascx.cs" %>

<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="6" class="controltitle">F) ITI Conformity</td>
	</tr>
	<tr>
		<td colspan="6" height="15px"></td>
	</tr>
	<tr>
	    <td width="0px"></td>
		<td width="220px" class="summarylabel">&nbsp;ITI ARCHITECTURE APPROVER:
		</td>
		<td width="150px" align="left" class="tablegreybg">
            <asp:Label ID="txtIESArchApprover" runat="server"></asp:Label></td>
		<td width="40px">
		    <a runat="server" ID="hRefIESArchApproverID"></a>
		    <asp:HiddenField runat="server" id="hiddenIESArchApprover"></asp:HiddenField>
		 </td>
		<td width="200px" class="summarylabel">ITI ARCHITECTURE - APPROVAL DATE:
		</td>
		<td width="80px" class="tablegreybg" align="Center">
            <asp:Label ID="txtIESArchApDate" runat="server"></asp:Label>
        </td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
</table>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr>
	    <td width="0px"></td>
		<td width="220px" class="summarylabel">&nbsp;Fully Compliant with Technology Roadmap?</td>
		<td width="150px" class="tablegreybg" align="left">
            <asp:Label ID="ddlFullyCompliant" runat="server"></asp:Label></td>
		<td class="summarylabel"></td>
	    <td></td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
</table>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitlesmall">Additional spend and Remediation for Non-Compliant Applications - Exceptions Only</td>
	</tr>
	<tr height="5">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td width="0px"></td>
	    <td align="left">
				<asp:repeater id="repeaterProduct" EnableViewState="False" runat="server" OnItemDataBound="repeaterProduct_ItemDataBound">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr>
							<td class="headcell" colspan="3" align="center">Technology</td>
							<td class="headcell" colspan="25"></td>
						</tr>
						<tr runat="server" id="HeaderID" height="22px">
							<td class="headcell" width="120" align="left">Product Name</td>
							<td class="headcell" width="110" align="center">Vendor</td>
							<td class="headcell" width="90" align="center">Type</td>
							<td class="headcell" width="50" align="center">CTB/RTB</td>
							<td class="headcell" width="50" align="center">ITA/ITI</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20" runat="server" id="RowID">
						    <td class="incell" align="left">
                                <%# DataBinder.Eval(Container.DataItem, "ProductName")%>						    
                            </td>
						    <td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "TVendor")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "ProductType")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "CTB_RTB")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "CIO_IES")%></td>
	                    </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20"  runat="server" id="AlternateRowID">
						     <td class="alternateincell" align="left">
                                <%# DataBinder.Eval(Container.DataItem, "ProductName")%>						    
						     </td>
						    <td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "TVendor")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "ProductType")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "CTB_RTB")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "CIO_IES")%></td>
	                    </tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
					    <tr runat="server" id="FooterID1">
					        <td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;" colspan="3" align="left">Total</td>
					        <td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;"></td>
					        <td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;"></td>
						</tr>
						 <tr runat="server" id="FooterID2">
					        <td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;" colspan="11" align="left">Grand Total</td>
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
		<td></td>
	</tr>
</table>
<br >
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td class="controltitlesmall">Financial Justification for Deviation from the Technology Roadmap</td>
	</tr>
	<tr height="5">
		<td></td>
	</tr>
	<tr>
	    <td class="tablegreybg" width="900px">
            <asp:Label ID="txtIESFinancialJustification" runat="server"></asp:Label></td>
    </tr>
</table>
<br >