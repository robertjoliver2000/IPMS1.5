<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SectionC_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.SectionC_PrintVersion" %>

<style>
BODY TABLE TD A P { font-size:50%;}
</style>
<table class="def">
	<tr class="ms-WPHeader">
		<td class="controltitle" colSpan="3">C) Initiative Financial Details: in M Euros</td>
	</tr>
	<tr>
		<td colSpan="3" height="5"></td>
	</tr>
	<tr>
	    <td class="summarylabel" valign="top" width="95px" >
	        1) BENEFITS
	    </td>
		<td align="left" colspan="2">
				<asp:repeater id="rptBenefits" EnableViewState="False" runat="server" OnItemDataBound="rptBenefits_ItemDataBound">
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
							<td class="headcell" width="55px" align="left">Type</td>
							<td class="headcell" width="60px">Description</td>
							<td class="headcell" width="60px" align="center">Realisation Owner</td>
							<td class="headcell" width="60px" align="center">Level 7</td>
							<td class="headcell" width="60px" align="center">Level 8</td>
							<td class="headcell" width="60px" align="center">Level 9</td>
							<td class="headcell" width="60px" align="center">Level 9</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="headcell" width="52" align="center">Start Date</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="incell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem,"StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="alternateincell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>                    
						<tr runat="Server" id="trTotal">
							<td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;"></td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Total Benefit</td>
							<td class="empty" style="background-color:#ffcc00;" width="10px"></td>
							<td class="emptytotal" style="background-color:#ffcc00;" width="52">&nbsp;</td>
							<td class="empty" style="background-color:#ffcc00;" width="10px">&nbsp;</td>
						</tr>
						<tr>
						    <td class="empty" height="0px" colspan="24"></td>
						</tr>										
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>
	<tr height="20" valign="middle">
	    <td></td>
	    <td>
	    </td>
	    <td></td>
	</tr>
	

	
	<tr>
	    <td class="summarylabel" valign="top" width="95px" >
	        2) SPEND: <br><br> i) One Time Costs <br> <span style="font-weight:normal">a) GTO Expense</span> 
	    </td>
		<td align="left" colspan="2">
				<asp:repeater id="rptSpendGTOOneTimeCosts" EnableViewState="False" runat="server" OnItemDataBound="rptSpendGTOOneTimeCosts_ItemDataBound" >
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
							<td class="headcell" width="55px" align="left">Category</td>
							<td class="headcell" width="60px">Description</td>
							<td class="headcell" width="60px" align="center">Detail</td>
							<td class="headcell" width="60px" align="center">Level 7</td>
							<td class="headcell" width="60px" align="center">Level 8</td>
							<td class="headcell" width="60px" align="center">Level 9</td>
							<td class="headcell" width="60px" align="center">Level 9</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="headcell" width="52" align="center">Start Date</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="incell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="incell" width="60px"  ><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="incell" width="60px"  align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="60px"  align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="60px"  align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>							
							<td class="incell" width="60px"  align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="60px"  align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					
					<AlternatingItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="alternateincell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="alternateincell"  width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="alternateincell"  width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell"  width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell"  width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell"  width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell"  width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    
                    <FooterTemplate>
                    <!-- Ionut: Depreciations are displayed in other list
						<tr runat="Server" id="trDepreciation">
							<td class="depreciationcell" style="font-weight:bold;">CTB</td>
							<td class="depreciationcell" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							<td align="center" id="tdStartDate" runat="server" class="emptytotal" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
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
	
		<!-- Ionut Add Depreciation List 1-->
	
		 <tr>

	 	<td class="summarylabel" valign="top" align="right" >
	 	     <span><b>Depreciation</b></span>	        
	    </td>
	    
	    <td align="left" colspan="2">
	         <!-- Ionut -->      
             <asp:repeater id="rptSpendGTOOneTimeCostsDepreciation" EnableViewState="False" runat="server" OnItemDataBound="rptSpendGTOOneTimeCostsDepreciation_ItemDataBound">
                	<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
                    <ItemTemplate>
                    	    <tr runat="Server" id="trDepreciation">   
							    <td class="depreciationcell" width="55px" runat="server" id="tdDepreciationType" >CTB</td>
							    <td class="depreciationcell" width="120px" colspan="2" runat="Server" id="tdDescription" ></td>							    							    
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px" ><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px" ><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px" ><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px" ><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="55px" style="background-color:#F0FFF2;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						    </tr>
                    </ItemTemplate>    
                    <AlternatingItemTemplate>
                            <tr runat="Server" id="trDepreciation">                         	    
							    <td class="altdepreciationcell" width="55px" runat="server" id="tdDepreciationType">CTB</td>
							    <td class="altdepreciationcell" width="120px" colspan="2" runat="Server" id="tdDescription" ></td>							    
							    <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px" ><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px" ><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px" ><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px" ><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#DCFADE;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="55px" style="background-color:#DCFADE;">&nbsp;</td>
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
	
	<!-- End Ionut Depreciation 1 -->
	
	
	<tr>
	    <td class="summarylabel" valign="top" width="95px" >
	        <span style="font-weight:normal">b) Business Direct Expense</span> 
	    </td>
		<td align="left" colspan="2">
				<asp:repeater id="rptSpendBusinessOneTimeCosts" EnableViewState="False" runat="server" OnItemDataBound="rptSpendBusinessOneTimeCosts_ItemDataBound" >
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
					    <tr>
					        <td class="headcell" colspan="7" align="center"></td>
					        <td class="empty"></td>
					        <td class="empty"></td>
					        <td class="empty"></td>
					        <td class="headcell" runat="Server" id="tdSpanTitle" align="center"></td>
							<td class="emptynopadding"></td>
					    </tr>
						<tr runat="Server" id="trItem">
							<td class="incell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="Server" id="trItem">
							<td class="alternateincell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="52px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>
                    <!--
						<tr runat="Server" id="trDepreciation">
							<td class="depreciationcell" width="55px" style="font-weight:bold;">CTB</td>
							<td class="depreciationcell" width="120px" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							<td class="depreciationcell" width="60px" style="font-weight:bold;"></td>
							<td class="depreciationcell" width="60px" style="font-weight:bold;"></td>
							<td class="depreciationcell" width="60px" style="font-weight:bold;"></td>
							<td class="depreciationcell" width="60px" style="font-weight:bold;"></td>
							<td class="empty"  width="10px" style="background-color:#F0FFF2;"></td>
							<td align="center" id="tdStartDate" runat="server" class="emptytotal" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr>
						    <td height="0px" colspan="24"></td>
						</tr>					
				        <tr runat="Server" id="trTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( i ):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Project Costs</td>
							<td class="empty" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" width="52px" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>						
						<tr>
						    <td height="0px" colspan="24"></td>
						</tr>		
						-->			
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>	
	
		<!-- Ionut depreciations + footer pentru Business Expense -->
	
	 <tr>

	 	<td class="summarylabel" valign="top" align="right" width="95px">
	 	     <span ><b>Depreciation</b></span>	        
	    </td>
	    
	    <td align="left" colspan="2">
	         <!-- Ionut -->      
             <asp:repeater id="rptSpendBusinessOneTimeCostsDepreciation" EnableViewState="False" runat="server" OnItemDataBound="rptSpendBusinessOneTimeCostsDepreciation_ItemDataBound">
                	<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
                    <ItemTemplate>
                    	    <tr runat="Server" id="trDepreciation">                           	    
							    <td class="depreciationcell" width="55px" runat="server" id="tdDepreciationType">CTB</td>
							    <td class="depreciationcell" width="120px" colspan="2" runat="Server" id="tdDescription" ></td>							    
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="55px" style="background-color:#F0FFF2;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						    </tr>
                    </ItemTemplate>     
                    <AlternatingItemTemplate>
                            <tr runat="Server" id="trDepreciation">                         	    						        
						        <td class="altdepreciationcell" width="55px" runat="server" id="tdDepreciationType">CTB</td>
						        <td class="altdepreciationcell" width="120px" colspan="2" runat="Server" id="tdDescription"></td>
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>						        
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
						        <td class="empty" width="10px" style="background-color:#DCFADE;"></td>
						        <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="55px" style="background-color:#DCFADE;">&nbsp;</td>
						        <td class="empty" width="10px" style="background-color:#DCFADE;">&nbsp;</td>
					        </tr>
                    </AlternatingItemTemplate>                          
                    <FooterTemplate>
                        <tr>
						    <td height="0px" colspan="24"></td>
						</tr>					
				        <tr runat="Server" id="trTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( i ):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Project Costs</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>						
						<tr>
						    <td height="0px" colspan="24"></td>
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
	    <td class="summarylabel" valign="top" width="95px" >
	        ii) RTB Incremental <br> <span style="font-weight:normal">a) GTO </span> 
	    </td>
		<td align="left" colspan="2">
				<asp:repeater id="rptSpendGTORunningCosts" EnableViewState="False" runat="server" OnItemDataBound="rptSpendGTORunningCosts_ItemDataBound" >
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="60px" style="WORD-BREAK:BREAK-ALL" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty">&nbsp;</td>
							<td class="alternateincell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>
                    <!-- 
						<tr runat="Server" id="trDepreciation">
							<td class="depreciationcell" style="font-weight:bold;">RTB</td>
							<td class="depreciationcell" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							<td align="center" id="tdStartDate" runat="server" class="emptytotal" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
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

	 	<td class="summarylabel" valign="top" align="right" width="95px" >
	 	     <span><b>Depreciation</b></span>	        
	    </td>
	    
	    <td align="left" colspan="2">
	         <!-- Ionut -->      
             <asp:repeater id="rptSpendGTORunningCostsDepreciation" EnableViewState="False" runat="server" OnItemDataBound="rptSpendGTORunningCostsDepreciation_ItemDataBound">
                	<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
                    <ItemTemplate>
                    	    <tr runat="Server" id="trDepreciation">                         	    
							    <td class="depreciationcell" width="55px" runat="server" id="tdDepreciationType" >CTB</td>
							    <td class="depreciationcell" width="120px" colspan="2" runat="Server" id="tdDescription"></td>							    
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="55px" style="background-color:#F0FFF2;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						    </tr>
                    </ItemTemplate>    
                    <AlternatingItemTemplate>
                            <tr runat="Server" id="trDepreciation">                         	    
		                        <td class="altdepreciationcell" width="55px" runat="server" id="tdDepreciationType" >CTB</td>
							    <td class="altdepreciationcell" width="120px" colspan="2" runat="Server" id="tdDescription"></td>
							    <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>							    
							    <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#DCFADE;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="55px" style="background-color:#DCFADE;">&nbsp;</td>
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
	    <td class="summarylabel" valign="top" width="95px" >
	        <span style="font-weight:normal">b) Business Direct </span> 
	    </td>
		<td align="left" colspan="2">
				<asp:repeater id="rptSpendBusinessRunningCosts" EnableViewState="False" runat="server" OnItemDataBound="rptSpendBusinessRunningCosts_ItemDataBound" >
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="55px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>
                    <!--
						<tr runat="Server" id="trDepreciation">
							<td class="depreciationcell" style="font-weight:bold;">RTB</td>
							<td class="depreciationcell" runat="Server" id="tdDescription" colspan="2" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="depreciationcell" style="font-weight:bold;"></td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							<td align="center" id="tdStartDate" runat="server" class="emptytotal" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr>
						    <td height="0px" colspan="24"></td>
						</tr>					
				        <tr runat="server" id="trSubTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Sub Total (ii):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Running Costs</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" width="52" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>						
				        <tr runat="server" id="trTotal">
							<td class="emptytotal" colspan="1" style="background-color:#ffcc00; font-weight:bold;">Total (i+ii):</td>
							<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">Total Costs</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;"></td>
							<td class="emptytotal" width="52" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>	
						<tr>
						    <td height="0px" colspan="24"></td>
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

	 	<td class="summarylabel" valign="top" align="right" width="95px">
	 	     <span><b>Depreciation</b></span>	        
	    </td>
	    
	    <td align="left" colspan="2">
	         <!-- Ionut -->      
             <asp:repeater id="rptSpendBusinessRunningCostsDepreciation" EnableViewState="False" runat="server" OnItemDataBound="rptSpendBusinessRunningCostsDepreciation_ItemDataBound" >
                	<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
                    <ItemTemplate>
                    	    <tr runat="Server" id="trDepreciation">   
                                <td class="depreciationcell" width="55px" runat="server" id="tdDepreciationType">RTB</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" width="120px" colspan="2" runat="Server" id="tdDescription"></td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>							    
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							    <td class="depreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;"></td>
							    <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="55px" style="background-color:#F0FFF2;">&nbsp;</td>
							    <td class="empty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						    </tr>
                    </ItemTemplate>     
                    <AlternatingItemTemplate>
                            <tr runat="Server" id="trDepreciation">                         	    
						        <td class="altdepreciationcell" width="55px" runat="server" id="tdDepreciationType" >RTB</td>
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" width="120px" colspan="2" runat="Server" id="tdDescription"></td>
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>						        
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
						        <td class="altdepreciationcell" style="WORD-BREAK:BREAK-ALL" align="center" width="60px"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
						        <td class="empty" width="10px"  style="background-color:#DCFADE;"></td>
						        <td align="center" id="tdStartDate" runat="server" class="emptytotal" width="55px" style="background-color:#DCFADE;">&nbsp;</td>
						        <td class="empty" width="10px" style="background-color:#DCFADE;">&nbsp;</td>
					        </tr>
                    </AlternatingItemTemplate>                          
                    <FooterTemplate>
                        <tr>
						    <td height="0px" colspan="24"></td>
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
							<td class="emptytotal" width="55px" style="background-color:#ffcc00;">&nbsp;</td>
							<td class="empty" width="10px" style="background-color:#ffcc00;">&nbsp;</td>
						</tr>												
						<tr>
						    <td height="0px" colspan="24"></td>
						</tr>					
                        </table>
                    </FooterTemplate>
             </asp:repeater>             
        </td>
        
        <td>
        </td>
        
     </tr>
	
	<!-- End Ionut depreciation + footer + footer for RTB Incremental -->
	
		
	<tr height="20" valign="middle">
	    <td></td>
	    <td>
	    </td>
	    <td></td>
	</tr>
	<tr>
	    <td class="summarylabel" valign="top" width="95px" >
	        iii) RTB Existing<br />
            <span style="font-weight:normal">a) GTO</span></td>
	    <td>
            <asp:repeater id="rptSpendRTBX_GTO" EnableViewState="False" runat="server" OnItemDataBound="rptSpendRTBX_GTO_ItemDataBound">
                <AlternatingItemTemplate>
                    <tr runat="Server" id="trItem">
                        <td class="alternateincell" width="55px">
							<%# DataBinder.Eval(Container.DataItem,"Type")%>
                        </td>
                        <td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                        <td class="alternateincell" width="52px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
