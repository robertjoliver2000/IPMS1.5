<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_Summary_PrintVersion.ascx.cs" Inherits="Controls_Summary_PrintVersion" %>
<%@ Register Src="SectionA_PrintVersion_Section2.ascx" TagName="SectionA_PrintVersion_Section2" TagPrefix="uc3" %>
<%@ Register Src="SectionB_ProgramDeliverables_PrintVersion.ascx" TagName="SectionB_ProgramDeliverables_PrintVersion" TagPrefix="uc4" %>
<%@ Register Src="Sectiona_PrintVersion.ascx" TagName="sectiona" TagPrefix="uc1" %>
<%@ Register Src="Review_SectionB_PrintVersion.ascx" TagName="review_sectionb" TagPrefix="uc2" %>

<uc1:sectiona ID="ctlSectionA" runat="server" /><br />
<uc2:review_sectionb ID="ctlReview_SectionB" runat="server" /><br />
<uc3:SectionA_PrintVersion_Section2 id="SectionA_PrintVersion_Section2_1" runat="server" /><br />
<uc4:SectionB_ProgramDeliverables_PrintVersion ID="SectionB_ProgramDeliverables_PrintVersion1" runat="server" />
