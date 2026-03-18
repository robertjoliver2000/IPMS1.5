<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebFormPage5.aspx.cs" Inherits="WebFormPage5" %>

<%@ Register Src="Controls/Review_SectionB.ascx" TagName="Review_SectionB" TagPrefix="uc1" %>
<%@ Register TagPrefix="uc_SecF" TagName="SectionF" Src="Controls/SectionF.ascx" %>
<%@ Register TagPrefix="uc_SecG" TagName="SectionG" Src="Controls/SectionG.ascx" %>
<%@ Register TagPrefix="uc_SecK" TagName="SectionH" Src="Controls/SectionH.ascx" %>
<%@ Register TagPrefix="uc_SecL" TagName="SectionI" Src="Controls/SectionI.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>TEST</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<BODY>
		<form id="frmMain" method="post" runat="server">    
            <uc1:Review_SectionB ID="Review_SectionB1" runat="server" />
		    
		</form>
	</BODY>
</HTML>