<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProjectsImport.aspx.cs" Inherits="ProjectsImport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Multiple Projects Import</title>
    <base target="_self">
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Large" Height="41px"
            Text="Import New Initiatives" Width="505px"></asp:Label><br />
        <br />
    <table width="100%">
    <tr>
        <td align="left"colspan="5">
            &nbsp;<asp:GridView ID="gvProjects" runat="Server" PageSize="5"
		                PagerSettings-Mode="NextPrevious" OnPageIndexChanging="gvProjects_PageIndexChanging" PagerSettings-NextPageText="Next..." PagerSettings-PreviousPageText="Prev...">
                    <PagerStyle  Font-Bold="True" HorizontalAlign="Right"/>			
                    <HeaderStyle Font-Bold="True" ForeColor="White" BackColor="Navy" Font-Size="Smaller" />
                    <AlternatingRowStyle BackColor="Gainsboro" />	    
                    <RowStyle BackColor="White" />
                <PagerSettings Mode="NextPrevious" NextPageText="Next..." PreviousPageText="Prev..." />
                  </asp:GridView>
        </td>      
    </tr>
    <tr>
        <td align="left" colspan="5">
            1.
            Browse for Saved File.<asp:FileUpload CssClass="def" ID="FileUpload1" runat="server" />
            <asp:Label ID="Label1" runat="server" Text="" />
        </td>
    </tr>
        <tr>
            <td align="left" colspan="5" style="height: 15px">
                &nbsp; &nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td align="left" colspan="5">
                2.
                Populate IPMS Project Grid.
                <asp:Button ID="btnPopGrid" CssClass="def" runat="server" OnClick="btnPopGrid_Click" Text="Populate Grid" EnableViewState="False" /></td>
        </tr>
        <tr>
            <td align="left" colspan="5">
                &nbsp; &nbsp; &nbsp;&nbsp;
            </td>
        </tr>
    <tr>
        <td align="left" colspan="5">
            3.
            Confirm and Save Project Data.
            <asp:Button ID="btnSaveProjects" CssClass="def" runat="server" OnClick="btnSaveProjects_Click" Text="Save Projects" Enabled="False" EnableViewState="False" /></td>
    </tr>
        <tr>
            <td align="left" colspan="5">
                &nbsp; &nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td align="left" colspan="5">
                4.
                Close Popup Window.
                <INPUT class="def" style="WIDTH: 70px" onclick="window.close()" type="button" value="Close" id="Button1" /></td>
        </tr>
    
    </table>
    </div>
    </form>
</body>
</html>
