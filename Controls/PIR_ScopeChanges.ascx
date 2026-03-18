<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_ScopeChanges.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_ScopeChanges" %>
<script language="javascript" type="text/javascript">
<!--
function popupWindowAddScopeChange(initiativeID, scopeChangeID)
{
	var dialogwidth = 500
	var dialogheight = 200
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + "px,height=" + dialogheight + 
		"px,titlebar=no,status=no,dependent=yes"
    
    var link = "PIRScopeChange.aspx?InitiativeID=" + initiativeID;
    
    if (scopeChangeID != null) 
        link = link + "&record=" + scopeChangeID

    var returnCode;
    
	returnCode = window.showModalDialog(link, "scope_change_dialog", 
	                "dialogWidth:520px;dialogHeight:200px;status:no;resizable:no;scroll:yes");
					
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
			<asp:repeater id="rptScopeChanges" EnableViewState="False" runat="server" OnItemDataBound="rptScopeChanges_ItemDataBound" OnItemCommand="rptScopeChanges_ItemCommand">
				<HeaderTemplate>
		            <table class="datatable" cellspacing="0" cellpadding="3" rules="all" style="width:100%;">
		            <colgroup>
		                <col class="incell" style="width:250px; text-align:left;"/>
		                <col class="incell" style="width:380px; text-align:left;"/>
		                <col class="incell" style="width:80px; text-align:center;"/>
		            </colgroup>
					<tr runat="Server" id="trHeader" style="height:30px;">
						<td class="headcell" style="border-left: 0px">Scope Change</td>
						<td class="headcell">Commentary</td>
						<td class="headcell" style="border-right: 0px">Status</td>
					</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr runat="Server" id="trItem">
						<td runat="Server" id="tdScopeChange">
						    <table cellpadding="0" cellspacing="0" border="0">
						        <tr>
						            <td style="width:20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeScopeChangeID")%>' CommandName="Delete"></asp:ImageButton></td>
						            <td><a runat="server" id="lnkEditScopeChange" href="#" onclick='<%# "javascript:popupWindowAddScopeChange(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeScopeChangeID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem,"ScopeChange")%></a></td>
						        </tr>
						    </table>
					    </td>
						<td><%# DataBinder.Eval(Container.DataItem,"Commentary")%></td>
						<td class="PIRMajorMinor"><%# DataBinder.Eval(Container.DataItem,"Status")%></td>
					</tr>
				</ItemTemplate>
				<FooterTemplate>
				    </table>
				</FooterTemplate>
            </asp:repeater>	    
	    </td>
	</tr>
	<tr style="height:20px" valign="middle">
	    <td>
			<button runat="server" id="btnAddScopeChange" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add Scope Change</button>
	    </td>
	</tr>	
</table>