<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionA_PrintVersion" CodeFile="SectionA_PrintVersion.ascx.cs" %>

<style>
.apptitle span { font-size:18px; }
</style>
<table cellpadding="0" cellspacing="0" border="0" style="width: 772px">
    <tr>
        <td colspan="5" class="apptitle" style="padding:2px; background-color:#094268; color:White; font-size:18pt; "><asp:Label ID="txtLargeName" runat="server"  CssClass="PrintLabel"></asp:Label></td>
    </tr>
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitle">A) & B) Initiative Summary and Detail in  M Euros</td>
	</tr>
	<tr>
	    <td align="left" style="height: 10px;">
        </td>
     </tr>
     <tr>
        <td align="left">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>&nbsp;</td>
                    <td rowspan="2">
<table style="margin:0px;" cellpadding="0" cellspacing="0">
<colgroup><col style="width:18px;" /><col style="width:7px;" /><col span="5" style="width:18px;" /></colgroup>
<tr style="text-align:center;"><th>O</th><th>&nbsp;</th><th>C</th><th>D</th><th>T</th><th>R/I</th><th>B</th></tr>
<tr style="text-align:center;">
    <td><img runat="server" id="imgPPROverall" style="height:1.2em;" /></td>
    <td>&nbsp;</td>
    <td><img runat="server" id="imgPPRCost" style="height:1.2em;" /></td>
    <td><img runat="server" id="imgPPRDeliverables" style="height:1.2em;" /></td>
    <td><img runat="server" id="imgPPRTime" style="height:1.2em;" /></td>
    <td><img runat="server" id="imgPPRRisks" style="height:1.2em;" /></td>
    <td><img runat="server" id="imgPPRBenefits" style="height:1.2em;" /></td>
