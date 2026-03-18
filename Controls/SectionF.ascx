<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionF" CodeFile="sectionF.ascx.cs" %>
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

	dlgwindow =window.open("SelectItem.aspx?CategoryID="+categoryID+"&ControlID="+txtBoxID+"&HiddenControlID="+hiddenTxtBoxID, 
					"item_dialog", attr);
					
    dlgwindow.focus();
}

function popupWindowProduct(initiativeID, productID)
{
	var dialogwidth = 360
	var dialogheight = 400
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		        dialogwidth + ",height=" + dialogheight + 
		        ",titlebar=no,status=no,dependent=yes";
  
    var returnCode;
	if(productID==0)
	{
	    returnCode= window.showModalDialog("Product.aspx?InitiativeID=" + initiativeID,"product_dialog", 
	                    "dialogWidth:380px;dialogHeight:420px;status:no;resizable:no;scroll:yes");
	}
	else
    {
	    returnCode= window.showModalDialog("Product.aspx?InitiativeID=" + initiativeID + "&ProductID=" + productID, 
					            "product_dialog", "dialogWidth:380px;dialogHeight:420px;status:no;resizable:no;scroll:yes");
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
		<td colspan="6" class="controltitle">F) ITI Conformity</td>
	</tr>
	<tr>
		<td colspan="6" height="10px"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
		<td class="summarylabel" width="280">&nbsp;ITI ARCHITECTURE APPROVER:
		</td>
		<td><asp:TextBox Runat="server" ID="txtIESArchApprover" CssClass="textinput" Width="200">
			 </asp:Textbox></td>
		<td width="50"><a runat="server" ID="hRefIESArchApproverID"><img src="Images/pick.jpg" border="0"></a><asp:HiddenField runat="server" id="hiddenIESArchApprover"></asp:HiddenField></td>
		<td class="summarylabel" width="270">ITI ARCHITECTURE - APPROVAL DATE:
		</td>
		<td>
		    <table align="left" border="0" cellpadding="0" cellspacing="0">
		        <tr>
		            <td><asp:TextBox Runat="server" ID="txtIESArchApDate" CssClass="textinput" Width="120px"></asp:TextBox></td>
		            <td width="20px" align="center"><a runat="server" id="lnkIESArchApDate"><img src="Images/calendar.jpg" border="0"></a></td>
		            <td width="20px" align="center"><asp:RangeValidator ID="rvIESArchApDate" runat="server" ControlToValidate="txtIESArchApDate" Text="*" MaximumValue="1/1/2020" MinimumValue="1/1/1900" Type="Date" ></asp:RangeValidator></td>
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
		<td colspan="5" height="5"></td>
	</tr>
</table>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr>
	    <td width="10px"></td>
		<td class="summarylabel" width="280">&nbsp;Fully Compliant with Technology Roadmap?</td>
		<td>
			<asp:DropDownList Runat="server" ID="ddlFullyCompliant" CssClass="textselect" Width="200">
			</asp:DropDownList>
		</td>
		<td width="50"></td>
		<td class="summarylabel" width="270"></td>
	    <td></td>
	</tr>
</table>
<br>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitlesmall">Additional spend and Remediation for Non-Compliant Applications - Exceptions Only</td>
	</tr>
	<tr height="5">
		<td colspan="5"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
	    <td align="left">
				<asp:repeater id="repeaterProduct" EnableViewState="False" runat="server" OnItemDataBound="repeaterProduct_ItemDataBound" OnItemCommand="repeaterProduct_ItemCommand">
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
						        <table>
						            <tr>
						               <td><asp:ImageButton runat="server" ID="delProductID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeProductID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td>
						               <td class="incell" align="center"><a runat="server" id="lnkEditProduct" href="#" onclick='<%# "javascript:popupWindowProduct(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeProductID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem, "ProductName")%></a></td>
						            </tr>
						       </table>
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
						        <table>
						            <tr>
						               <td><asp:ImageButton runat="server" ID="delProductID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeProductID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td>
						               <td class="alternateincell" align="center"><a runat="server" id="lnkEditProduct" href="#" onclick='<%# "javascript:popupWindowProduct(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeProductID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem, "ProductName")%></a></td>
						            </tr>
						       </table>
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
			<br>
			<button runat="server" id="btnAddProduct" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add Product</button>
		</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
</table>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="1">
	<tr>
		<td align="center" valign="middle" class="summarycell" style="font-weight:bold" width="1010"> Please ensure that any 
		    additional costs arising above, are embedded in Section 2 (Spend) of the Financial Page</td>
	</tr>
</table>
<br>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr class="ms-WPHeader">
		<td colspan="2"  class="controltitlesmall">Financial Justification for Deviation from the Technology Roadmap</td>
	</tr>
	<tr height="5">
		<td></td>
		<td></td>
	</tr>
	<tr>
	    <td width="10px"></td>
	    <td>
	        <asp:TextBox Runat="server" ID="txtIESFinancialJustification" CssClass="textinput" TextMode="MultiLine"
				Width="1000" Height="80px"></asp:TextBox>	
        </td>
    </tr>
</table>
