<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CheckBoxListWithAll.ascx.cs" Inherits="Controls_CheckBoxListWithAll" %>
<div onclick="handleCblaClick(this);">
<asp:Panel ID="pnlAll" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
    HorizontalAlign="Center" Width="100%">
    <asp:CheckBox ID="cbxAll" runat="server" BorderColor="Transparent" Checked="True"
        Font-Bold="True" Font-Names="Arial" Font-Size="8pt" Text="All" TextAlign="Left"
        Width="100%" /></asp:Panel>
<asp:CheckBoxList ID="cblItems" runat="server" CellPadding="0" CellSpacing="0" Font-Size="6pt"
    RepeatColumns="3" Width="100%">
</asp:CheckBoxList>
</div>