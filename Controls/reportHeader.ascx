<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.ReportHeader" CodeFile="reportHeader.ascx.cs" %>
<table width="100%" height="60px" border="0" cellspacing="0" cellpadding="0" class="borderbottom">
	<tr class="ms-WPTitle">
	    <td>
            <table width="100%" height="58px" border="0">
	             <tr>
		            <td valign="top" class="apptitle">
		                    <asp:Label runat="server" ID="lblTitle" Text="<%$ AppSettings:ApplicationName %>"></asp:Label>
		            </td>
		            <td align="right" valign="top" width="200px">
		                    <asp:Label CssClass="usertitle" runat="Server" ID="lblWelcomeMessage">Welcome, User!</asp:Label>
		            </td>
		            <td width="10">
		            </td>
	            </tr>
	            <tr>
		            <td valign="bottom" runat="server" id="tdLinks"  class="myprojects">
                        <a href="~/" class="map" runat="server" id="HomeLink">Home</a>&nbsp;&nbsp;
                        <a href="~/Report.aspx?report=1" class="map" runat="server" id="lnkProvider">Provider View</a>&nbsp;&nbsp;
                        <a href="~/Report.aspx?report=2" class="map" runat="server" id="lnkClient">Client View</a>&nbsp;&nbsp;
                        <a href="~/Report.aspx?report=3" class="map" runat="server" id="lnkCommittee">Committee View</a>&nbsp;&nbsp;
                        <a href="~/Report.aspx?report=4" class="map" runat="server" id="lnkBenefits">Profit &amp; Loss Analysis</a>&nbsp;&nbsp;
                        <a href="~/Report.aspx?report=5" class="map" runat="server" id="lnkBubble">ROI Analysis</a>&nbsp;&nbsp;
		            </td>
		            <td valign="bottom" align="right">
		                <a href="http://ig.gto.intranet.db.com/index.php" class="title">Logout</a>
		            </td>
		            <td></td>
	            </tr>
	        </table>	
	    </td>
	</tr>
</table>
