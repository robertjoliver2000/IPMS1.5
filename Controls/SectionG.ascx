<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionG" CodeFile="SectionG.ascx.cs" %>
<script language="javascript">

function popupWindowSelectItem(categoryID,txtBoxID, hiddenTxtBoxID)
{
    var dialogwidth = 320
	var dialogheight = 400
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"
  
	
    dlgwindow= window.open("SelectItem.aspx?CategoryID="+categoryID+"&ControlID="+txtBoxID+"&HiddenControlID="+hiddenTxtBoxID, 
					"item_dialog", attr);
					
	dlgwindow.focus();
}

function popupWindowImpact(initiativeID, impactID)
{
	var dialogwidth = 350
	var dialogheight = 400
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		        dialogwidth + ",height=" + dialogheight + 
		        ",titlebar=no,status=no,dependent=yes"
  
    var returnCode;
	if(impactID==0)
	{
	    returnCode = window.showModalDialog("Impact.aspx?InitiativeID=" + initiativeID ,
	            "impact_dialog", "dialogWidth:370px;dialogHeight:420px;status:no;resizable:no;scroll:yes");
	}
	else
    {
	    returnCode = window.showModalDialog("Impact.aspx?InitiativeID=" + initiativeID + "&ImpactID=" + impactID, 
					           "impact_dialog","dialogWidth:370px;dialogHeight:420px;status:no;resizable:no;scroll:yes");
    }
					
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            AllowOneTimeSubmit();
            window.document.forms[0].submit();
        }
    }
}
</script>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="6" class="controltitle">G) ITA Conformity</td>
	</tr>
	<tr>
		<td colspan="6" height="15"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
		<td class="summarylabel" width="280">&nbsp;ITA ARCHITECTURE APPROVER:
		</td>
		<td><asp:TextBox Runat="server" ID="txtCIOArchApprover" CssClass="textinput" Width="200">
			 </asp:Textbox></td>
		<td width="50"><a runat="server" ID="hRefCIOArchApproverID"><img src="Images/pick.jpg" border="0"></a><asp:HiddenField runat="server" id="hiddenCIOArchApprover"></asp:HiddenField></td>
		<td class="summarylabel" width="270">ITA ARCHITECTURE - APPROVAL DATE:
		</td>
		<td>
		    <table align="left" border="0" cellpadding="0" cellspacing="0">
		        <tr>
		            <td><asp:TextBox Runat="server" ID="txtCIOArchApDate" CssClass="textinput" Width="120"></asp:TextBox></td>
		            <td width="20px" align="center"><a runat="server" id="lnkCIOArchApDate"><img src="Images/calendar.jpg" border="0"></a></td>
		            <td width="20px" align="center"><asp:RangeValidator ID="rvCIOArchApDate" runat="server" ControlToValidate="txtCIOArchApDate" Text="*" MaximumValue="1/1/2020" MinimumValue="1/1/1900" Type="Date" ></asp:RangeValidator></td>
		            <td width="40px"></td>
		        </tr>
	            <tr>
	                <td valign="top"><font face="verdana, arial, helvetica, sans-serif" color="#333333" size="1"><em>dd/mm/yyyy</em></font></td>
	                <td></td>
	                <td></td>
	                <td></td>
	            </tr>
		    </table>		    
		</td>
	</tr>
	<tr>
		<td colspan="6" height="20"></td>
	</tr>
