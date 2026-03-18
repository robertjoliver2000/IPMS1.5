<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebFormPage3.aspx.cs" Inherits="WebFormPage3" %>
<%@ Register Src="Controls/SectionC.ascx" TagName="SectionC" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="javascript">
var ns4 = document.layers;
var ns6 = document.getElementById && !document.all;
var ie4 = document.all;
offsetX = 0;
offsetY = 0;
var toolTipSTYLE="";


function initToolTips()
{
  if(ns4||ns6||ie4)
  {
    if(ns4) toolTipSTYLE = document.toolTipLayer;
    else if(ns6) toolTipSTYLE = document.getElementById("toolTipLayer").style;
    else if(ie4) toolTipSTYLE = document.all.toolTipLayer.style;
    if(ns4) document.captureEvents(Event.MOUSEMOVE);
    else
    {
      toolTipSTYLE.visibility = "visible";
      toolTipSTYLE.display = "none";
    }
    document.onmousemove = moveToMouseLoc;
  }
}


function toolTip(msg, wd, fg, bg)
{
  if(toolTip.arguments.length < 1) // hide
  {
    if(ns4) toolTipSTYLE.visibility = "hidden";
    else toolTipSTYLE.display = "none";
  }
  else // show
  {
    if(!fg) fg = "#000000";
    if(!bg) bg = "#EEEEEE";
	if(!wd) wd = '150';
    var content =
    '<table width="'+ wd +'" border="0" cellspacing="0" cellpadding="1" bgcolor="#006600"><td>' +
    '<table width="100%" border="0" cellspacing="0" cellpadding="3" bgcolor="' + bg + 
    '"><td align="left" width="100%"><font face="Verdana" color="' + fg +
    '" size="1">' + msg +
    '&nbsp\;</font></td></table></td></table>';
    if(ns4)
    {
      toolTipSTYLE.document.write(content);
      toolTipSTYLE.document.close();
      toolTipSTYLE.visibility = "visible";
    }
    if(ns6)
    {
      document.getElementById("toolTipLayer").innerHTML = content;
      toolTipSTYLE.display='block'
    }
    if(ie4)
    {
      document.all("toolTipLayer").innerHTML=content;
      toolTipSTYLE.display='block'
    }
  }
}


function moveToMouseLoc(e)
{
  if(ns4||ns6)
  {
    x = e.pageX;
    y = e.pageY;
  }
  else
  {
    x = event.x + document.body.scrollLeft + document.documentElement.scrollLeft;
    y = event.y + document.body.scrollTop + document.documentElement.scrollTop;
  }
  
  toolTipSTYLE.left = x + offsetX;
  toolTipSTYLE.top = y + offsetY;
  return true;
}
//-->
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <LINK href="style.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <div id="divContent">
                <uc2:SectionC ID="ctlSectionC" runat="server" />
        </div>
    </form>
    
    <div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
      <script language="JavaScript"><!--
    initToolTips(); //--></script>
    
</body>
</html>
