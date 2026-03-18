<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PIRDeliverable.aspx.cs" Inherits="PIRDeliverable" %>

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
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" Text="*" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="summarylabel" width="130px">Commentary: </td>
                <td>
                    <asp:TextBox CssClass="textinput" Width="300px" runat="Server" ID="txtPIRCommentary" MaxLength="4000"></asp:TextBox>
                </td>
            </tr>
            <tr><td class="summarylabel">Status</td>
            <td><asp:DropDownList ID="ddlPIRStatus" runat="server"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvPIRStatus" runat="server" ControlToValidate="ddlPIRStatus"
                    InitialValue="0" Text="*"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="summarylabel">
                    Plan Date:</td>
                <td>
				    <table align="left" border="0" cellpadding="0" cellspacing="0">
				        <tr>
				            <td><asp:TextBox CssClass="textinput" style="text-align: center;" Width="80px" runat="Server" ID="txtPIRPlanDate"></asp:TextBox></td>
				            <td width="20px" align="center"><a runat="server" id="lnkPIRPlanDate"><img src="Images/calendar.jpg" border="0"></a></td>
				            <td width="20px" align="center"><asp:RangeValidator ID="rvPIRPlanDate" runat="server" ControlToValidate="txtPIRPlanDate" Text="*" MaximumValue="1/1/2020" MinimumValue="1/1/1900" Type="Date" ></asp:RangeValidator></td>
				        </tr>
	                    <tr>
	                        <td valign="top"><font face="verdana, arial, helvetica, sans-serif" color="#333333" size="1"><em>dd/mm/yyyy</em></font></td>
	                        <td></td>
	                        <td></td>
	                    </tr>
				    </table>
                    <asp:RequiredFieldValidator ID="rfvPIRPlanDate" runat="server" ControlToValidate="txtPIRPlanDate"
                        Text="*"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="summarylabel">
                    Actual Date:</td>
                <td>
				    <table align="left" border="0" cellpadding="0" cellspacing="0">
				        <tr>
				            <td><asp:TextBox CssClass="textinput" style="text-align: center;" Width="80px" runat="Server" ID="txtPIRActualDate"></asp:TextBox></td>
				            <td width="20px" align="center"><a runat="server" id="lnkPIRActualDate"><img src="Images/calendar.jpg" border="0"></a></td>
				            <td width="20px" align="center"><asp:RangeValidator ID="rvPIRActualDate" runat="server" ControlToValidate="txtPIRActualDate" Text="*" MaximumValue="1/1/2020" MinimumValue="1/1/1900" Type="Date" ></asp:RangeValidator></td>
				        </tr>
	                    <tr>
	                        <td valign="top"><font face="verdana, arial, helvetica, sans-serif" color="#333333" size="1"><em>dd/mm/yyyy</em></font></td>
	                        <td></td>
	                        <td></td>
	                    </tr>
				    </table>
                    <asp:RequiredFieldValidator ID="rfvPIRActualDate" runat="server" ControlToValidate="txtPIRActualDate"
                        Text="*"></asp:RequiredFieldValidator></td>
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