</tr>
</table>
                        </td>
                    <td class="summarylabel" style="width: 10px;">
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="summarylabel" style="width: 170px;">
                        1) PERFORMANCE STATUS:
                    </td>
                    <td class="summarylabel" style="width: 10px;">
                    </td>
                    <td class="summarylabel" style="width: 190px;">
                        7) INVESTMENT TIER:
                    </td>
                    <td style="width: 206px;" class="tablegreybg">
		                <asp:Label ID="ddlInvestmentTier" runat="server"  CssClass="PrintText"></asp:Label></td>
                </tr>
                <tr>
                    <td class="summarylabel" colspan="5" style="height: 5px">
                    </td>
                </tr>
	            <tr>
	                <td colspan="2">
	                    <table height="100%" cellpadding="0" cellspacing="0">
	                        <tr>
	                            <td class="summarylabel" style="width:1.5em;">&nbsp;</td>
		                        <td style="width: 366px;" class="tablegreybg">
                                    <asp:Label ID="txtPPRComments" runat="server"  CssClass="PrintText"></asp:Label></td>
        		            </tr>
        		        </table>
		            </td>
                    <td class="summarylabel" style="width: 10px">
                    </td>
                    <td class="summarylabel" style="width: 190px">
                        8) GTO MANAGING BUSINESS AREA:
                    </td>
                    <td style="width: 206px" class="tablegreybg">
                        <asp:Label ID="txtGTOManagingBusinessArea" runat="server"  CssClass="PrintText"></asp:Label></td>
	            </tr>
                <tr>
                    <td class="summarylabel" colspan="5" style="height: 5px">
                    </td>
                </tr>
	            <tr>
		            <td class="summarylabel" style="width: 170px">
			            2) PRIMARY SPONSORING <span style="color:#ffffff">2)</span>&nbsp;BUSINESS UNIT:
		            </td>
		            <td style="width: 206px" class="tablegreybg">
		                <asp:Label ID="txtPrimarySponsoringArea" runat="server"  CssClass="PrintText"></asp:Label></td>
                    <td class="summarylabel" style="width: 10px">
                    </td>
                    <td class="summarylabel" style="width: 190px">
                        9) GTO INITIATIVE MANAGER:
                    </td>
                    <td style="width: 206px" class="tablegreybg">
                        <asp:Label ID="txtGTOInitiativeManager" runat="server"  CssClass="PrintText"></asp:Label></td>
	            </tr>
                <tr>
                    <td class="summarylabel" colspan="5" style="height: 5px">
                    </td>
                </tr>
                <tr>
		            <td class="summarylabel" style="width: 170px">
			            3) OTHER SPONSORING BUSINESS <span style="color:#ffffff">3)</span>&nbsp;UNIT:
		            </td>
		            <td style="width: 206px" class="tablegreybg">
		                <asp:Label ID="txtOtherSponsoringAreas" runat="server"  CssClass="PrintText"></asp:Label></td>
                    <td class="summarylabel" style="width: 10px">
                    </td>
                    <td class="summarylabel" style="width: 190px">
                        10) FUNCTIONAL DOMAIN:
                    </td>
                    <td style="width: 206px" class="tablegreybg">
                        <asp:Label ID="ddlFunctionalDomain" runat="server"  CssClass="PrintText"></asp:Label></td>
	            </tr>
                <tr>
                    <td class="summarylabel" colspan="5" style="height: 5px">
                    </td>
                </tr>
	            <tr>
		            <td class="summarylabel" style="width: 170px">
			            4) BUSINESS SPONSOR NAME:
		            </td>
		            <td style="width: 206px" class="tablegreybg">
		                <asp:Label ID="txtBusinessSponsorName" runat="server"  CssClass="PrintText"></asp:Label></td>
                    <td class="summarylabel" style="width: 10px">
                    </td>
                    <td class="summarylabel" style="width: 190px">
			            11) SECONDARY FUNCTIONAL <span style="color:#ffffff">11)</span>&nbsp;DOMAIN:
                    </td>
                    <td style="width: 206px" class="tablegreybg">
                        <asp:Label ID="ddlSecondaryFunctionalDomain" runat="server"  CssClass="PrintText"></asp:Label></td>
	            </tr>
                <tr>
                    <td class="summarylabel" colspan="5" style="height: 5px">
                    </td>
                </tr>
	            <tr>
		            <td class="summarylabel" style="width: 170px;">
			            5) BUSINESS INITIATIVE <span style="color:#ffffff">5)</span>&nbsp;MANAGER:
		            </td>
		            <td style="width: 206px" class="tablegreybg">
		                <asp:Label ID="txtBusinessInitiativeManager" runat="server"  CssClass="PrintText"></asp:Label></td>
                    <td class="summarylabel" style="width: 10px">
                    </td>
                    <td class="summarylabel" style="width: 190px">
			            12) TECHNOLOGY FUNCTION:
                    </td>
                    <td style="width: 206px" class="tablegreybg">
                        <asp:Label ID="ddlTechnologyFunction" runat="server"  CssClass="PrintText"></asp:Label></td>
	            </tr>
                <tr>
                    <td class="summarylabel" colspan="5" style="height: 5px">
                    </td>
                </tr>
	            <tr>
		            <td class="summarylabel">
			            6) REGION:
		            </td>
		            <td style="width: 206px" class="tablegreybg">
		                <asp:Label ID="ddlRegion" runat="server"  CssClass="PrintText"></asp:Label></td>
                    <td class="summarylabel" style="width: 10px">
                    </td>
                    <td class="summarylabel" style="width: 190px;">
			            13) MAJOR APPLICATION NAME:</td>
                    <td style="width: 206px;" class="tablegreybg">
                        <asp:Label ID="txtMajorApplicationName" runat="server"  CssClass="PrintText"></asp:Label></td>
	            </tr>
	            <tr>
		            <td class="summarylabel">
		            </td>
		            <td style="width: 206px;">
                        &nbsp;</td>
                    <td class="summarylabel" style="width: 10px">
                    </td>
                    <td class="summarylabel" style="width: 190px;">
                        </td>
                    <td style="width: 206px;">
                        <asp:Label ID="txtMajorApplicationInvestmentStrategy" runat="server"  CssClass="PrintLabel"></asp:Label>
                    </td>
	            </tr>
	         </table>
	      </td>
	   </tr>
	   <tr>
	      <td align="left">
	    </td>
	</tr>
</table>