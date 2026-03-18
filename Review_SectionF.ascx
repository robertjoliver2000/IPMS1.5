<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_SectionF.ascx.cs" Inherits="ProjectPortfolio.Controls.Review_SectionF" %>
<script language="javascript">
function popupWindowRisk(initiativeID, riskID)
{
	var dialogwidth = 400
	var dialogheight = 170
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"
  
    var lnk = "Review_Risk.aspx?InitiativeID=" + initiativeID;
    
    if (riskID != null && riskID != 0)
    {
        lnk = lnk + "&RiskID=" + riskID;
    }

    var returnCode;
    
    returnCode=window.showModalDialog(lnk, 
                "risk_dialog","dialogWidth:430px;dialogHeight:200px;status:no;resizable:no;scroll:yes");
    
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
		<td colspan="5" class="controltitle" width="1020">F) Initiative Risk Assesment  All Amount in EUROs(not million EUROs)</td>
	</tr>
	<tr>
		<td colspan="5" height="20"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
	    <td align="left">
				<asp:repeater id="repeaterRisk" EnableViewState="False" runat="server" OnItemCommand="repeaterRisk_ItemCommand" OnItemDataBound="repeaterRisk_ItemDataBound">
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
						        <td> <asp:ImageButton runat="server" ID="delRiskID" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeRiskID")%>' CommandName="Delete"></asp:ImageButton></td>
						        <td class="incell" align="left"><a runat="server" id="lnkEditRisk" href="#" onclick='<%# "javascript:popupWindowRisk(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeRiskID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem, "RiskCategory")%></a></td>
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
						        <td> <asp:ImageButton runat="server" ID="delRiskID" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeRiskID")%>' CommandName="Delete"></asp:ImageButton></td>
						        <td class="alternateincell" align="left"><a runat="server" id="lnkEditRisk" href="#" onclick='<%# "javascript:popupWindowRisk(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeRiskID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem, "RiskCategory")%></a></td>
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
			<br>
			<button runat="server" id="btnAddRisk" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add Risk</button>
		</td>
		<td></td>
		<td></td>
		<td><td>
	</tr>
	<tr height="10">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td width="7"></td>
	    <td colspan="4" class="summarylabel" width="270">1) Risks,Issues and Dependencies</td>
	</tr>
	<tr height="3">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td width="10"></td>
		<td colspan="4" class="summarylabel" style="height: 100px">
			<asp:TextBox Runat="server" ID="txtRisksIssuesDeps" CssClass="textinput" TextMode="MultiLine"
				Width="100%" Height="80px"></asp:TextBox>
		</td>
	</tr>
	<tr height="10">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td width="7"></td>
	    <td colspan="4" class="summarylabel" width="270">2) Overall IG Coordinator Comment</td>
	</tr>
	<tr height="3">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td width="10"></td>
		<td colspan="4" class="summarylabel" style="height: 100px">
			<asp:TextBox Runat="server" ID="txtOverallIGComment" CssClass="textinput" TextMode="MultiLine"
				Width="100%" Height="80px"></asp:TextBox>
		</td>
	</tr>


</table>
