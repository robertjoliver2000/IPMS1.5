<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_SectionB_SponsorAllocations_PrintVersion.ascx.cs"
    Inherits="ProjectPortfolio.Controls.Review_SectionB_SponsorAllocations_PrintVersion" %>
<table border="0" cellpadding="0" cellspacing="0" >
    <tr>
        <td valign="top">
            <table cellpadding="1" cellspacing="1" id="tblSponsorAllocations">
                <tr>
                    <td colspan="7" class="summarytitlecell" style="width: 451px">
                        % SPONSOR ALLOCATIONS</td>
                </tr>
                <tr>
                    <td colspan="7" style="width: 451px">
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <table cellpadding="1" cellspacing="0">
                            <tr>
                                <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold">
                                    BA</td>
                                <td class="sponsorallocationlabel" align="center" >
                                    Last<br />Review</td>
                                <td class="sponsorallocationlabel" align="center"  >
                                    Current<br />Review</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold">
                                    Business</td>
                                <td class="tablegreenbg" style="text-align: center">
                                    <asp:Label runat="server" ID="txtPreviousBusiness" cssclass="sponsorallocationtext">0%</asp:Label></td>
                                <td class="tablegreenbg" style="text-align: center">
                                    <asp:Label runat="server" ID="txtBusiness" cssclass="sponsorallocationtext">0%</asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                            <asp:Repeater runat="Server" ID="rptBusiness" OnItemDataBound="rptBusiness_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td runat="Server" id="tdLabel">
                                        </td>
                                        <td runat="Server" id="tdPreviousValue">
                                        </td>
                                        <td runat="Server" id="tdValue">
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </td>
                    <td>                        
                    </td>
                    <td valign="top">
                        <table cellpadding="1" cellspacing="0">
                            <tr>
                                <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold">
                                    BA</td>
                                <td align="center" class="sponsorallocationlabel">
                                    Last<br />Review</td>
                                <td align="center" class="sponsorallocationlabel">
                                    Current<br />Review</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold">
                                    &nbsp;&nbsp;GTO&nbsp;&nbsp;</td>
                                <td class="tablegreenbg" style="text-align: center">
                                    <asp:Label runat="server" ID="txtPreviousGTO" cssclass="sponsorallocationtext">0%</asp:Label></td>
                                <td class="tablegreenbg" style="text-align: center">
                                    <asp:Label runat="server" ID="txtGTO" cssclass="sponsorallocationtext">0%</asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                            <asp:Repeater runat="Server" ID="rptGTO" OnItemDataBound="rptGTO_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td runat="Server" id="tdLabel">
                                        </td>
                                        <td runat="Server" id="tdPreviousValue">
                                        </td>
                                        <td runat="Server" id="tdValue">
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </td>
                    <td>                        
                    </td>
                    <td valign="top">
                        <table cellpadding="1" cellspacing="0">
                            <tr>
                                <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold">
                                    BA</td>
                                <td align="center" class="sponsorallocationlabel">
                                    Last<br />Review</td>
                                <td align="center" class="sponsorallocationlabel">
                                    Current<br />Review</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold">
                                    CF</td>
                                <td class="tablegreenbg" style="text-align: center">
                                    <asp:Label runat="server" ID="txtPreviousCF" cssclass="sponsorallocationtext">0%</asp:Label></td>
                                <td class="tablegreenbg" style="text-align: center">
                                    <asp:Label runat="server" ID="txtCF" cssclass="sponsorallocationtext">0%</asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                            <asp:Repeater runat="Server" ID="rptCF" OnItemDataBound="rptCF_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td runat="Server" id="tdLabel">
                                        </td>
                                        <td runat="Server" id="tdPreviousValue">
                                        </td>
                                        <td runat="Server" id="tdValue">
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" style="width: 451px">
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <table>
                            <tr>
                                <td style="font-weight: bold;" class="sponsorallocationlabel">
                                    Allocations agreed with Sponsors?
                                </td>
                                <td align="left" class="tablegreybg" valign="middle">
                                    <asp:Label runat="server" ID="ddlAllocationAgreed" CssClass="sponsorallocationtext"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td style="font-weight: bold;" class="sponsorallocationlabel">
                                    Initiative budgeted for current year?
                                </td>
                                <td align="left" class="tablegreybg">
                                    <asp:Label runat="server" ID="ddlInitiativeBudget" CssClass="sponsorallocationtext"></asp:Label>
                                </td>
                            </tr>
                        </table><table>
                            <tr>
                                <td style="font-weight: bold;" class="sponsorallocationlabel">
                                    Basis for Allocation</td>
                                <td align="left" class="tablegreybg">
                                    <asp:Label ID="ddlBasisForAllocation" runat="server" CssClass="sponsorallocationtext"></asp:Label>
                                </td>
                            </tr>
                        </table><table>
                            <tr>
                                <td style="font-weight: bold;" class="sponsorallocationlabel">
                                    Description
                                </td>
                                <td align="left" class="tablegreybg"">
                                    <asp:Label ID="txtBasisForAllocationDescription" runat="server" CssClass="sponsorallocationtext"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
