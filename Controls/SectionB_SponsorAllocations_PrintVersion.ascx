<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionB_SponsorAllocations_PrintVersion"
    CodeFile="SectionB_SponsorAllocations_PrintVersion.ascx.cs" %>
<table id="tblSponsorAllocations" height="100%">
    <tr>
        <td colspan="5" class="summarytitlecell">
            % SPONSOR ALLOCATIONS</td>
    </tr>
    <tr>
        <td colspan="5"> 
        </td>
    </tr>
    <tr>
        <td valign="top">
            <table cellpadding="2" cellspacing="0">
                <tr>
                    <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold">
                        BA</td>
                    <td class="sponsorallocationlabel" style="font-weight: bold">
                        % Alloc.</td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td class="sponsorallocationlabel" style="font-weight: bold">
                        Business</td>
                    <td class="tablegreenbg" style="text-align: center">
                        <asp:Label ID="txtBusiness" cssclass="sponsorallocationtext" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
                <asp:Repeater runat="Server" ID="rptBusiness" OnItemDataBound="rptBusiness_ItemDataBound">
                    <ItemTemplate>
                        <tr>
                            <td class="sponsorallocationlabel" runat="Server" id="tdLabel">
                            </td>
                            <td class="sponsorallocationlabel" runat="Server" id="tdValue">
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </td>
        <td width="1px">
        </td>
        <td valign="top">
            <table cellpadding="2" cellspacing="0">
                <tr>
                    <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold; width: 39px;">
                        BA</td>
                    <td class="sponsorallocationlabel" style="font-weight: bold">
                        % Alloc.</td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td class="sponsorallocationlabel" style="font-weight: bold; width: 39px;">
                        &nbsp;&nbsp;GTO&nbsp;&nbsp;</td>
                    <td class="tablegreenbg" style="text-align: center">
                        <asp:Label ID="txtGTO" runat="server" cssclass="sponsorallocationtext"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
                <asp:Repeater runat="Server" ID="rptGTO" OnItemDataBound="rptGTO_ItemDataBound">
                    <ItemTemplate>
                        <tr>
                            <td class="sponsorallocationlabel" runat="Server" id="tdLabel">
                            </td>
                            <td class="sponsorallocationlabel" runat="Server" id="tdValue">
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </td>
        <td width="1px">
        </td>
        <td valign="top" style="width: 93px">
            <table cellpadding="2" cellspacing="0">
                <tr>
                    <td valign="middle" class="sponsorallocationlabel" style="font-weight: bold">
                        BA</td>
                    <td class="sponsorallocationlabel" style="font-weight: bold">
                        % Alloc.</td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td class="sponsorallocationlabel" style="font-weight: bold">
                        CF</td>
                    <td class="tablegreenbg" style="text-align: center">
                        <asp:Label ID="txtCF" runat="server" cssclass="sponsorallocationtext"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
                <asp:Repeater runat="Server" ID="rptCF" OnItemDataBound="rptCF_ItemDataBound">
                    <ItemTemplate>
                        <tr>
                            <td class="sponsorallocationlabel" runat="Server" id="tdLabel">
                            </td>
                            <td class="sponsorallocationlabel" runat="Server" id="tdValue">
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="5">
        </td>
    </tr>
    <tr>
        <td colspan="7" align="left">
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
