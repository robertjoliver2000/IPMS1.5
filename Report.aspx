<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Report" %>

<%@ Register Src="Controls/reportHeader.ascx" TagName="reportHeader" TagPrefix="uc1" %>
<%@ Register Src="Controls/reportFooter.ascx" TagName="reportFooter" TagPrefix="uc2" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html scroll="no">
<head runat="server">
    <title>IPMS</title>
    <link href="style.css" type="text/css" rel="stylesheet">
</head>
<body leftmargin="0" topmargin="0" bottommargin="0" marginwidth="0" marginheight="0" scroll="no" onload="javascript:setH()">
   <form id="frmMainForm" runat="server">
        <uc1:reportHeader ID="ctlHeader" runat="server" />
       <div style="overflow: hidden; " id="divControl">
        <asp:Label runat="server" ID="ReportFrameSrc" Visible="false"/>
           <asp:PlaceHolder ID="ctlPlaceHolder" runat="server"></asp:PlaceHolder>
       </div>
        <uc2:reportFooter ID="ctlFooter" runat="server" />
    </form>
    
    <script language="javascript">
       function setH()
       {
          if (document.documentElement && document.documentElement.clientHeight)
          {
             H = document.documentElement.clientHeight;
             W = document.documentElement.clientWidth;
          }
          else
          {
             H = document.body.clientHeight;
             W = document.body.clientWidth;
          }
          
          divControl.style.height = ((H - 100)>=0 ? H - 100 : 0)+ 'px';
          divControl.style.width = W + 'px';
       } 
       
       window.onresize = setH;
       setH();       
    </script>
    
</body>
</html>
