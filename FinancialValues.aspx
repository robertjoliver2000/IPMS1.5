<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FinancialValues.aspx.cs" Inherits="ProjectPortfolio.FinancialValues" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">
    <title>Add Financial Record</title>
	<LINK href="style.css" type="text/css" rel="stylesheet">    
	<BASE target="_self">
</head>

<script src="js/DatePicker.js" type="text/javascript"></script>

<body> 
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
		        <td></td>
		        <td colspan="4" class="summarylabel"><asp:Label runat="Server" ID="lblAmountsTitle"></asp:Label>&nbsp;(€M)</td>
            </tr>		
            <tr>
                <td colspan="2"></td>
            </tr>
		    <tr>
		        <td class="summarylabel" width="70px"><asp:Label runat="server" id="lblStartDate">Start Date</asp:Label></td>
        		<td width="240px" colspan="4">
				    <table align="left" border="0" cellpadding="0" cellspacing="0">
				        <tr>
				            <td><asp:TextBox Runat="server" ID="txtStartDate" CssClass="textinput" MaxLength="50" Width="80px" style="text-align:center" TabIndex="8"></asp:TextBox></td>
				            <td width="20px" align="center"><a runat="server" id="lnkStartDate"><img src="Images/calendar.jpg" border="0"></a></td>
				            <td width="20px" align="center">
				                <asp:RangeValidator ID="rvStartDate" runat="server" ControlToValidate="txtStartDate" MaximumValue="1/1/2020" MinimumValue="1/1/1900" Type="Date" >*</asp:RangeValidator>
				                <asp:RequiredFieldValidator ID="rqvStartDate" runat="server" ControlToValidate="txtStartDate">*</asp:RequiredFieldValidator>
				            </td>
				        </tr>
	                    <tr>
	                        <td valign="top"><font face="verdana, arial, helvetica, sans-serif" color="#333333" size="1"><em><asp:Label runat="server" id="lblDateInfo">dd/mm/yyyy</asp:Label></em></font></td>
	                        <td></td>
	                        <td></td>
	                    </tr>
				    </table>        		
			    </td>
        	</tr>
            <tr>
                <td colspan="2"></td>
            </tr>
            <asp:Repeater runat="Server" ID="rptControls" OnItemDataBound="rptControls_OnItemDataBound" EnableViewState="true">
                <ItemTemplate>
                    <tr runat="Server" id="trContent"></tr>
                </ItemTemplate>
            </asp:Repeater>
            <tr height="15px">
                <td colspan="5" style="height: 15px">
                    </td>
            </tr>
            <tr>
                <td colspan="3" align="left">
                    <asp:Button runat="server" ID="btnOK" Text="OK" Width="70px" CssClass="def" OnClick="btnOK_Click" TabIndex="20" />
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
