<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_SectionB_SponsorAllocations.ascx.cs" Inherits="ProjectPortfolio.Controls.Review_SectionB_SponsorAllocations" %>

<script type="text/javascript">
    function textLimit(field, maxlen) 
    {
        if (field.value.length > maxlen + 1)
            alert('You have exceeded the text limit of 50 characters.');
        if (field.value.length > maxlen)
            field.value = field.value.substring(0, maxlen);
    }

    function popupWindowSelectUBR( initiativeID, sponsorId, flagEltId, valueEltId )
    {
        var dialogwidth = 500;
	    var dialogheight = 500;
	    var leftpos = (screen.width - dialogwidth) / 2;
	    var toppos = (screen.height - dialogheight) / 2;
	    var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=yes,scrollbars=no,width="+
		    dialogwidth + ",height=" + dialogheight + 
		    ",titlebar=no,status=no,dependent=yes";
        var canOpen = false;
	    var isReadOnly = 1;

		var storeSponsorLevel = '0';
        var flagElt = document.getElementById( flagEltId );
        if ( flagElt )
        {
            if ( flagElt.value.toLowerCase() == 'true' || flagElt.value == '1' )
            {
                storeSponsorLevel = '1';
            }
        }
        
        canOpen = true;
          
		if ( canOpen )
		{
		    if ( document.getElementById( 'ctlFooter_btnSave' ) )
		    {
		        isReadOnly = 0;
		    }
		    else
		    {
		        // don't open popup if read-only and allocations stored at sponsor level
		        if ( storeSponsorLevel == '1' )
	            {
	                window.alert( 'There are no lower-level allocations for this combination of Initiative and Sponsor' );
	                return;
	            }
		    }
		    
            var dialogResult = window.showModalDialog("AllocateUBRWrapper.aspx?InitiativeID=" + initiativeID + "&SponsorId=" + sponsorId + '&StoreSponsorLevel=' + storeSponsorLevel + '&ReadOnly=' + isReadOnly,
                                    "selectitem_dialog", attr);
                                    
            //var dialogResult = -1;
            //window.open("AllocateUBR.aspx?InitiativeID=" + initiativeID + "&SponsorType=" + sponsorType + '&ReadOnly=' + isReadOnly,
            //                "selectitem_dialog");
            
            if (dialogResult != -1)
            {
                if ( flagElt )
                {
                    flagElt.value = 'False';
                    document.getElementById(valueEltId).value = dialogResult;
                    computeTotals();
                    SetDirtyFlag();
                }
            }
	    }
    }
    
    function setStoreSponsorLevel( eltid, newval )
    {
        var elt = document.getElementById( eltid );
        if ( elt )
        {
            elt.value = newval;
        }
    }
    
</script>

