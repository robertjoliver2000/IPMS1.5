<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ArchitectureAndRisk_Printing.aspx.cs" Inherits="ArchitectureAndRisk_Printing" %>

<%@ Register Src="Controls/ArchitectureAndRisk_PrintVersion.ascx" TagName="ArchitectureAndRisk_PrintVersion"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Architecture and Risk</title>
    <link href="Style_Print.css" rel="stylesheet" type="text/css" />
</head>
<body style="page-size:A4; page-orientation:portrait; page-margin-top:0.25in; page-margin-bottom:0.25in; page-margin-left:0.25in; page-margin-right:0.25in;">

    <form id="printForm" runat="server">
    <div id="printArea">
        <asp:PlaceHolder ID="ctlPlaceHolder" runat="server"></asp:PlaceHolder>
    </div>
    </form>
</body>
</html>

