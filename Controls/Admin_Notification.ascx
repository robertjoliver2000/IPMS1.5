<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.Admin_Notification" CodeFile="Admin_Notification.ascx.cs" %>
<script language="javascript">

function popupWindowSelectItem(categoryID,txtBoxID,hiddenTxtBoxID)
{
    var dialogwidth = 360
	var dialogheight = 400
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"
	
	dlgwindow = window.open("SelectItem.aspx?CategoryID="+categoryID+"&ControlID="+txtBoxID+"&HiddenControlID="+hiddenTxtBoxID, 
					"mydialog", attr)
					
	dlgwindow.focus();
}
</script>

<table width="100%">
	<tr class="ms-WPHeader">
		<td colspan="4" class="controltitle">Automatic Email Notification</td>
	</tr>
</table>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
</table>
<table class="def" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
		<td width="10px"></td>
		<td align="left">IG Approval Committee</td>
		<td colspan="3" height="10px"></td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
	    <td align="left">
			<asp:DropDownList Runat="server" ID="ddlIGApprovalCommittee" CssClass="textselect" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlIGApprovalCommittee_SelectedIndexChanged"> </asp:DropDownList>
		</td>
		<td colspan="3"></td>		
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
	     <td width="10px"></td>
	    <td align="left">
	        	<asp:repeater id="repeaterNotification" EnableViewState="False" runat="server" OnItemCommand="repeaterNotification_ItemCommand" OnItemDataBound="repeaterNotification_ItemDataBound" >
					<HeaderTemplate>
					<table class="datatable" cellSpacing="0" cellPadding="2">
						<tr runat="server" id="HeaderID" height="22px">
							<td class="headcell" width="170" align="center">IG Approval Committee</td>
							<td class="headcell" width="170" align="center">IG Coordinator</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20" runat="server" id="RowID">
						   <td class="incell" align="left">
						    <table>
						            <tr>
						               <td><asp:ImageButton runat="server" ID="delComCon" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"ContactID")%>' CommandName="DeleteComCon" ></asp:ImageButton></td>
						               <td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "Committee")%></td>
						            </tr>
						    </table>
						    </td>
						    <td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem, "Name")%></td>
	                    </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20" runat="server" id="AlternateRowID">
							    <td class="incell" align="left">
							        <table>
				                    <tr>
						                   <td><asp:ImageButton runat="server" ID="delComCon" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"ContactID")%>' CommandName="DeleteComCon" ></asp:ImageButton></td>
						                   <td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "Committee")%></td>
						                </tr>
						            </table>
						        </td>
						    <td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem, "Name")%></td>
	                    </tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
						</table>
					</FooterTemplate>
				</asp:repeater>
	    </td>
	</tr>
	<tr>
		<td colspan="5" height="10px"></td>
	</tr>
	<tr>
	    <td width="10px"></td>
	    <td>IG Coordinator</td>
	    <td colspan="3"></td>
	<tr>
	    <td width="10px"></td>
	    <td align="left">
	        <table>
	        <tr>
	            <td>
	                <asp:TextBox Runat="server" ID="txtIGCoordinator" CssClass="textinput" Width="170px" MaxLength="50"></asp:TextBox>
	                <a runat="server" ID="lnkIGCoordinator"><img src="Images/pick.jpg" border="0" id="IMG1"></a>
	                <asp:HiddenField runat="server" ID="hIGCoordinator" />
	             </td>
	             <td width="10px"></td>
	             <td><asp:Button runat="server" ID="btnAdd" Text="Add" OnClick="btnAdd_Click" Width="70px" /></td>
	          </tr>
	          </table>
	    </td>
	    <td colspan="3"></td>
	</tr>
</table>
<table class="def" cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td colspan="5" height="10px">
            <br />
            <br />
            <br />
            <br />
        </td>
    </tr>
    <tr>
        <td style="width: 10px">
        </td>
        <td align="left">
            Sponsor</td>
        <td colspan="3" height="10px">
        </td>
    </tr>
    <tr>
        <td colspan="5" height="10px">
        </td>
    </tr>
    <tr>
        <td style="width: 10px">
        </td>
        <td align="left">
            <asp:DropDownList Runat="server" ID="ddlSponsor" CssClass="textselect" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlIGApprovalCommittee_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
        <td colspan="3">
        </td>
    </tr>
    <tr>
        <td colspan="5" height="10px">
        </td>
    </tr>
    <tr>
        <td style="width: 10px">
        </td>
        <td align="left">
            <asp:repeater id="repeaterSponsor" EnableViewState="False" runat="server" OnItemCommand="repeaterSponsor_ItemCommand" OnItemDataBound="repeaterSponsor_ItemDataBound" >
                <HeaderTemplate>
                    <table class="datatable" cellSpacing="0" cellPadding="2">
                        <tr runat="server" id="HeaderID" height="22px">
                            <td class="headcell" width="170" align="center">
                                Sponsor</td>
                            <td class="headcell" width="170" align="center">
                                Sponsor Email</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr height="20" runat="server" id="RowID">
                        <td class="incell" align="left">
                            <table>
                                <tr>
                                    <td>
                                        <asp:ImageButton ID="delComCon" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"SponsorContactID")%>'
                                            CommandName="DeleteComCon" ImageUrl="~/Images/delete.gif" /></td>
                                    <td class="incell" align="center">
                                        <%# DataBinder.Eval(Container.DataItem, "Name")%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="incell" align="center">
                            <%# DataBinder.Eval(Container.DataItem, "SponsorContactEmail")%>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr height="20" runat="server" id="AlternateRowID">
                        <td class="incell" align="left">
                            <table>
                                <tr>
                                    <td>
                                        <asp:ImageButton ID="delComCon" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"SponsorContactID")%>'
                                            CommandName="DeleteComCon" ImageUrl="~/Images/delete.gif" /></td>
                                    <td class="alternateincell" align="center">
                                        <%# DataBinder.Eval(Container.DataItem, "Name")%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="alternateincell" align="center">
                            <%# DataBinder.Eval(Container.DataItem, "SponsorContactEmail")%>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </td>
    </tr>
    <tr>
        <td colspan="5" height="10px">
        </td>
    </tr>
    <tr>
        <td style="width: 10px">
        </td>
        <td>
            Sponsor Email</td>
        <td colspan="3">
        </td>
    </tr>
    <tr>
        <td style="width: 10px">
        </td>
        <td align="left">
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="txtSponsorEmail" runat="server" CssClass="textinput" MaxLength="50" Width="170px"></asp:TextBox>
                        <a runat="server" ID="lnkSponsor"><img src="Images/pick.jpg" border="0" id="IMG2"></a>
                        <asp:HiddenField runat="server" ID="hSponsor" />
                    </td>
                    <td width="10px">
                    </td>
                    <td>
                        <asp:Button runat="server" ID="btnAddSponsorEmail" Text="Add" OnClick="btnAddSponsorEmail_Click" Width="70px" /></td>
                </tr>
            </table>
        </td>
        <td colspan="3">
        </td>
    </tr>
</table>
<br>