<table cellpadding="2" cellspacing="2" style="border: 1px solid #CCCCCC; ">
	<tr>
		<td colspan="5" class="sponsorallocationtitle">% SPONSOR ALLOCATIONS</td>
	</tr>
	<tr>
		<td colspan="5">
		</td>
	</tr>
	<tr>
	    <td valign="top">
	        <table cellpadding="2" cellspacing = "0">
	            <tr>
		            <td width="60px" class="sponsorallocationlabel" style="FONT-WEIGHT:bold">BA</td>
		            <td width="55px" style="FONT-WEIGHT:bold" align="center">Last Review</td>
		            <td width="55px" style="FONT-WEIGHT:bold" align="center">Current Review</td>
	            </tr>
	            <tr>
		            <td colspan="3">
		            </td>
	            </tr>
	            <tr>
		            <td class="sponsorallocationlabel" style="FONT-WEIGHT:bold">Business</td>
		            <td class="sponsorallocationlabel"><asp:TextBox Runat="server" ID="txtPreviousBusiness" CssClass="textinputgreen" Width="50px" style="TEXT-ALIGN:center"
				            ReadOnly="True">0%</asp:TextBox></td>
		            <td class="sponsorallocationlabel"><asp:TextBox Runat="server" ID="txtBusiness" CssClass="textinputgreen" Width="50px" style="TEXT-ALIGN:center"
				            ReadOnly="True">0%</asp:TextBox></td>
	            </tr>
	            <tr>
		            <td colspan="3">
		            </td>
	            </tr>
            	<asp:Repeater runat="Server" id="rptBusiness" OnItemDataBound="rptBusiness_ItemDataBound">
            	    <ItemTemplate>
	                <tr>
		                <td class="sponsorallocationlabel" runat="Server" id="tdLabel"></td>
		                <td class="sponsorallocationlabel" runat="Server" id="tdPreviousValue"></td>
		                <td class="sponsorallocationlabel" runat="Server" id="tdValue"></td>
                        <td class="sponsorallocationlabel" runat="Server" id="tdLink"></td>
	                </tr>    	        
	                </ItemTemplate>
                </asp:Repeater>	                
	        </table>
	    </td>
	    <td width="5px">
	    </td>
	    <td valign="top">
	        <table cellpadding="2" cellspacing = "0">
	            <tr>
		            <td width="60px" class="sponsorallocationlabel" style="FONT-WEIGHT:bold">BA</td>
		            <td width="55px" style="FONT-WEIGHT:bold" align="center">Last Review</td>
		            <td width="55px" style="FONT-WEIGHT:bold" align="center">Current Review</td>
	            </tr>
	            <tr>
		            <td colspan="3">
		            </td>
	            </tr>
	            <tr>
		            <td class="sponsorallocationlabel" style="FONT-WEIGHT:bold">GTO</td>
		            <td class="sponsorallocationlabel"><asp:TextBox Runat="server" ID="txtPreviousGTO" CssClass="textinputgreen" Width="50px" style="TEXT-ALIGN:center"
				            ReadOnly="True">0%</asp:TextBox></td>
		            <td class="sponsorallocationlabel"><asp:TextBox Runat="server" ID="txtGTO" CssClass="textinputgreen" Width="50px" style="TEXT-ALIGN:center"
				            ReadOnly="True">0%</asp:TextBox></td>
	            </tr>
	            <tr>
		            <td colspan="3">
		            </td>
	            </tr>
            	<asp:Repeater runat="Server" id="rptGTO" OnItemDataBound="rptGTO_ItemDataBound">
            	    <ItemTemplate>
	                <tr>
		                <td class="sponsorallocationlabel" runat="Server" id="tdLabel"></td>
		                <td class="sponsorallocationlabel" runat="Server" id="tdPreviousValue"></td>
		                <td class="sponsorallocationlabel" runat="Server" id="tdValue"></td>
                        <td class="sponsorallocationlabel" runat="Server" id="tdLink"></td>
	                </tr>    	  
	                </ItemTemplate>      
	            </asp:Repeater>
	        </table>
	    </td>	
	    <td width="5px">
	    </td>
	    <td valign="top">
	        <table cellpadding="2" cellspacing = "0">
	            <tr>
		            <td width="60px" class="sponsorallocationlabel" style="FONT-WEIGHT:bold">BA</td>
		            <td width="55px" style="FONT-WEIGHT:bold" align="center">Last Review</td>
		            <td width="55px" style="FONT-WEIGHT:bold" align="center">Current Review</td>
	            </tr>
	            <tr>
		            <td colspan="3">
		            </td>
	            </tr>
	            <tr>
		            <td class="sponsorallocationlabel" style="FONT-WEIGHT:bold">CF</td>
		            <td class="sponsorallocationlabel"><asp:TextBox Runat="server" ID="txtPreviousCF" CssClass="textinputgreen" Width="50px" style="TEXT-ALIGN:center"
				            ReadOnly="True">0%</asp:TextBox></td>
		            <td class="sponsorallocationlabel"><asp:TextBox Runat="server" ID="txtCF" CssClass="textinputgreen" Width="50px" style="TEXT-ALIGN:center"
				            ReadOnly="True">0%</asp:TextBox></td>
	            </tr>
	            <tr>
		            <td colspan="3">
		            </td>
	            </tr>
            	<asp:Repeater runat="Server" id="rptCF" OnItemDataBound="rptCF_ItemDataBound">
          	        <ItemTemplate>
	                <tr>
		                <td class="sponsorallocationlabel" runat="Server" id="tdLabel"></td>
		                <td class="sponsorallocationlabel" runat="Server" id="tdPreviousValue"></td>
		                <td class="sponsorallocationlabel" runat="Server" id="tdValue"></td>
                        <td class="sponsorallocationlabel" runat="Server" id="tdLink"></td>
	                </tr>    	        
	                </ItemTemplate>
	            </asp:Repeater>
	        </table>
	    </td>	
    </tr>
    <tr>
        <td colspan="5">
            <asp:CustomValidator ID="cvSponsorAllocations" runat="server" Display="Dynamic" Text="* Sponsor allocations percentages must add up to 100%!" ClientValidationFunction="validatePercents"></asp:CustomValidator>
            <asp:CustomValidator ID="RVsectionB_cvSponsorAllocations" runat="server" Display="Dynamic" Text="Sponsor allocations percentages must add up to 100%!" ErrorMessage="Sponsor allocations percentages must add up to 100%!" ClientValidationFunction="validatePercentsOnSubmitForReview" ValidationGroup="SubmitForReview"></asp:CustomValidator>
        </td>
    </tr>
	<tr>
	    <td colspan="5">
	        <table>
	            <tr>
		            <td width="250px" class="sponsorallocationlabel" style="FONT-WEIGHT:bold; TEXT-ALIGN:left">
		                Allocations agreed with Sponsors?
		            </td>
		            <td align="left">
			            <asp:DropDownList Runat="server" ID="ddlAllocationAgreed" CssClass="textselect" Width="105px">
				            <asp:ListItem value="Please Select" Selected="True" />
				            <asp:ListItem Value="Yes" />
				            <asp:ListItem Value="No" />
			            </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RVsectionB_rvAllocationAgreedDDL" runat="server" ControlToValidate="ddlAllocationAgreed"
                            ErrorMessage="Allocations Agreed must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
		            </td>
	            </tr>
	        </table>
            </td>
	</tr>
	<tr>
	    <td colspan="5">
	        <table>
	            <tr>
		            <td width="250px" class="sponsorallocationlabel" style="FONT-WEIGHT:bold; TEXT-ALIGN:left;">
		                Initiative budgeted for current year?</td>
		            <td align="left">
			            <asp:DropDownList Runat="server" ID="ddlInitiativeBudget" CssClass="textselect" Width="105px">
				            <asp:ListItem value="Please Select" Selected="True" />
				            <asp:ListItem Value="Yes" />
				            <asp:ListItem Value="No" />
			            </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RVsectionB_rvInitiativeBudgetDDL" runat="server" ControlToValidate="ddlInitiativeBudget"
                            ErrorMessage="Initiative Budgeted must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
		            </td>
        		</tr>
            </table>
        </td>
	</tr>
    <tr>
        <td colspan="5">
            <table>
                <tr>
                    <td width="250px" class="sponsorallocationlabel" style="FONT-WEIGHT:bold; TEXT-ALIGN:left;">
                        Basis for allocation?</td>
                    <td align="left">
                        <asp:DropDownList Runat="server" ID="ddlBasisForAllocation" CssClass="textselect" Width="105px">
                            <asp:ListItem value="Please Select" Selected="True" />
                            <asp:ListItem Value="Yes" />
                            <asp:ListItem Value="No" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RVsectionB_rvBasisForAllocationDDL" runat="server"
                            ControlToValidate="ddlBasisForAllocation" ErrorMessage="Basis for Allocation must not be blank"
                            InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <asp:TextBox name="txtBasisForAllocationDescription" ID="txtBasisForAllocationDescription" runat="server" CssClass="textinput"
            	TextMode="MultiLine" Width="362px" onkeyup="textLimit(this, 50);"></asp:TextBox>
            <asp:CustomValidator ID="cvBasisForValidationDescription" runat="server" ClientValidationFunction="fn_cvBasisForAllocationDescription"
                ControlToValidate="txtBasisForAllocationDescription" ErrorMessage="The Basis For Allocation text is too long"
                Width="8px">*</asp:CustomValidator></td>
    </tr>
</table>
