<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>


<%@ Reference VirtualPath="~/Controls/Admin_Initiative.ascx"%>
<%@ Reference VirtualPath="~/Controls/Admin_Review.ascx"%>
<%@ Reference VirtualPath="~/Controls/Admin_StaticData.ascx"%>
<%@ Reference VirtualPath="~/Controls/Admin_Period.ascx"%>
<%@ Reference VirtualPath="~/Controls/IGAudit.ascx"%>

<%@ Register Src="Controls/Admin_Header.ascx" TagName="Header" TagPrefix="uc1" %>
<%@ Register Src="Controls/Admin_Footer.ascx" TagName="Footer" TagPrefix="uc2" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<script language="javascript" type="text/javascript">
//<!--
var ns4 = document.layers;
var ns6 = document.getElementById && !document.all;
var ie4 = document.all;
offsetX = 20;
offsetY = -85;
var toolTipSTYLE="";


function initToolTips()
{
  if(ns4||ns6||ie4)
  {
    if(ns4) {
        toolTipSTYLE = document.toolTipLayer;
    }
    else if(ns6) {
        toolTipSTYLE = document.getElementById("toolTipLayer").style;
    }
    else if(ie4) {
        toolTipSTYLE = document.all.toolTipLayer.style;    
    }
    
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
    x = event.x + contentLayer.scrollLeft + document.documentElement.scrollLeft;
    y = event.y + contentLayer.scrollTop + document.documentElement.scrollTop;
  }
  
  toolTipSTYLE.left = x + offsetX;
  toolTipSTYLE.top = y + offsetY;
  return true;
}
//-->
</script>

<script language="javascript" type="text/javascript">
//<!--

/**
 * Takes an existing event handler, and adds some extra code to it.
 * This allows us to override existing functions, such as document.onclick
 * events without destroying the existing functionality, unless we require it.
 *
 * @param element the element on which the event handler is defined.
 * @param handlerName the name of the handler on the element.
 * @param extraCode the extraCode to be added to the element's handler.
 */
function Events_chainEvent(element, handlerName, extraCode) {
 var strOldHandlerContent=""
 if (element!=null) {
     if(element[handlerName]!=null) {
      //Get the contents of the old function from the event handler ...
      var strOldHandler=element[handlerName].toString();
      //Retrieve the content of the handler between the outermost { }
      strOldHandlerContent=strOldHandler.match(/\{[\s\S]*\}/g)[0]
      //If it's null, then change to blank ..
      if(strOldHandlerContent==null) strOldHandlerContent=""
      //Now pull off the first and last characters which _should_ be { and }
      if (strOldHandlerContent.length>3)
       strOldHandlerContent=strOldHandlerContent.substring(1,strOldHandlerContent.length-2);
     }
     //Check that extraCode ends with a ;
     if (!extraCode.substring(extraCode.length-1, extraCode.length)==";") extraCode+=";";
     
     //Now redefine the handler, with the new code prepended to the string.
     //*** Has to be a prepend otherwise the code might return before ours is executed
     element[handlerName]=new Function(extraCode+strOldHandlerContent);
  }
}

var bAllowSubmit = false;

function SetDirtyFlag()
{
    document.forms[0].dirty.value = "true";
    //alert('set dirty flag');
}

function ClearDirtyFlag()
{
    document.forms[0].dirty.value = "false";
    //alert('clear dirty flag');
}

function AllowOneTimeSubmit()
{
    bAllowSubmit = true;
    //alert('one time submit - preserve dirty flag');
}

function ConfirmUnload()
{
    //debugger
    if (document.forms[0].dirty.value == "true" && bAllowSubmit == false)
    {
        event.returnValue = "There are unsaved changes on this worksheet.";        
    }
    
    bAllowSubmit = false;
}

//-->
</script>

<script src="js/DatePicker.js" type="text/javascript"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server">PPO Administrator</title>
    <link href="style.css" type="text/css" rel="stylesheet" />
</head>
<body onload="javascript:setH()">
    <!--body leftmargin="0" topmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="javascript:setH()">-->
   <form id="frmAdminForm" runat="server">
   
        <input type="submit" name="dummy" value="_" style="width:0px; height:0px; position:absolute; top:-50px;left:-50px;" onclick="javascript: return false;"/>
        <input type="hidden" name="dirty" id="dirty" runat="server" value="false" />
        
        <uc1:header ID="ctlHeader" runat="server" />
        <div style="overflow: auto; " id="contentLayer">
            <asp:PlaceHolder ID="ctlPlaceHolder" runat="server"></asp:PlaceHolder><br />
            <div id="toolTipLayer" style="overflow: auto; position:absolute; visibility: hidden"></div>
        </div>
        <uc2:footer ID="ctlFooter" runat="server" />
        
        <asp:HiddenField runat="server" id="hiddenScrollY" /> 
    </form>
    
    <script language="javascript" type="text/javascript">
        //<!--
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
          
          contentLayer.style.height = ((H - 100)>=0 ? H - 100 : 0) + 'px';
          contentLayer.style.width = W + 'px';
          
          if (restoreScroll)
            restoreScroll();
       } 
       
       window.onresize = setH;
       setH();       
       //-->
    </script>

    <script language="JavaScript"type="text/javascript">
    //<!--
    initToolTips(); //--></script>
   
</body>
</html>
