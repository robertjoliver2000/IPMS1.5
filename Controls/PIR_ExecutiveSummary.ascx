<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_ExecutiveSummary.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_ExecutiveSummary" %>
<%@ Register Src="Status_DDL.ascx" TagName="Status_DDL" TagPrefix="uc2" %>
<%@ Register Src="PIR_KeyMetrics.ascx" TagName="PIR_KeyMetrics" TagPrefix="uc1" %>

<script type="text/javascript" src="js/utils.js" ></script>

<script language="javascript" type="text/javascript">

function popupWindowSelectItem(categoryID,txtBoxID,hiddenTxtBoxID)
{
    var dialogwidth = 360
	var dialogheight = 400
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"
	
	dlgwindow = window.open("SelectItem.aspx?CategoryID="+categoryID+"&ControlID="+txtBoxID+"&HiddenControlID="+hiddenTxtBoxID, 
					"mydialog", attr)
					
	dlgwindow.focus();
}

</script>
<%--<span style="font-size:large; color: #000066;">Executive Summary</span> --%>
<table style="width:1244px" cellpadding="0" cellspacing="0"><tr><td class="controltitle PIR_Executive_Title" style="width: 1228px">Executive Summary</td></tr></table>
<div style="xborder:solid 1px black; width:1240px; padding:0px; margin:0px;">
<div style="xborder-style:none none solid none; xborder-width:1px; xborder-color:black; xbackground-color:silver; background-color:#dddddd; padding:2px;">
<table style="width:100%;" class="PIR_Executive_Header">
<tr>
    <td>
        <table>
            <tr>
                <td>Initiative Name:</td>
                <td><asp:TextBox ID="txtName" runat="server" CssClass="textinput" MaxLength="100" ReadOnly="true"
                        Width="425px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Business Sponsor Name:</td>
                <td>
                    <span style="display:inline-block; vertical-align:top;"><asp:TextBox ID="txtBusinessSponsorName" runat="server" CssClass="textinput" MaxLength="50"
                        Width="265px"></asp:TextBox><asp:RequiredFieldValidator ID="sectionA_rvBusinessSponsorName" runat="server" ControlToValidate="txtBusinessSponsorName"
                        ErrorMessage="Business Sponsor Name must not be blank" ValidationGroup="SubmitForReview"
                        >*</asp:RequiredFieldValidator>
                    <asp:HiddenField ID="hBusinessSponsorID" runat="server" />
                    </span>
                    <a runat="server" ID="lnkBusinessSponsorName"><img src="Images/pick_tb.gif" border="0"></a>
                </td>
            </tr>
            <tr>
                <td>GTO Initiative Manager:</td>
                <td>
                    <span style="display:inline-block; vertical-align:top;"><asp:TextBox ID="txtGTOInitiativeManager" runat="server" CssClass="textinput" MaxLength="50"
                        Width="265px"></asp:TextBox><asp:RequiredFieldValidator ID="sectionA_rvGTOInitiativeManager" runat="server" ControlToValidate="txtGTOInitiativeManager"
                        ErrorMessage="GTO Initiative Manager must not be blank" ValidationGroup="SubmitForReview"
                        Width="1px">*</asp:RequiredFieldValidator>
                    <asp:HiddenField ID="hGTOInitiativeManagerID" runat="server" />
                    </span>
                    <a id="lnkGTOInitiativeManager" runat="server"><img border="0" src="Images/pick_tb.gif" /></a>
                </td>
            </tr>
        </table>
    </td>
    <td>
        <table>
            <tr>
                <td>IG Impact Category:</td>
                <td>
                    <asp:DropDownList ID="ddlImpactCategory" runat="server" CssClass="textselect" Width="179px">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="RVsectionD_rvImpactCategoryDDL"
                        runat="server" ControlToValidate="ddlImpactCategory" ErrorMessage="IG Impact Category must not be blank"
                        InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Start Date:</td>
                <td>
                    <table align="left" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:TextBox ID="txtPIRStartDate" runat="Server" CssClass="textinput" Style="text-align: center"
                                    Width="80px"></asp:TextBox></td>
                            <td align="center" width="20">
                                <a id="lnkPIRStartDate" runat="server">
                                    <img border="0" src="Images/calendar.jpg" /></a></td>
                            <td align="center" style="width: 30px">
                                <asp:RangeValidator ID="rvPIRStartDate" runat="server" ControlToValidate="txtPIRStartDate"
                                    MaximumValue="1/1/2020" MinimumValue="1/1/1900" Text="*" Type="Date" ValidationGroup="SubmitForReview"></asp:RangeValidator>
                                <asp:RequiredFieldValidator ID="rfvPIRStartDate" runat="server" ControlToValidate="txtPIRStartDate"
                                    ErrorMessage="Start Date must not be blank" ValidationGroup="SubmitForReview"
                                    Width="1px">*</asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <font color="#333333" face="verdana, arial, helvetica, sans-serif" size="1"><em>dd/mm/yyyy</em></font>
							</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>End Date:</td>
                <td>
                    <table align="left" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:TextBox ID="txtPIREndDate" runat="server" CssClass="textinput" Style="text-align: center"
                                    Width="80px"></asp:TextBox></td>
                            <td align="center" width="20">
                                <a id="lnkPIREndDate" runat="server">
                                    <img border="0" src="Images/calendar.jpg" /></a></td>
                            <td align="center" style="width: 30px">
                                <asp:RangeValidator ID="rvPIREndDate" runat="server" ControlToValidate="txtPIREndDate"
                                    MaximumValue="1/1/2020" MinimumValue="1/1/1900" Text="*" Type="Date" ValidationGroup="SubmitForReview"></asp:RangeValidator>
                                <asp:RequiredFieldValidator ID="rfvPIREndDate" runat="server" ControlToValidate="txtPIREndDate"
                                    ErrorMessage="End Date must not be blank" ValidationGroup="SubmitForReview"
                                    Width="1px">*</asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <font color="#333333" face="verdana, arial, helvetica, sans-serif" size="1"><em>dd/mm/yyyy</em></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </td>
    <td style="text-align:right;">
        <table class="PIRSpend">
            <tr>
                <td>Spend</td>
                <td>Plan:</td>
                <td><asp:Label ID="lblSpendPlanned" runat="server" Text="0.00"></asp:Label></td>
            </tr>
            <tr>
                <td />
                <td>Actual:</td>
                <td><asp:Label ID="lblSpendActual" runat="server" Text="0.00"></asp:Label></td>
            </tr>
            <tr>
                <td />
                <td>Var:</td>
                <td><asp:Label ID="lblSpendVariance" runat="server" Text="0%"></asp:Label></td>
            </tr>
            <tr>
                <td />
                <td>ROI:</td>
                <td><asp:Label ID="lblROI" runat="server" Text="0.00"></asp:Label></td>
            </tr>
        </table>
    </td>
