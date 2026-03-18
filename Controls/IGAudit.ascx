<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IGAudit.ascx.cs" Inherits="Controls_IGAudit" %>
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

<table width="100%" runat="server" id="tbAuditID" visible="false">
	<tr class="ms-WPHeader">
		<td colspan="4" class="controltitle">Audit</td>
	</tr>
</table>

<table cellpadding="2" cellspacing="2" border="0">
    <tr>
        <td width="1px">            
        </td>
        <td valign="top" style="border: solid 1px #CCCCCC"> 
            <table cellpadding="2" cellspacing="0" >
                <tr>
                    <td height="22px" style="font-size: 12px; font-weight: bold; border: 1px solid #eaeaea" class="mp_headcell">Search Panel</td>
                </tr>
                <tr>
                    <td height="15px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">Table Name</td>
                </tr>
                <tr>
                    <td><asp:DropDownList Runat="server" ID="ddlTableName" CssClass="textselect" Width="140px"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td height="10px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">IG Identifer</td>
                </tr>
                <tr>
                    <td><asp:TextBox Runat="server" ID="txtIGIdentifier" CssClass="textinput" Width="140px" MaxLength="200"></asp:TextBox></td>
                </tr>
                <tr>
                    <td height="10px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">Modified by (Firstname/Surname)</td>
                </tr>
                <tr>
                <td>
                    <table>
                    <tr>
                        <td><asp:TextBox Runat="server" ID="txtUserName" CssClass="textinput" Width="140px" MaxLength="200"></asp:TextBox></td>
                        <td><a runat="server" ID="lnkUserName"><img src="Images/pick.jpg" border="0" ></a></td>
                    </tr>
                    <tr>
                        <td><asp:HiddenField runat="server" ID="hUserID" /></td>
                        <td></td>
                    </tr>
                    </table>
                </td>
                </tr>
                <tr>
                    <td height="10px"></td>
                 </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">Modified Date</td>
                </tr>
                <tr>
                    <td>
                    <table>
                        <tr>
                            <td><asp:TextBox Runat="server" ID="txtModifyDate"  CssClass="textinput" Width="140px" MaxLength="200"></asp:TextBox></td>
                            <td><a runat="server" id="lnkModifyDate"><img src="Images/calendar.jpg" border="0"></a></td>
                        </tr>
	                    <tr>
	                        <td valign="top"><font face="verdana, arial, helvetica, sans-serif" color="#333333" size="1"><em>dd/mm/yyyy</em></font></td>
	                        <td></td>
	                    </tr>
                    </table>
                    
                    </td>
                </tr>
                <tr>
                    <td height="10px"></td>
                </tr>
                <tr>
                    <td><asp:Button runat="server" ID="btnSearch" Width="80px" Text="Search" CssClass="button" OnClick="btnSearch_Click"/></td>
                </tr>
                <tr>
                    <td height="5px"></td>
                </tr>
            </table>
        </td>
        <td width="1px">            
        </td>
         <td valign="top">
               <asp:GridView AutoGenerateColumns="False" EnableViewState="False" runat="Server" ID="gvAudit" 
                AllowPaging="True" PageSize="25" PagerSettings-Mode="NextPrevious" PagerSettings-NextPageText="Next..." PagerSettings-PreviousPageText="Prev..."
                CellPadding="2" CssClass="datatable" AllowSorting="True" 
                OnRowCommand="gvAudit_RowCommand" OnRowDataBound="gvAudit_RowDataBound" OnSorting="gvAudit_Sorting" OnPageIndexChanging="gvAudit_PageIndexChanging" >
                <PagerStyle  Font-Bold="True" HorizontalAlign="Right"/>	
                <Columns>
                    <asp:TemplateField HeaderText="Modified Date" SortExpression="ModifiedDate">
                        <HeaderStyle CssClass="mp_headcell" Width="135px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="135px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"ModifiedDate")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Modified By" SortExpression="Surname">
                        <HeaderStyle CssClass="mp_headcell" Width="120px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="120px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "Firstname").ToString() + " " + DataBinder.Eval(Container.DataItem, "Surname").ToString()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="IGIdentifier" SortExpression="IGIdentifier">
                        <HeaderStyle CssClass="mp_headcell" Width="100px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="100px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "IGIdentifier")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Table" SortExpression="TableName">
                        <HeaderStyle CssClass="mp_headcell" Width="200px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="200px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# GetIGTableName(DataBinder.Eval(Container.DataItem, "TableName").ToString())%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Column" SortExpression="ColumnName">
                        <HeaderStyle CssClass="mp_headcell" Width="210px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="210px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"ColumnName")%>
                        </ItemTemplate>
                    </asp:TemplateField>   
                     <asp:TemplateField HeaderText="Old Value" SortExpression="OldValue">
                        <HeaderStyle CssClass="mp_headcell" Width="100px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="100px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"OldValue")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="New Value" SortExpression="NewValue">
                        <HeaderStyle CssClass="mp_headcell" Width="100px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="100px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"NewValue")%>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                </Columns>
                <RowStyle BackColor="#FCFCFC" Height="25px" />
                <AlternatingRowStyle BackColor="#F6F6F6" Height="25px" />
                <HeaderStyle Height="25px" />
                   <PagerSettings Mode="NextPrevious" NextPageText="Next..." PreviousPageText="Prev..." />
            </asp:GridView>        
        </td>
    </tr>
    <tr>
        <td colspan="2">
          
        </td>
    </tr>
</table>