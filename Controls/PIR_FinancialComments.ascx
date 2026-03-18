<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_FinancialComments.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_FinancialComments" %>
<script type="text/javascript" src="js/utils.js" ></script>
<table style="width:100%; border-right: #cccccc 1px solid; border-top: #cccccc 1px solid; border-left: #cccccc 1px solid; border-bottom: #cccccc 1px solid; xwidth: 760px;">
<tr>
    <td class="PIRTitle" style="width: 756px">Financial Comments
        <asp:RequiredFieldValidator ID="rvPIRFinancialComments" runat="server" ControlToValidate="txtPIRFinancialComments"
            ErrorMessage="Financial Comments must not be blank" ValidationGroup="SubmitForReview"
            Width="1px">*</asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
    <td style="width: 756px">
        <asp:TextBox Runat="server" ID="txtPIRFinancialComments" CssClass="textinput" TextMode="MultiLine"
            Width="700px" Height="322px" style="width:100%;"></asp:TextBox>
        </td>
</tr>
</table>