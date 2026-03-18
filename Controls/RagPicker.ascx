<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RagPicker.ascx.cs" Inherits="ProjectPortfolio.Controls.RagPicker" %>
<script type="text/javascript" language="javascript" src=Js/RagList.js></script>
<div metric="01" id="metric_01" class="raglist" onmouseover="showSub( this );" onmouseout="hideSub( this );"
		style="color:gray; background-color:Yellow;" title="Please select">
    <!-- script type="text/javascript" language="javascript">hideSub( this );</script -->
	<img src="Images/Rag_04.bmp" />
	<ul id="sub01" style="position:absolute; left:-1000px;">
		<li><a href="#" onclick="setStatus(this, 4)" class="rag_04"	title="Please select"	><img src="Images/Rag_04.bmp" /></a></li>
		<li><a href="#" onclick="setStatus(this, 1)" class="rag_01" title="Red"				><img src="Images/Rag_01.bmp" /></a></li>
		<li><a href="#" onclick="setStatus(this, 2)" class="rag_02" title="Amber"			><img src="Images/Rag_02.bmp" /></a></li>
		<li><a href="#" onclick="setStatus(this, 3)" class="rag_03" title="Green"			><img src="Images/Rag_03.bmp" /></a></li>
	</ul>
	<input type="hidden" ragtype="StatusID" runat="server" id="ragStatusID" />
	<input type="hidden" ragtype="Status" runat="server" id="ragStatus" />
</div>