<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_ProfitLossAnalysis_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_ProfitLossAnalysis_PrintVersion" %>
<table cellpadding="0" xcellspacing="2" style="border: 1px solid #CCCCCC; height: 100%; width: 100%;">
<tr style="height: 12px; width: 100%;"><td class="PIRTitle">Profit &amp; Loss Analysis (Eur'Mn)</td></tr>
<tr style="width:100%; height: 100%;"><td>
<img src="images/SummaryB_Review_ProfitLossImage.aspx?InitiativeID=<%=Request.QueryString["InitiativeID"]%>" style="width: 99.5%; height:57.4mm;"/>
</td></tr></table>