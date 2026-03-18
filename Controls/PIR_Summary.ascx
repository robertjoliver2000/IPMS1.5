<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_Summary.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_Summary" %>
<%@ Register Src="PIR_FinancialsAndDelivery.ascx" TagName="PIR_FinancialsAndDelivery"
    TagPrefix="uc3" %>
<%@ Register Src="PIR_KeyMetrics.ascx" TagName="PIR_KeyMetrics" TagPrefix="uc2" %>
<%@ Register Src="PIR_ExecutiveSummary.ascx" TagName="PIR_ExecutiveSummary" TagPrefix="uc1" %>
<div style="margin:5px; width:1045px;"><script type="text/javascript" src="Js/PprStatus.js"></script>
<uc1:PIR_ExecutiveSummary ID="ctlPIR_ExecutiveSummary" runat="server" />
<br />
<uc2:PIR_KeyMetrics ID="ctlPIR_KeyMetrics" runat="server"/>
<uc3:PIR_FinancialsAndDelivery id="ctlPIR_FinancialsAndDelivery" runat="server" />
</div>  