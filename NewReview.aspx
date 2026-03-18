<%@ Page language="c#" Inherits="ProjectPortfolio.NewReview" CodeFile="NewReview.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	
	<head runat="server">
		<title id="pageTitle" runat="server">New Review</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<BASE target="_self">
	</head>
	<body >
	    <script type="text/javascript" language="javascript">
	        var click_count = 0;
	    </script>
		<form id="frmNewInitiative" method="post" runat="server">
			<table border="0">
				<tr>
				    <td colspan="4" height="5"></td>
				</tr>
				<tr>
					<td ></td>
					<td class="summarylabel" width="200">Please select the year this review will take place in :</td>
					<td></td>
					<td>
                        <asp:DropDownList Runat="server" ID="ddlPeriod" CssClass="textinput" Width="100%"></asp:DropDownList>
					</td>
		             <td width="20">	                
		             </td>
				</tr>
		
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td align="right" style="height:10px">
						<table>
							<tr>
								<td><asp:Button id="btnOK" runat="server" Width="70" Text="OK" CssClass="def" onclick="btnOK_Click"></asp:Button></td>
								<td width="20"></td>
								<td><INPUT class="def" style="WIDTH: 70px" onclick="window.returnValue=0; window.close();" type="button" value="Cancel" id="btnCancel"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
				<td colspan="3" class="def" style="color:Red;font-weight:bold">
				    <div id="divWait" style="visibility:hidden">
				        IPMS has started creating the review.This operation can not be undone.Please wait.
				    </div>
				</td>
				</tr>
				
		
			</table>
		</form>
	</body>
</HTML>