</tr>
</table>
<%--
<table style="width:100%;" class="PIR_Executive_Header">
    <colgroup>
        <col style="width:200px;" />
        <col style="width:175px;" />
        <col style="width:175px;" />
        <col style="width:100px;" />
        <col style="width:50px;" />
        <col style="width:50px;" />
        <col style="width:75px;" />
    </colgroup>
    <tr style="height:20px; vertical-align:top;">
        <td>
            Initiative Name:
        </td>
        <td>
            <asp:TextBox ID="txtName" runat="server" CssClass="textinput" MaxLength="100" ReadOnly="true"
                Width="425px"></asp:TextBox></td>
        <td>
            IG Impact Category:</td>
        <td>
            <asp:DropDownList ID="ddlImpactCategory" runat="server" CssClass="textselect" Width="179px">
            </asp:DropDownList><asp:RequiredFieldValidator ID="RVsectionD_rvImpactCategoryDDL"
                runat="server" ControlToValidate="ddlImpactCategory" ErrorMessage="IG Impact Category must not be blank"
                InitialValue="0" ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
        <td style="text-align: right;">
            Spend</td>
        <td style="text-align: right;">
            Plan:</td>
        <td style="text-align: right;">
            <asp:Label ID="lblSpendPlanned" runat="server" Text="0.00"></asp:Label></td>
    </tr>
    <tr style="height:35px; vertical-align:top;">
        <td>
            Business Sponsor Name:
        </td>
        <td>
            <span style="display:inline-block; vertical-align:top;"><asp:TextBox ID="txtBusinessSponsorName" runat="server" CssClass="textinput" MaxLength="50"
                Width="265px"></asp:TextBox><asp:RequiredFieldValidator ID="sectionA_rvBusinessSponsorName" runat="server" ControlToValidate="txtBusinessSponsorName"
                ErrorMessage="Business Sponsor Name must not be blank" ValidationGroup="SubmitForReview"
                >*</asp:RequiredFieldValidator>
            <asp:HiddenField ID="hBusinessSponsorID" runat="server" />
            </span>
            <a runat="server" ID="lnkBusinessSponsorName"><img src="Images/pick_sb.gif" border="0"></a>
        </td>
        <td>
            Start Date:</td>
        <td>
            <table align="left" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <asp:TextBox ID="txtPIRStartDate" runat="Server" CssClass="textinput" Style="text-align: center"
                            Width="80px"></asp:TextBox></td>
                    <td align="center" width="20">
                        <a id="lnkPIRStartDate" runat="server">
                            <img border="0" src="Images/calendar.jpg" /></a></td>
                    <td align="center" style="width: 30px">
                        <asp:RangeValidator ID="rvPIRStartDate" runat="server" ControlToValidate="txtPIRStartDate"
                            MaximumValue="1/1/2020" MinimumValue="1/1/1900" Text="*" Type="Date" ValidationGroup="SubmitForReview"></asp:RangeValidator>
                        <asp:RequiredFieldValidator ID="rfvPIRStartDate" runat="server" ControlToValidate="txtPIRStartDate"
                            ErrorMessage="Start Date must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td valign="top">
                        <font color="#333333" face="verdana, arial, helvetica, sans-serif" size="1"><em>dd/mm/yyyy</em></font></td>
                    <td>
                    </td>
                    <td style="width: 30px">
                    </td>
                </tr>
            </table>
        </td>
        <td>
        </td>
        <td style="text-align: right;">
            Actual:</td>
        <td style="text-align: right;">
            <asp:Label ID="lblSpendActual" runat="server" Text="0.00"></asp:Label></td>
    </tr>
    <tr style="height:35px; vertical-align:top;">
        <td>
            GTO Initiative Manager:
        </td>
        <td>
            <span style="display:inline-block; vertical-align:top;"><asp:TextBox ID="txtGTOInitiativeManager" runat="server" CssClass="textinput" MaxLength="50"
                Width="265px"></asp:TextBox><asp:RequiredFieldValidator ID="sectionA_rvGTOInitiativeManager" runat="server" ControlToValidate="txtGTOInitiativeManager"
                ErrorMessage="GTO Initiative Manager must not be blank" ValidationGroup="SubmitForReview"
                Width="1px">*</asp:RequiredFieldValidator>
            <asp:HiddenField ID="hGTOInitiativeManagerID" runat="server" />
            </span>
            <a id="lnkGTOInitiativeManager" runat="server"><img border="0" src="Images/pick_sb.gif" /></a>
        </td>
        <td>
            End Date:</td>
        <td>
            <table align="left" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <asp:TextBox ID="txtPIREndDate" runat="server" CssClass="textinput" Style="text-align: center"
                            Width="80px"></asp:TextBox></td>
                    <td align="center" width="20">
                        <a id="lnkPIREndDate" runat="server">
                            <img border="0" src="Images/calendar.jpg" /></a></td>
                    <td align="center" style="width: 30px">
                        <asp:RangeValidator ID="rvPIREndDate" runat="server" ControlToValidate="txtPIREndDate"
                            MaximumValue="1/1/2020" MinimumValue="1/1/1900" Text="*" Type="Date" ValidationGroup="SubmitForReview"></asp:RangeValidator>
                        <asp:RequiredFieldValidator ID="rfvPIREndDate" runat="server" ControlToValidate="txtPIREndDate"
                            ErrorMessage="End Date must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <font color="#333333" face="verdana, arial, helvetica, sans-serif" size="1"><em>dd/mm/yyyy</em></font></td>
                    <td>
                    </td>
                    <td style="width: 30px">
                    </td>
                </tr>
            </table>
        </td>
        <td>
        </td>
        <td style="text-align: right;">
            Var:</td>
        <td style="text-align: right;">
            <asp:Label ID="lblSpendVariance" runat="server" Text="0%"></asp:Label></td>
    </tr>
    <tr style="height:20px; vertical-align:top;">
        <td />
        <td />
        <td />
        <td />
        <td />
        <td style="text-align: right;">
            ROI:</td>
        <td style="text-align: right;">
            <asp:Label ID="lblROI" runat="server" Text="0.00"></asp:Label></td>
    </tr>
