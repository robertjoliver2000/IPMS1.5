<%@ Reference Control="~/Controls/sectionb_sponsorallocations.ascx" %>
<%@ Reference Control="~/Controls/sectionb_benefitsanalysis.ascx" %>
<%@ Reference Control="~/Controls/sectionb_profitlossanalysis.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SectionB_SponsorAllocations" Src="~/Controls/SectionB_SponsorAllocations_PrintVersion.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SectionB_ProfitLossAnalysis" Src="~/Controls/SectionB_ProfitLossAnalysis_PrintVersion.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SectionB_BenefitsAnalysis" Src="~/Controls/SectionB_BenefitsAnalysis_PrintVersion.ascx" %>
<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionB_PrintVersion" CodeFile="Sectionb_PrintVersion.ascx.cs" %>
<%@ Register Src="SectionB_ProgramDeliverables_PrintVersion.ascx" TagName="SectionB_ProgramDeliverables" TagPrefix="uc2" %>
<table class="def" width="">
	<tr>
	    <td valign="top">
	        <table border="0" cellpadding="0" cellspacing="0">
	            <tr>
	                <td  style="border: 1px solid #CCCCCC; " valign="top"><uc1:SectionB_ProfitLossAnalysis id="ctlSectionB_ProfitLossAnalysis" runat="server" /></td>
	                <td  style="border: 1px solid #CCCCCC; " valign="top"><uc1:SectionB_SponsorAllocations id="ctlSectionB_SponsorAllocations" runat="server" /></td>
	            </tr>
	        </table>
	        
	    </td>
	</tr>
</table><br />
	        <%-- Note that here, the control will start a new table and row which spans the 3 cols here
	             in order to show the Benefits Analysis table properly. This is a bit of a hack
	             We should really split the analysis into separate controls, one for the main table
	             and one for the Summary analysis table. --%>
            <uc1:SectionB_BenefitsAnalysis id="ctlSectionB_BenefitsAnalysis" runat="server" />
 
 <!--
 Page break removed by Ross Saunders to bring the Milestones onto the second page. Requested by client Tom Herbich
  style="page-break-before:always" 
 -->
	
        
