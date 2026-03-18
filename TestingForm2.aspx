<%@ Register TagPrefix="uc_SecD" TagName="SectionD" Src="Controls/SectionD.ascx" %>
<%@ Register TagPrefix="uc_AI" TagName="AI" Src="Controls/Admin_Initiative.ascx" %>
<%@ Register TagPrefix="uc_A" TagName="A" Src="Controls/IGAudit.ascx" %>
<%@ Page language="c#" Inherits="ProjectPortfolio.TestingForm2" CodeFile="TestingForm2.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>TEST</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<BODY>
		<form id="frmMain" method="post" runat="server">
			<uc_AI:AI id="ctlSectionAI" runat="server"></uc_AI:AI>
		</form>
	</BODY>
</HTML>
