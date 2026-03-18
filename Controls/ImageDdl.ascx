<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageDdl.ascx.cs" Inherits="Controls_ImageDdl" %>
<div class="imageddlclosed">
<iframe frameborder="1" src="" class="hidden"></iframe>
<ul>
	<li onmouseover="showMask( this );" onmouseout="hideMask( this );"
		><a href="#" onclick="toggleMenu( this ); return false;"><img src="Images/ppr_grey.gif"
						alt="- - Please Select" /><button
						    onclick="toggleMenu( this );" onkeyup="toggleMenu( this );">v</button><!--[if gt IE 6]><!--></a><!--<![endif]--><!--[if lt IE 7]><table border="0" cellpadding="0" cellspacing="0"><tr><td><![endif]-->
		<ul>
			<li><a href="#" onclick="doSelect( this ); return false;"><img src="Images/ppr_grey.gif" alt="- - Please Select"/></a></li>
			<li><a href="#" onclick="doSelect( this ); return false;"><img src="Images/ppr_red.gif" alt="R - Red"/></a></li>
			<li><a href="#" onclick="doSelect( this ); return false;"><img src="Images/ppr_amber.gif" alt="A - Amber"/></a></li>
			<li><a href="#" onclick="doSelect( this ); return false;"><img src="Images/ppr_green.gif" alt="G - Green"/></a></li>
		</ul>

		<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
</ul><input type="hidden" value="" runat="server" id="hdnStatus"/><input type="hidden" value="" runat="server" id="hdnStatusId"/>
</div>