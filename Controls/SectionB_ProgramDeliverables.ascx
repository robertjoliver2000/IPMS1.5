<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SectionB_ProgramDeliverables.ascx.cs" Inherits="Controls_SectionB_ProgramDeliverables" %>

<script language="javascript">
<!--
function popupWindowAddDeliverable(initiativeID, deliverableID)
{
	var dialogwidth = 500
	var dialogheight = 200
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + "px,height=" + dialogheight + 
		"px,titlebar=no,status=no,dependent=yes"
    
    var link = "Deliverable.aspx?InitiativeID=" + initiativeID;
    
    if (deliverableID != null) 
        link = link + "&record=" + deliverableID

    var returnCode;
    
	returnCode = window.showModalDialog(link, "deliverable_dialog", 
	                "dialogWidth:520px;dialogHeight:230px;status:no;resizable:no;scroll:yes");
					
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            AllowOneTimeSubmit();
            window.document.forms[0].submit();
        }
    }
}
-->
</script>


<table cellpadding="2" cellspacing="2" style="border: 1px solid #CCCCCC; ">
	<tr>
		<td class="sponsorallocationtitle">MAJOR PROGRAM DELIVERABLES</td>
	</tr>
	<tr>
		<td height="5px">
		</td>
	</tr>
	<tr>
	    <td>
			<asp:repeater id="rptProgramDeliverables" EnableViewState="False" runat="server" OnItemDataBound="rptProgramDeliverables_ItemDataBound" OnItemCommand="rptProgramDeliverables_ItemCommand">
				<HeaderTemplate>
		            <table class="datatable" cellSpacing="0" cellPadding="3">
					<tr runat="Server" id="trHeader">
						<td class="emptynopadding" style="background-color:#eaeaea; border: 0px;"></td>
						<td class="headcell" width="380px" align="left" style="border-left: 0px">Key Deliverables</td>
						<td class="headcell" width="80px" align="center">Due Date</td>
						<td class="headcell" width="80px" align="center">Cost (€M) </td>
						<td class="headcell" width="250px" align="left" style="border-right: 0px">Affected Applications</td>
						<td class="emptynopadding" style="background-color:#eaeaea; border: 0px;"></td>
					</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr runat="Server" id="trItem">
						<td class="emptynopadding"></td>
						<td class="incell" width="380px" runat="Server" id="tdName">
						    <table cellpadding="0" cellspacing="0" border="0">
						        <tr>
						            <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DeliverableID")%>' CommandName="Delete"></asp:ImageButton></td>
						            <td><a runat="server" id="lnkAddDeliverable" href="#" onclick='<%# "javascript:popupWindowAddDeliverable(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"DeliverableID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem,"Name")%></a></td>
						        </tr>
						    </table>
					    </td>
						<td class="incell" width="80px" align="center"><%# DataBinder.Eval(Container.DataItem,"DueDate", "{0:d}")%>&nbsp;</td>
						<td class="incell" width="80px" align="right"><%# DataBinder.Eval(Container.DataItem,"Cost", "{0:N2}")%>&nbsp;</td>
						<td class="incell" width="250px" align="left"><%# DataBinder.Eval(Container.DataItem,"AffectedApplications")%>&nbsp;</td>
						<td class="emptynopadding"></td>
					</tr>
				</ItemTemplate>
				<AlternatingItemTemplate>
					<tr runat="Server" id="trItem">
						<td class="emptynopadding"></td>
						<td class="alternateincell" width="380px" runat="Server" id="tdName">
						    <table cellpadding="0" cellspacing="0" border="0">
						        <tr>
						            <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"DeliverableID")%>' CommandName="Delete"></asp:ImageButton></td>
						            <td><a runat="server" id="lnkAddDeliverable" href="#" onclick='<%# "javascript:popupWindowAddDeliverable(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"DeliverableID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem,"Name")%></a></td>
						        </tr>
						    </table>
						</td>
						<td class="alternateincell" width="80px" align="center"><%# DataBinder.Eval(Container.DataItem,"DueDate", "{0:d}")%>&nbsp;</td>
						<td class="alternateincell" width="80px" align="right"><%# DataBinder.Eval(Container.DataItem,"Cost", "{0:N2}")%>&nbsp;</td>
						<td class="alternateincell" width="250px" align="left"><%# DataBinder.Eval(Container.DataItem,"AffectedApplications")%>&nbsp;</td>
						<td class="emptynopadding"></td>
					</tr>
                </AlternatingItemTemplate>	
                <FooterTemplate>
					<tr runat="Server" id="trTotal">
						<td class="emptynopadding"></td>
						<td class="totalcell">Total Cost</td>
						<td class="totalcell"></td>
						<td class="totalcell" runat="server" id="tdTotalCost" align="right"></td>
						<td class="totalcell"></td>
						<td class="emptynopadding"></td>
					</tr>
					<tr>
					    <td class="empty" height="0px" colspan="25"></td>
					</tr>					
        			</table>
                </FooterTemplate>			
            </asp:repeater>	    
	    </td>
	</tr>
	<tr height="20" valign="middle">
	    <td>
			<button runat="server" id="btnAddDeliverable" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add Deliverable</button>
	    </td>
	</tr>	
</table>