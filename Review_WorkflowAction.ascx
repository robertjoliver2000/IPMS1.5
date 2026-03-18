<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_WorkflowAction.ascx.cs" Inherits="ProjectPortfolio.Controls.Review_WorkflowAction" %>
<%@ Register Src="section_status.ascx" TagName="section_status" TagPrefix="uc11" %>
<%@ Register Src="sectiona.ascx" TagName="sectiona" TagPrefix="uc1" %>
<%@ Register Src="Review_sectionb.ascx" TagName="Review_sectionb" TagPrefix="uc2" %>
<%@ Register Src="SectionC.ascx" TagName="SectionC" TagPrefix="uc3" %>
<%@ Register Src="Review_sectiond.ascx" TagName="Review_sectiond" TagPrefix="uc4" %>
<%@ Register Src="SectionE.ascx" TagName="SectionE" TagPrefix="uc5" %>
<%@ Register Src="Review_sectionF.ascx" TagName="Review_sectionF" TagPrefix="uc6" %>
<%@ Register Src="SectionJ.ascx" TagName="SectionJ" TagPrefix="uc10" %>
<uc11:section_status ID="ctlSectionStatus" runat="server" OnLoad="ctlSectionStatus_Load" />
<uc1:sectiona ID="ctlSectionA" runat="server" />
<br>
<uc2:Review_sectionb ID="ctlReview_SectionB" runat="server" />
<br>
<br>
<uc3:SectionC ID="ctlSectionC" runat="server" />
<br>
<uc4:Review_sectiond ID="ctlReview_SectionD" runat="server" />

<uc5:SectionE ID="ctlSectionE" runat="server" />
<uc6:Review_SectionF ID="ctlReview_SectionF" runat="server" />

<uc10:SectionJ ID="ctlSectionJ" runat="server" />
