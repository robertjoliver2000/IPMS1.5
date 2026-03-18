<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Projects_Printing.aspx.cs" Inherits="Projects_Printing" %>

<%@ Register Src="Controls/Projects_PrintVersion.ascx" TagName="Projects_PrintVersion"
    TagPrefix="uc3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Projects</title>
    <link href="Style.css" rel="stylesheet" type="text/css" />

</head>
<body style="page-size:A4; page-orientation:landscape; page-margin-top:0.25in; page-margin-bottom:0.25in; page-margin-left:0.25in; page-margin-right:0.25in;">
    <form id="form1" runat="server">
    <div id="printArea">
        <uc3:Projects_PrintVersion id="ctlProjects_PrintVersion" runat="server">
        </uc3:Projects_PrintVersion>
    </div>
    </form>
</body>
</html>
