<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Admin_Review.ascx.cs" Inherits="Controls_Admin_Review" %>
<script language="javascript">

function popupWindowInitiative(initiativeID, initiative)
{
    var returnCode;
	returnCode= window.showModalDialog("InitiativeDetails.aspx?InitiativeID=" + initiativeID + "&InitiativeName=" + initiative, 
					            "initiative_dialog", "dialogWidth:480px;dialogHeight:180px;status:no;resizable:no;scroll:yes");
					
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            window.document.forms[0].submit();
        }
    }   
}


</script>

<table width="100%">
	<tr class="ms-WPHeader">
		<td colspan="4" class="controltitle">Review Maintenance</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="1" border="0">
    <tr>
        <td width="1px">            
        </td>
        <td valign="top" style="border: solid 1px #CCCCCC"> 
         
        </td>
        <td width="1px">            
        </td>
        <td valign="top">
             <asp:GridView AutoGenerateColumns="False" EnableViewState="False" runat="Server" ID="gvInitiatives" 
                CellPadding="2" CssClass="datatable" AllowSorting="True" OnRowCommand="gvInitiatives_RowCommand" OnRowDataBound="gvInitiatives_RowDataBound" OnSorting="gvInitiatives_Sorting">
                <Columns>
                    <asp:TemplateField HeaderText="Initiative Name" SortExpression="Name">
                        <HeaderStyle CssClass="mp_headcell" Width="220px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="220px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                        <table>
                        <tr>
                            <td><a runat="server" id="lnkInitiative" href="#" 
                                onclick='<%# "javascript:popupWindowInitiative(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", \"" + DataBinder.Eval(Container.DataItem,"Name") + "\"); return false;"%>'>
                                <%# DataBinder.Eval(Container.DataItem, "Name")%>
                           </a></td>
                         </tr>
                        </table>
                        </ItemTemplate>
                    </asp:TemplateField>                
                    <asp:TemplateField HeaderText="IG Identifier" SortExpression="IGBusinessAreaCode, IGIdentifierCode">
                        <HeaderStyle CssClass="mp_headcell" Width="110px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="110px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGBusinessAreaCode")%>-<%# DataBinder.Eval(Container.DataItem,"IGIdentifierCode")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Version Number" SortExpression="IGVersionNumber">
                        <HeaderStyle CssClass="mp_headcell" Width="70px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="70px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGVersionNumber").ToString().PadLeft(2, '0')%>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Review Date" SortExpression="IGReviewDate">
                        <HeaderStyle CssClass="mp_headcell" Width="90px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="90px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGReviewDate", "{0:d}") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="IGApprovalStatusID">
                        <HeaderStyle CssClass="mp_headcell" Width="160px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Left" />
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td width="16px"><asp:Image runat="server" id="imgStatus"/></td>
                                    <td><%# DataBinder.Eval(Container.DataItem,"IGApprovalStatus")%></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:TemplateField HeaderText="Locked by" SortExpression="LockedBy">
                        <HeaderStyle CssClass="mp_headcell" Width="70px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="70px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"LockedBy").ToString()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="mp_headcell" Width="120px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle cssclass="button" />
                        <ItemTemplate>
                            <asp:Button runat="server" id="btnUnlock" CommandName="Unlock" CommandArgument=<%# DataBinder.Eval(Container.DataItem,"InitiativeID")%> Text="Unlock" Enabled=<%# DataBinder.Eval(Container.DataItem, "LockedBy").ToString()!= string.Empty %> />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle BackColor="#FCFCFC" Height="25px" />
                <AlternatingRowStyle BackColor="#F6F6F6" Height="25px" />
                <HeaderStyle Height="25px" />
            </asp:GridView>
            <asp:Label runat="server" CssClass="mp_headcell" id="lblDeletedInitiatives" Text="Deleted Initiatives" Visible="False"/>
            <asp:GridView AutoGenerateColumns="False" EnableViewState="False" runat="Server" ID="gvDeletedInitiatives" 
                CellPadding="2" CssClass="datatable" AllowSorting="True" OnRowCommand="gvDeletedInitiatives_RowCommand" OnRowDataBound="gvDeletedInitiatives_RowDataBound" OnSorting="gvDeletedInitiatives_Sorting" Visible="False">
                <Columns>
                    <asp:TemplateField HeaderText="Initiative Name">
                        <HeaderStyle CssClass="mp_headcell" Width="220px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="220px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                        <table>
                        <tr>
                            <td><a runat="server" id="lnkInitiative">
                                <%# DataBinder.Eval(Container.DataItem, "Name")%>
                           </a></td>
                         </tr>
                        </table>
                        </ItemTemplate>
                    </asp:TemplateField>                
                    <asp:TemplateField HeaderText="IG Identifier">
                        <HeaderStyle CssClass="mp_headcell" Width="110px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="110px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGBusinessAreaCode")%>-<%# DataBinder.Eval(Container.DataItem,"IGIdentifierCode")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Version Number">
                        <HeaderStyle CssClass="mp_headcell" Width="70px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="70px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGVersionNumber").ToString().PadLeft(2, '0')%>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Review Date">
                        <HeaderStyle CssClass="mp_headcell" Width="90px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="90px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGReviewDate", "{0:d}") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <HeaderStyle CssClass="mp_headcell" Width="160px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Left" />
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td width="16px"><asp:Image runat="server" id="imgStatus"/></td>
                                    <td><asp:Label runat="server" id="Image1" Text="Deleted"/></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:TemplateField>
                        <HeaderStyle CssClass="mp_headcell" Width="70px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="70px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"LockedBy").ToString()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="mp_headcell" Width="120px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle cssclass="button" />
                        <ItemTemplate>
                            <asp:Button runat="server" id="btnReinstate" CommandName="Reinstate" CommandArgument=<%# DataBinder.Eval(Container.DataItem,"InitiativeID")%> Text="Reinstate" Enabled="True" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle BackColor="#FCFCFC" Height="25px" />
                <AlternatingRowStyle BackColor="#F6F6F6" Height="25px" />
                <HeaderStyle Height="25px" />
            </asp:GridView>       
        </td>
    </tr>
    <tr height="30px">
        <td></td>
        <td></td> <td></td>
        <td colspan="2">&nbsp&nbsp
            <asp:Button runat="server" ID="btnBack" Width="70px" Text="Back" CssClass="button" OnClick="btnBack_Click"/>
        </td>
    </tr>
    
</table>