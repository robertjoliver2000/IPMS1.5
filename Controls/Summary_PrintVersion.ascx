<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Summary_PrintVersion.ascx.cs" Inherits="Controls_Summary_PrintVersion" %>
<%@ Register Src="SectionA_PrintVersion_Section2.ascx" TagName="SectionA_PrintVersion_Section2" TagPrefix="uc3" %>
<%@ Register Src="SectionB_ProgramDeliverables_PrintVersion.ascx" TagName="SectionB_ProgramDeliverables_PrintVersion" TagPrefix="uc4" %>
<%@ Register Src="Sectiona_PrintVersion.ascx" TagName="sectiona" TagPrefix="uc1" %>
<%@ Register Src="Sectionb_PrintVersion.ascx" TagName="sectionb" TagPrefix="uc2" %>

<uc1:sectiona ID="ctlSectionA" runat="server" /><br />
<uc2:sectionb ID="ctlSectionB" runat="server" /><br />
<uc3:SectionA_PrintVersion_Section2 id="SectionA_PrintVersion_Section2_1" runat="server" /><br />
<uc4:SectionB_ProgramDeliverables_PrintVersion ID="SectionB_ProgramDeliverables_PrintVersion1" runat="server" />
