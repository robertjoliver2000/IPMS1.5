<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.Footer" CodeFile="Footer.ascx.cs" %>

<table width="100%" height="40px" border="0" cellspacing="0" cellpadding="0" class="bordertop">
    <tr class="ms-WPFooter">
        <td>
            <table width="100%" height="36px" border="0" cellspacing="0" cellpadding="0">
	            <tr  height="30">
	                <td width="10"></td>
		            <td>
			            <asp:Button runat="server" ID="btnSave" Text="Save Changes" Width="100px" CssClass="button" OnClick="btnSave_Click"/>&nbsp;
			            <asp:Button runat="server" ID="btnBack" Text="Close" Width="70px" CausesValidation="false" CssClass="button" OnClick="btnBack_Click"/>
		            </td>
		            <td align="right">
		            </td>
		            <td width="10">
		            </td>
	            </tr>
            </table>
        </td>
    </tr>
</table>