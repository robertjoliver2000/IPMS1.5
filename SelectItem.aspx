<%@ Page language="c#" Inherits="ProjectPortfolio.SelectItem" CodeFile="SelectItem.aspx.cs" %><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>

	<script language="javascript">
    function popupWindowAddItem(categoryID)
    {
	    var dialogwidth = 400; 
	    var dialogheight = 170; 
	    var leftpos = (screen.width - dialogwidth) / 2;
	    var toppos = (screen.height - dialogheight) / 2; 
	    var attr = "left=" + leftpos + ",top=" + toppos + 
	            ",resizable=no,scroll=yes," + 
	            "width=" + dialogwidth + ",height=" + dialogheight + 
	            ",titlebar=no,status=no,dependent=yes"; 
	    
        if(categoryID==2)
            dlgwindow = window.open("NewApplication.aspx","newapp_dialog",attr);
        else if (categoryID==3)
            dlgwindow = window.open("NewServer.aspx","newserver_dialog",attr);
        
	    dlgwindow.focus();
    }
   </script>
   
	<HEAD>
		<title id="pageTitle" runat="server">Pick...</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="frmItemPicker" method="post" defaultbutton="btnSearch" runat="server">
			<table border="0">
				<tr>
				    <td colspan="4" height="5"></td>
				</tr>
				<tr>
					<td></td>
					<td class="summarylabel" width="100"><asp:label id="lblSearch" runat="server"></asp:label></td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtSearch" CssClass="textinput" Width="200"></asp:TextBox></td>
				</tr>
				<tr>
				    <td></td>
					<td class="summarylabel" width="100"><asp:label id="lblFirstName" runat="server" ></asp:label></td>
					<td></td>
					<td><asp:TextBox Runat="server" ID="txtFirstName" CssClass="textinput" Width="200"  ></asp:TextBox></td>
				</tr>
				<tr>
				    <td colspan="4" height="5"></td>
				</tr>
				<tr>
				    <td></td>
				    <td></td>
				    <td></td>
				    <td align="right">
				        <table>
				        <tr>
				            <td><asp:Button id="btnEmptyItem" runat="server" Width="70" Text="Set Empty" CssClass="def" OnClick="btnEmptyItem_Click" Visible="False"></asp:Button></td>
		    	        </tr>
   				        <tr>
				            <td><asp:Button id="btnSearch" runat="server" Width="70" Text="Search" CssClass="def" OnClick="btnSearch_Click"></asp:Button></td>
				        </tr>
				        </table>
				     </td>
				</tr>
				<tr>
				    <td> </td>
				    <td align="left" colspan="3">
				    				    
				    <asp:GridView ID="gvItems" AutoGenerateColumns="False" AllowPaging="True" EnableViewState="False" runat="Server" PageSize="10" Width="300"
				            PagerSettings-Mode="NextPrevious" PagerSettings-NextPageText="Next..." PagerSettings-PreviousPageText="Prev..." OnRowCommand="gvItems_RowCommand" OnPageIndexChanging="gvItems_PageIndexChanging">
                        <PagerStyle  Font-Bold="True" HorizontalAlign="Right"/>			
                        <HeaderStyle Font-Bold="True" ForeColor="White" BackColor="Navy" Font-Size="XX-Small" Width="100%"  />
                        <AlternatingRowStyle BackColor="Gainsboro" />	    
                        <RowStyle BackColor="White" />
                     </asp:GridView>
			    
				    
		            </td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
				<tr>
					<td colspan="3" height="5"></td>
					<td align="right"><button id="btnNewItem" style="WIDTH: 70px" runat="server" class="def">New</button></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td align="right">
						<table>
							<tr>
								<td></td>
								<td width="20"></td>
								<td><INPUT class="def" style="WIDTH: 70px" onclick="window.close()" type="button" value="Cancel"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>

