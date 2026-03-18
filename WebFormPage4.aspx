<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebFormPage4.aspx.cs" Inherits="WebFormPage4" %>
<%@ Register TagPrefix="uc_SecH" TagName="SectionJ" Src="Controls/SectionJ.ascx" %>
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
					<uc_SecH:SectionJ id="ctlSectionJ" runat="server"></uc_SecH:SectionJ>
				</tr>
		    </table>
		</form>
	</BODY>
</HTML>