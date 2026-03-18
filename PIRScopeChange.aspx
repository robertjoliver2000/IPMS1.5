<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PIRScopeChange.aspx.cs" Inherits="PIRScopeChange" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Add Scope Change Record</title>
	<LINK href="style.css" type="text/css" rel="stylesheet">
	<BASE target="_self">    
</head>

<body >
    <form id="frmMain" runat="server">
    <div>
		<table border="0">
		<tr height="5px">
		</tr>
		<tr>
		<td width="5px"></td>
		<td>
	    <table border="0" cellpadding="2" cellspacing="2">
            <tr>
		        <td colspan="2" style="font-size:12px" class="summarylabel"><asp:Label runat="Server" ID="lblTitle">New Scope Change</asp:Label></td>
            </tr>		
            <tr>
                <td colspan="2" height="5px"></td>
            </tr>
            <tr>
                <td class="summarylabel" width="130px">Scope Change: </td>
                <td>
                    <asp:TextBox CssClass="textinput" Width="300px" runat="Server" ID="txtScopeChange" MaxLength="200"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvScopeChange" runat="server" Text="*" ControlToValidate="txtScopeChange"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="summarylabel" width="130px">Commentary: </td>
                <td>
                    <asp:TextBox CssClass="textinput" Width="300px" runat="Server" ID="txtCommentary" MaxLength="4000"></asp:TextBox>
                </td>
            </tr>
            <tr><td class="summarylabel">Status</td>
            <td><asp:DropDownList ID="ddlStatus" runat="server"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                    Text="*" InitialValue="0"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td colspan="3" align="left">
                    <asp:Button runat="server" ID="btnOK" Text="OK" Width="70px" CssClass="def" TabIndex="20" OnClick="btnOK_Click" />
                    <asp:Button runat="server" ID="btnCancel" Text="Cancel" Width="70px" CssClass="def" TabIndex="21" />
                </td>
            </tr>	    	    
        </table>
                <asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
                    HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
                    ShowMessageBox="True" ShowSummary="False" />
        </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>