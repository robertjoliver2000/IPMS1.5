<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Financial.aspx.cs" Inherits="ProjectPortfolio.Financial" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Add Financial Record</title>
	<LINK href="style.css" type="text/css" rel="stylesheet">    
	<BASE target="_self">
</head>

<script language="javascript">

function popupWindowSelectItem(categoryID,txtBoxID,hiddenTxtBoxID)
{
    var dialogwidth = 360
	var dialogheight = 400
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"
	
	dlgwindow = window.open("SelectItem.aspx?CategoryID="+categoryID+"&ControlID="+txtBoxID+"&HiddenControlID="+hiddenTxtBoxID, 
					"mydialog", attr)
					
	dlgwindow.focus();
}

</script>


<script src="js/DatePicker.js" type="text/javascript"></script>

<body>
    <form id="frmMain" runat="server">
    <div>
		<table border="0">
		<tr height="5px">
		</tr>
		<tr>
		    <td width="5px">		        
		    </td>
            <td valign="top">
		<table border="0">
		    <tr>
		        <td class="summarylabel" width="160px">
			        Financial Category
		        </td>
		        <td>
		            <asp:DropDownList Font-Bold="true" Font-Size="10px" Runat="server" ID="ddlCategory" CssClass="textselect" Width="220px" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
		                <asp:ListItem Text="Benefit" Value="1"></asp:ListItem>
		                <asp:ListItem Text="GTO One Time Cost" Value="2"></asp:ListItem>
		                <asp:ListItem Text="Business Direct One Time Cost" Value="3"></asp:ListItem>
		                <asp:ListItem Text="GTO Incremental Cost" Value="4"></asp:ListItem>
		                <asp:ListItem Text="Business Direct Incremental Cost" Value="5"></asp:ListItem>
		                <asp:ListItem Text="Capital Hardware Expense" Value="6"></asp:ListItem>
		                <asp:ListItem Text="Building/Premises Expense" Value="7"></asp:ListItem>
		                <asp:ListItem Text="Capital Software Expense" Value="8"></asp:ListItem>
		            </asp:DropDownList>
		        </td>
      	    </tr>
		    <tr>
		        <td height="3" colspan="2">
		        </td>
		    </tr>
		    <tr>
		        <td class="summarylabel" width="160px">Start Date</td>
        		<td width="245px">
				    <table align="left" border="0" cellpadding="0" cellspacing="0">
				        <tr>
				            <td><asp:TextBox Runat="server" ID="txtStartDate" CssClass="textinput" MaxLength="50" Width="80px" style="text-align:center" TabIndex="8"></asp:TextBox></td>
				            <td width="20px" align="center"><a runat="server" id="lnkStartDate"><img src="Images/calendar.jpg" border="0"></a></td>
				            <td width="20px" align="center">
				                <asp:RangeValidator ID="rvStartDate" runat="server" ControlToValidate="txtStartDate" MaximumValue="1/1/2020" MinimumValue="1/1/1900" Type="Date" >*</asp:RangeValidator>
				                <asp:RequiredFieldValidator ID="rqvStartDate" runat="server" ControlToValidate="txtStartDate">*</asp:RequiredFieldValidator>
				            </td>
				        </tr>
	                    <tr>
	                        <td valign="top"><font face="verdana, arial, helvetica, sans-serif" color="#333333" size="1"><em>dd/mm/yyyy</em></font></td>
	                        <td></td>
	                        <td></td>
	                    </tr>
				    </table>        		
			    </td>
        	</tr>
		    <tr>
		        <td class="summarylabel" width="160px">
		            <asp:Label runat="server" ID="lblTypeTitle">Benefits Type</asp:Label>
		        </td>
        		<td>
        		    <asp:TextBox Runat="server" ID="txtType" CssClass="textinputgreen" MaxLength="250" Width="220px" TabIndex="1" ReadOnly="True"></asp:TextBox>
        		    <asp:DropDownList Runat="server" ID="ddlType" CssClass="textselect" Width="223px" TabIndex="1"></asp:DropDownList>
        		    <asp:CustomValidator ID="rvType" runat="server" Text="*" ClientValidationFunction="validateType"></asp:CustomValidator>
        		</td>
		    </tr>
		    <tr>
 		        <td class="summarylabel">
		            <asp:Label runat="server" ID="lblDescriptionTitle">Benefits Description</asp:Label>
		        </td>
        		<td>
        		    <asp:DropDownList Runat="server" ID="ddlDescription" CssClass="textselect" Width="223px" TabIndex="2"></asp:DropDownList>
        		    <asp:CustomValidator ID="rvDescription" runat="server" Text="*" ClientValidationFunction="validateDescription"></asp:CustomValidator>
        		</td>
		    </tr>
		    <tr>
		        <td class="summarylabel">
		            <asp:Label runat="server" ID="lblCommentTitle">Benefit Realisation Owner</asp:Label>
		        </td>
        		<td>
        		    <table border="0" cellspacing="0" cellpadding="0">
        		    	<tr>
        		    		<td>
                    		    <asp:TextBox Runat="server" ID="txtComments" CssClass="textinput" MaxLength="250" Width="220px" TabIndex="3"></asp:TextBox>
        		                <asp:HiddenField runat="server" ID="hOwnerID" />
        		            </td>
        		            <td>
				                <asp:RequiredFieldValidator ID="rqvComments" runat="server" ControlToValidate="txtComments">*</asp:RequiredFieldValidator>
        		    		</td>
        		    		<td>
        				        <a runat="server" ID="lnkOwner"><img src="Images/pick.jpg" border="0"></a>
        		    		</td>
        		    	</tr>
        		    </table>
        		</td>
		    </tr>
		    <tr>
 		        <td class="summarylabel">
		            Business/GT (Level 7)
		        </td>
        		<td>
        		    <asp:TextBox Runat="server" ID="txtBusinessGTLevel7" CssClass="textinputgreen" MaxLength="50" Width="220px" TabIndex="5" ReadOnly="True"></asp:TextBox>
         		    <asp:DropDownList runat="server" id="ddlBusinessGTLevel7" Width="0px" EnableViewState="false" CssClass="textselectgreen"></asp:DropDownList>
           		</td>
		    </tr>
		    <tr>
		        <td class="summarylabel">
		            Business/GT (Level 8)
		        </td>
        		<td>
        		    <asp:TextBox Runat="server" ID="txtBusinessGTLevel8" CssClass="textinputgreen" MaxLength="50" Width="220px" TabIndex="6" ReadOnly="True"></asp:TextBox>
          		    <asp:DropDownList runat="server" id="ddlBusinessGTLevel8" Width="0px" EnableViewState="false" CssClass="textselectgreen"></asp:DropDownList>
          		</td>
		    </tr>	
		    <tr>
		        <td class="summarylabel">
		            Business/GT (Level 9)
		        </td>
        		<td>
        		    <asp:TextBox Runat="server" ID="txtBusinessGTLevel9" CssClass="textinputgreen" MaxLength="50" Width="220px" TabIndex="4" ReadOnly="True"></asp:TextBox>
        		    <asp:DropDownList runat="server" id="ddlBusinessGTLevel9" Width="0px" EnableViewState="false" CssClass="textselectgreen"></asp:DropDownList>
        		</td>
		    </tr>
		    <tr runat="server">
		        <td class="summarylabel">
		            Business/GT (Level 9)
		        </td>
        		<td>
        		    <asp:DropDownList Runat="server" ID="ddlBusinessGTLevel10" CssClass="textselect" Width="223px" TabIndex="7"></asp:DropDownList>
        		    <asp:CustomValidator ID="rvBusinessGT" runat="server" Text="*" ClientValidationFunction="validateUBR"></asp:CustomValidator>
        		</td>
		    </tr>	
		    <tr>
		        <td class="summarylabel">
		            Custom Grouping
		        </td>
        		<td>
        		    <asp:TextBox Runat="server" ID="txtCustomGrouping" CssClass="textinputgreen" MaxLength="50" Width="220px" TabIndex="4" ReadOnly="True"></asp:TextBox>
        		    <asp:DropDownList runat="server" id="ddlCustomGrouping" Width="0px" EnableViewState="false" CssClass="textselectgreen"></asp:DropDownList>
        		</td>
		    </tr>
		    <tr height="15px">
		        <td colspan="5" style="height: 15px">
                    </td>
		    </tr>
		    <tr>
		        <td colspan="3" align="left">
		            <asp:Button runat="server" ID="btnOK" Text="OK" Width="70px" CssClass="def" OnClick="btnOK_Click" TabIndex="20" />
		            <asp:Button runat="server" ID="btnCancel" Text="Cancel" Width="70px" CssClass="def" TabIndex="21" />
		        </td>
		    </tr>	    	    
		</table>
                <asp:ValidationSummary ID="ctlValidationSummary" runat="server" DisplayMode="SingleParagraph"
                    HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!"
                    ShowMessageBox="True" ShowSummary="False" />
		    </td>
		    <td width="5px">
		    </td>
		    <td valign="top">
		        <table border="0" cellpadding="2" cellspacing="2">
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
		            <tr>
        		        <td></td>
        		        <td class="summarylabel" colspan="4"><asp:Label runat="Server" ID="lblAmountsTitle">BENEFITS</asp:Label>&nbsp;(€M)</td>
                    </tr>		
                    <tr>
                        <td colspan="2"></td>
                    </tr>
                    <asp:Repeater runat="Server" ID="rptControls" OnItemDataBound="rptControls_OnItemDataBound" EnableViewState="true">
                        <ItemTemplate>
                            <tr runat="Server" id="trContent"></tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
		    </td>
		</tr>
	</table>
    </div>
    </form>
</body>
</html>
