<%@ Reference Control="~/controls/sectiond.ascx" %>
<%@ Reference Control="~/controls/SectionE.ascx" %>
<%@ Register TagPrefix="uc_SecC" TagName="SectionE" Src="Controls/SectionE.ascx" %>
<%@ Register TagPrefix="uc_SecD" TagName="SectionD" Src="Controls/SectionD.ascx" %>
<%@ Page language="c#" Inherits="ProjectPortfolio.WebFormPage2" CodeFile="WebFormPage2.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>TEST</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<BODY>
		<form id="frmMain" method="post" runat="server">
			<table border="0">
				<tr>
					<td><uc_SecC:SectionE id="ctlSectionE" runat="server"></uc_SecC:SectionE></td>
				</tr>
				<tr>
					<td><uc_SecD:SectionD id="ctlSectionD" runat="server"></uc_SecD:SectionD></td>
				</tr>
				<tr>
					<td><asp:Button id="btnUpdate" runat="server" Text="Update" onclick="btnUpdate_Click"></asp:Button></td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>