</table>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr>
	    <td width="10px"></td>
		<td class="summarylabel" width="280">&nbsp;Uses Approved 3rd party Software?</td>
		<td>
			<asp:DropDownList Runat="server" ID="ddlUsesAproved3rdParty" CssClass="textselect" Width="200">
			</asp:DropDownList>
		</td>
		<td width="50"></td>
		<td class="summarylabel" width="270">Application Architecture(Roadmap)compliant?
		</td>
		<td>
		    <asp:DropDownList Runat="server" ID="ddlApplicationArchCompliant" CssClass="textselect" Width="200">
			</asp:DropDownList>
		</td>
	</tr>
	<tr><td colspan="6" height="15"></td></tr>
	<tr>
	    <td width="10px"></td>
		<td class="summarylabel" width="280">&nbsp;Technical Architecture compliant?</td>
		<td>
			<asp:DropDownList Runat="server" ID="ddlTechnicalArchCompliant" CssClass="textselect" Width="200">
			</asp:DropDownList>
		</td>
		<td width="50"></td>
		<td class="summarylabel" width="270">Technical Architecture requirement satisfied?
		</td>
		<td>
			<asp:DropDownList Runat="server" ID="ddlTechnicalArchSatisfied" CssClass="textselect" Width="200">
			</asp:DropDownList>
		</td>
	</tr>
	<tr><td colspan="6" height="15"></td></tr>
	<tr>
	    <td width="10px"></td>
		<td class="summarylabel" width="280">&nbsp;Business Architecture Information 
			provided?</td>
		<td>
			<asp:DropDownList Runat="server" ID="ddlBusinessArchInfo" CssClass="textselect" Width="200">
			</asp:DropDownList>
		</td>
		<td width="50"></td>
		<td class="summarylabel" width="270">Development Architecture compliant?
		</td>
		<td>
			<asp:DropDownList Runat="server" ID="ddlDevelopmentArchCompl" CssClass="textselect" Width="200">
		    </asp:DropDownList>
		</td>
	</tr>
	<tr><td colspan="6" height="15"></td></tr>
	<tr>
	    <td width="10px"></td>
		<td class="summarylabel" width="280">&nbsp;Approved by Corporate and/or Business 
			Unit Architecture Comittee (CIO)?</td>
		<td><asp:TextBox Runat="server" ID="txtApprovedByCorporate" CssClass="textinputgreen" Width="200"></asp:TextBox></td>
		<td width="50"></td>
		<td width="270"><asp:Label Runat="server" ID="lblErr" Width="100%" Font-Bold="True" BorderStyle="None" ForeColor="Red" Visible="False">Initiative is not fully compliant - please complete section below.</asp:Label></td>
				
	</tr>
</table>
<br>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="6" class="controltitlesmall">Justification for Deviation from GTO Blue Print / Other Comments</td>
	</tr>
	<tr height="5">
		<td colspan="6"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
		<td colspan="5" class="summarylabel" style="height: 100px">
			<asp:TextBox Runat="server" ID="txtJustificationForDeviation" CssClass="textinput" TextMode="MultiLine"
				Width="1000" Height="80px"></asp:TextBox>
		</td>
	</tr>
</table>
<br>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitlesmall">Financial impact of Non-Compliant Applications - Exceptions Only</td>
	</tr>
	<tr height="5">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
	    <td align="left">
			    <asp:repeater id="repeaterImpact" EnableViewState="False" runat="server" OnItemDataBound="repeaterImpact_ItemDataBound" OnItemCommand="repeaterImpact_ItemCommand">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr height="20" runat="server" id="HeaderID">
							<td class="headcell" width="180" align="left">Non-compliance Type</td>
							<td class="headcell" width="140" align="center">Agreed Alternative</td>
							<td class="headcell" width="50" align="center">CTB/RTB</td>
							<td class="headcell" width="50" align="center">ITA/ITI</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="RowID">
							<td class="incell" align="left">
							<table>    
							    <tr>
							        <td> <asp:ImageButton runat="server" ID="delImpactID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeImpactID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td>
							        <td class="incell">  <%# DataBinder.Eval(Container.DataItem, "NonComplianceType")%>  </td>
							    </tr>   
							</table>
							 </td>
							<td class="incell" align="center"><a runat="server" id="lnkEditImpact" href="#" onclick='<%# "javascript:popupWindowImpact(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeImpactID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem, "AgreedAlternative")%></a></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "CTB_RTB")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "CIO_CTO")%></td>
	                </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20" runat="server" id="AlternateRowID">
						    <td class="alternateincell" align="left">
						        <table>    
							        <tr>
							            <td><asp:ImageButton runat="server" ID="delImpactID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeImpactID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td>
							            <td class="alternateincell">  <%# DataBinder.Eval(Container.DataItem, "NonComplianceType")%>  </td>
							        </tr>   
							    </table>
							</td>
							<td class="alternateincell" align="center"><a runat="server" id="lnkEditImpact" href="#" onclick='<%# "javascript:popupWindowImpact(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeImpactID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem, "AgreedAlternative")%></a></td>
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
		
			<br>
			<button runat="server" id="btnAddImpact" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add Financial Impact</button>
		</td>
		<td></td>
		<td></td>
		<td><td>
	</tr>
</table>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="1">
	<tr height="5">
		<td align="center" class="summarycell" width="1010" style="font-weight: bold;"> Please ensure that any 
		    additional costs arising above, are embedded in Section 2 (Spend) of the Financial Page</td>
	</tr>	
</table>
