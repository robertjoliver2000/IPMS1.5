<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ClientViewReport.ascx.cs" Inherits="Controls_ClientViewReport" %>
<%@ Register Src="CheckBoxListWithAll.ascx" TagName="CheckBoxListWithAll" TagPrefix="uc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
 
<script type="text/javascript" src="js/BrainJar.js"></script>
<script type="text/javascript" src="js/utils.js"></script>

<table width="100%" height="100%">
    <tr>
        <td style="width: 100%; height: 20px; text-align: center;">
            <table style="width: 100%; font-size: 10pt; font-family: Arial;">
                <tr style="vertical-align:top;">
                    <td style="font-weight: bold; text-align: left; height: 24px; width: 17%;" valign="top">
                        <asp:Label ID="lblYearOfApprovalTitle" runat="server" Font-Names="Arial" Text="Year of Approval:" Font-Size="10pt" Font-Bold="True" Height="18px"></asp:Label><br />
                        <asp:DropDownList ID="ddlApprovalYear" runat="server" Font-Names="Arial" Font-Size="10pt">
                        </asp:DropDownList>
                    </td>
                    <td style="width:17%;">
                        <button type="button" class="button" style="width:140px;" onclick="javascript:togglePopup('divSpendCategory');">Spend Category</button>
                        <div id="divSpendCategory"
								style="position:absolute;top:200px;left:0px;z-index:100;display:none;width:150px;height:auto;background-color:white; border:solid 1px black;">
                            <table style="width:100%;" cellpadding="0" cellspacing="0">
	                            <colgroup>
	                                <col style="width:10px;text-align:left;" />
		                            <col style="width:130px;text-align:center;" />
		                            <col style="width:10px;text-align:right;" />
	                            </colgroup>
	                            <tr style="background-color:#eaeaea; font-weight:bold;">
	                                <td>&nbsp;</td>
	                                <td onmousedown="dragStart(event, 'divSpendCategory')">Spend Category</td>
	                                <td><a href="javascript:togglePopup('divSpendCategory');"><img src="Images/pick.jpg" alt="Close" title="Close" style="border-color:transparent;" /></a></td>
	                            </tr>
                                <tr style="vertical-align:top;">
                                    <td colspan="3"><uc1:CheckBoxListWithAll ID="cblaSpendCategory" RepeatColumns="1" runat="server" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td style="width:17%;">
                        <button type="button" class="button" style="width:140px;" onclick="javascript:togglePopup('divFinancialCategory');">Financial Category</button>
                        <div id="divFinancialCategory"
					            style="position:absolute;top:200px;left:100px;z-index:100;display:none;width:250px;height:auto;background-color:white; border:solid 1px black;">
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
                    <td style="width:17%;">
                        <button type="button" class="button"
                                style="width:140px;" onclick="javascript:togglePopup('divStatus');">Status</button>
                        <div id="divStatus" style="position:absolute;top:200px;left:200px;z-index:100;display:none;width:500px;height:auto;background-color:white; border:solid 1px black;">
                            <table style="width:100%;" cellpadding="0" cellspacing="0">
	                            <colgroup>
	                                <col style="width:10px;text-align:left;" />
		                            <col style="width:480px;text-align:center;" />
		                            <col style="width:10px;text-align:right;" />
	                            </colgroup>
	                            <tr style="background-color:#eaeaea; font-weight:bold;">
	                                <td style="height: 19px">&nbsp;</td>
	                                <td onmousedown="dragStart(event, 'divStatus')" style="height: 19px">Status</td>
	                                <td style="height: 19px"><a href="javascript:togglePopup('divStatus');"><img src="Images/pick.jpg" alt="Close" title="Close" style="border-color:transparent;" /></a></td>
	                            </tr>
                                <tr style="vertical-align:top;">
                                    <td colspan="3"><uc1:CheckBoxListWithAll ID="cblaStatus" runat="server" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td style="width:17%;">
                        <button type="button" class="button"
                                style="width:140px;" onclick="javascript:togglePopup('divCommittee');">Committee</button>
                        <div id="divCommittee" style="position:absolute;top:200px;left:450px;z-index:100;display:none;width:500px;height:auto;background-color:white; border:solid 1px black;">
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
                    </td style="width:17%;">
                    <td style="text-align:right; width:17%;">
                        <span style="float:right; text-align:left;">
                            <input id="Submit2" type="submit" value="Run Report" class="button" /><br />
                            <asp:CheckBox ID="cbxSaveFilter" runat="server" Text="Save Filter" />
                        </span>
                    </td>
                </tr>
            </table>
            </td>
    </tr>   
    <tr>
        <td colspan="6">
        <rsweb:reportviewer id="rptvwClientViewReport" runat="server" font-names="Verdana" font-size="8pt"
            height="100%" width="100%" ShowDocumentMapButton="False" ShowFindControls="False">    
        <LocalReport ReportPath="Reports\ClientView.rdlc">    
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="objDSClientView" Name="Reports_spReport_ClientView" />
            </DataSources>
        </LocalReport>
            <ServerReport Timeout="-1" />
        </rsweb:reportviewer>
            <asp:ObjectDataSource ID="objDSClientView" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="ReportsTableAdapters.spReport_ClientViewTableAdapter">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlApprovalYear" DefaultValue="2005" Name="YearOfApproval"
                        PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="cblaSpendCategory" DefaultValue="ALL" Name="SpendCategory"
                        PropertyName="ItemsSelected" Type="String" />
                    <asp:ControlParameter ControlID="cblaFinancialCategory" DefaultValue="ALL" Name="FinancialCategory"
                        PropertyName="ItemsSelected" Type="String" />
                    <asp:ControlParameter ControlID="cblaCommittee" DefaultValue="ALL" Name="IGApprovalCommittee"
                        PropertyName="ItemsSelected" Type="String" />
                    <asp:ControlParameter ControlID="cblaStatus" DefaultValue="ALL" Name="InitiativeStatus"
                        PropertyName="ItemsSelected" Type="String" />
                    <asp:ControlParameter ControlID="ddlApprovalYear" DefaultValue="2005" Name="CurrentYear"
                        PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </td>
    </tr>
</table>