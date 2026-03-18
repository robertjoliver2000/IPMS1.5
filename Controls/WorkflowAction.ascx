<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WorkflowAction.ascx.cs" Inherits="ProjectPortfolio.Controls.Controls_WorkflowAction" %>
<%@ Register Src="section_status.ascx" TagName="section_status" TagPrefix="uc11" %>
<%@ Register Src="sectiona.ascx" TagName="sectiona" TagPrefix="uc1" %>
<%@ Register Src="sectionb.ascx" TagName="sectionb" TagPrefix="uc2" %>
<%@ Register Src="SectionC.ascx" TagName="SectionC" TagPrefix="uc3" %>
<%@ Register Src="sectiond.ascx" TagName="sectiond" TagPrefix="uc4" %>
<%@ Register Src="SectionE.ascx" TagName="SectionE" TagPrefix="uc5" %>
<%@ Register Src="sectionF.ascx" TagName="sectionF" TagPrefix="uc6" %>
<%@ Register Src="sectionG.ascx" TagName="sectionG" TagPrefix="uc7" %>
<%@ Register Src="SectionH.ascx" TagName="SectionH" TagPrefix="uc8" %>
<%@ Register Src="SectionI.ascx" TagName="SectionI" TagPrefix="uc9" %>
<%@ Register Src="SectionJ.ascx" TagName="SectionJ" TagPrefix="uc10" %>
<uc11:section_status ID="ctlSectionStatus" runat="server" />
<uc1:sectiona ID="ctlSectionA" runat="server" />
<br>
<uc2:sectionb ID="ctlSectionB" runat="server" />
<br>
<br>
<uc3:SectionC ID="ctlSectionC" runat="server" />
<br>
<uc4:sectiond ID="ctlSectionD" runat="server" />

<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td>
            <uc5:SectionE ID="ctlSectionE" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc6:sectionF ID="ctlSectionF" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc7:sectionG ID="ctlSectionG" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc8:SectionH ID="ctlSectionH" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc9:SectionI ID="ctlSectionI" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
</table>

<uc10:SectionJ ID="ctlSectionJ" runat="server" />
