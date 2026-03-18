<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MyProjects.ascx.cs" Inherits="Controls_MyProjects" %>
<table cellpadding="2" cellspacing="2" border="0">
    <tr height="15px">
        <td width="15px">&nbsp;</td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <asp:GridView AutoGenerateColumns="False" EnableViewState="False" runat="Server" ID="gvMyProjects" 
                CellPadding="2" CssClass="datatable" OnRowCommand="gvMyProjects_RowCommand" OnRowDataBound="gvMyProjects_RowDataBound" AllowSorting="True" OnSorting="gvMyProjects_Sorting" >
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="InitiativeID" DataNavigateUrlFormatString="~/default.aspx?section=1&amp;InitiativeID={0}" DataTextField="Name" HeaderText="Initiative Name" SortExpression="Name">
                        <HeaderStyle CssClass="mp_headcell" Width="300px"  HorizontalAlign="Left"/>
                        <ItemStyle CssClass="mp_incell" Width="300px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                    </asp:HyperLinkField>
                    <asp:TemplateField HeaderText="IG Identifier" SortExpression="IGBusinessAreaCode, IGIdentifierCode">
                        <HeaderStyle CssClass="mp_headcell" Width="110px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="110px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGBusinessAreaCode")%>-<%# DataBinder.Eval(Container.DataItem,"IGIdentifierCode")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Current Version" SortExpression="IGVersionNumber">
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
                        <HeaderStyle CssClass="mp_headcell" Width="180px"  HorizontalAlign="Center"/>
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
                    <asp:HyperLinkField DataNavigateUrlFields="InitiativeID" Text="Show All Versions" DataNavigateUrlFormatString="~/default.aspx?InitiativeID={0}">
                        <HeaderStyle CssClass="mp_headcell" Width="120px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                    </asp:HyperLinkField>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="mp_headcell" Width="120px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle cssclass="button" />
                        <ItemTemplate>
                            <asp:Button runat="server" id="btnCreateReview" CommandName="CreateReview" CommandArgument=<%# DataBinder.Eval(Container.DataItem,"InitiativeID")%> Text="New Review" Enabled=<%# DataBinder.Eval(Container.DataItem, "Approved").Equals("True") %> />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle BackColor="#FCFCFC" Height="25px" />
                <AlternatingRowStyle BackColor="#F6F6F6" Height="25px" />
                <HeaderStyle Height="25px" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td></td>
        <td><asp:Button runat="server" ID="btnNewInitiative" Width="120px" Text="New Initiative" CssClass="button" OnClick="btnNewInitiative_Click"/></td>
    </tr>
</table>