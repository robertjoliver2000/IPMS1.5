<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_Summary_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_Summary_PrintVersion" %>
<%@ Register Src="PIR_FinancialsAndDelivery_PrintVersion.ascx" TagName="PIR_FinancialsAndDelivery"
    TagPrefix="uc3" %>
<%@ Register Src="PIR_KeyMetrics_PrintVersion.ascx" TagName="PIR_KeyMetrics_PrintVersion" TagPrefix="uc2" %>
<%@ Register Src="PIR_ExecutiveSummary_PrintVersion.ascx" TagName="PIR_ExecutiveSummary_PrintVersion" TagPrefix="uc1" %>
<div style="margin:0mm; width:280mm;">
<uc1:PIR_ExecutiveSummary_PrintVersion ID="ctlPIR_ExecutiveSummary" runat="server" />
<!-- Page breaks done by &Page=1 etc. -->
<!-- <span style="page-break-after:always;"></span> -->
<uc2:PIR_KeyMetrics_PrintVersion ID="ctlPIR_KeyMetrics" runat="server" />
<!-- <span style="page-break-after:always;"></span> -->
<uc3:PIR_FinancialsAndDelivery id="ctlPIR_FinancialsAndDelivery" runat="server" />
</div>