<%-- Rev 1.7.3, GMcF
                    <tr>
                        <td height="0px" colspan="25">
                        </td>
                    </tr>
                    <tr runat="Server" id="trTotalRTBExisting">
						<td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( i ):</td>
						<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">RTB Existing - GTO</td>
						<td class="empty" style="background-color:#ffcc00;" width="10px"></td>
						<td class="emptytotal" style="background-color:#ffcc00;" width="52">&nbsp;</td>
						<td class="empty" style="background-color:#ffcc00;" width="10px">&nbsp;</td>
                    </tr>
--%>
                    <tr>
                        <td height="0px" colspan="25"></td>
                    </tr>
                    </table>
                </FooterTemplate>
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2">
                </HeaderTemplate>
                <ItemTemplate>
                    <tr runat="Server" id="trItem">
                        <td class="incell" width="55px">
                            <%# DataBinder.Eval(Container.DataItem,"Type")%>
                        </td>
                        <td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                        <td class="incell" width="52px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
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
            <asp:repeater id="rptSpendRTBX_BusinessDirect" EnableViewState="False" runat="server" OnItemDataBound="rptSpendRTBX_Business_ItemDataBound">
                <AlternatingItemTemplate>
                    <tr runat="Server" id="trItem">
                        <td class="alternateincell" width="55px">
                            <%# DataBinder.Eval(Container.DataItem,"Type")%>
                        </td>
                        <td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
                        <td class="alternateincell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                        <td class="alternateincell" width="52px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td class="emptytotal" height="0px" colspan="25">
                        </td>
                    </tr>
