<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_KeyMetrics.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_KeyMetrics" %>
<%@ Register Src="Status_DDL.ascx" TagName="Status_DDL" TagPrefix="uc1" %>
<script type="text/javascript" src="js/utils.js" ></script>
<table class="KeyMetricsTable" style="xwidth:100%; width:1249px; margin:0px 0px 0px -2px;">
<colgroup>
    <col style="width:400px;" />
    <col style="width:50px; text-align:center;" />
    <col style="width:600px;" />
</colgroup>
<thead>
    <tr>
        <th>Key Metrics<asp:TextBox ID="txtOverallStatus" runat="server" style="display:none;" />
            <asp:TextBox ID="txtOverallStatusID" runat="server" style="display:none;" />
        </th>
        <th style="text-align:center;">Status</th>
        <th>Comments</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>
            <p class="KeyMetricTitle">Spend</p>
            <p class="KeyMetricSubtitle">Was spend within budget?</p></td>
        <td>&nbsp;
            <uc1:Status_DDL ID="sddlSpend" runat="server" CssClass="PIRStatus"/>
            &nbsp;<asp:RequiredFieldValidator ID="rfvSpendStatus" runat="server" ControlToValidate="sddlSpend:ddl"
                CssClass="statusError" ErrorMessage="Key Metric - Spend Status must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td>
            <asp:TextBox ID="txtSpendComments" runat="server" CssClass="textinput" Height="50px"
                TextMode="MultiLine" Width="100%"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Key Delivery</p>
            <p class="KeyMetricSubtitle">Were key milestones delivered on-time?</p>     
        </td>
        <td>&nbsp;
            <uc1:Status_DDL ID="sddlDelivery" runat="server" CssClass="PIRStatus"/>
            &nbsp;<asp:RequiredFieldValidator ID="rfvDeliveryStatus" runat="server" ControlToValidate="sddlDelivery:ddl"
                CssClass="statusError" ErrorMessage="Key Metric - Delivery Status must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td>
            <asp:TextBox ID="txtDeliveryComments" runat="server" CssClass="textinput" Height="50px"
                TextMode="MultiLine" Width="100%"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Time</p>
            <p class="KeyMetricSubtitle">Was delivery on time?</p>     
        </td>
        <td>&nbsp;
            <uc1:Status_DDL ID="sddlTime" runat="server" CssClass="PIRStatus"/>
            &nbsp;<asp:RequiredFieldValidator ID="rfvTimeStatus" runat="server" ControlToValidate="sddlTime:ddl"
                CssClass="statusError" ErrorMessage="Key Metric - Time Status must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td>
            <asp:TextBox ID="txtTimeComments" runat="server" CssClass="textinput" Height="50px"
                TextMode="MultiLine" Width="100%"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Risk & Issue Management</p>
            <p class="KeyMetricSubtitle">Were risks and issues managed well?</p>
        </td>
        <td>&nbsp;
            <uc1:Status_DDL ID="sddlRiskMan" runat="server" CssClass="PIRStatus"/>
            &nbsp;<asp:RequiredFieldValidator ID="rfvRiskMan" runat="server" ControlToValidate="sddlRiskMan:ddl"
                CssClass="statusError" ErrorMessage="Key Metric - Risk & Issue Management Status must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td>
            <asp:TextBox ID="txtRiskManComments" runat="server" CssClass="textinput" Height="50px"
                TextMode="MultiLine" Width="100%"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Business Impact</p>
            <p class="KeyMetricSubtitle">Were expected benefits achieved?</p>
        </td>
        <td>&nbsp;
            <uc1:Status_DDL ID="sddlImpact" runat="server" CssClass="PIRStatus"/>
            &nbsp;<asp:RequiredFieldValidator ID="rfvImpact" runat="server" ControlToValidate="sddlImpact:ddl"
                CssClass="statusError" ErrorMessage="Key Metric - Spend Status must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td>
            <asp:TextBox ID="txtImpactComments" runat="server" CssClass="textinput" Height="50px"
                TextMode="MultiLine" Width="100%"></asp:TextBox></td>
    </tr>
    <tr>
        <td style="height: 59px">
            <p class="KeyMetricTitle">Scope</p>
            <p class="KeyMetricSubtitle">Was expected scope (product /regional coverage) achieved?</p>
        </td>
        <td style="height: 59px">&nbsp;
            <uc1:Status_DDL ID="sddlScope" runat="server" CssClass="PIRStatus"/>
            &nbsp;<asp:RequiredFieldValidator ID="rfvScopeStatus" runat="server" ControlToValidate="sddlScope:ddl"
                CssClass="statusError" ErrorMessage="Key Metric - Scope Status must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td style="height: 59px">
            <asp:TextBox ID="txtScopeComments" runat="server" CssClass="textinput" Height="50px"
                TextMode="MultiLine" Width="100%"></asp:TextBox>
            </td>
    </tr>
    <tr>
        <td>
            <p class="KeyMetricTitle">Project Management</p>
            <p class="KeyMetricSubtitle">Did the approach fit the initiative?</p>
        </td>
        <td>&nbsp;
            <uc1:Status_DDL ID="sddlProjMan" runat="server" CssClass="PIRStatus"/>
            &nbsp;<asp:RequiredFieldValidator ID="rfvProjMan" runat="server" ControlToValidate="sddlProjMan:ddl"
                CssClass="statusError" ErrorMessage="Key Metric - Project Management Status must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td>
            <asp:TextBox ID="txtProjManComments" runat="server" CssClass="textinput" Height="50px"
                TextMode="MultiLine" Width="100%"></asp:TextBox></td>
    </tr>
    
    <tr>
        <td>
            <p class="KeyMetricTitle">Alpha</p>
            <p class="KeyMetricSubtitle">Does this work deliver technology that will provide a competitive advantage?</p>
        </td>
        <td>&nbsp;
            <uc1:Status_DDL ID="sddlAlpha" runat="server" CssClass="PIRStatus"/>
            &nbsp;<asp:RequiredFieldValidator ID="rfvAlpha" runat="server" ControlToValidate="sddlAlpha:ddl"
                CssClass="statusError" ErrorMessage="Key Metric - Alpha Status must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td>
            <asp:TextBox ID="txtAlphaComments" runat="server" CssClass="textinput" Height="50px"
                TextMode="MultiLine" Width="100%"></asp:TextBox></td>
    </tr>
</tbody>
</table>