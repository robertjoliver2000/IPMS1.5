<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.Admin_Header" CodeFile="Admin_Header.ascx.cs" %>
<table width="100%" height="60px" border="0" cellspacing="0" cellpadding="0" class="borderbottom">
	<tr class="ms-WPTitle">
	    <td>
            <table width="100%" height="29px" border="0">
	             <tr>
		            <td valign="top" class="apptitle">
		                    <asp:Label runat="server" ID="lblTitle" Text="<%$ AppSettings:ApplicationName %>" ></asp:Label>
		            </td>
		            <td align="right" valign="top">
		                    <asp:Label CssClass="usertitle" runat="Server" ID="lblWelcomeMessage">Welcome, User!</asp:Label>
		            </td>
		            <td width="10">
		            </td>
	            </tr>
	        </table>
            <table width="100%" height="29px" border="0">
	            <tr>
		            <td valign="bottom" runat="server" id="tdLinks" class="myprojects">
		                Administration
		            </td>
		            <td valign="bottom" align="right" class="myprojects">
                        <a href="~/admin.aspx?section=1" class="map" runat="server" id="lnkInitiatives">Initiatives</a>&nbsp;&nbsp;
                        <a href="~/admin.aspx?section=2" class="map" runat="server" id="lnkStaticData">Static data</a>&nbsp;&nbsp;
                        <a href="~/admin.aspx?section=3" class="map" runat="server" id="lnkUBR">UBR</a>&nbsp;&nbsp;
                        <a href="~/admin.aspx?section=4" class="map" runat="server" id="lnkPeriods">Periods</a>&nbsp;&nbsp;
                        <a href="~/admin.aspx?section=5" class="map" runat="server" id="lnkAudit">Audit</a>&nbsp;&nbsp;
                        <a href="~/admin.aspx?section=6" class="map" runat="server" id="lnkNotification">Notification</a>&nbsp;&nbsp;
                        <a href="~/admin.aspx?section=7" class="map" runat="server" id="lnkDeletedInitiatives">Deleted Initiatives</a>&nbsp;&nbsp;
                    <td valign="bottom" align="right" class="myprojects" width="100px">
		                <a href="http://ig.gto.intranet.db.com/" class="title">Logout</a>
		            </td>
		            <td width="10"></td>
	            </tr>
	        </table>	
	    </td>
	</tr>
</table>
