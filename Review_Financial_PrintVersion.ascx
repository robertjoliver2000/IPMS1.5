<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_Financial_PrintVersion.ascx.cs" Inherits="Controls_Review_Financial_PrintVersion" %>
<%@ Register Src="Review_sectiond_PrintVersion.ascx" TagName="sectiond_PrintVersion" TagPrefix="uc2" %>
<%@ Register Src="SectionC_PrintVersion.ascx" TagName="SectionC_PrintVersion" TagPrefix="uc1" %>

<table cellpadding="0" cellspacing="0" border="0">
<tr>
    <td>
<uc1:SectionC_PrintVersion ID="ctlSectionC_PrintVersion" runat="server" />
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td>
<uc2:sectiond_PrintVersion ID="ctlSectionD_PrintVersion" runat="server" />
    </td>
</tr>
</table>
