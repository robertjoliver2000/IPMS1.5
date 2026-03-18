<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionE_PrintVersion" CodeFile="SectionE_PrintVersion.ascx.cs" %>

<table class="def">
	<tr class="ms-WPHeader">
		<td class="controltitle" colSpan="6">E) Initiative Non-Financial Summary</td>
	</tr>
	<tr>
		<td colSpan="6" height="10px"></td>
	</tr>
	<tr>
		<td class="summarylabel" colSpan="6">1) What is the impact of not doing the 
			investment?
		</td>
	</tr>
	<tr>
		<td colSpan="6" class="tablegreybg">
            <asp:Label ID="txtImpact" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colSpan="6" height="10px"></td>
	</tr>
	<tr>
		<td class="summarylabel" colSpan="6">
            2) KEY PERFORMANCE INDICATORS:</td>
	</tr>
	<tr>
		<td colSpan="6" class="tablegreybg">
            <asp:Label ID="txtKeyPerformance" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colSpan="6" height="10px"></td>
	</tr>
	<tr>
		<td class="summarylabel" colSpan="6">3) What applications are impacted?
		</td>
	</tr>
	<tr>
		<td align="left" valign="top">
				<asp:repeater id="repeaterApp" EnableViewState="False" runat="server">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr height="20">
							<td class="headcell" width="180">Application Instance Name</td>
							<td class="headcell" width="110" style="text-align:center;">Application ID</td>
							<td class="headcell" width="160" style="text-align:center;">Impact</td>
							<td class="headcell" width="160" style="text-align:center;">Investment Strategy</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20">
						    <td class="incell">
							     <%# DataBinder.Eval(Container.DataItem, "ApplicationInstanceName")%>
							</td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"ExternalApplicationID")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"Impact")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"InvestmentStrategy")%></td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20">
						    <td class="alternateincell">
							     <%# DataBinder.Eval(Container.DataItem, "ApplicationInstanceName")%>
							</td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"ExternalApplicationID")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"Impact")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"InvestmentStrategy")%></td>
						</tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
					</table>
					</FooterTemplate>
				</asp:repeater>
		</td>
		<td width="40px"></td>
		<td vAlign="top" align="left">
				<asp:repeater id="repeaterServer" EnableViewState="False" Runat="server">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr height="20">
							<td class="headcell" width="180">Server Node Name</td>
							<td class="headcell" width="110" style="text-align:center;">Server Node ID</td>
							<td class="headcell" width="160" style="text-align:center;">Impact</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20">
							<td class="incell">
                                <%# DataBinder.Eval(Container.DataItem, "ServerNodeName")%>
							</td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"ExternalServerNodeID")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"Impact")%></td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20">
						    <td class="alternateincell">
                                <%# DataBinder.Eval(Container.DataItem, "ServerNodeName")%>
							</td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"ExternalServerNodeID")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"Impact")%></td>
						</tr>
					</AlternatingItemTemplate>
				    <FooterTemplate>
				        </table>
				    </FooterTemplate>
				</asp:repeater>
		</td>
	</tr>
	<tr>
		<td colspan="6" style="height: 10px"></td>
	</tr>
	<tr>
		<td class="summarylabel" colSpan="6">Comments</td>
	</tr>
	<tr>
		<td colSpan="6" class="tablegreybg">
            <asp:Label ID="txtShutDownComments" runat="server"></asp:Label></td>
	</tr>
	<tr>
		<td colspan="6" height="20"></td>
	</tr>
	<tr>
		<td class="summarylabel" colspan="6">
            4) Functional Domain Sub-Function 3
        </td>
	</tr>
    <tr>
        <td colspan="6" height="10">
            <asp:Repeater ID="repeaterDFD" runat="server" EnableViewState="False">
                <HeaderTemplate>
                    <table cellpadding="2" cellspacing="0" class="datatable">
                        <colgroup>
                            <col style="width:180px" />
                            <col style="width:100px" />
                            <col style="width:845px" />
                        </colgroup>
                        <tr height="20">
                            <td class="headcell">
                                Sub-Function 3</td>
                            <td class="headcell" style="text-align: center;">
                                % Allocation</td>
                            <td class="headcell" style="text-align: center;">
                                Comments</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr height="20">
                        <td class="incell">
                            <%# DataBinder.Eval(Container.DataItem, "Description")%>
                        </td>
                        <td align="center" class="incell">
                            <%# DataBinder.Eval(Container.DataItem,"Allocation")%>
                        </td>
                        <td align="center" class="incell">
                            <%# DataBinder.Eval(Container.DataItem,"Comments")%>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr height="20">
                        <td class="alternateincell">
                            <%# DataBinder.Eval(Container.DataItem, "Description")%>
                        </td>
                        <td align="center" class="alternateincell">
                            <%# DataBinder.Eval(Container.DataItem,"Allocation")%>
                        </td>
                        <td align="center" class="alternateincell">
                            <%# DataBinder.Eval(Container.DataItem,"Comments")%>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </td>
    </tr>
</table>
<br />
