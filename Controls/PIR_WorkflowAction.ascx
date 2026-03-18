<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PIR_WorkflowAction.ascx.cs" Inherits="ProjectPortfolio.Controls.PIR_WorkflowAction" %>
<%@ Register Src="section_status.ascx" TagName="section_status" TagPrefix="uc4" %>
<%@ Register Src="PIR_Summary.ascx" TagName="PIR_Summary" TagPrefix="uc1" %>
<%@ Register Src="sectionc.ascx" TagName="sectionc" TagPrefix="uc2" %>
<%@ Register Src="Review_SectionD.ascx" TagName="Review_SectionD" TagPrefix="uc3" %>

<uc4:section_status ID="ctlSectionStatus" runat="server" />
<uc1:PIR_Summary ID="ctlPIR_Summary" runat="server" />
<uc2:sectionc ID="ctlSectionC" runat="server" />
<uc3:Review_SectionD ID="ctlReview_SectionD" runat="server" />
