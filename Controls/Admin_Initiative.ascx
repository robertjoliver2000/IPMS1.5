<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Admin_Initiative.ascx.cs" Inherits="Controls_Admin_Initiative" %>
<script language="javascript">
 
function popupWindowInitiative(initiativeID, allowSubmit)
{
    //debugger
        
    var returnCode;
	returnCode= window.showModalDialog("InitiativeDetails.aspx?InitiativeID=" + initiativeID, 
					            "initiative_dialog", "dialogWidth:480px;dialogHeight:230px;status:no;resizable:no;scroll:yes");
					
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            //ERW 27 May 2008
            if (allowSubmit)
            {
                AllowOneTimeSubmit();
            }
        
        
            window.document.forms[0].submit();
        }
    }   
}

function popupWindowNewInitiative()
{
    var returnCode;
	returnCode= window.showModalDialog("NewInitiative.aspx", 
					            "initiative_dialog", "dialogWidth:480px;dialogHeight:270px;status:no;resizable:no;scroll:yes");
					
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            window.document.forms[0].submit();
        }
    }   
}

function popupWindowUploadInitiativeTemplate()
{
    //ERW 23 Feb 2009
	// changed per HW feedback to allow copy paste from window / give more space within window	
        //var returnCode;
	    //returnCode= window.showModalDialog("UploadInitiative.aspx", 
	    //				            "initiative_dialog", "dialogWidth:680px;dialogHeight:480px;status:no;resizable:no;scroll:yes");
	    
	   // debugger;
	var newWindow;
	newWindow = window.open("UploadInitiative.aspx", "_blank"); 
	
	/*
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            window.document.forms[0].submit();
        }
    } 
    */  
}


function selectAllInPPR( sender )
{
	var checked = ( sender.innerText.toLowerCase() == 'select all' );
	var list = document.getElementsByTagName( "INPUT" );
	var id;
	var elt;
	
	for ( var i = 0; i < list.length; i++ )
	{
		elt = list[ i ];
		id = list[ i ].id;
		if ( ( id.substring( id.length - 9 ) == "_cbxInPPR" ) && ( elt.checked != checked ) )
		{
			elt.checked = checked;
		}
	}

	return( false );
}

function AddPPRChangeHandlers()
{
   var list = document.getElementsByTagName( 'INPUT' );
    var id;
    for ( var i = 0; i < list.length; i++ )
    {
        id = list[ i ].id;
        if ( id.substring( id.length - 9 ) == "_cbxInPPR" )
        {
            Events_chainEvent( list[ i ], "onclick", "SetDirtyFlag();" );
        }
    }
}

</script>

