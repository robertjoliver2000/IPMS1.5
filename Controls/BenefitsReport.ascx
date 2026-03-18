<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BenefitsReport.ascx.cs" Inherits="Reports_BenefitsReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="CheckBoxListWithAll.ascx" TagName="CheckBoxListWithAll" TagPrefix="uc1" %>
 
<script type="text/javascript" src="js/BrainJar.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
    
<table width="100%" height="100%">
    
    
    <tr>
        <td style="width: 100%; height: 20px;">
            <table style="width: 100%; font-size: 10pt; font-family: Arial;">
                <tr style="vertical-align:top;">
                    <td style="font-weight: bold; text-align: left; height: 24px;" valign="top">
                        <asp:Label ID="lblYearOfApprovalTitle" runat="server" Font-Names="Arial" Text="Year of Approval:" Font-Size="10pt" Height="18px" Font-Bold="True"></asp:Label>&nbsp;                       
                    </td>
                    <td><asp:DropDownList ID="ddlApprovalYear" runat="server" Font-Names="Arial" Font-Size="10pt" Width="144px" OnSelectedIndexChanged="ddlApprovalYear_SelectedIndexChanged" >
                        </asp:DropDownList></td>
                    <td>&nbsp;</td>
                    <td>
                        <button type="button" class="button" style="width:140px;" onclick="javascript:togglePopup('divSpendCategory');">Spend Category</button>
                        <div id="divSpendCategory"
								style="position:absolute;top:200px;left:0px;z-index:100;display:none;width:244px;height:auto;background-color:white; border:solid 1px black;">
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
                                    <td colspan="3"><uc1:CheckBoxListWithAll ID="cblaSpendCategory" runat="server" EnableViewState="true" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td>
                        <button type="button" class="button" style="width:140px;" onclick="javascript:togglePopup('divFinancialCategory');">Financial Category</button>
                        <div id="divFinancialCategory"
					            style="position:absolute;top:200px;left:200px;z-index:100;display:none;width:250px;height:auto;background-color:white; border:solid 1px black;">
                            <table style="width:100%;" cellpadding="0" cellspacing="0">
                                <colgroup>
                                    <col style="width:10px;text-align:left;" />
                                    <col style="width:230px;text-align:center;" />
                                    <col style="width:10px;text-align:right;" />
                                </colgroup>
                                <tr style="background-color:#eaeaea; font-weight:bold;">
                                    <td>&nbsp;</td>
                                    <td onmousedown="dragStart(event, 'divFinancialCategory')">Financial Category</td>
                                    <td><a href="javascript:togglePopup('divFinancialCategory');"><img src="Images/pick.jpg" alt="Close" title="Close" style="border-color:transparent;" /></a></td>
                                </tr>
                                <tr style="vertical-align:top;">
                                    <td colspan="3"><uc1:CheckBoxListWithAll ID="cblaFinancialCategory" RepeatColumns="1" runat="server" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <button type="button" class="button"
                                style="width:140px;" onclick="javascript:togglePopup('divBenefit');">Benefit</button>
                        <div id="divBenefit" style="position:absolute;top:200px;left:400px;z-index:100;display:none;width:500px;height:auto;background-color:white; border:solid 1px black;">
                            <table style="width:100%;" cellpadding="0" cellspacing="0">
	                            <colgroup>
	                                <col style="width:10px;text-align:left;" />
		                            <col style="width:480px;text-align:center;" />
		                            <col style="width:10px;text-align:right;" />
	                            </colgroup>
	                            <tr style="background-color:#eaeaea; font-weight:bold;">
	                                <td style="height: 19px">&nbsp;</td>
	                                <td onmousedown="dragStart(event, 'divBenefit')" style="height: 19px">Benefit</td>
	                                <td style="height: 19px"><a href="javascript:togglePopup('divBenefit');"><img src="Images/pick.jpg" alt="Close" title="Close" style="border-color:transparent;" /></a></td>
	                            </tr>
                                <tr style="vertical-align:top;">
                                    <td colspan="3"><uc1:CheckBoxListWithAll ID="cblaBenefit" runat="server" EnableViewState="true" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <button type="button" class="button"
                                style="width:140px;" onclick="javascript:togglePopup('divCommittee');">Committee</button>
                        <div id="divCommittee" style="position:absolute;top:200px;left:600px;z-index:100;display:none;width:500px;height:auto;background-color:white; border:solid 1px black;">
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
                                    <td colspan="3"><uc1:CheckBoxListWithAll ID="cblaCommittee" runat="server" EnableViewState="true" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>                    
                    <td>&nbsp;</td>
                    <td style="text-align:right;">
                        <span style="float:right; text-align:left;">
                            <asp:Button ID="btnRunReport" runat="server" CssClass="button" Text="Run Report" OnClick="btnRunReport_Click" /><br />
                            <asp:CheckBox ID="cbxSaveFilter" runat="server" Text="Save Filter" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lblOutput" runat="server" Font-Names="Arial" Text="Output:" Font-Size="10pt" Height="18px" Font-Bold="True"></asp:Label></td>
                    <td><asp:DropDownList ID="ddlOutput" runat="server" Font-Names="Arial" Font-Size="10pt" OnSelectedIndexChanged="ddlOutput_SelectedIndexChanged">
                            <asp:ListItem Selected="True">Annual</asp:ListItem>
                            <asp:ListItem>Quarterly</asp:ListItem>
                        </asp:DropDownList></td>
                    <td colspan="8"></td>                
                </tr>
            </table>
            </td>
    </tr>   
    
   <tr>
        <td>    
            <rsweb:reportviewer id="rptvwBenefits" runat="server" font-names="Verdana" font-size="8pt" 
                height="100%" width="100%" ShowDocumentMapButton="False" ShowFindControls="False" ShowPageNavigationControls="True">
            <LocalReport ReportPath="Reports\BenefitsReport.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="objDSBenefitVsSpendLines" Name="Reports_spReport_BenefitvsSpend_Lines" />
                    <rsweb:ReportDataSource DataSourceId="objDSProfitLossTable" Name="Reports_spReport_ProfitLossTable" />
                </DataSources>
            </LocalReport>
                <ServerReport Timeout="-1" />
            </rsweb:reportviewer>       
            <asp:ObjectDataSource ID="objDSProfitLossTable" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="ReportsTableAdapters.spReport_ProfitLossTableTableAdapter">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlApprovalYear" Name="YearOfApproval" Type="String" PropertyName="SelectedValue" />
                    <asp:Parameter DefaultValue="ALL" Name="IGApprovalCommittee" Type="String" />
                    <asp:Parameter DefaultValue="ALL" Name="Spend" Type="String" />
                    <asp:Parameter DefaultValue="ALL" Name="Benefit" Type="String" />
                    <asp:Parameter DefaultValue="ALL" Name="FinancialCategory" Type="String" />
                    <asp:ControlParameter ControlID="ddlApprovalYear" Name="CurrentYear" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="objDSBenefitVsSpendLines" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="ReportsTableAdapters.spReport_BenefitvsSpend_LinesTableAdapter">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlApprovalYear" Name="YearOfApproval" PropertyName="SelectedValue" Type="String" />
                    <asp:Parameter DefaultValue="ALL" Name="IGApprovalCommittee" Type="String" />
                    <asp:Parameter DefaultValue="ALL" Name="Spend" Type="String" />
                    <asp:Parameter DefaultValue="ALL" Name="Benefit" Type="String" />
                    <asp:Parameter DefaultValue="ALL" Name="FinancialCategory" Type="String" />
                    <asp:ControlParameter ControlID="ddlApprovalYear" Name="CurrentYear" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </td>
    </tr>
</table>
        


