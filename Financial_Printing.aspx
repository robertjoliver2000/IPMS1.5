<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Financial_Printing.aspx.cs" Inherits="Financial_Printing" %>

<%@ Register Src="Controls/Financial_PrintVersion.ascx" TagName="Financial_PrintVersion"
    TagPrefix="uc1" %>

<%@ Register Src="Controls/Review_Financial_PrintVersion.ascx" TagName="Review_Financial_PrintVersion"
    TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Financials</title>
    <link href="Style_FinancialPrint.css" rel="stylesheet" type="text/css" />
</head>
<body style="page-size:A4; page-orientation:landscape; page-margin-top:0.25in; page-margin-bottom:0.25in; page-margin-left:0.25in; page-margin-right:0.25in;" >
    <form id="printForm" runat="server">
    
    <div id="printArea">
        <asp:PlaceHolder ID="ctlPlaceHolder" runat="server"></asp:PlaceHolder>
    </div>
    
    </form>
</body>
</html>