</table>
 --%>
 </div>
 <%--
<div style="text-align:right; width:100%; padding-right: 0px; padding-left: 2px; padding-bottom: 2px; margin-right: -5px; padding-top: 2px; font-size:10px; font-weight:bold; vertical-align:middle;">Overall Status:&nbsp;<uc2:Status_DDL ID="sddlPIRStatus" runat="server" CssClass="PIRStatus" Size="12px"/>
    <asp:RequiredFieldValidator ID="rfvPIRStatus" runat="server" ControlToValidate="sddlPIRStatus:ddl"
        InitialValue="0" Width="0px" ErrorMessage="Overall Status must not be blank" ValidationGroup="SubmitForReview">*</asp:RequiredFieldValidator>
</div>
--%>
<table style="padding:0px; margin-left:-2px; xmargin-right: -5px; xwidth:100%; width:1249px;" cellpadding="0">
<tr>
    <td>
        <table style="width:100%" cellpadding="0" cellspacing="0">
            <tr>
                <td style="vertical-align:top; text-align:left;">
                    Overall Status:&nbsp;<uc2:Status_DDL ID="sddlPIRStatus" runat="server" CssClass="PIRStatus" Size="12px"/>
                    <asp:RequiredFieldValidator ID="rfvPIRStatus" runat="server" ControlToValidate="sddlPIRStatus:ddl"
                        InitialValue="0" Width="0px" ErrorMessage="Overall Status must not be blank" ValidationGroup="SubmitForReview">*</asp:RequiredFieldValidator>
                </td>
                <td style="width: 1095px"><asp:TextBox runat="server" ID="txtPPRComments" Width="100%" TextMode="MultiLine" CssClass="textinput" Height="30px" onkeyup="textLimit2(this, 200);" onchange="textLimit2(this, 200);" ></asp:TextBox></td>
            </tr>
            <tr>
                <td style="vertical-align:bottom;" colspan="2">
                    <span class="PIR_Section_Header" style="margin-top:0px;">Initiative Business Drivers</span>
                    <asp:RequiredFieldValidator ID="sectionA_rvInitiativeBusinessDrivers"
                        runat="server" ControlToValidate="txtInitiativeBusinessDrivers" ErrorMessage="Initiative Business Drivers must not be blank"
                        ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr><td><asp:TextBox ID="txtInitiativeBusinessDrivers" runat="server" TextMode="MultiLine"
            CssClass="textinput PIR_Executive_Text"></asp:TextBox></td></tr>
