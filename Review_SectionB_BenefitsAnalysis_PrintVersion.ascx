<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_SectionB_BenefitsAnalysis_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.Review_SectionB_BenefitsAnalysis_PrintVersion" %>

<table cellpadding="0" cellspacing="0" border="0">
	<tr class="ms-WPHeader" height="18px">
	    <td>
            <table border="0" cellpadding="0" cellspacing="0" style="padding-right:4px;">
                <tr>
        		    <td width="200px" class="controltitle" style="font-weight:bold; ">Current Review</td>
            	    <td class="summarylabel">Date </td>
                    <td><asp:Label Runat="server" ID="txtIGReviewDate" style="text-align: center;" CssClass="textinput" Width="100px"></asp:Label></td>
                    <td width="20px" align="center"><a runat="server" id="lnkIGReviewDate"><img src="Images/calendar.jpg" border="0"></a></td>
                </tr>
            </table>
        </td>
	</tr>
    <tr>
        <td>
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:Repeater runat="Server" ID="rptBenefitsAnalysis" EnableViewState="false" OnItemDataBound="rptBenefitsAnalysis_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="1" style="border-collapse: collapse; border-color: #CCCCCC;" class="summaryFinancials">
	                                <tr>
		                                <td runat="Server" id="tdBigTitle" class="analysisheadcell" style="text-align:center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
		                                    BENEFITS ANALYSIS</td>
		                                <td class="empty" width="10px"></td>
		                                <td class="empty" width="40px"></td>
		                                <td colspan="2" class="analysisheadcell" style="text-align:center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
		                                    Movement</td>
	                                </tr>
	                                <tr runat="Server" id="trHeader">
		                                <td class="analysisheadcell" style="border-left: 1px solid #CCCCCC;"></td>
	                                </tr>
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr runat="Server" id="trTangible">
	                                    <td class="analysiswhitecell" style="font-weight: bold; border: 1px solid #CCCCCC;">Tangible Benefits</td>
	                                    <td class="analysiswhitecell" runat="server" id="tdTangibleEmpty"></td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal1">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Revenue Generation</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal2">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Cost Reduction</td>
	                                </tr>
	                                <tr runat="Server" id="trIntangible">
	                                    <td class="analysiswhitecell" style="font-weight: bold; border: 1px solid #CCCCCC;">Intangible Benefits</td>
	                                    <td class="analysiswhitecell" runat="server" id="tdIntangibleEmpty"></td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal3">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Risk Reduction</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal4">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Cost Avoidance</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal5">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Rev. Loss Avoidance</td>
	                                </tr>
	                                <tr runat="Server" id="trTotal">
		                                <td class="analysistotalcell" style="border-left: 1px solid #000000; text-align: center">Total Benefits</td>
	                                </tr>
                                </table>
	                        </FooterTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                    </td>
                </tr>
                <tr>
                   <td>
                        <asp:Repeater runat="Server" ID="rptSpendAnalysis" EnableViewState="false" OnItemDataBound="rptSpendAnalysis_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="1" style="border-collapse: collapse; border-color: #CCCCCC;" class="summaryFinancials">
	                                <tr>
		                                <td  runat="Server" id="tdBigTitle" class="analysisheadcell" style="text-align:center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
		                                    SPEND ANALYSIS</td>
		                                <td class="empty" width="10px"></td>
		                                <td class="empty" width="40px"></td>
		                                <td colspan="2" class="analysisheadcell" style="text-align:center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
		                                    Movement</td>
	                                </tr>
	                                <tr runat="Server" id="trHeader">
		                                <td class="analysisheadcell" style="border-left: 1px solid #CCCCCC;"></td>
	                                </tr>
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr runat="Server" id="trSubTotal1">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">CTB</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal2">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">MAN</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal3">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">RTB (incremental)</td>
	                                </tr>
	                                <tr runat="Server" id="trTotal">
		                                <td class="analysistotalcell" style="border-left: 1px solid #000000; text-align: center">Total</td>
                                    </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                   </td>
                </tr>
                <tr>
                    <td>&nbsp;
                    </td>
                </tr>
                <tr>
                   <td>
                        <asp:Repeater runat="Server" ID="rptRTBExisting" EnableViewState="false" OnItemDataBound="rptRTBExisting_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="1" style="border-collapse: collapse; border-color: #CCCCCC;">
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr runat="Server" id="trRTBExisting">
		                                <td class="analysisgreencell" style="border: 1px solid #000000;" width="80px">RTB (existing)</td>
	                                </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                   </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td height="15px"> 
        </td>
    </tr>
	<tr class="ms-WPHeader" height="18px">
        <td align="left">
	        <table border="0" cellpadding="0" cellspacing="0" style="padding-right:4px;">
	            <tr>
            		<td width="200px" class="controltitle" style="font-weight:bold; ">Last Review</td>
                	<td class="summarylabel">Date </td>
	                <td><asp:Label Runat="server" ID="txtIGLastReviewDate" style="text-align: center;" readonly="true" CssClass="textinput" Width="100px"></asp:Label></td>
	            </tr>
	        </table>
		</td>
	</tr>
    <tr>
        <td>
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:Repeater runat="Server" ID="rptPreviousVersion_BenefitsAnalysis" EnableViewState="false" OnItemDataBound="rptPreviousVersion_BenefitsAnalysis_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="1" style="border-collapse: collapse; border-color: #CCCCCC;">
	                                <tr>
		                                <td  runat="Server" id="tdBigTitle" class="analysisheadcell" style="text-align:center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
		                                    BENEFITS ANALYSIS</td>
		                                <td class="empty" width="10px"></td>
		                                <td class="empty" width="40px"></td>
		                                <td rowspan="2" class="analysisheadcell" style="text-align:center; border: 1px solid #CCCCCC;">
                		                                    Additional Comments</td>
	                                </tr>
	                                <tr runat="Server" id="trHeader">
		                                <td class="analysisheadcell" style="border-left: 1px solid #CCCCCC;"></td>
	                                </tr>
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr runat="Server" id="trTangible">
	                                    <td class="analysiswhitecell" style="font-weight: bold; border: 1px solid #CCCCCC;">Tangible Benefits</td>
	                                    <td runat="Server" id="tdTangibleEmpty" class="analysiswhitecell"></td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal1">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Revenue Generation</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal2">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Cost Reduction</td>
	                                </tr>
	                                <tr runat="Server" id="trIntangible">
	                                    <td class="analysiswhitecell" style="font-weight: bold; border: 1px solid #CCCCCC;">Intangible Benefits</td>
	                                    <td runat="Server" id="tdIntangibleEmpty" class="analysiswhitecell"></td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal3">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Risk Reduction</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal4">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Cost Avoidance</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal5">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">Rev. Loss Avoidance</td>
	                                </tr>
	                                <tr runat="Server" id="trTotal">
		                                <td class="analysistotalcell" style="border-left: 1px solid #000000; text-align: center">Total Benefits</td>
	                                </tr>
                                </table>
	                        </FooterTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                    </td>
                </tr>
                <tr>
                   <td>
                        <asp:Repeater runat="Server" ID="rptPreviousVersion_SpendAnalysis" EnableViewState="false" OnItemDataBound="rptPreviousVersion_SpendAnalysis_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="1" style="border-collapse: collapse; border-color: #CCCCCC;">
	                                <tr>
		                                <td runat="Server" id="tdBigTitle" class="analysisheadcell" style="text-align:center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
		                                    SPEND ANALYSIS</td>
		                                    <td class="empty" width="10px"></td>
		                                <td class="empty" width="40px"></td>
		                                <td class="empty" width="65px" />
	                                </tr>
	                                <tr runat="Server" id="trHeader">
		                                <td class="analysisheadcell" style="border-left: 1px solid #CCCCCC;"></td>
	                                </tr>
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr runat="Server" id="trSubTotal1">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">CTB</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal2">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">MAN</td>
	                                </tr>
	                                <tr runat="Server" id="trSubTotal3">
		                                <td class="analysisgreencell" style="border-left: 1px solid #CCCCCC;" width="80px">RTB (incremental)</td>
	                                </tr>
	                                <tr runat="Server" id="trTotal">
		                                <td class="analysistotalcell" style="border-left: 1px solid #000000; text-align: center">Total</td>
                                    </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                   </td>
                </tr>
                <tr>
                    <td>&nbsp;
                    </td>
                </tr>
                <tr>
                   <td>
                        <asp:Repeater runat="Server" ID="rptPreviousVersion_RTBExisting" EnableViewState="false" OnItemDataBound="rptPreviousVersion_RTBExisting_ItemDataBound">
                            <HeaderTemplate>
                                <table cellSpacing="0" cellPadding="1" style="border-collapse: collapse; border-color: #CCCCCC;">
                            </HeaderTemplate>
	                        <FooterTemplate>
	                                <tr runat="Server" id="trRTBExisting">
		                                <td class="analysisgreencell" style="border: 1px solid #000000;" width="80px">RTB (existing)</td>
	                                </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                   </td>
                </tr>
           </table>
        </td>
    </tr>
</table>    

