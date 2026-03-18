<%@ Page language="c#" Inherits="ProjectPortfolio.Server" CodeFile="Server.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<script language="javascript">
function popupWindowSelectServer(initiativeID, txtBoxID, txtBox2ID, hiddenTxtBoxID)
{
    var dialogwidth = 320
	var dialogheight = 400
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"
  
    dlgwindow = window.open("SelectItem.aspx?InitiativeID=" + initiativeID + "&CategoryID=3&ControlID=" + txtBoxID + "&Control2ID=" + txtBox2ID + "&HiddenControlID=" + hiddenTxtBoxID, 
					"selectitem_dialog", attr);
					
					
	dlgwindow.focus();
}
</script>
<script src="js/DatePicker.js" type="text/javascript"></script>

	<HEAD>
		<title runat="server" id="pageTitle">Server</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<BASE target="_self">
	</HEAD>
	<body>
		<form id="frmNewServer" method="post" runat="server">
			<table border="0">
				<tr>
					<td></td>
					<td class="summarylabel" width="170">Server Node Name</td>
					<td> <asp:RequiredFieldValidator ID="rvServerName" runat="server" Text="*" ControlToValidate="txtServerName"></asp:RequiredFieldValidator></td>
					<td>
					    <asp:TextBox Runat="server" ID="txtServerName" CssClass="textinput" Width="200"></asp:Textbox>
					</td>
		             <td width="50">
		                <a runat="server" ID="hRefServerName"><img src="Images/pick.jpg" border="0"></a>
		             </td>
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Server Node ID</td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtServerNodeID" CssClass="textinputgreen" Enabled="False" Width="200"></asp:TextBox></td>
					<td><asp:HiddenField runat="server" id="hiddenServerID"></asp:HiddenField></td>
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Impact</td>
					<td></td>
					<td align="left">
					    <table align="left" border="0" cellpadding="0" cellspacing="0">
					        <tr visible="false" runat="server">
					            <td><asp:TextBox Runat="server" ID="txtDate" CssClass="textinput" Width="100"></asp:TextBox></td>
					            <td width="5"></td>
					            <td><a href="javascript:popupWindowDatePicker('txtDate');" title="Pick Date"><img src="Images/calendar.jpg" border="0"></a></td>
					        </tr>
					        <tr>
					              <td colspan="3"><asp:TextBox Runat="server" ID="txtImpact" CssClass="textinput" Width="200" TextMode="MultiLine"></asp:TextBox></td>
					        </tr>
					    </table>
					</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="5" height="10"></td>
				<tr>
					<td height="20"></td>
					<td></td>
					<td></td>
					<td align="right">
						<table>
							<tr>
								<td><asp:Button id="btnOK"  Width="70" Runat="server" Text="Update" CssClass="def" onclick="btnOK_Click"></asp:Button></td>
								<td width="20"></td>
								<td><INPUT class="def" style="WIDTH: 70px" onclick="window.close()" type="button" value="Cancel"></td>
							</tr>
						</table>
					</td>
					<td></td>
				</tr>
				<asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
                HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
                ShowMessageBox="True" ShowSummary="False" />
			</table>
		</form>
	</body>
</HTML>
