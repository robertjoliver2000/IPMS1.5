<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Review_Summary.ascx.cs" Inherits="Controls_Review_Summary" %>
<%@ Register Src="SectionA.ascx" TagName="SectionA" TagPrefix="uc1" %>
<%@ Register Src="Review_SectionB.ascx" TagName="Review_SectionB" TagPrefix="uc2" %>
<uc1:SectionA ID="ctlSectionA" runat="server" />
<br>
<uc2:Review_SectionB ID="ctlReview_SectionB" runat="server" />
<br>
<br>
