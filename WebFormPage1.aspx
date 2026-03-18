<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebFormPage1.aspx.cs" Inherits="WebFormPage1" %>

<%@ Register Src="Controls/sectionb_sponsorallocations.ascx" TagName="sectionb_sponsorallocations"
    TagPrefix="uc5" %>
<%@ Reference Control="~/controls/SectionB.ascx" %>
<%@ Reference Control="~/controls/SectionB_BenefitsAnalysis.ascx" %>
<%@ Reference Control="~/controls/SectionA.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SectionA" Src="Controls/SectionA.ascx" %>
<%@ Register TagPrefix="uc2" TagName="SectionB" Src="Controls/SectionB.ascx" %>
<%@ Register TagPrefix="uc4" TagName="SectionB_BenefitsAnalysis" Src="Controls/SectionB_BenefitsAnalysis.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head runat="server">
    <title>Untitled Page</title>
    <LINK href="style.css" type="text/css" rel="stylesheet">
</head>
<body leftmargin="0px" rightmargin="0px" bottommargin="0px" topmargin="0px">
    <form id="form1" runat="server">
    <div>
            <uc1:SectionA id="ctlSectionA" runat="Server" />
			<br>
			<uc4:SectionB_BenefitsAnalysis id="ctlSectionB_BenefitsAnalysis" runat="server"></uc4:SectionB_BenefitsAnalysis>
			<br>
            <uc5:sectionb_sponsorallocations ID="ctlSectionB_SponsorAllocations" runat="server" />
			<br>
			<asp:Button id="btnInsert" runat="server" Text="Insert" onclick="btnInsert_Click"></asp:Button>
			<asp:Button id="btnUpdate" runat="server" Text="Update" onclick="btnUpdate_Click"></asp:Button>			
    </div>
    </form>
</body>
</html>
