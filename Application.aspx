<%@ Page language="c#" Inherits="ProjectPortfolio.Application" CodeFile="Application.aspx.cs" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<script language="javascript">

function popupWindowSelectApplication(initiativeID, txtBoxID, txtBox2ID, hiddenTxtBoxID, txtBox3ID, hiddenTxtBox3ID)
{
    var dialogwidth = 340
	var dialogheight = 445
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"
  
	dlgwindow = window.open("SelectItem.aspx?InitiativeID=" + initiativeID + "&CategoryID=2&ControlID="+txtBoxID+"&Control2ID="+txtBox2ID+"&HiddenControlID="+hiddenTxtBoxID+"&Control3ID="+txtBox3ID+"&Control4ID="+hiddenTxtBox3ID, 
					"selectitem_dialog", attr)
					
	dlgwindow.focus();
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
		                <a runat="server" ID="hRefAppInstanceName"><img src="Images/pick.jpg" border="0"></a>
		             </td>
		
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel">Application ID</td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtAppID" CssClass="textinputgreen" Width="200" Enabled="False"></asp:TextBox></td>
					<td><asp:HiddenField runat="server" id="hiddenAppID"></asp:HiddenField></td>
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
					<td></td>
					<td class="summarylabel">Investment Strategy</td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtInvestmentStrategy" CssClass="textinputgreen" Width="200" Enabled="False"></asp:TextBox></td>
					<td><asp:HiddenField runat="server" id="hiddenInvestmentStrategy"></asp:HiddenField></td>
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
