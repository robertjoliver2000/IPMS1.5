<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestingForm_Printing.aspx.cs" Inherits="TestingForm_Printing" %>

<%--@ Register Src="Controls/Summary_PrintVersion.ascx" TagName="Summary_PrintVersion"
    TagPrefix="uc1" --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Initiative</title>
    <link href="Style_Print_Summary.css" rel="stylesheet" type="text/css" />
</head>
<body style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 1px; padding-top: 0px; page-size:A4; page-orientation:portrait; page-margin-top:0.25in; page-margin-bottom:0.25in; page-margin-left:0.25in; page-margin-right:0.25in;" >
    <form id="form1" runat="server">
        &nbsp;&nbsp;<asp:PlaceHolder ID="ctlPlaceHolder" runat="server"></asp:PlaceHolder>
        <%--<uc1:Summary_PrintVersion ID="Summary_PrintVersion1" runat="server" 
        page-size-width:8.5in; page-size-height:11in; />--%>

    </form>
</body>
</html>