<%-- Rev 1.7.3, GMcF
                    <tr runat="Server" id="trTotalRTBExisting">
						<td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( ii ):</td>
						<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;">RTB Existing - Business Direct</td>
						<td class="empty" style="background-color:#ffcc00;" width="10px"></td>
						<td class="emptytotal" style="background-color:#ffcc00;" width="52">&nbsp;</td>
						<td class="empty" style="background-color:#ffcc00;" width="10px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="0px" colspan="25">
                        </td>
                    </tr>
--%>
                </FooterTemplate>
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2">
                    <colgroup>
                        <col class="incell" width="55px" />
                        <col class="incell" width="60px" />
                        <col class="incell" width="60px" align="center" />
                        <col class="incell" width="60px" align="center" />
                        <col class="incell" width="60px" align="center" />
                        <col class="incell" width="60px" align="center" />
                        <col class="incell" width="60px" align="center" />
                        <col class="empty" width="10px" />
                        <col class="incell" width="52px" align="center" />
                        <col class="empty" width="10px" />
                    </colgroup>
               </HeaderTemplate>
                <ItemTemplate>
                    <tr runat="Server" id="trItem">
                        <td class="incell" width="55px">
							<%# DataBinder.Eval(Container.DataItem,"Type")%>
                        </td>
                        <td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
                        <td class="incell" style="WORD-BREAK:BREAK-ALL" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                        <td class="incell" width="52px" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                    </tr>
                </ItemTemplate>
            </asp:repeater>
            <asp:repeater id="rptSpendRTBX_Total" EnableViewState="False" runat="server" OnItemDataBound="rptSpendRTBX_Total_ItemDataBound">
                <HeaderTemplate>
                    <tr style="display:none;">
                        <td class="incell" width="55px">&nbsp;</td>
                        <td class="incell" width="60px" />
                        <td class="incell" width="60px" align="center">&nbsp;</td>
                        <td class="incell" width="60px" align="center">&nbsp;</td>
                        <td class="incell" width="60px" align="center">&nbsp;</td>
                        <td class="incell" width="60px" align="center">&nbsp;</td>
                        <td class="incell" width="60px" align="center">&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                        <td class="incell" width="52px" align="center">&nbsp;</td>
                        <td class="empty" width="10px">&nbsp;</td>
                    </tr>
                </HeaderTemplate>
                <FooterTemplate>
                    <tr>
                        <td height="0px" colspan="25">
                        </td>
                    </tr>
                    <tr runat="Server" id="trTotalRTBExisting">
						<td class="emptytotal" style="background-color:#ffcc00; font-weight:bold;">Sub Total ( iii ):</td>
						<td class="emptytotal" colspan="6" style="background-color:#ffcc00; font-weight:bold;" width="390px">Total RTB Existing</td>
						<td class="emptytotal" style="background-color:#ffcc00;" width="10px"></td>
						<td class="emptytotal" style="background-color:#ffcc00;" width="52">&nbsp;</td>
						<td class="emptytotal" style="background-color:#ffcc00;" width="10px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="0px" colspan="25">
                        </td>
                    </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </td>
        <td>
        </td>
    </tr>
	<tr>
	    <td class="summarylabel" valign="top" width="95px" >
	    </td>
	    <td>
            <table cellSpacing="0" cellPadding="2">
                <tr height="0px">
			        <td class="empty" width="50px"></td>
			        <td class="empty" width="60px"></td>
			        <td class="empty" width="60px"></td>
			        <td class="empty" width="60px"></td>
			        <td class="empty" width="60px"></td>
			        <td class="empty" width="65px"></td>
			        <td class="empty" width="65px"></td>
			        <td class="empty" width="10px"></td>
			        <td class="emptytotal" width="52"></td>
			        <td class="empty" width="10px"></td>
			    </tr>
			    <tr>
			        <td class="empty" colspan="5" align="left" style="font-weight:bold">Has additional data centre consumption been taken into consideration when calculating RTB costs?</td>
			        <td colspan="2" align="left" class="tablegreybg">
