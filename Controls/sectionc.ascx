<%@ Control Language="C#" AutoEventWireup="true" CodeFile="sectionc.ascx.cs" Inherits="ProjectPortfolio.Controls.SectionC" %>

<script language="javascript">
<!--
function popupWindowAddFinancial(initiativeID, categoryID, financialID)
{
    /*
	var dialogwidth = 945
	var dialogheight = 290
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + "px,height=" + dialogheight + 
		"px,titlebar=no,status=no,dependent=yes"
    */
    
    var link = "Financial.aspx?InitiativeID=" + initiativeID + "&category=" + categoryID;
    
    if (financialID != null && financialID != 0) 
        link = link + "&record=" + financialID

	var returnCode;
	returnCode = window.showModalDialog(link, "financial_dialog", 
	    "dialogWidth:925px;dialogHeight:350px;status:no;resizable:no;scroll:no");
					
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            AllowOneTimeSubmit();
            window.document.forms[0].submit();
        }
    }
}

function popupWindowAddFinancialCapex(initiativeID, categoryID, financialID)
{
    /*
	var dialogwidth = 945
	var dialogheight = 290
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + "px,height=" + dialogheight + 
		"px,titlebar=no,status=no,dependent=yes"
    */
    
    var link = "FinancialCapex.aspx?InitiativeID=" + initiativeID + "&category=" + categoryID;
    
    if (financialID != null && financialID != 0) 
        link = link + "&record=" + financialID

	var returnCode;
	returnCode = window.showModalDialog(link, "financial_dialog", 
	    "dialogWidth:1000px;dialogHeight:600px;status:no;resizable:no;scroll:yes");
					
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            AllowOneTimeSubmit();
            window.document.forms[0].submit();
        }
    }
}

function popupWindowEditFinancial(initiativeID, categoryID, financialID)
{
    /*
	var dialogwidth = 575
	var dialogheight = 290
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + "px,height=" + dialogheight + 
		"px,titlebar=no,status=no,dependent=yes"
    */
    
    var link = "FinancialValues.aspx?InitiativeID=" + initiativeID + "&category=" + categoryID;
    
    if (financialID != null && financialID != 0) 
        link = link + "&record=" + financialID

    var returnCode;
	returnCode = window.showModalDialog(link, "financial_dialog",     
	            "dialogWidth:575px;dialogHeight:350px;status:no;resizable:no;scroll:no");
					
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            AllowOneTimeSubmit();
            window.document.forms[0].submit();
        }
    }
    
}

    //ERW 9 Mar 2009
    // this is basically from Experts exchange, but with a few changes.
    //http://74.125.77.132/search?q=cache:U-Gq6VYhqqYJ:www.experts-exchange.com/Programming/Languages/Scripting/JavaScript/Q_20337221.html+client+side+script+to+export+html+table+toe+xcel&hl=en&ct=clnk&cd=1&gl=uk&client=firefox-a 
    function transferCSV(TableID)
    {

        var r  = 0;
        csvout = window.document ;
        numofRows = TableID.rows.length-1;
        numofCells =  TableID.rows[0].cells.length-1    //
        var rowcsv= [numofRows];
        var cntrows = 0;
        for ( r == 0; r <= numofRows; r++) {
             var c =0;
             tempdata = "";
             for (c == 0; c<=numofCells; c++) {
                 if (c != numofCells) {
                     tempdata+= TableID.rows[r].cells[c].innerText + ",";
                    }else{
                     tempdata+= TableID.rows[r].cells[c].innerText + "<br>";
                    }
                  }
             rowcsv[r] = tempdata
             }
        csvout.open("text/html");
        var rowcnt = 0;
        for (rowcnt == 0; rowcnt<= rowcsv.length-1; rowcnt++){
            csvout.write(rowcsv[rowcnt]);
            } csvout.close();
    }


//-->
</script>

