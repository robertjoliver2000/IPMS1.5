<%@ Page language="c#" Inherits="ProjectPortfolio.NewApplication" CodeFile="NewApplication.aspx.cs" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<script language="javascript">
function updateItem(itemValue,item2Value,itemID)
{
    opener.updateItem(itemValue,item2Value,itemID);
    window.close();
}
</script>

<script src="js/DatePicker.js" type="text/javascript"></script>
	
	<HEAD>
		<title id="pageTitle" runat="server">Application</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<BASE target="_self">
	</HEAD>
	<body >
		<form id="frmNewApp" method="post" runat="server">
			<table border="0">
				<tr>
					<td ></td>
					<td class="summarylabel" width="170">Application Instance Name</td>
					<td><asp:RequiredFieldValidator ID="rvAppInstanceName" runat="server" Text="*" ControlToValidate="txtAppInstanceName"></asp:RequiredFieldValidator></td>
					<td>
					    <asp:TextBox Runat="server" ID="txtAppInstanceName" CssClass="textinput" Width="200"></asp:Textbox>
					</td>
		             <td width="50">	                
		             </td>
		
				</tr>
				<tr>
					<td style="height: 21px"></td>
					<td class="summarylabel" style="height: 21px">Application ID</td>
					<td style="height: 21px"></td>
					<td style="height: 21px"><asp:TextBox Runat="server" ID="txtAppID" CssClass="textinput" Width="200"></asp:TextBox></td>
					<td><asp:HiddenField runat="server" id="hiddenAppID"></asp:HiddenField></td>
				</tr>
				<tr>
					<td colspan="4" height="10"></td>
				<tr>
					<td height="20"></td>
					<td></td>
					<td></td>
					<td align="right">
						<table>
							<tr>
								<td><asp:Button id="btnOK" runat="server" Width="70" Text="OK" CssClass="def" onclick="btnOK_Click"></asp:Button></td>
								<td width="20"></td>
								<td><INPUT class="def" style="WIDTH: 70px" onclick="window.close()" type="button" value="Cancel"></td>
							</tr>
						</table>
					</td>
				</tr>
				<asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
                HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
                ShowMessageBox="True" ShowSummary="False" />
			</table>
		</form>
	</body>
</HTML>