<%--			            <asp:DropDownList runat="Server" ID="ddlAdditionalConsumption" CssClass="textselect" Width="120px">
			                <asp:ListItem Value="0" Text="Please Select" Selected="True"></asp:ListItem>
			                <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
			                <asp:ListItem Value="2" Text="N/A"></asp:ListItem>
			            </asp:DropDownList>--%>
			            <asp:Label runat="server" ID="ddlAdditionalConsumption"></asp:Label>
			        </td>
			        <td class="empty" width="10px"></td>
			        <td class="empty" width="52">&nbsp;</td>
			        <td class="empty" width="10px">&nbsp;</td>
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
	    <td class="summarylabel" valign="top" width="95px" >3) GTO Analysis 
	    </td>
		<td align="left" colspan="2">
            <asp:repeater id="rptGTOAnalysis" EnableViewState="False" runat="server" OnItemDataBound="rptGTOAnalysis_ItemDataBound">
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2">
                </HeaderTemplate>
                <FooterTemplate>
	                <tr>
	                    <td class="emptynopadding" height="0px" colspan="10"></td>
	                </tr>					
	                <tr runat="Server" id="trSubTotal1">
		                <td class="empty" width="430px"></td>
		                <td class="empty" width="105px" style="background-color:#F0FFF2; font-weight:bold;">CTB</td>
	                </tr>
	                <tr runat="Server" id="trSubTotal2">
		                <td class="empty" width="430px"></td>
		                <td class="empty" width="105px" style="background-color:#F0FFF2; font-weight:bold;">MAN</td>
	                </tr>
	                <tr runat="Server" id="trSubTotal3">
		                <td class="empty" width="430px"></td>
		                <td class="empty" width="105px" style="background-color:#F0FFF2; font-weight:bold;">RTB Incremental</td>
	                </tr>
	                <tr runat="Server" id="trTotal">
		                <td class="emptytotal" colspan="2" style="background-color:#ffcc00; font-weight:bold;">GTO Total</td>
	                </tr>
					<tr>
					    <td height="0px" colspan="10"></td>
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
	    <td class="summarylabel" valign="top" width="95px" >
	       <span style="font-weight:normal">
                <asp:Label ID="Label4" runat="server" Text="4) CAPEX Analysis:" Width="112px" Font-Bold="True"></asp:Label><br />
                <br />
                <asp:Label ID="lblCapitalHardware" runat="server" Text="a) Capital Hardware " Width="112px" Visible="False"></asp:Label></span></td>
		<td align="left" colspan="2">
				<asp:repeater id="rptCAPEXCapitalHardware" EnableViewState="False" runat="server" OnItemDataBound="rptCAPEXCapitalHardware_ItemDataBound" >
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
						<tr runat="server" id="trHeader">
							<td class="headcell" width="50px" align="left">Owner</td>
							<td class="headcell" width="60px">Description</td>
							<td class="headcell" width="60px" align="center">Name</td>
							<td class="headcell" width="60px" align="center">Level 7</td>
							<td class="headcell" width="60px" align="center">Level 8</td>
							<td class="headcell" width="60px" align="center">Level 9</td>
							<td class="headcell" width="60px" align="center">Level 9</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="headcell" width="52" align="center">Start Date</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="50px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="50px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                   <FooterTemplate>                                        
				        <tr runat="server" id="trblank11" align="right">
				            <td height="3px" colspan="24" style="border: solid 1px"></td>
				        </tr>					
				        <tr runat="server" id="trblank21">
				            <td height="3px" colspan="24"></td>
				        </tr>					
						<tr runat="server" id="trSubTotal11">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalGTOCapex1" runat="server" Text="Total GTO Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal21">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" style="background-color:#F0FFF2;" colspan="6"><asp:Label ID="lblTotalBusinessCapex1" runat="server" Text="Total Business Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal31">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalCapex1" runat="server" Text="Total Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trblank31">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="depreciationcell" runat="Server" id="tdSpan" style="background-color:#F0FFF2;" align="center">&nbsp;</td>
							<td class="emptynopadding"></td>
						</tr>
				        <tr runat="server" id="trblank41">
				            <td height="1px" colspan="24"></td>
				        </tr>					
						<tr runat="server" id="trDepreciation1">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalDepreciation1" runat="server" Text="Total Depreciation"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
				        <tr runat="server" id="trblank51">
				            <td height="1px" colspan="24"></td>
				        </tr>					                    
            			</table>
                    </FooterTemplate>               
             </asp:repeater>
		</td>
		<td>
		</td>
	</tr>	
	<tr>
	    <td class="summarylabel" valign="top" width="95px" >
	        <span style="font-weight:normal">
                <asp:Label ID="lblBuildingPremises" runat="server" Text="b) Building / Premises " Width="112px" Visible="False"></asp:Label></span></td>
		<td align="left" colspan="2">
				<asp:repeater id="rptCAPEXBuildingPremises" EnableViewState="False" runat="server" OnItemDataBound="rptCAPEXBuildingPremises_ItemDataBound" >
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="50px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="50px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>                                        
				        <tr runat="server" id="trblank12" align="right">
				            <td height="3px" colspan="24" style="border: solid 1px"></td>
				        </tr>					
				        <tr runat="server" id="trblank22">
				            <td height="3px" colspan="24"></td>
				        </tr>					
						<tr runat="server" id="trSubTotal12">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalGTOCapex2" runat="server" Text="Total GTO Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal22">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" style="background-color:#F0FFF2;" colspan="6"><asp:Label ID="lblTotalBusinessCapex2" runat="server" Text="Total Business Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal32">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalCapex2" runat="server" Text="Total Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trblank32">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="depreciationcell" runat="Server" id="tdSpan" style="background-color:#F0FFF2;" align="center">&nbsp;</td>
							<td class="emptynopadding"></td>
						</tr>
				        <tr runat="server" id="trblank42">
				            <td height="1px" colspan="24"></td>
				        </tr>					
						<tr runat="server" id="trDepreciation2">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalDepreciation2" runat="server" Text="Total Depreciation"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
				        <tr runat="server" id="trblank52">
				            <td height="1px" colspan="24"></td>
				        </tr>					
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>		
	<tr>
	    <td class="summarylabel" valign="top" width="95px" >
	       <span style="font-weight:normal">
                <asp:Label ID="lblCapitalSoftware" runat="server" Text="c) Capital Software " Width="112px" Visible="False"></asp:Label></span></td>
		<td align="left" colspan="2">
				<asp:repeater id="rptCAPEXCapitalSoftware" EnableViewState="False" runat="server" OnItemDataBound="rptCAPEXCapitalSoftware_ItemDataBound" >
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="50px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="incell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="50px">
				                    <%# DataBinder.Eval(Container.DataItem,"Type")%>
							</td>
							<td class="alternateincell" width="60px"><%# DataBinder.Eval(Container.DataItem,"Description")%></td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                     <FooterTemplate>                                        
				        <tr runat="server" id="trblank13" align="right">
				            <td height="3px" colspan="24" style="border: solid 1px"></td>
				        </tr>					
				        <tr runat="server" id="trblank23">
				            <td height="3px" colspan="24"></td>
				        </tr>					
						<tr runat="server" id="trSubTotal13">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalGTOCapex3" runat="server" Text="Total GTO Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal23">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" style="background-color:#F0FFF2;" colspan="6"><asp:Label ID="lblTotalBusinessCapex3" runat="server" Text="Total Business Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal33">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalCapex3" runat="server" Text="Total Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trblank33">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="depreciationcell" runat="Server" id="tdSpan" style="background-color:#F0FFF2;" align="center">&nbsp;</td>
							<td class="emptynopadding"></td>
						</tr>
				        <tr runat="server" id="trblank43">
				            <td height="1px" colspan="24"></td>
				        </tr>					
						<tr runat="server" id="trDepreciation3">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalDepreciation3" runat="server" Text="Total Depreciation"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
				        <tr runat="server" id="trblank53">
				            <td height="1px" colspan="24"></td>
				        </tr>					
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>
	<tr>
	    <td class="summarylabel" valign="top" width="95px" >
	        <span style="font-weight:normal">
                <asp:Label ID="lblMarketData" runat="server" Text="d) Market Data" Width="112px" Visible="False"></asp:Label></span></td>
		<td align="left">
				<asp:repeater id="rptCAPEXMarketData" EnableViewState="False" runat="server" OnItemDataBound="rptCAPEXMarketData_ItemDataBound" >
					<HeaderTemplate>
			            <table class="datatable" cellSpacing="0" cellPadding="2">
					</HeaderTemplate>
					<ItemTemplate>
						<tr runat="server" id="trItem">
							<td class="incell" width="50px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td class="incell"><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Description")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="incell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="incell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr runat="server" id="trItem">
							<td class="alternateincell" width="50px">
					            <table cellpadding="0" cellspacing="0" border="0">
					                <tr>
					                    <td class="alternateincell"><%# DataBinder.Eval(Container.DataItem,"Type")%></td>
					                </tr>
					            </table>
							</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Description")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"Comments")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel7Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel8Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel9Name")%>&nbsp;</td>
							<td class="alternateincell" width="60px" align="center"><%# DataBinder.Eval(Container.DataItem,"BusinessGTLevel10Code")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
							<td class="alternateincell" width="52" align="center"><%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:d}")%>&nbsp;</td>
							<td class="empty" width="10px">&nbsp;</td>
						</tr>
                    </AlternatingItemTemplate>	
                    <FooterTemplate>                                        
				        <tr runat="server" id="trblank1" align="right">
				            <td height="3px" colspan="24" style="border: solid 1px"></td>
				        </tr>					
				        <tr runat="server" id="trblank2">
				            <td height="3px" colspan="24"></td>
				        </tr>					
						<tr runat="server" id="trSubTotal1">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalGTOCapex" runat="server" Text="Total GTO Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal2">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" style="background-color:#F0FFF2;" colspan="6"><asp:Label ID="lblTotalBusinessCapex" runat="server" Text="Total Business Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trSubTotal3">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalCapex" runat="server" Text="Total Capex"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
						<tr runat="server" id="trblank3">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="depreciationcell" runat="Server" id="tdSpan" style="background-color:#F0FFF2;" align="center">&nbsp;</td>
							<td class="emptynopadding"></td>
						</tr>
				        <tr runat="server" id="trblank4">
				            <td height="1px" colspan="24"></td>
				        </tr>					
						<tr runat="server" id="trDepreciation">
							<td class="greenempty" align="right"></td>
							<td class="greenempty" colspan="6" style="font-weight:bold;"><asp:Label ID="lblTotalDepreciation" runat="server" Text="Total Depreciation"></asp:Label></td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;"></td>
							<td class="greenempty" width="52px" style="background-color:#F0FFF2;">&nbsp;</td>
							<td class="greenempty" width="10px" style="background-color:#F0FFF2;">&nbsp;</td>
						</tr>
				        <tr runat="server" id="trblank5">
				            <td height="1px" colspan="24"></td>
				        </tr>					
            			</table>
                    </FooterTemplate>			
                </asp:repeater>
		</td>
		<td>
		</td>
	</tr>		
    <tr height="20" valign="middle">
	    <td></td>
	    <td></td>
	    <td></td>
	</tr>		
	<tr>
	    <td class="summarylabel" valign="top" width="95px" style="background-color:#F0FFF2;border: 1px solid; border-right: 0px solid;">5) PAYBACK 
	    </td>
		<td align="left" colspan="2">
            <asp:repeater id="rptPayBack" EnableViewState="False" runat="server" OnItemDataBound="rptPayBack_ItemDataBound">
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2" style="border-left: 0px solid;">
                </HeaderTemplate>
                <FooterTemplate>
	                <tr>
	                    <td class="emptynopadding" height="0px" colspan="10"></td>
	                </tr>					
	                <tr runat="Server" id="trNetCashFlow">
		                <td class="empty" width="52" style="background-color:#F0FFF2; font-weight:bold;">&nbsp;</td>
		                <td class="empty" width="490px" style="background-color:#F0FFF2; font-weight:bold;">Net Cash flow</td>
	                </tr>
	                <tr runat="Server" id="trNetCashFlowCumulated">
		                <td class="empty" width="52" style="background-color:#F0FFF2; font-weight:bold;">&nbsp;</td>
		                <td class="empty" width="490px" style="background-color:#F0FFF2; font-weight:bold;"><i>Net Cash flow cumulated</i></td>
	                </tr>
	                <tr>
	                    <td class="emptynopadding" height="0px" colspan="10"></td>
	                </tr>					
	                </table>
                </FooterTemplate>       
            </asp:repeater>
        </td>
        <td></td>
    </tr>	
	
</table>
