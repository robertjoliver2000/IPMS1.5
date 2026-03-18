<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArchitectureAndRisk_Review_PrintVersion.ascx.cs" Inherits="Controls_ArchitectureAndRisk_Review_PrintVersion" %>
<%@ Register Src="Review_SectionF_PrintVersion.ascx" TagName="Review_SectionF_PrintVersion"
    TagPrefix="uc6" %>
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
    <tr><td height="10px">
        <uc6:Review_SectionF_PrintVersion id="Review_SectionF_PrintVersion1" runat="server">
        </uc6:Review_SectionF_PrintVersion></td></tr>
    <tr>
        <td>
            &nbsp;</td>
    </tr>    
</table>