<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Deliverable.aspx.cs" Inherits="Deliverable" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Add Deliverable Record</title>
	<LINK href="style.css" type="text/css" rel="stylesheet">
	<BASE target="_self">    
</head>

<script src="js/DatePicker.js" type="text/javascript"></script>

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
		        <td colspan="2" style="font-size:12px" class="summarylabel"><asp:Label runat="Server" ID="lblTitle">New Deliverable</asp:Label></td>
            </tr>		
            <tr>
                <td colspan="2" height="5px"></td>
            </tr>
            <tr>
                <td class="summarylabel" width="130px">Deliverable Name: </td>
                <td>
                    <asp:TextBox CssClass="textinput" Width="300px" runat="Server" ID="txtName" MaxLength="200"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rvName" runat="server" Text="*" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="summarylabel">Due Date:</td>
                <td>
				    <table align="left" border="0" cellpadding="0" cellspacing="0">
				        <tr>
				            <td><asp:TextBox CssClass="textinput" style="text-align: center;" Width="80px" runat="Server" ID="txtDueDate"></asp:TextBox></td>
				            <td width="20px" align="center"><a runat="server" id="lnkDueDate"><img src="Images/calendar.jpg" border="0"></a></td>
				            <td width="20px" align="center"><asp:RangeValidator ID="rvDueDate" runat="server" ControlToValidate="txtDueDate" Text="*" MaximumValue="1/1/2020" MinimumValue="1/1/1900" Type="Date" ></asp:RangeValidator></td>
				        </tr>
	                    <tr>
	                        <td valign="top"><font face="verdana, arial, helvetica, sans-serif" color="#333333" size="1"><em>dd/mm/yyyy</em></font></td>
	                        <td></td>
	                        <td></td>
	                    </tr>
				    </table>
                </td>
            </tr>
            <tr>
                <td class="summarylabel">Cost:</td>
                <td>
                    <asp:TextBox CssClass="textinput" style="text-align: right;" Width="50px" runat="Server" ID="txtCost"></asp:TextBox>
                    &nbsp;€M&nbsp;&nbsp;
                    <asp:RangeValidator ID="rvCost" runat="server" ControlToValidate="txtCost"
                        Text="*" MaximumValue="1000000" MinimumValue="0" Type="Double" ></asp:RangeValidator>                    
                </td>
            </tr>
            <tr>
                <td class="summarylabel">Affected Applications:</td>
                <td>
                    <asp:TextBox CssClass="textinput" Width="200px" runat="Server" ID="txtAffectedApplications" MaxLength="200"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="15px"></td>
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