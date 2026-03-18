<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArchitectureAndRisk_PrintVersion.ascx.cs" Inherits="Controls_ArchitectureAndRisk_PrintVersion" %>
<%@ Register Src="SectionE_PrintVersion.ascx" TagName="SectionE_PrintVersion" TagPrefix="uc5" %>
<%@ Register Src="sectionF_PrintVersion.ascx" TagName="sectionF_PrintVersion" TagPrefix="uc1" %>
<%@ Register Src="sectionG_PrintVersion.ascx" TagName="sectionG_PrintVersion" TagPrefix="uc2" %>
<%@ Register Src="SectionH_PrintVersion.ascx" TagName="SectionH_PrintVersion" TagPrefix="uc3" %>
<%@ Register Src="SectionI_PrintVersion.ascx" TagName="SectionI_PrintVersion" TagPrefix="uc4" %>

<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td>
            <uc5:SectionE_PrintVersion ID="ctlSectionE_PrintVersion" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc1:sectionF_PrintVersion ID="ctlSectionF_PrintVersion" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc2:sectionG_PrintVersion ID="ctlSectionG_PrintVersion" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc3:SectionH_PrintVersion ID="ctlSectionH_PrintVersion" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc4:SectionI_PrintVersion ID="ctlSectionI_PrintVersion" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
</table>
