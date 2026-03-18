<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionE" CodeFile="SectionE.ascx.cs" %>
<script language="javascript" type="text/javascript">

function popupWindowApp(appID, initiativeID)
{
	var dialogwidth = 400
	var dialogheight = 150
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"

    var returnCode=-1;
	
	if(appID==0)
	{
	    returnCode=window.showModalDialog("Application.aspx?InitiativeID=" + initiativeID,
					"app_dialog", "dialogWidth:400px;dialogHeight:180px;status:no;resizable:no;scroll:yes");
	}
    else
    {
        returnCode=window.showModalDialog("Application.aspx?AppID=" + appID + "&InitiativeID=" + initiativeID, 
					"app_dialog", "dialogWidth:400px;dialogHeight:180px;status:no;resizable:no;scroll:yes");
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

function popupWindowServer(serverID, initiativeID)
{
	var dialogwidth = 400
	var dialogheight = 150
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"

    var returnCode=0;
	if(serverID==0)
	{
	    returnCode=window.showModalDialog("Server.aspx?InitiativeID=" + initiativeID,
					"server_dialog", "dialogWidth:400px;dialogHeight:180px;status:no;resizable:no;scroll:yes");
	}
	else
    {
	    returnCode=window.showModalDialog("Server.aspx?ServerID=" + serverID + "&InitiativeID=" + initiativeID,
	    				"server_dialog", "dialogWidth:400px;dialogHeight:180px;status:no;resizable:no;scroll:yes");
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

function popupWindowDFD(initiativeDetailedFunctionalDomainID, initiativeID)
{
	var dialogwidth = 390;
	var dialogheight = 240;
	var leftpos = (screen.width - dialogwidth) / 2;
	var toppos = (screen.height - dialogheight) / 2;
    var features = "dialogHeight:"+dialogheight+"px;dialogWidth:"+dialogwidth+"px;status:no;resizable:no;scroll:yes";
    var returnCode = 0;

    var url = "DetailedFunctionalDomain.aspx";
	if( initiativeDetailedFunctionalDomainID == 0 )
	{
	    url += "?InitiativeID=" + initiativeID;
	}
	else
    {
	    url += "?InitiativeDetailedFunctionalDomainID=" + initiativeDetailedFunctionalDomainID;
	}
    
    returnCode=window.showModalDialog( url, "dfd_dialog", features );
    
    if ( returnCode == 1 )
    {
        if(window.document.forms[0].onsubmit())
        {
            AllowOneTimeSubmit();
            window.document.forms[0].submit();
        }
    }
   
}
</script>
<table class="def">
	<tr class="ms-WPHeader">
		<td class="controltitle" colspan="7">E) Initiative Non-Financial Summary</td>
	</tr>
	<tr>
		<td colspan="7" height="10px"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
		<td class="summarylabel" colspan="6">1) What is the impact of not doing the 
			investment?
		</td>
	</tr>
	<tr>
	    <td></td>
		<td colspan="6"><asp:textbox id="txtImpact" Runat="server" CssClass="textinput" TextMode="MultiLine" Width="1000px"
				Height="80"></asp:textbox></td>
	</tr>
	<tr>
	    <td></td>
		<td colspan="6" height="10px"></td>
	</tr>
	<tr>
	    <td></td>
		<td class="summarylabel" colspan="6">
            2) KEY PERFORMANCE INDICATORS:</td>
	</tr>
	<tr>
	    <td></td>
		<td colspan="6"><asp:textbox id="txtKeyPerformance" Runat="server" CssClass="textinput" TextMode="MultiLine"
				Width="1000" Height="80"></asp:textbox></td>
	</tr>
	<tr>
	    <td></td>
		<td colspan="6" height="10px"></td>
	</tr>
	<tr>
	    <td></td>
		<td class="summarylabel" colSpan="6">3) What applications are impacted?
		</td>
	</tr>
	<tr>
	    <td></td>
		<td colspan="6" height="5"></td>
	</tr>
	<tr>
	    <td></td>
		<td align="left" valign="top">
				<asp:repeater id="repeaterApp" EnableViewState="False" runat="server" OnItemCommand="repeaterApp_ItemCommand" OnItemDataBound="repeaterApp_ItemDataBound">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr height="20">
							<td class="headcell" width="160">Application Instance Name</td>
							<td class="headcell" width="90" style="text-align:center;">Application ID</td>
							<td class="headcell" width="125" style="text-align:center;">Impact</td>
							<td class="headcell" width="130" style="text-align:center;">Investment Strategy</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20">
						    <td class="incell">
						        <table>
						            <tr>
						                <td> <asp:ImageButton runat="server" ID="delAppID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeApplicationID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td> 
							            <td class="incell"><a runat="server" id="lnkEditApplication" href="#" onclick='<%# "javascript:popupWindowApp(" + DataBinder.Eval(Container.DataItem,"InitiativeApplicationID") + ", " + nInitiativeID + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem, "ApplicationInstanceName")%></a></td>
							        </tr>
							     </table>
							</td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"ExternalApplicationID")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"Impact")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"InvestmentStrategy")%></td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20">
						    <td class="alternateincell">
						        <table>
						            <tr>
						                <td> <asp:ImageButton runat="server" ID="delAppID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeApplicationID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td> 
							            <td class="alternateincell"><a runat="server" id="lnkEditApplication" href="#" onclick='<%# "javascript:popupWindowApp(" + DataBinder.Eval(Container.DataItem,"InitiativeApplicationID") + ", " + nInitiativeID + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem, "ApplicationInstanceName")%></a></td>
							        </tr>
							     </table>
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
			
			<br>
			<button runat="server" id="btnAddApplication" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
				Add Application</button>
		</td>
		<td width="40px"></td>
		<td vAlign="top" align="left">
				<asp:repeater id="repeaterServer" EnableViewState="False" Runat="server" OnItemCommand="repeaterServer_ItemCommand" OnItemDataBound="repeaterServer_ItemDataBound">
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr height="20">
							<td class="headcell" width="180">Server Node Name</td>
							<td class="headcell" width="110" style="text-align:center;">Server Node ID</td>
							<td class="headcell" width="125" style="text-align:center;">Impact</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20">
							<td class="incell">
						        <table>
						            <tr>
						                <td> <asp:ImageButton runat="server" ID="delServerID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeServerID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td> 
							            <td class="incell"><a runat="server" id="lnkEditServer" href="#" onclick='<%# "javascript:popupWindowServer(" + DataBinder.Eval(Container.DataItem,"InitiativeServerID") + ", " + nInitiativeID + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem, "ServerNodeName")%></a></td>
							        </tr>
							     </table>
							</td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"ExternalServerNodeID")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"Impact")%></td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20">
						    <td class="alternateincell">
						        <table>
						            <tr>
						                <td> <asp:ImageButton runat="server" ID="delServerID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeServerID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td> 
							            <td class="alternateincell"><a runat="server" id="lnkEditServer" href="#" onclick='<%# "javascript:popupWindowServer(" + DataBinder.Eval(Container.DataItem,"InitiativeServerID") + ", " + nInitiativeID + "); return false;"%>'><%# DataBinder.Eval(Container.DataItem, "ServerNodeName")%></a></td>
							        </tr>
							     </table>
							</td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"ExternalServerNodeID")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"Impact")%></td>
						</tr>
					</AlternatingItemTemplate>
				    <FooterTemplate>
				        </table>
				    </FooterTemplate>
				</asp:repeater>
			
			<br />
			<button runat="server" id="btnAddServer" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana"
				type="button">Add Server</button>
		</td>
	</tr>
	<tr>
	    <td></td>
		<td colspan="6" style="height: 23px"></td>
	</tr>
	<tr>
	    <td></td>
		<td class="summarylabel" colspan="6">&nbsp;Comments</td>
	</tr>
	<tr>
	    <td></td>
		<td colspan="6"><asp:textbox id="txtShutDownComments" Runat="server" CssClass="textinput" TextMode="MultiLine"
				Width="1000" Height="80"></asp:textbox></td>
	</tr>
	<tr>
	    <td></td>
		<td colspan="6" height="20"></td>
	</tr>
	<tr>
	    <td></td>
		<td class="summarylabel" colspan="6">
            4) Functional Domain Sub-Function 3
            <asp:RangeValidator ID="ravDFDTotalAllocation" runat="server" ControlToValidate="txtDFDTotalAllocation"
                ErrorMessage="The Detailed Functional Domain Allocation must total 100.00%" MaximumValue="100.00" MinimumValue="100.00" Type="Double" ValidationGroup="SubmitForReview">The Detailed Functional Domain Allocation must total 100.00%</asp:RangeValidator>
        </td>
	</tr>
    <tr>
        <td></td>
        <td colspan="6" height="10">
            <asp:Repeater ID="repeaterDFD" runat="server" EnableViewState="False" OnItemCommand="repeaterDFD_ItemCommand"
                OnItemDataBound="repeaterDFD_ItemDataBound">
                <HeaderTemplate>
                    <table cellpadding="2" cellspacing="0" class="datatable">
                        <colgroup>
                            <col style="width:160px" />
                            <col style="width:100px" />
                            <col style="width:725px" />
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
                            <table>
                                <tr>
                                    <td>
                                        <asp:ImageButton ID="delDFDID" runat="server" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeDetailedFunctionalDomainID")%>'
                                            CommandName="Delete" ImageUrl="~/Images/delete.gif" /></td>
                                    <td class="incell">
                                        <a id="lnkEditDetailedFunctionalDomain" runat="server" href="#" onclick='<%# "javascript:popupWindowDFD(" + DataBinder.Eval(Container.DataItem,"InitiativeDetailedFunctionalDomainID") + ", 0); return false;"%>'>
                                            <%# DataBinder.Eval(Container.DataItem, "Description")%>
                                        </a>
                                    </td>
                                </tr>
                            </table>
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
                            <table>
                                <tr>
                                    <td>
                                        <asp:ImageButton ID="delDFDID" runat="server" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeDetailedFunctionalDomainID")%>'
                                            CommandName="Delete" ImageUrl="~/Images/delete.gif" /></td>
                                    <td class="alternateincell">
                                        <a id="lnkEditDetailedFunctionalDomain" runat="server" href="#" onclick='<%# "javascript:popupWindowDFD(" + DataBinder.Eval(Container.DataItem,"InitiativeDetailedFunctionalDomainID") + "); return false;"%>'>
                                            <%# DataBinder.Eval(Container.DataItem, "Description")%>
                                        </a>
                                    </td>
                                </tr>
                            </table>
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
            
            <br />
            <button runat="server" id="btnAddDFD" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">
	Add Sub-Function 3</button>
            <asp:TextBox ID="txtDFDTotalAllocation" runat="server" CssClass="invisible" OnPreRender="txtDFDTotalAllocation_PreRender"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
        </td>
        <td colspan="6" height="10">
        </td>
    </tr>
</table>
