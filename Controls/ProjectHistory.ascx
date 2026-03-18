<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProjectHistory.ascx.cs" Inherits="Controls_ProjectHistory" %>
<table cellpadding="2" cellspacing="2" border="0">
    <tr height="15px">
        <td width="15px">&nbsp;</td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <asp:GridView AutoGenerateColumns="False" EnableViewState="False" runat="Server" ID="gvMyProjects" 
                CellPadding="2" CssClass="datatable" OnRowDataBound="gvMyProjects_RowDataBound">
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="InitiativeID" DataNavigateUrlFormatString="~/default.aspx?section=1&InitiativeID={0}" DataTextField="Name" HeaderText="Initiative Name">
                        <HeaderStyle CssClass="mp_headcell" Width="400px"  HorizontalAlign="Left"/>
                        <ItemStyle CssClass="mp_incell" Width="400px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                    </asp:HyperLinkField>
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
                    <asp:TemplateField HeaderText="Status" SortExpression="IGApprovalStatusID">
                        <HeaderStyle CssClass="mp_headcell" Width="200px"  HorizontalAlign="Center"/>
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
                </Columns>
                <RowStyle BackColor="#fcfcfc" Height="25px" />
                <AlternatingRowStyle BackColor="#f6f6f6" Height="25px" />
                <HeaderStyle Height="25px" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td></td>
        <td><asp:Button runat="server" ID="btnBack" Width="70px" Text="Back" CssClass="button" OnClick="btnBack_Click"/></td>
    </tr>
</table>