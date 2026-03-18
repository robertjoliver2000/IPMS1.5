<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GenericError.aspx.cs" Inherits="GenericError" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>IPMS Error Page</title>
    <link href="style.css" type="text/css" rel="stylesheet" />
    
    <style>
     H2 { font-family:"Verdana";font-weight:normal;font-size:14pt;color:RedIndian }
     pre {font-family:"Lucida Console";font-size: 9pt;}
     .errortext {font-family:"Lucida Console";font-size: 9pt;}
     .marker {font-weight: bold; color: black;text-decoration: none;}
     .version {color: gray;}
     .error {margin-bottom: 10px;}
     .expandable { text-decoration:underline; font-weight:bold; color:navy; cursor:hand; }
    </style>
            
</head>
<body leftmargin="0" topmargin="0" bottommargin="0" marginwidth="0" marginheight="0" onload="javascript:setH()">
   <form id="frmMainForm" runat="server">
   
   <table width="100%" height="40px" border="0" cellspacing="0" cellpadding="0" class="borderbottom">
	<tr class="ms-WPTitle">
	    <td>
            <table width="100%" height="50px" border="0">
	             <tr>
		            <td valign="top" class="apptitle">
		                    <span style="color:IndianRed">An error has occured in the PPO application!</span>
		            </td>
		            <td align="right" valign="top">
		            </td>
		            <td width="10">
		            </td>
	            </tr>
	        </table>
            <table width="100%" height="20px" border="0">
	            <tr>
		            <td valign="bottom" class="myprojects">Please contact the Central Support team at <a href="mailto:robertjoliver@outlook.com" class="support">robertjoliver@outlook.com</a> with the following error details:</td>
		            <td valign="bottom" align="right" class="myprojects">
		            </td>
		            <td width="10"></td>
	            </tr>
	        </table>	
	    </td>
	</tr>
    </table>
   
        <div style="overflow: auto; " id="contentLayer">
            <table cellpadding="2" cellspacing="2">
            <tr>
            <td width="10px"></td>
            <td>
            <span runat="server" id="ltContent"></span>
            </td></tr></table>
        </div>
        
        <asp:HiddenField runat="server" id="hiddenScrollY" /> 
        
    <table width="100%" height="40px" border="0" cellspacing="0" cellpadding="0" class="bordertop">
        <tr class="ms-WPFooter">
            <td>
                <table width="100%" height="36px" border="0" cellspacing="0" cellpadding="0">
	                <tr  height="30">
	                    <td width="10"></td>
		                <td>
                            <asp:Hyperlink runat="server" id="lnkBack" CssClass="support"></asp:Hyperlink>
		                </td>
		                <td align="right">
		                </td>
		                <td width="10">
		                </td>
	                </tr>
                </table>
            </td>
        </tr>
    </table>        

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
          
          contentLayer.style.height = ((H - 114)>=0 ? H - 114 : 0) + 'px';
          contentLayer.style.width = W + 'px';
          
          if (restoreScroll)
            restoreScroll();
       } 
       
       window.onresize = setH;
       setH();       
       //-->
    </script>
 
</body>
</html>