<tr>
    <td>
        <span class="PIR_Section_Header">Initiative Scope &amp; Objectives</span>
        <asp:RequiredFieldValidator ID="sectionA_rvInitiativeScopeAndObjectives" runat="server"
            ControlToValidate="txtInitiativeScopeAndObjectives" ErrorMessage="Initiative Scope & Objectives must not be blank"
            ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>
    </td>
</tr>
<tr><td><asp:TextBox ID="txtInitiativeScopeAndObjectives" runat="server" TextMode="MultiLine"
    CssClass="textinput PIR_Executive_Text"></asp:TextBox></td></tr>
<tr>
    <td>
        <span class="PIR_Section_Header">Initiative Benefit Calculation / Justification</span>
        <asp:RequiredFieldValidator ID="sectionA_rvInitiativeBenefitCalculation" runat="server"
            ControlToValidate="txtInitiativeBenefitCalculation" ErrorMessage="Initiative Benefit Calculation must not be blank"
            ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>
    </td>
</tr>
<tr><td><asp:TextBox ID="txtInitiativeBenefitCalculation" runat="server" TextMode="MultiLine"
    CssClass="textinput PIR_Executive_Text"></asp:TextBox></td></tr>
<tr>
    <td>
        <span class="PIR_Section_Header">Key Successes, New Opportunities, Innovation and Additional Benefits</span>
        <asp:RequiredFieldValidator ID="rvSuccesses" runat="server" ControlToValidate="txtPIRSuccesses"
            ErrorMessage="Key Successes etc must not be blank" ValidationGroup="SubmitForReview"
            Width="1px">*</asp:RequiredFieldValidator>
    </td>
</tr>
<tr><td><asp:TextBox ID="txtPIRSuccesses" runat="server" TextMode="MultiLine"
    CssClass="textinput PIR_Executive_Text"></asp:TextBox></td></tr>
<tr>
    <td>
        <span class="PIR_Section_Header">Issues / Lessons Learned:</span>
        <asp:RequiredFieldValidator ID="rvIssues" runat="server" ControlToValidate="txtPIRIssues"
            ErrorMessage="Issues / Lessons Learned must not be blank" ValidationGroup="SubmitForReview"
            Width="1px">*</asp:RequiredFieldValidator>
    </td>
</tr>
<tr><td><asp:TextBox ID="txtPIRIssues" runat="server" TextMode="MultiLine"
    CssClass="textinput PIR_Executive_Text"></asp:TextBox></td></tr>
</table>
</div>