<table class="def" width="1950px">
	<tr class="ms-WPHeader">
		<td  colSpan="3">
		    <table><tr><td class="controltitle" style="width:40%">C) Initiative Financial Details: in M Euros </td><td style="width:10%; text-align:right"><asp:LinkButton ID="lnkBtnExcel2" runat="server" OnClick="lnkBtnExcel2_Click" Visible="false" >Export To Excel</asp:LinkButton></td><td></td></tr> </table>
		</td> 
		</tr>
	<tr>
		<td colSpan="3" height="5"></td>
	</tr>
	<tr>
	    <td class="summarylabel" valign="top" width="115px" >
	        1) BENEFITS
	    </td>
		<td align="left">
				<asp:repeater id="rptBenefits" EnableViewState="False" runat="server" OnItemDataBound="rptBenefits_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					    <tr>
					        <td class="headcell" colspan="7" align="center">Realisation Owner</td>
					        <td class="empty"></td>
					        <td class="empty"></td>
					        <td class="empty"></td>
					        <td class="headcell" runat="Server" id="tdSpanTitle" align="center">BENEFITS</td>
							<td class="emptynopadding"></td>
					    </tr>
						<tr runat="Server" id="trHeader">
							<td class="headcell" width="130px" align="left">Benefits Type</td>
							<td class="headcell" width="130px">Benefits Description</td>
							<td class="headcell" width="130px" align="center">Benefit Realisation Owner</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 7)</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 8)</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 9)</td>
							<td class="headcell" width="100px" align="center">Business/GT (Level 9)</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="headcell" width="85px" align="center">Start Date</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>
						<tr runat="Server" id="trTotal">
							<td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;"></td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Total Benefit</td>
							<td class="empty" style="background-color:#ffcc00;" width="10px"></td>
							<td class="emptytotal" style="background-color:#ffcc00;" width="85px">&nbsp;</td>
							<td class="empty" style="background-color:#ffcc00;" width="10px">&nbsp;</td>
						</tr>
						<tr>
						    <td class="empty" height="0px" colspan="25"></td>
						</tr>					
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td >
		</td>
	</tr>
	<tr height="30" valign="middle">
	    <td></td>
	    <td>
			<button runat="Server" id="btnAddBenefit" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button" onclick="ExportFinancialToExcel()">
				Add Benefit</button>
            <asp:LinkButton ID="lnkBtnExcel" runat="server" OnClick="lnkBtnExcel_Click" Visible="false" >Export To Excel</asp:LinkButton>
            </td>
	    <td></td>
	</tr>
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	        2) SPEND: <br><br> i) One Time Costs <br> <span style="font-weight:normal">a) GTO Expense</span> 
	    </td>
		<td align="left">
		
			 <asp:repeater id="rptSpendGTOOneTimeCosts" EnableViewState="False" runat="server" OnItemDataBound="rptSpendGTOOneTimeCosts_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					    <tr>
					        <td class="headcell" colspan="7" align="center">Responsibility</td>
					        <td class="empty"></td>
					        <td class="empty"></td>
					        <td class="empty"></td>
					        <td class="headcell" runat="Server" id="tdSpanTitle" align="center">SPEND</td>
							<td class="emptynopadding"></td>
					    </tr>
						<tr runat="Server" id="trHeader">
							<td class="headcell" width="130px" align="left">Spend Category</td>
							<td class="headcell" width="130px">Spend Description</td>
							<td class="headcell" width="130px" align="center">Detail As Necessary</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 7)</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 8)</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 9)</td>
							<td class="headcell" width="100px" align="center">Business/GT (Level 9)</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="headcell" width="85px" align="center">Start Date</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>							
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>        
                    
                        <!-- // Ionut: was removed because depreciations are added via Add CAPEX button       
                        
						<tr runat="Server" id="trDepreciation">
							<td class="depreciationcell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandName="Clear"></asp:ImageButton></td>
					                    <td runat="server" id="tdDepreciationType" style="font-weight:bold;" >CTB</td>
					                </tr>
					            </table>
							</td>
							<td class="depreciationcell" width="130px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							<td class="depreciationcell" width="130px" style="font-weight:bold;"></td>
							<td class="depreciationcell" width="130px" style="font-weight:bold;"></td>
							<td class="depreciationcell" width="130px" style="font-weight:bold;"></td>
							<td class="depreciationcell" width="100px" style="font-weight:bold;"></td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							<td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						-->
						
            			</table>
            		
                    </FooterTemplate>                
             </asp:repeater>
             
		</td>       				
		<td>
		</td>
	</tr>		
	 
	 
	 <tr>

	 	<td class="summarylabel" valign="top" align="right" width="110px" onmouseover="toolTip('You can add <b>Depreciation</b> via Add Capex button');" onmouseout="toolTip();">
	 	     <span style="font-weight:normal"><b>Depreciation</b></span>	        
	    </td>
	    
	    <td align="left">
	         <!-- Ionut -->      
             <asp:repeater id="rptSpendGTOOneTimeCostsDepreciation" EnableViewState="False" runat="server" OnItemDataBound="rptSpendGTOOneTimeCostsDepreciation_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
                	<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
                    <ItemTemplate>
                    	    <tr runat="Server" id="trDepreciation">                         	    
							    <td class="depreciationcell" width="129px">
					                <table cellpadding="0" cellspacing="0" border="0">
					                    <tr>
					                        
					                        <td runat="server" id="tdDepreciationType" style="font-weight:bold;">CTB</td>
					                    </tr>
					                </table>
							    </td>
							    <td class="depreciationcell" width="265px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;" ></td>
							    <td class="depreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="128px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="100px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						    </tr>
                    </ItemTemplate>    
                    <AlternatingItemTemplate>
                            <tr runat="Server" id="trDepreciation">                         	    
							    <td class="altdepreciationcell" width="129px">
					                <table cellpadding="0" cellspacing="0" border="0">
					                    <tr>
					                        
					                        <td runat="server" id="tdDepreciationType" style="font-weight:bold;">CTB</td>
					                    </tr>
					                </table>
							    </td>
							    <td class="altdepreciationcell" width="265px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							    <td class="altdepreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" width="128px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" width="100px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#DCFADE;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#DCFADE;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#DCFADE;">&nbsp;</td>
						    </tr>
                    </AlternatingItemTemplate>                           
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
             </asp:repeater>             
        </td>
        
        <td>
        </td>
        
     </tr>
	
	
	
	
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	        <span style="font-weight:normal">b) Business <br>Direct Expense</span> 
	    </td>
		<td align="left">
				<asp:repeater id="rptSpendBusinessOneTimeCosts" EnableViewState="False" runat="server" OnItemDataBound="rptSpendBusinessOneTimeCosts_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="131px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="131px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>
                    
                    <!-- Ionut These informations will be displayed in the next repeater
                    // Ionut: was removed because depreciations are added via Add CAPEX button
                    
						<tr runat="Server" id="trDepreciation">
							<td class="depreciationcell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandName="Clear"></asp:ImageButton></td>
					                    <td runat="server" id="tdDepreciationType" style="font-weight:bold;">CTB</td>
					                </tr>
					            </table>
							</td>
							<td class="depreciationcell" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							<td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr>
						    <td height="0px" colspan="25"></td>
						</tr>					
				        <tr runat="Server" id="trTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( i ):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Project Costs</td>
							<td class="empty" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>						
						<tr>
						    <td height="0px" colspan="25"></td>
						</tr>	
							
						End Ionut -->			
						
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>	
	
	<!-- Ionut depreciations + footer pentru Business Expense -->
	
	 <tr>

	 	<td class="summarylabel" valign="top" align="right" width="110px" onmouseover="toolTip('You can add <b>Depreciation</b> via Add Capex button');" onmouseout="toolTip();" >
	 	     <span style="font-weight:normal"><b>Depreciation</b></span>	        
	    </td>
	    
	    <td align="left">
	         <!-- Ionut -->      
             <asp:repeater id="rptSpendBusinessOneTimeCostsDepreciation" EnableViewState="False" runat="server" OnItemDataBound="rptSpendBusinessOneTimeCostsDepreciation_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
                	<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
                    <ItemTemplate>
                    	    <tr runat="Server" id="trDepreciation">   
                        	    
							    <td class="depreciationcell" width="129px">
					                <table cellpadding="0" cellspacing="0" border="0">
					                    <tr>
					                        
					                        <td runat="server" id="tdDepreciationType" style="font-weight:bold;">CTB</td>
					                    </tr>
					                </table>
							    </td>
							    <td class="depreciationcell" width="265px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							    <td class="depreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="128px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="100px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						    </tr>
                    </ItemTemplate>     
                    <AlternatingItemTemplate>
                            <tr runat="Server" id="trDepreciation">                         	    
						        <td class="altdepreciationcell" width="129px">
				                    <table cellpadding="0" cellspacing="0" border="0">
				                        <tr>
				                            
				                            <td runat="server" id="tdDepreciationType" style="font-weight:bold;">CTB</td>
				                        </tr>
				                    </table>
						        </td>
						        <td class="altdepreciationcell" width="265px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
						        <td class="altdepreciationcell" align="center" width="130px" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" align="center" width="130px" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" align="center" width="128px" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" align="center" width="100px" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
						        <td class="empty" width="10px" style="background-color:#DCFADE;"></td>
						        <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#DCFADE;">&nbsp;</td>
						        <td class="empty" width="10px" style="background-color:#DCFADE;">&nbsp;</td>
					        </tr>
                    </AlternatingItemTemplate>                          
                    <FooterTemplate>
                        <tr>
						    <td height="0px" colspan="25"></td>
						</tr>					
				        <tr runat="Server" id="trTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( i ):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Project Costs</td>
							<td class="empty" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>						
						<tr>
						    <td height="0px" colspan="25"></td>
						</tr>					
                        </table>
                    </FooterTemplate>
             </asp:repeater>             
        </td>
        
        <td>
        </td>
        
     </tr>
	
	
	<!-- End Ionut depreciations + footer Business Expense -->
	
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	        ii) RTB Incremental <br> <span style="font-weight:normal">a) GTO </span> 
	    </td>
		<td align="left">
				<asp:repeater id="rptSpendGTORunningCosts" EnableViewState="False" runat="server" OnItemDataBound="rptSpendGTORunningCosts_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>
                        <!-- // Ionut: was removed because depreciations are added via Add CAPEX button
						<tr runat="Server" id="trDepreciation">
							<td class="depreciationcell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandName="Clear"></asp:ImageButton></td>
					                    <td runat="server" id="tdDepreciationType" style="font-weight:bold;">RTB</td>
					                </tr>
					            </table>
							</td>
							<td class="depreciationcell" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							<td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						-->
            			</table>
                    </FooterTemplate>                
             </asp:repeater>
		</td>
		<td>
		</td>
	</tr>	
	
	<!-- Ionut : Depreciations for RTB incremental -->
	
		 <tr>

	 	<td class="summarylabel" valign="top" align="right" width="110px"  onmouseover="toolTip('You can add <b>Depreciation</b> via Add Capex button');" onmouseout="toolTip();">
	 	     <span style="font-weight:normal"><b>Depreciation</b></span>	        
	    </td>
	    
	    <td align="left">
	         <!-- Ionut -->      
             <asp:repeater id="rptSpendGTORunningCostsDepreciation" EnableViewState="False" runat="server" OnItemDataBound="rptSpendGTORunningCostsDepreciation_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
                	<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
                    <ItemTemplate>
                    	    <tr runat="Server" id="trDepreciation">                         	    
							    <td class="depreciationcell" width="129px">
					                <table cellpadding="0" cellspacing="0" border="0">
					                    <tr>
					                        
					                        <td runat="server" id="tdDepreciationType" style="font-weight:bold;">CTB</td>
					                    </tr>
					                </table>
							    </td>
							    <td class="depreciationcell" width="265px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							    <td class="depreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="128px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="100px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						    </tr>
                    </ItemTemplate>    
                    <AlternatingItemTemplate>
                            <tr runat="Server" id="trDepreciation">                         	    
							    <td class="altdepreciationcell" width="129px">
					                <table cellpadding="0" cellspacing="0" border="0">
					                    <tr>
					                        
					                        <td runat="server" id="tdDepreciationType" style="font-weight:bold;">CTB</td>
					                    </tr>
					                </table>
							    </td>
							    <td class="altdepreciationcell" width="265px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							    <td class="altdepreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" width="128px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" width="100px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#DCFADE;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#DCFADE;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#DCFADE;">&nbsp;</td>
						    </tr>
                    </AlternatingItemTemplate>                           
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
             </asp:repeater>             
        </td>
        
        <td>
        </td>
        
     </tr>
	
	<!-- End Depreciations for RTB Incremental -->
	
	<tr>
	    <td class="summarylabel" valign="top" width="110px">
	        <span style="font-weight:normal">b) Business <br>Direct </span> 
	    </td>
		<td align="left">
				<asp:repeater id="rptSpendBusinessRunningCosts" EnableViewState="False" runat="server" OnItemDataBound="rptSpendBusinessRunningCosts_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>
                    <!-- Ionut: This was removed because the depreciation are added wia capex button
						<tr runat="Server" id="trDepreciation">
							<td class="depreciationcell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandName="Clear"></asp:ImageButton></td>
					                    <td runat="server" id="tdDepreciationType" style="font-weight:bold;">RTB</td>
					                </tr>
					            </table>
							</td>							
							<td class="depreciationcell" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							<td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr>
						    <td height="0px" colspan="25"></td>
						</tr>					
				        <tr runat="server" id="trSubTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total (ii):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Running Costs</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" width="85px" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>						
				        <tr runat="server" id="trTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Total (i+ii):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Total Costs</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" width="85px" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>	
						<tr>
						    <td height="0px" colspan="25"></td>
						</tr>					
						-->
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>	
	
	<!-- Ionut depreciation + footer+footer for RTB Incremental -->
	
		 <tr>

	 	<td class="summarylabel" valign="top" align="right" width="110px" onmouseover="toolTip('You can add <b>Depreciation</b> via Add Capex button');" onmouseout="toolTip();">
	 	     <span style="font-weight:normal"><b>Depreciation</b></span>	        
	    </td>
	    
	    <td align="left">
	         <!-- Ionut -->      
             <asp:repeater id="rptSpendBusinessRunningCostsDepreciation" EnableViewState="False" runat="server" OnItemDataBound="rptSpendBusinessRunningCostsDepreciation_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
                	<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
                    <ItemTemplate>
                    	    <tr runat="Server" id="trDepreciation">   
                        	    
							    <td class="depreciationcell" width="129px">
					                <table cellpadding="0" cellspacing="0" border="0">
					                    <tr>
					                        
					                        <td runat="server" id="tdDepreciationType" style="font-weight:bold;">RTB</td>
					                    </tr>
					                </table>
							    </td>
							    <td class="depreciationcell" width="265px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							    <td class="depreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="128px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="depreciationcell" width="100px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						    </tr>
                    </ItemTemplate>     
                    <AlternatingItemTemplate>
                            <tr runat="Server" id="trDepreciation">                         	    
						        <td class="altdepreciationcell" width="129px">
				                    <table cellpadding="0" cellspacing="0" border="0">
				                        <tr>
				                            
				                            <td runat="server" id="tdDepreciationType" style="font-weight:bold;">RTB</td>
				                        </tr>
				                    </table>
						        </td>
						        <td class="altdepreciationcell" width="265px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
						        <td class="altdepreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" width="130px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" width="128px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" width="100px" align="center" style="font-weight:bold;"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
						        <td class="empty" width="10px" style="background-color:#DCFADE;"></td>
						        <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="85px" style="background-color:#DCFADE;">&nbsp;</td>
						        <td class="empty" width="10px" style="background-color:#DCFADE;">&nbsp;</td>
					        </tr>
                    </AlternatingItemTemplate>                          
                    <FooterTemplate>
                        <tr>
						    <td height="0px" colspan="25"></td>
						</tr>					
				        <tr runat="Server" id="trSubTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( ii ):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Running Costs</td>
							<td class="empty" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>	
						<tr runat="server" id="trTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Total (i+ii):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Total Costs</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" width="85px" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>												
						<tr>
						    <td height="0px" colspan="25"></td>
						</tr>					
                        </table>
                    </FooterTemplate>
             </asp:repeater>             
        </td>
        
        <td>
        </td>
        
     </tr>
	
	<!-- End Ionut depreciation + footer + footer for RTB Incremental -->
		
	<tr height="30" valign="middle">
	    <td></td>
	    <td>
			<button runat="Server" id="btnAddSpend" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add Spend</button>
        </td>
	    <td></td>
	</tr>
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	        iii) RTB Existing<br />
            <span style="font-weight:normal">a) GTO</span></td>
	    <td>
	        <%-- table enclosing old RTB Existing repeater removed - start --%>
	        <%-- table enclosing old RTB Existing repeater removed - end --%>
            <asp:repeater id="rptSpendRTBX_GTO" EnableViewState="False" runat="server" OnItemDataBound="rptSpendRTBX_GTO_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
                <AlternatingItemTemplate>
                    <tr runat="Server" id="trItem">
                        <td class="alternateincell" width="130px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="20px">
                                        <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>'
                                            CommandName="Delete" ImageUrl="~/Images/delete.gif" /></td>
                                    <td>
                                        <%# DataBinder.Eval(Container.DataItem,"Type")%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="alternateincell" width="130px">
                            <a id="lnkAddFinancial" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'>
                                <%# DataBinder.Eval(Container.DataItem,"Description")%>
                            </a>
                            <asp:TextBox ID="txtLegacyRTBExistingCheck" runat="server" CssClass="invisible"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLegacyRTB" runat="server" ControlToValidate="txtLegacyRTBExistingCheck"
                                ErrorMessage="Legacy RTB Existing needs to be converted" ValidationGroup="SubmitForReview">*</asp:RequiredFieldValidator>
                        </td>
                        <td class="alternateincell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"Comments")%>
                            &nbsp;</td>
                        <td class="alternateincell" width="131px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>
                            &nbsp;</td>
                        <td class="alternateincell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>
                            &nbsp;</td>
                        <td class="alternateincell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>
                            &nbsp;</td>
                        <td class="alternateincell" width="100px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>
                            &nbsp;</td>
                        <td class="empty" width="10px">
                            &nbsp;</td>
                        <td class="alternateincell" width="85px" align="center">
                            <%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>
                            &nbsp;</td>
                        <td class="empty" width="10px">
                            &nbsp;</td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
