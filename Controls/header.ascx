<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.Header" CodeFile="Header.ascx.cs" %>
<table width="100%" height="60px" border="0" cellspacing="0" cellpadding="0" class="borderbottom">
	<tr class="ms-WPTitle">
	    <td>
            <table width="100%" height="50px" border="0">
	             <tr>
		            <td valign="top" class="apptitle">
		                    <asp:Label runat="server" ID="lblTitle" Text="<%$ AppSettings:ApplicationName %>"></asp:Label>
		            </td>
		            <td align="right" valign="top">
		                    <asp:Label CssClass="usertitle" runat="Server" ID="lblWelcomeMessage">Welcome, User!</asp:Label>
		            </td>
		            <td width="10">
		            </td>
	            </tr>
	        </table>
            <table width="100%" height="20px" border="0">
	            <tr>
		            <td valign="bottom" runat="server" id="tdLinks"  class="myprojects">
                        <a href="~/default.aspx?section=1" class="map" runat="server" id="lnkSummary">Summary</a>&nbsp;&nbsp;
                        <a href="~/default.aspx?section=2" class="map" runat="server" id="lnkFinancial">Financial</a>&nbsp;&nbsp;
                        <span id="notPIR" runat="server">
                        <a href="~/default.aspx?section=3" class="map" runat="server" id="lnkArchitectureAndRisk">Architecture&amp;Risk</a>&nbsp;&nbsp;
                        <a href="~/default.aspx?section=4" class="map" runat="server" id="lnkProjects">Projects</a>&nbsp;
                        </span>|&nbsp;
                        <a href="~/default.aspx?section=5" class="map" runat="server" id="lnkWorkflow">Workflow</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="~/default.aspx?section=6" class="map" runat="server" id="lnkAudit">Audit</a>&nbsp;&nbsp;
		            </td>
		            <td valign="bottom" align="right" class="myprojects">
                        <a href="~/FullPDF.aspx" class="map" runat="server" id="lnkPrintFull" target="_blank">Print Initiative</a>&nbsp;&nbsp;
                        <a href="~/TestingForm_Printing.aspx" class="map" runat="server" id="lnkPrintForm" target="_blank">Print Sheet</a>&nbsp;&nbsp;
		                <a href="~/Admin.aspx" class="map" runat="server" id="lnkAdmin" target="_blank" visible="false">Admin</a>&nbsp;&nbsp;
                        <a href="~/Report.aspx" class="map" runat="server" id="lnkReports">Reports</a>&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton
                            ID="lnkLogout" runat="server" class="title" OnClick="lnkLogout_Click">Logout</asp:LinkButton>
		            </td>
		            <td width="10"></td>
	            </tr>
	        </table>	
	    </td>
	</tr>
</table>
<script type="text/javascript">
function cordaPrintLinks() {
    if (document.getElementById("ctlHeader_lnkPrintForm")) {
        //Prepend the href with the Corda server
        var link = document.getElementById("ctlHeader_lnkPrintForm");
        if( !( /.*\/FullPDF.aspx.*/.test( link.href ) ) )
        {
            link.href = "http://<%=System.Configuration.ConfigurationSettings.AppSettings["CordaServerAddress"]%>:2001/?@_DOC_LOAD"+link.href;
        }
    }
}

cordaPrintLinks();
</script>