<script src="js/DatePicker.js" type="text/javascript"></script>
<table width="100%" border="0" cellpading="0" cellspacing="0">
	<tr class="ms-WPHeader" style="height: 22px">
		<td class="controltitle">Initiative Maintenance</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="1" border="0">
	<tr>
        <td colspan="4" class="undertitle">Please note that you can only delete the last version of an initiative.
        </td>
    </tr>
    <tr>
        <td width="1px">            
        </td>
        <td valign="top" style="border: solid 1px #CCCCCC; width: 164px;"> 
            <table cellpadding="2" cellspacing="0" >
                <tr>
                    <td height="22px" style="font-size: 12px; font-weight: bold; border: 1px solid #eaeaea" class="mp_headcell">Search Panel</td>
                </tr>
                <tr>
                    <td height="5px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">Initiative Name</td>
                </tr>
                <tr>
                    <td><asp:TextBox Runat="server" ID="txtInitiativeName" CssClass="textinput" Width="140px" MaxLength="200"></asp:TextBox></td>
                </tr>
                <tr>
                    <td height="5px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">IG Identifier</td>
                </tr>
                <tr>
                    <td><asp:TextBox Runat="server" ID="txtIGIdentifier" CssClass="textinput" Width="140px" MaxLength="200"></asp:TextBox></td>
                </tr>
                <tr>
                    <td height="5px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">Strategic Business Unit</td>
                </tr>
                <tr>
	                <td><asp:DropDownList Runat="server" ID="ddlSBU" CssClass="textselect" Width="140px"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td height="5px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">Review Date</td>
                </tr>
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td><asp:TextBox Runat="server" ID="txtReviewDate"  style="text-align: center;" CssClass="textinput" Width="100px" MaxLength="200"></asp:TextBox></td>
                                <td width="20px" align="center"><a runat="server" id="lnkReviewDate"><img src="Images/calendar.jpg" border="0"></a></td>
                                <td width="20px" align="center"><asp:RangeValidator ID="rvReviewDate" runat="server" ControlToValidate="txtReviewDate" Text="*" MaximumValue="1/1/2020" MinimumValue="1/1/1900" Type="Date" ></asp:RangeValidator></td>
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
                    <td height="5px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">Status</td>
                </tr>
                <tr>
                    <td><asp:DropDownList Runat="server" ID="ddlApprovalStatus" Width="140px" CssClass="textselect"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td height="10px"></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" width="180px">Year</td>
                </tr>
                <tr>
                    <td><asp:DropDownList Runat="server" ID="ddlYear" Width="140px" CssClass="textselect"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td height="10px"></td>
                </tr>
                <tr>
                    <td><asp:Button runat="server" ID="btnSearch" Width="100px" Text="Search" CssClass="button" OnClick="btnSearch_Click"/></td>
                </tr>
                <tr>
                    <td height="20px"></td>
                </tr>
                <tr>
                    <td height="22px" style="font-size: 12px; font-weight: bold; border: 1px solid #eaeaea" class="mp_headcell">Add Panel</td>
                </tr>
                <tr>
                    <td style="height: 15px"></td>
                </tr>
                <tr>
                    <td style="height: 32px"><button  class="button" style="width:100px"   onclick="javascript:popupWindowNewInitiative()" id="BUTTON1">New Initiative</button></td>
                </tr>
                <tr>
                    <td style="height: 32px">
                        <button  class="button" style="width:161px"   onclick="javascript:popupWindowUploadInitiativeTemplate()" id="Button3">
                            Upload Initiative Template</button></td>
                </tr>
                <tr>
                    <td style="height: 15px"></td>
                </tr>
                <tr>
                    <td height="22px" style="font-size: 12px; font-weight: bold; border: 1px solid #eaeaea" class="mp_headcell">
                        In PPR Panel</td>
                </tr>
                <tr>
                    <td style="height: 15px"></td>
                </tr>
                <%-- %><tr>
                    <td style="height: 32px"><button  class="button" style="width:100px" onclick="javascript:selectAllInPPR( this )" id="btnSelectAll">Select All</button></td>
                </tr>
                <tr>
                    <td style="height: 5px"></td>
                </tr>
                <tr>
                    <td style="height: 32px"><button  class="button" style="width:100px" onclick="javascript:selectAllInPPR( this )" id="Button2">Deselect All</button></td>
                </tr>
                <tr>
                    <td style="height: 5px"></td>
                </tr>--%>
                <tr>
                    <td style="height: 32px"><asp:Button  CssClass="button" runat="server" style="width:100px" OnClick="btnSave_Click" ID="btnSave" Text="Save" /></td>
                </tr>
                <tr>
                    <td style="height: 5px"></td>
                </tr>
                <tr>
                    <td style="height: 32px"><asp:Button runat="server" ID="btnCancel" Width="100px" Text="Cancel" CssClass="button" OnClick="btnSearch_Click"/></td>
                </tr>
            </table>
        </td>
        <td style="width: 20px">            
        </td>
        <td valign="top">
             <asp:GridView AutoGenerateColumns="False" EnableViewState="False" runat="Server" ID="gvInitiatives" 
                CellPadding="2" CssClass="datatable" AllowSorting="True" OnRowCommand="gvInitiatives_RowCommand" OnRowDataBound="gvInitiatives_RowDataBound" OnSorting="gvInitiatives_Sorting">
                <Columns>
                    <asp:TemplateField HeaderText="Initiative Name" SortExpression="Name">
                        <HeaderStyle CssClass="mp_headcell" Width="220px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="220px" HorizontalAlign="Left" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                        <table>
                        <tr>
                            <td><asp:ImageButton runat="server" ID="delInitiative" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeID")%>' CommandName="DeleteInitiative" CausesValidation="false"></asp:ImageButton> </td>
                            <td><a runat="server" id="lnkInitiative" href="#" 
                                onclick='<%# "javascript:popupWindowInitiative(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", true); return false;"%>'>
                                <%# DataBinder.Eval(Container.DataItem, "Name")%>
                           </a></td>
                         </tr>
                        </table>
                        </ItemTemplate>
                    </asp:TemplateField>                
                    <asp:TemplateField HeaderText="IG Identifier" SortExpression="IGBusinessAreaCode, IGIdentifierCode">
                        <HeaderStyle CssClass="mp_headcell" Width="110px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="110px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGBusinessAreaCode")%>-<%# DataBinder.Eval(Container.DataItem,"IGIdentifierCode")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Current Version" SortExpression="IGVersionNumber">
                        <HeaderStyle CssClass="mp_headcell" Width="70px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="70px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGVersionNumber").ToString().PadLeft(2, '0')%>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Review Date" SortExpression="IGReviewDate">
                        <HeaderStyle CssClass="mp_headcell" Width="90px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="90px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGReviewDate", "{0:d}") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="IGApprovalStatusID">
                        <HeaderStyle CssClass="mp_headcell" Width="160px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Left" />
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td width="16px"><asp:Image runat="server" id="imgStatus"/></td>
                                    <td><%# DataBinder.Eval(Container.DataItem,"IGApprovalStatus")%></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <%-- %><asp:BoundField DataField="CurrentYearGTOOneTimeCost" HeaderText="Current Year GTO One&#160;Time Cost (€M)" DataFormatString="{0:0.00}" SortExpression="CurrentYearGTOOneTimeCost" >
                        <HeaderStyle CssClass="mp_headcell" />
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>--%>
                    <%-- %><asp:TemplateField HeaderText="In PPR" SortExpression="InPPR">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbxInPPR" runat="server" />
                            <asp:HiddenField ID="hdnInitiativeID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"InitiativeID") %>' />
                        </ItemTemplate>
                        <HeaderStyle CssClass="mp_headcell" HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                    </asp:TemplateField>--%>
                    <asp:HyperLinkField DataNavigateUrlFields="InitiativeID" Text="Show All Versions" DataNavigateUrlFormatString="~/admin.aspx?InitiativeID={0}">
                        <HeaderStyle CssClass="mp_headcell" Width="120px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                    </asp:HyperLinkField>
                    <%-- %><asp:TemplateField HeaderText="Locked by" SortExpression="LockedBy">
                        <HeaderStyle CssClass="mp_headcell" Width="70px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="70px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"LockedBy").ToString()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="mp_headcell" Width="100px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle cssclass="button" />
                        <ItemTemplate>
                            <asp:Button runat="server" id="btnUnlock" CommandName="Unlock" CommandArgument=<%# DataBinder.Eval(Container.DataItem,"InitiativeID")%> Text="Unlock" Enabled=<%# DataBinder.Eval(Container.DataItem, "LockedBy").ToString()!= string.Empty %> />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="mp_headcell" Width="100px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle cssclass="button" />
                        <ItemTemplate>
                            <asp:Button runat="server" id="btnReopen" CommandName="Reopen" CommandArgument=<%# DataBinder.Eval(Container.DataItem,"InitiativeID")%> Text="Reopen"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle BackColor="#FCFCFC" Height="25px" />
                <AlternatingRowStyle BackColor="#F6F6F6" Height="25px" />
                <HeaderStyle Height="25px" />
            </asp:GridView>        
        </td>
    </tr>
    <tr>
        <td colspan="4">
        </td>
    </tr>
</table>