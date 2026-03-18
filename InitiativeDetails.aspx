<%@ Page language="c#" Inherits="ProjectPortfolio.InitiativeDetails" CodeFile="InitiativeDetails.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Administer Initiative</title>
		<link href="style.css" type="text/css" rel="stylesheet"/>
		<base target="_self"/>
		
		<script type="text/javascript">
	
		</script>
	</head>
	<body>
		<form id="frmInitiativeDetails" method="post" runat="server">
	
             <asp:Panel ID="pnlDetails" Visible="true"  runat="server">
                    <table border="0">
				    <tr>
					    <td colspan="4" style="height: 30px"></td>
					    <td align="center">Apply to <strong>ALL</strong> Versions</td>
				    </tr>
				    <tr>
					    <td></td>
					    <td class="summarylabel" width="100">Initiative Name</td>
					    <td><asp:RequiredFieldValidator ID="rvInitiativeName" runat="server" Text="*" ControlToValidate="txtInitiativeName"></asp:RequiredFieldValidator></td>
					    <td><asp:TextBox Runat="server" ID="txtInitiativeName" CssClass="textinput" Width="300"></asp:TextBox></td>
					    <td align="center"><asp:CheckBox ID="cbxNameAAV" Checked="true" runat="server" /></td>
				    </tr>
				    <tr>
					    <td></td>
					    <td class="summarylabel" width="100">IG Identifier</td>
					    <td><asp:RequiredFieldValidator ID="rvIGIdentifier" runat="server" Text="*" ControlToValidate="txtIGIdentifier"></asp:RequiredFieldValidator></td>
					    <td><asp:TextBox Runat="server" ID="txtIGIdentifier" CssClass="textinput" Width="300"></asp:TextBox></td>
					    <td align="center"><asp:CheckBox ID="cbxIGIdentifierAAV" Checked="true"  runat="server" Enabled="False" /></td>
				    </tr>
				    <tr>
					    <td></td>
					    <td class="summarylabel" width="100">Primary SBU</td>
					    <td><asp:CompareValidator ID="sectionA_rvPrimarySponsoringArea" runat="server"
                                ControlToValidate="ddlPrimarySBU" ErrorMessage="Primary Sponsoring Business Unit must not be blank or Legacy"
                                Operator="GreaterThan" ValidationGroup="SubmitForReview" ValueToCompare="0" Width="1px">*</asp:CompareValidator></td>
					    <td><asp:DropDownList Runat="server" ID="ddlPrimarySBU" Width="300px" CssClass="textselect">
                            </asp:DropDownList></td>
					    <td align="center"><asp:CheckBox ID="cbxPrimarySBUAAV" Checked="false"  runat="server" /></td>
				    </tr>
				    <tr>
					    <td colspan="4" height="10"></td>
				    </tr>
				    <tr>
					    <td height="20"></td>
					    <td></td>
					    <td></td>
					    <td align="right">
						    <table>
							    <tr>
								    <td> <asp:Button id="btnOK" runat="server" Width="70" Text="OK" CssClass="def" OnClick="btnOK_Click"></asp:Button>
								        
								    </td>
								    <td width="20"></td>
								    <td><input class="def" style="WIDTH: 70px" onclick="window.close()" type="button" value="Cancel"/></td>
							    </tr>
						    </table>
					    </td>
				    </tr>
				    <asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
                HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
                ShowMessageBox="True" ShowSummary="False" />
			    </table>
                </asp:Panel>
                 
                
                 <asp:Panel ID="pnlMessage" Visible="false" runat="server">
                    <br />
                     <table style="width: 420">
                     <tr style="height: 45px "><td></td> <td></td></tr>
			            <tr>
			                <td style="width: 3px"></td>
			                <td >
                                <asp:Literal ID="txtMessage" runat="server"></asp:Literal>
                            </td>
			            </tr>
			            <tr>
			                <td style="width: 3px"></td>
			                <td align="right">
						        <table>
						            <tr style="height: 25px "><td></td><td></td></tr>
							        <tr>							
								        <td width="20"></td>
								        <td><input class="def" style="WIDTH: 70px" onclick="window.close()" type="button" value="Cancel"/></td>
							        </tr>
						        </table>
					        </td>
			            </tr>
			            </table>
                 </asp:Panel>
			
		</form>
	</body>
</html>

