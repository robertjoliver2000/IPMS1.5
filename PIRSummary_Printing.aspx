<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PIRSummary_Printing.aspx.cs" Inherits="ProjectPortfolio.PIRSummary_Printing" %>
<%@ Register Src="Controls/PIR_PrintHeader.ascx" TagName="PIR_PrintHeader" TagPrefix="pph" %>

<!-- DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" 
    "http://www.w3.org/TR/html4/loose.dtd">
    
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>PIR Summary</title>
    <!-- link href="style.css" rel="stylesheet" type="text/css" / -->
    <link href="Style_Print.css" rel="stylesheet" type="text/css" />
</head>
<body style="page-size:A4; page-orientation:landscape; page-margin-top:0.25in; page-margin-bottom:0.25in; page-margin-left:0.25in; page-margin-right:0.25in;" >
    <form id="printForm" runat="server">
    
    <div id="printArea">
        <pph:PIR_PrintHeader id="lblHeaderText" runat="server"></pph:PIR_PrintHeader>

        <asp:PlaceHolder ID="ctlPlaceHolder" runat="server"></asp:PlaceHolder>

        <div style="font-size:4pt">&nbsp;</div>
        
        <!-- Commented out as we could not anchor the footer at the bottom right of every page
        <div style="width:280mm; text-align:right;"><img src="images/PIR_Footer.jpg" /></div> -->       
    </div>
    
    </form>
</body>
</html>
