<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CommitteeViewReport.ascx.cs" Inherits="Controls_CommitteeViewReport" %>
<%@ Register Src="CheckBoxListWithAll.ascx" TagName="CheckBoxListWithAll" TagPrefix="uc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
 
<script type="text/javascript" src="js/BrainJar.js"></script>
<script type="text/javascript" src="js/utils.js"></script>

<table width="100%" height="100%">
    <tr style="vertical-align:top;">
        <td style="width: 100%; height: 20px;">
            <table style="font-size: 10pt; width: 100%; font-family: Arial">
                <tr style="vertical-align:top;">
                    <td style="font-weight: bold; width: 14%; height: 46px;" valign="top" align="left">
                        <asp:Label ID="lblYearOfApprovalTitle" runat="server" Font-Names="Arial" Text="Year of Approval:" Font-Size="10pt" Height="18px" Width="116px" Font-Bold="True"></asp:Label><asp:DropDownList ID="ddlApprovalYear" runat="server" Font-Names="Arial" Font-Size="10pt" Width="116px">
                        </asp:DropDownList>
                    </td>
                    <td style="width:14%;"></td>
                    <td style="width: 14%; text-align: center">
                        <button type="button" class="button" style="width:140px;" onclick="javascript:togglePopup('divFinancialCategory');">Financial Category</button>
                        <div id="divFinancialCategory"
					            style="position:absolute;top:200px;left:0px;z-index:100;display:none;width:250px;height:auto;background-color:white; border:solid 1px black;">
                            <table style="width:100%;" cellpadding="0" cellspacing="0">
                                <colgroup>
                                    <col style="width:10px;text-align:left;" />
                                    <col style="width:230px;text-align:center;" />
                                    <col style="width:10px;text-align:right;" />
                                </colgroup>
                                <tr style="background-color:#eaeaea; font-weight:bold;">
                                    <td style="width: 10px">&nbsp;</td>
                                    <td onmousedown="dragStart(event, 'divFinancialCategory')">Financial Category</td>
                                    <td><a href="javascript:togglePopup('divFinancialCategory');"><img src="Images/pick.jpg" alt="Close" title="Close" style="border-color:transparent;" /></a></td>
                                </tr>
                                <tr style="vertical-align:top;">
                                    <td colspan="3"><uc1:CheckBoxListWithAll ID="cblaFinancialCategory" RepeatColumns="1" runat="server" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td style="width:14%;"></td>
                    <td style="width:14%; text-align:center; height: 46px;">
                        <button type="button" class="button"
                                style="width:140px;" onclick="javascript:togglePopup('divCommittee');">Committee</button>
                        <div id="divCommittee" style="position:absolute;top:200px;left:300px;z-index:100;display:none;width:500px;height:auto;background-color:white; border:solid 1px black;">
                            <table style="width:100%;" cellpadding="0" cellspacing="0">
	                            <colgroup>
	                                <col style="width:10px;text-align:left;" />
		                            <col style="width:480px;text-align:center;" />
		                            <col style="width:10px;text-align:right;" />
	                            </colgroup>
	                            <tr style="background-color:#eaeaea; font-weight:bold;">
	                                <td>&nbsp;</td>
	                                <td onmousedown="dragStart(event, 'divCommittee')">Committee</td>
	                                <td><a href="javascript:togglePopup('divCommittee');"><img src="Images/pick.jpg" alt="Close" title="Close" style="border-color:transparent;" /></a></td>
	                            </tr>
                                <tr style="vertical-align:top;">
                                    <td colspan="3"><uc1:CheckBoxListWithAll ID="cblaCommittee" runat="server" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td style="width:14%;"></td>
                    <td style="width: 14%; text-align:right; height: 46px;" valign="bottom">
                        <div style="float:right; text-align:left;">
                            <input id="btnRefresh" class="button" type="submit" value="Run Report" /><br />
                            <asp:CheckBox ID="cbxSaveFilter" runat="server" EnableTheming="True" Text="Save filter" />
                        </div>
                    </td>
                </tr>
                <tr>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
        <rsweb:reportviewer id="rptvwCommitteeViewReport" runat="server" font-names="Verdana" font-size="8pt"
            height="100%" width="100%" ShowDocumentMapButton="False" ShowFindControls="False">
        <LocalReport ReportPath="Reports\CommitteeView.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="objDSCommitteeView" Name="Reports_spReport_CommitteeView" />
            </DataSources>
        </LocalReport>
        </rsweb:reportviewer>
        <asp:ObjectDataSource ID="objDSCommitteeView" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="ReportsTableAdapters.spReport_CommitteeViewTableAdapter">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlApprovalYear" DefaultValue="" Name="YearOfApproval" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="cblaFinancialCategory" DefaultValue="ALL" Name="FinancialCategory" PropertyName="ItemsSelected" />
                <asp:ControlParameter ControlID="cblaCommittee" DefaultValue="ALL" Name="IGApprovalCommittee" PropertyName="ItemsSelected" />
                <asp:ControlParameter ControlID="ddlApprovalYear" DefaultValue="" Name="CurrentYear" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        </td>
    </tr>
</table>
