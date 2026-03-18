<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BubbleInfo.aspx.cs" Inherits="BubbleInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">
    <title>ROI Bubble Chart - Initiative Financial Details</title>
    <link href="style.css" type="text/css" rel="stylesheet" />
</head>

<body>
    <form id="frmMain" runat="server">
        <div>        
            <table style="border: solid 1px lightgrey" cellspacing="0" cellpadding="2">
                <tr>
                    <td colspan="6" style="font: bold 12pt Arial" height="28px" valign="middle">
                        Initiative Details
                    </td>
                </tr>
                <tr>
                    <td class="bubbleheadcell" width="150px" height="18px"> 
                        Impact Category
                    </td>
                    <td class="bubbleheadcell" width="100px">
                        IG Identifier
                    </td>
                    <td class="bubbleheadcell" width="300px">
                        Initiative Name
                    </td>
                    <td class="bubbleheadcell" width="100px" align="center">
                        Total Benefit
                    </td>
                    <td class="bubbleheadcell" width="100px" align="center">
                        Total Spend
                    </td>
                    <td class="bubbleheadcell" width="100px" align="center">
                        ROI
                    </td>
                </tr>
                <tr>
                    <td class="bubblecell">
                        <asp:Label runat="server" id="lblImpactCategory"></asp:Label>
                    </td>
                    <td class="bubblecell">
                        <asp:Label runat="server" id="lblIGIdentifier"></asp:Label>
                    </td>
                    <td class="bubblecell">
                        <asp:Label runat="server" id="lblInitiativeName"></asp:Label>
                    </td>
                    <td class="bubblecell" align="right">
                        <asp:Label runat="server" id="lblTotalBenefit"></asp:Label>
                    </td>
                    <td class="bubblecell" align="right">
                        <asp:Label runat="server" id="lblTotalSpend"></asp:Label>
                    </td>
                    <td class="bubblecell" align="right">
                        <asp:Label runat="server" id="lblROI"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>

</html>