<%--
                    <tr>
                        <td height="0px" colspan="25">
                        </td>
                    </tr>
                    <tr runat="Server" id="trTotalRTBExisting">
                        <td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( i ):</td>
                        <td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">RTB Existing - GTO</td>
                        <td class="empty" style="background-color:#ffcc00;"></td>
                        <td class="emptytotal" style="background-color:#ffcc00;">&nbsp;</td>
                        <td class="empty" style="background-color:#ffcc00;">&nbsp;</td>
                    </tr>
--%>
                    <tr>
                        <td height="0px" colspan="25">
                        </td>
                    </tr>
                    </table>
                </FooterTemplate>
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2">
                </HeaderTemplate>
                <ItemTemplate>
                    <tr runat="Server" id="trItem">
                        <td class="incell" width="130px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="20px">
                                        <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>'
                                            CommandName="Delete" ImageUrl="~/Images/delete.gif" /></td>
                                    <td>
                                        <%# DataBinder.Eval(Container.DataItem,"Type")%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="incell" width="130px">
                            <a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'>
                                <%# DataBinder.Eval(Container.DataItem,"Description")%>
                            </a>
                            <asp:TextBox ID="txtLegacyRTBExistingCheck" runat="server" CssClass="invisible"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLegacyRTB" runat="server" ControlToValidate="txtLegacyRTBExistingCheck"
                                ErrorMessage="Legacy RTB Existing needs to be converted" ValidationGroup="SubmitForReview">*</asp:RequiredFieldValidator>
                        </td>
                        <td class="incell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"Comments")%>
                            &nbsp;</td>
                        <td class="incell" width="131px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>
                            &nbsp;</td>
                        <td class="incell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>
                            &nbsp;</td>
                        <td class="incell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>
                            &nbsp;</td>
                        <td class="incell" width="100px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>
                            &nbsp;</td>
                        <td class="empty" width="10px">
                            &nbsp;</td>
                        <td class="incell" width="85px" align="center">
                            <%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>
                            &nbsp;</td>
                        <td class="empty" width="10px">
                            &nbsp;</td>
                    </tr>
                </ItemTemplate>
            </asp:repeater>
	    </td>
	    <td>
	    </td>
    </tr>	
    <tr height="30" valign="middle">
        <td valign="top">
            b) Business Direct</td>
        <td>
            <asp:repeater id="rptSpendRTBX_BusinessDirect" EnableViewState="False" runat="server" OnItemDataBound="rptSpendRTBX_Business_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
                <AlternatingItemTemplate>
                    <tr runat="Server" id="trItem">
                        <td class="alternateincell" width="130px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="20px">
                                        <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>'
                                            CommandName="Delete" ImageUrl="~/Images/delete.gif" /></td>
                                    <td>
                                        <%# DataBinder.Eval(Container.DataItem,"Type")%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="alternateincell" width="130px">
                            <a id="lnkAddFinancial" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'>
                                <%# DataBinder.Eval(Container.DataItem,"Description")%>
                            </a>
                            <asp:TextBox ID="txtLegacyRTBExistingCheck" runat="server" CssClass="invisible"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLegacyRTB" runat="server" ControlToValidate="txtLegacyRTBExistingCheck"
                                ErrorMessage="Legacy RTB Existing needs to be converted" ValidationGroup="SubmitForReview">*</asp:RequiredFieldValidator>
                        </td>
                        <td class="alternateincell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"Comments")%>
                            &nbsp;</td>
                        <td class="alternateincell" width="131px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>
                            &nbsp;</td>
                        <td class="alternateincell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>
                            &nbsp;</td>
                        <td class="alternateincell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>
                            &nbsp;</td>
                        <td class="alternateincell" width="100px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>
                            &nbsp;</td>
                        <td class="empty" width="10px">
                            &nbsp;</td>
                        <td class="alternateincell" width="85px" align="center">
                            <%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>
                            &nbsp;</td>
                        <td class="empty" width="10px">
                            &nbsp;</td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td class="emptytotal" height="0px" colspan="25">
                        </td>
                    </tr>
