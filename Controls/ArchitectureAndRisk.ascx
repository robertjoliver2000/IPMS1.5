<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArchitectureAndRisk.ascx.cs" Inherits="Controls_ArchitectureAndRisk" %>
<%@ Register Src="SectionE.ascx" TagName="SectionE" TagPrefix="uc5" %>
<%@ Register Src="sectionF.ascx" TagName="sectionF" TagPrefix="uc1" %>
<%@ Register Src="sectionG.ascx" TagName="sectionG" TagPrefix="uc2" %>
<%@ Register Src="SectionH.ascx" TagName="SectionH" TagPrefix="uc3" %>
<%@ Register Src="SectionI.ascx" TagName="SectionI" TagPrefix="uc4" %>

<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td>
            <uc5:SectionE ID="ctlSectionE" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc1:sectionF ID="ctlSectionF" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc2:sectionG ID="ctlSectionG" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc3:SectionH ID="ctlSectionH" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
    <tr>
        <td>
            <uc4:SectionI ID="ctlSectionI" runat="server" />
        </td>
    </tr>    
    <tr><td height="10px"></td></tr>
</table>
