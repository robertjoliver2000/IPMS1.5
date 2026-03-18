<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_KeyMetrics_PrintVersion.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_KeyMetrics_PrintVersion" %>
<%@ Register Src="Status_DDL_PrintVersion.ascx" TagName="Status_DDL" TagPrefix="uc1" %>
<table class="KeyMetricsTable">
<colgroup>
    <col style="width:80mm;" />
    <col style="width:20mm; text-align:center;" />
    <col style="width:170mm;" />
</colgroup>
<thead>
    <tr class="xms-WPHeader">
        <th class="controltitle">Key Metrics</th>
        <th class="controltitle" style="text-align:center;">Status</th>
        <th>Comments</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>
            <p class="KeyMetricTitle">Spend</p>
            <p class="KeyMetricSubtitle">Was spend within budget?</p></td>
        <td>
            <uc1:Status_DDL ID="sddlSpend" runat="server" CssClass="PIRStatus" Size="3.5mm"/>
        </td>
        <td>
            <asp:Label ID="txtSpendComments" runat="server" Height="10mm"
                Width="100%"></asp:Label></td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Key Delivery</p>
            <p class="KeyMetricSubtitle">Were key milestones delivered on-time?</p>     
        </td>
        <td>
            <uc1:Status_DDL ID="sddlDelivery" runat="server" CssClass="PIRStatus" Size="3.5mm"/>
        </td>
        <td>
            <asp:Label ID="txtDeliveryComments" runat="server" Height="10mm"
                Width="100%"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Time</p>
            <p class="KeyMetricSubtitle">Was delivery on time?</p>     
        </td>
        <td>
            <uc1:Status_DDL ID="sddlTime" runat="server" CssClass="PIRStatus" Size="3.5mm"/>
        </td>
        <td>
            <asp:Label ID="txtTimeComments" runat="server" Height="10mm"
                Width="100%"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Risk & Issue Management</p>
            <p class="KeyMetricSubtitle">Were risks and issues managed well?</p>
        </td>
        <td>
            <uc1:Status_DDL ID="sddlRiskMan" runat="server" CssClass="PIRStatus" Size="3.5mm"/>
        </td>
        <td>
            <asp:Label ID="txtRiskManComments" runat="server" Height="10mm"
                Width="100%"></asp:Label></td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Business Impact</p>
            <p class="KeyMetricSubtitle">Were expected benefits achieved?</p>
        </td>
        <td>
            <uc1:Status_DDL ID="sddlImpact" runat="server" CssClass="PIRStatus" Size="3.5mm"/>
        </td>
        <td>
            <asp:Label ID="txtImpactComments" runat="server" Height="10mm"
                Width="100%"></asp:Label></td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Scope</p>
            <p class="KeyMetricSubtitle">Was expected scope (product /regional coverage) achieved?</p>
        </td>
        <td>
            <uc1:Status_DDL ID="sddlScope" runat="server" CssClass="PIRStatus" Size="3.5mm"/>
        </td>
        <td>
            <asp:Label ID="txtScopeComments" runat="server" Height="10mm"
                Width="100%"></asp:Label>
            </td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Project Management</p>
            <p class="KeyMetricSubtitle">Did the approach fit the initiative?</p>
        </td>
        <td>
            <uc1:Status_DDL ID="sddlProjMan" runat="server" CssClass="PIRStatus" Size="3.5mm"/>
        </td>
        <td>
            <asp:Label ID="txtProjManComments" runat="server" Height="10mm"
                Width="100%"></asp:Label></td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Alpha</p>
            <p class="KeyMetricSubtitle">Does this work deliver technology that will provide a competitive advantage?</p>
        </td>
        <td>
            <uc1:Status_DDL ID="sddlAlpha" runat="server" CssClass="PIRStatus" Size="3.5mm"/>
        </td>
        <td>
            <asp:Label ID="txtAlphaComments" runat="server" Height="10mm"
                Width="100%"></asp:Label></td>
    </tr>
</tbody>
</table>