<%--
                    <tr runat="Server" id="trTotalRTBExisting">
                        <td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( ii ):</td>
                        <td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">RTB Existing - Business Direct</td>
                        <td class="empty" style="background-color:#ffcc00;"></td>
                        <td class="emptytotal" style="background-color:#ffcc00;">&nbsp;</td>
                        <td class="empty" style="background-color:#ffcc00;">&nbsp;</td>
                    </tr>
--%>
<%--
                    </table>
--%>
                </FooterTemplate>
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2">
                    <colgroup>
                        <col class="incell" width="130px" />
                        <col class="incell" width="130px" />
                        <col class="incell" width="130px" align="center" />
                        <col class="incell" width="131px" align="center" />
                        <col class="incell" width="130px" align="center" />
                        <col class="incell" width="130px" align="center" />
                        <col class="incell" width="100px" align="center" />
                        <col class="empty" width="10px" />
                        <col class="incell" width="85px" align="center" />
                        <col class="empty" width="10px" />
                    </colgroup>
               </HeaderTemplate>
                <ItemTemplate>
                    <tr runat="Server" id="trItem">
                        <td class="incell" width="130px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="20px">
                                        <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>'
                                            CommandName="Delete" ImageUrl="~/Images/delete.gif" /></td>
                                    <td>
                                        <%# DataBinder.Eval(Container.DataItem,"Type")%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="incell" width="130px">
                            <a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancial(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'>
                                <%# DataBinder.Eval(Container.DataItem,"Description")%>
                            </a>
                            <asp:TextBox ID="txtLegacyRTBExistingCheck" runat="server" CssClass="invisible"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLegacyRTB" runat="server" ControlToValidate="txtLegacyRTBExistingCheck"
                                ErrorMessage="Legacy RTB Existing needs to be converted" ValidationGroup="SubmitForReview">*</asp:RequiredFieldValidator>
                        </td>
                        <td class="incell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"Comments")%>
                            &nbsp;</td>
                        <td class="incell" width="131px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>
                            &nbsp;</td>
                        <td class="incell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>
                            &nbsp;</td>
                        <td class="incell" width="130px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>
                            &nbsp;</td>
                        <td class="incell" width="100px" align="center">
                            <%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>
                            &nbsp;</td>
                        <td class="empty" width="10px">
                            &nbsp;</td>
                        <td class="incell" width="85px" align="center">
                            <%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>
                            &nbsp;</td>
                        <td class="empty" width="10px">
                            &nbsp;</td>
                    </tr>
                </ItemTemplate>
            </asp:repeater>
            <asp:repeater id="rptSpendRTBX_Total" EnableViewState="False" runat="server" OnItemDataBound="rptSpendRTBX_Total_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
                <HeaderTemplate>
<%--
                    <table class="datatable" cellSpacing="0" cellPadding="2">
                    <colgroup>
                        <col class="incell" width="130px" />
                        <col class="incell" width="130px" />
                        <col class="incell" width="130px" align="center" />
                        <col class="incell" width="131px" align="center" />
                        <col class="incell" width="130px" align="center" />
                        <col class="incell" width="130px" align="center" />
                        <col class="incell" width="100px" align="center" />
                        <col class="empty" width="10px" />
                        <col class="incell" width="85px" align="center" />
                        <col class="empty" width="10px" />
                    </colgroup>
--%>
                    <tr style="display:none;">
                        <td class="incell" width="130px">&nbsp;</td>
                        <td class="incell" width="130px" />
                        <td class="incell" width="130px" align="center">&nbsp;</td>
                        <td class="incell" width="131px" align="center">&nbsp;</td>
                        <td class="incell" width="130px" align="center">&nbsp;</td>
                        <td class="incell" width="130px" align="center">&nbsp;</td>
                        <td class="incell" width="100px" align="center">&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                        <td class="incell" width="85px" align="center">&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                    </tr>
                </HeaderTemplate>
                <FooterTemplate>
                    <tr>
                        <td height="0px" colspan="25">
                        </td>
                    </tr>
                    <tr runat="Server" id="trTotalRTBExisting">
                        <td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( iii ):</td>
                        <td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;" width="776px">Total RTB Existing</td>
                        <td class="emptytotal" style="background-color:#ffcc00;"></td>
                        <td class="emptytotal" style="background-color:#ffcc00;">&nbsp;</td>
                        <td class="emptytotal" style="background-color:#ffcc00;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="emptytotal" height="0px" colspan="25">
                        </td>
                    </tr>
                    </table>
                </FooterTemplate>
            </asp:repeater>
        </td>
        <td>
        </td>
    </tr>
	<tr height="30" valign="middle">
	    <td></td>
	    <td>
			<button runat="Server" id="btnAddRTBExisting" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add RTB Existing</button>
        </td>
	    <td></td>
	</tr>
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	    </td>
	    <td>
            <table cellSpacing="0" cellPadding="2">
                <tr height="0px">
			        <td class="empty" width="130px"></td>
			        <td class="empty" width="130px"></td>
			        <td class="empty" width="130px"></td>
			        <td class="empty" width="130px"></td>
			        <td class="empty" width="130px"></td>
			        <td class="empty" width="130px"></td>
			        <td class="empty" width="100px"></td>
			        <td class="empty" width="10px"></td>
			        <td class="emptytotal" width="85px"></td>
			        <td class="empty" width="10px"></td>
			    </tr>
			    <tr>
			        <td class="empty" colspan="5" align="left" style="font-weight:bold; height: 26px;">Has additional data centre consumption been taken into consideration when calculating RTB costs?</td>
			        <td class="empty" colspan="2" align="left" style="height: 26px">
			            <asp:DropDownList runat="Server" ID="ddlAdditionalConsumption" CssClass="textselect" Width="120px">
			                <asp:ListItem Value="0" Text="Please Select" Selected="True"></asp:ListItem>
			                <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
			                <asp:ListItem Value="2" Text="N/A"></asp:ListItem>
			            </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlAdditionalConsumption"
                            ErrorMessage="Data Centre Consumption must not be blank" InitialValue="0" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator></td>
			        <td class="empty" width="10px" style="height: 26px"></td>
			        <td class="empty" width="85px" style="height: 26px">&nbsp;</td>
			        <td class="empty" width="10px" style="height: 26px">&nbsp;</td>
			    </tr>
		    </table>
	    </td>
	    <td>
	    </td>
    </tr>	
    
	<tr height="10px" valign="middle">
	    <td></td>
	    <td></td>
	    <td></td>
	</tr>    
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >3) GTO Analysis </td>
	    <td>
            <asp:repeater id="rptGTOAnalysis" EnableViewState="False" runat="server" OnItemDataBound="rptGTOAnalysis_ItemDataBound">
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2">
                </HeaderTemplate>
                <FooterTemplate>
	                <tr>
	                    <td class="emptynopadding" height="0px" colspan="20"></td>
	                </tr>					
	                <tr runat="Server" id="trSubTotal1">
		                <td class="empty" width="925px"></td>
		                <td class="empty" width="105px" style="background-color:#F0FFF2; font-weight:bold;">CTB</td>
	                </tr>
	                <tr runat="Server" id="trSubTotal2">
		                <td class="empty" width="925px"></td>
		                <td class="empty" width="105px" style="background-color:#F0FFF2; font-weight:bold;">MAN</td>
	                </tr>
	                <tr runat="Server" id="trSubTotal3">
		                <td class="empty" width="925px"></td>
		                <td class="empty" width="105px" style="background-color:#F0FFF2; font-weight:bold;">RTB Incremental</td>
	                </tr>
	                <tr runat="Server" id="trTotal">
		                <td class="emptytotal" colspan="2" style="background-color:#ffcc00; font-weight:bold;">GTO Total</td>
	                </tr>
					<tr>
					    <td height="0px" colspan="25"></td>
					</tr>					
	                </table>
                </FooterTemplate>       
            </asp:repeater>
        </td>
        <td></td>
    </tr>
	<tr height="20" valign="middle">
	    <td></td>
	    <td></td>
	    <td></td>
	</tr>    
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	        <span style="font-weight:normal">
                <asp:Label ID="Label4" runat="server" Text="4) CAPEX Analysis:" Width="112px" Font-Bold="True"></asp:Label><br />
                <br />
                <asp:Label ID="lblCapitalHardware" runat="server" Text="a) Capital Hardware " Width="112px" Visible="False"></asp:Label></span></td>
		<td align="left">
				<asp:repeater id="rptCAPEXCapitalHardware" EnableViewState="False" runat="server" OnItemDataBound="rptCAPEXCapitalHardware_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
						<tr runat="server" id="trHeader">
							<td class="headcell" width="130px" align="left">Capex Owner</td>
							<td class="headcell" width="130px">Spend Description</td>
							<td class="headcell" width="130px" align="center">Name</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 7)</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 8)</td>
							<td class="headcell" width="130px" align="center">Business/GT (Level 9)</td>
							<td class="headcell" width="100px" align="center">Business/GT (Level 9)</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="headcell" width="85px" align="center">Start Date</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancialCapex(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancialCapex(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                        <FooterTemplate>                                        
				        <tr runat="server" id="trblank11" align="right">
				            <td height="3px" colspan="25" style="border: solid 1px"></td>
				        </tr>					
				        <tr runat="server" id="trblank21">
				            <td height="3px" colspan="25"></td>
				        </tr>					
						<tr runat="server" id="trSubTotal11">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalGTOCapex1" runat="server" Text="Total GTO Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal21">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" style="background-color:#F0FFF2;" colspan="6"><asp:Label ID="lblTotalBusinessCapex1" runat="server" Text="Total Business Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal31">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalCapex1" runat="server" Text="Total Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trblank31">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="depreciationcell" runat="Server" id="tdSpan" style="background-color:#F0FFF2;" align="center">&nbsp;</td>
							<td class="emptynopadding"></td>
						</tr>
				        <tr runat="server" id="trblank41">
				            <td height="1px" colspan="25"></td>
				        </tr>					
						<tr runat="server" id="trDepreciation1">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalDepreciation1" runat="server" Text="Total Depreciation"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
				        <tr runat="server" id="trblank51">
				            <td height="1px" colspan="25"></td>
				        </tr>					                    
            			</table>
                    </FooterTemplate>                
             </asp:repeater>
		</td>
		<td>
		</td>
	</tr>	
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	        <span style="font-weight:normal">
                <asp:Label ID="lblBuildingPremises" runat="server" Text="b) Building / Premises " Width="112px" Visible="False"></asp:Label></span></td>
		<td align="left">
				<asp:repeater id="rptCAPEXBuildingPremises" EnableViewState="False" runat="server" OnItemDataBound="rptCAPEXBuildingPremises_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancialCapex(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancialCapex(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>                                        
				        <tr runat="server" id="trblank12" align="right">
				            <td height="3px" colspan="25" style="border: solid 1px"></td>
				        </tr>					
				        <tr runat="server" id="trblank22">
				            <td height="3px" colspan="25"></td>
				        </tr>					
						<tr runat="server" id="trSubTotal12">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalGTOCapex2" runat="server" Text="Total GTO Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal22">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" style="background-color:#F0FFF2;" colspan="6"><asp:Label ID="lblTotalBusinessCapex2" runat="server" Text="Total Business Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal32">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalCapex2" runat="server" Text="Total Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trblank32">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="depreciationcell" runat="Server" id="tdSpan" style="background-color:#F0FFF2;" align="center">&nbsp;</td>
							<td class="emptynopadding"></td>
						</tr>
				        <tr runat="server" id="trblank42">
				            <td height="1px" colspan="25"></td>
				        </tr>					
						<tr runat="server" id="trDepreciation2">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalDepreciation2" runat="server" Text="Total Depreciation"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
				        <tr runat="server" id="trblank52">
				            <td height="1px" colspan="25"></td>
				        </tr>					
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>		
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	        <span style="font-weight:normal">
                <asp:Label ID="lblCapitalSoftware" runat="server" Text="c) Capital Software " Width="112px" Visible="False"></asp:Label></span></td>
		<td align="left">
				<asp:repeater id="rptCAPEXCapitalSoftware" EnableViewState="False" runat="server" OnItemDataBound="rptCAPEXCapitalSoftware_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancialCapex(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancialCapex(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                     <FooterTemplate>                                        
				        <tr runat="server" id="trblank13" align="right">
				            <td height="3px" colspan="25" style="border: solid 1px"></td>
				        </tr>					
				        <tr runat="server" id="trblank23">
				            <td height="3px" colspan="25"></td>
				        </tr>					
						<tr runat="server" id="trSubTotal13">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalGTOCapex3" runat="server" Text="Total GTO Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal23">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" style="background-color:#F0FFF2;" colspan="6"><asp:Label ID="lblTotalBusinessCapex3" runat="server" Text="Total Business Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal33">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalCapex3" runat="server" Text="Total Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trblank33">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="depreciationcell" runat="Server" id="tdSpan" style="background-color:#F0FFF2;" align="center">&nbsp;</td>
							<td class="emptynopadding"></td>
						</tr>
				        <tr runat="server" id="trblank43">
				            <td height="1px" colspan="25"></td>
				        </tr>					
						<tr runat="server" id="trDepreciation3">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalDepreciation3" runat="server" Text="Total Depreciation"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
				        <tr runat="server" id="trblank53">
				            <td height="1px" colspan="25"></td>
				        </tr>					
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>
	<tr>
	    <td class="summarylabel" valign="top" width="110px" >
	        <span style="font-weight:normal">
                <asp:Label ID="lblMarketData" runat="server" Text="d) Market Data" Width="112px" Visible="False"></asp:Label></span></td>
		<td align="left">
				<asp:repeater id="rptCAPEXMarketData" EnableViewState="False" runat="server" OnItemDataBound="rptCAPEXMarketData_ItemDataBound" OnItemCommand="repeaters_ItemCommand">
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancialCapex(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="130px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td width="20px"><asp:ImageButton runat="server" ID="imgDelete" CausesValidation="false" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeFinancialID")%>' CommandName="Delete"></asp:ImageButton></td>
					                    <td><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="130px"><a id="lnkAddFinancial" runat="server" href="#" onclick='<%# "javascript:popupWindowAddFinancialCapex(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"CategoryID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeFinancialID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"Description")%></a></td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="130px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="100px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="85px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>                                        
				        <tr runat="server" id="trblank1" align="right">
				            <td height="3px" colspan="25" style="border: solid 1px"></td>
				        </tr>					
				        <tr runat="server" id="trblank2">
				            <td height="3px" colspan="25"></td>
				        </tr>					
						<tr runat="server" id="trSubTotal1">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalGTOCapex" runat="server" Text="Total GTO Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal2">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" style="background-color:#F0FFF2;" colspan="6"><asp:Label ID="lblTotalBusinessCapex" runat="server" Text="Total Business Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal3">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalCapex" runat="server" Text="Total Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trblank3">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="depreciationcell" runat="Server" id="tdSpan" style="background-color:#F0FFF2;" align="center">&nbsp;</td>
							<td class="emptynopadding"></td>
						</tr>
				        <tr runat="server" id="trblank4">
				            <td height="1px" colspan="25"></td>
				        </tr>					
						<tr runat="server" id="trDepreciation">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalDepreciation" runat="server" Text="Total Depreciation"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="85px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
				        <tr runat="server" id="trblank5">
				            <td height="1px" colspan="25"></td>
				        </tr>					
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>			
    <tr height="30" valign="middle">
	    <td></td>
	    <td>
			<button runat="Server" id="btnAddCapex" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add Capex</button>
	    </td>
	    <td></td>
	</tr>		
	<tr>
	    <td class="summarylabel" valign="top" width="110px" style="background-color:#F0FFF2;border: 1px solid; border-right: 0px solid;">5) PAYBACK </td>
	    <td>
            <asp:repeater id="rptPayBack" EnableViewState="False" runat="server" OnItemDataBound="rptPayBack_ItemDataBound">
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2" style="border-left: 0px solid;">
                </HeaderTemplate>
                <FooterTemplate>
	                <tr>
	                    <td class="emptynopadding" height="0px" colspan="25"></td>
	                </tr>					
	                <tr runat="Server" id="trNetCashFlow">
		                <td class="empty" width="130px" style="background-color:#F0FFF2; font-weight:bold;">&nbsp;</td>
		                <td class="empty" width="895px" style="background-color:#F0FFF2; font-weight:bold;">Net Cash flow</td>
	                </tr>
	                <tr runat="Server" id="trNetCashFlowCumulated">
		                <td class="empty" width="130px" style="background-color:#F0FFF2; font-weight:bold;">&nbsp;</td>
		                <td class="empty" width="895px" style="background-color:#F0FFF2; font-weight:bold;"><i>Net Cash flow cumulated</i></td>
	                </tr>
	                <tr>
	                    <td class="emptynopadding" height="0px" colspan="25"></td>
	                </tr>					
	                </table>
                </FooterTemplate>       
            </asp:repeater>
        </td>
        <td></td>
    </tr>	
	
</table>
