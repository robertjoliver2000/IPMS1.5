<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Coordinator.ascx.cs" Inherits="Controls_Coordinator" %>
<script language="javascript" type="text/javascript">

function popupWindowNewReview(initiativeID, forPIR)
{
    
    var returnCode;

    var PIR = "";
    if ( ("" + forPIR).toString().toLowerCase() == "forpir" )
    {
        PIR = "&ForPIR=yes";
    }
        
	returnCode= window.showModalDialog("NewReview.aspx?InitiativeID=" + initiativeID + PIR, 
					            "review_dialog", "dialogWidth:440px;dialogHeight:155px;status:no;resizable:no;scroll:no");
	
	//alert(returnCode);
    if (returnCode==0)
    {
        //window.location="default.aspx";
    }
    else
    {
        window.location="default.aspx?section=1&InitiativeID="+returnCode;
    }   
    
    return false;
       
}


function popupWindowNewPIR(initiativeID)
{
    popupWindowNewReview(initiativeID, "forPIR" )
    return false;
}

function popWindowPPR_Comments( initiativeId, sender )
{
    var returnCode = window.showModalDialog( "PPR_Comments.aspx?InitiativeId=" + initiativeId, "PPR_Comments"
                    , "dialogWidth:310px; dialogHeight:190px; status:no; resizable:no; scroll:no;"
                    //, "resizable:yes;"
                );

    if ( returnCode )
    {
        if ( returnCode == "Y" )
        {
            sender.title = "Has PPR Comments";
            sender.innerText = "*";
        }
        else
        {
            sender.title = "Has No PPR Comments";
            sender.innerText = "+";
        }
    }
    return false;
}

</script>

<table cellpadding="0" cellspacing="1" border="0">
    <tr>
        <td width="1px">            
        </td>
        <td valign="top" style="border: solid 1px #CCCCCC"> 
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
	                <td class="mp_summarylabel" width="180px">IG Approval Committee</td>
                </tr>
                <tr>
	                <td><asp:DropDownList Runat="server" ID="ddlIGApprovalCommittee" CssClass="textselect" Width="140px"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" style="height: 5px">
                    </td>
                </tr>
                <tr>
	                <td class="mp_summarylabel" width="180px">Strategic Business Unit</td>
                </tr>
                <tr>
	                <td><asp:DropDownList Runat="server" ID="ddlSBU" CssClass="textselect" Width="140px"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" style="height: 5px">
                    </td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" style="height: 5px">
                        Approval Date</td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" height="5">
                        From:</td>
                </tr>
                <tr>
                    <td style="height: 49px">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtApprovalDateFrom" runat="server" CssClass="textinput" MaxLength="200"
                                        Style="text-align: center" Width="100px"></asp:TextBox></td>
                                <td align="center" width="20">
                                    <a id="lnkApprovalDateFrom" runat="server">
                                        <img id="Img3" border="0" src="Images/calendar.jpg" /></a></td>
                                <td align="center" style="width: 20px">
                                    <asp:RangeValidator ID="rvApprovalDateFrom" runat="server" ControlToValidate="txtApprovalDateFrom"
                                        MaximumValue="1/1/2020" MinimumValue="1/1/1900" Text="*" Type="Date"></asp:RangeValidator></td>
                            </tr>
                            <tr>
                                <td style="height: 19px" valign="top">
                                    <font color="#333333" face="verdana, arial, helvetica, sans-serif" size="1"><em>dd/mm/yyyy</em></font></td>
                                <td style="height: 19px">
                                </td>
                                <td style="width: 20px; height: 19px">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="mp_summarylabel" height="5">
                        To:</td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtApprovalDateTo" runat="server" CssClass="textinput" MaxLength="200"
                                        Style="text-align: center" Width="100px"></asp:TextBox></td>
                                <td align="center" width="20">
                                    <a id="lnkApprovalDateTo" runat="server">
                                        <img id="Img2" border="0" src="Images/calendar.jpg" /></a></td>
                                <td align="center" style="width: 20px">
                                    <asp:RangeValidator ID="rvApprovalDateTo" runat="server" ControlToValidate="txtApprovalDateTo"
                                        MaximumValue="1/1/2020" MinimumValue="1/1/1900" Text="*" Type="Date"></asp:RangeValidator></td>
                            </tr>
                            <tr>
                                <td style="height: 19px" valign="top">
                                    <font color="#333333" face="verdana, arial, helvetica, sans-serif" size="1"><em>dd/mm/yyyy</em></font></td>
                                <td style="height: 19px">
                                </td>
                                <td style="width: 20px; height: 19px">
                                </td>
                            </tr>
                        </table>
                    </td>
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
                    <td style="height: 26px"><asp:DropDownList Runat="server" ID="ddlYear" Width="140px" CssClass="textselect"></asp:DropDownList></td>
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
             <asp:GridView AutoGenerateColumns="False" EnableViewState="False" runat="Server" ID="gvInitiatives" 
                CellPadding="2" CssClass="datatable" AllowSorting="True" OnRowCommand="gvInitiatives_RowCommand" OnRowDataBound="gvInitiatives_RowDataBound" OnSorting="gvInitiatives_Sorting" EmptyDataText="No matching IG Initiatives have been found. If you cannot find your Initiative in the system please contact your IG Coordinator or the central IG team for further assistance.">
                <Columns>
                    <asp:TemplateField HeaderText="Initiative Name" SortExpression="Name">
                        <ItemTemplate>
                                <asp:Literal ID="litHasPPRComments" runat="server"></asp:Literal>
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("InitiativeID", "~/default.aspx?section=1&InitiativeID={0}") %>'
                                Text='<%# Eval("Name") %>' CssClass="padright"></asp:HyperLink>
                        </ItemTemplate>
                        <ControlStyle CssClass="mp_link" />
                        <HeaderStyle CssClass="mp_headcell" HorizontalAlign="Left" Width="220px" />
                        <ItemStyle CssClass="mp_incell noted" HorizontalAlign="Left" Width="220px" />
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
                        <HeaderStyle CssClass="mp_headcell" Width="60px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="60px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem,"IGVersionNumber").ToString().PadLeft(2, '0')%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Approval Date" SortExpression="IGApprovalDate">
                        <HeaderStyle CssClass="mp_headcell" Width="90px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" Width="90px" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "IGApprovalDate", "{0:d}")%>
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
                    <asp:TemplateField HeaderText="IG Status" SortExpression="IGApprovalStatusID">
                        <HeaderStyle CssClass="mp_headcell" Width="70px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Left" />
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td width="16"><asp:Image runat="server" id="imgStatus"/></td>
                                    <td><%# DataBinder.Eval(Container.DataItem,"IGApprovalStatus")%></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Performance Status">
                        <HeaderStyle CssClass="mp_headcell" Width="165px"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image ID="imgPPR_Overall" runat="server" ImageUrl="~/images/PPR_Grey.png" />
                            <asp:Image ID="imgPPR_Cost" runat="server" ImageUrl="~/images/PPR_Grey.png" />
                            <asp:Image ID="imgPPR_Deliverables" runat="server" ImageUrl="~/images/PPR_Grey.png" />
                            <asp:Image ID="imgPPR_Time" runat="server" ImageUrl="~/images/PPR_Grey.png" />
                            <asp:Image ID="imgPPR_Risks" runat="server" ImageUrl="~/images/PPR_Grey.png" />
                            <asp:Image ID="imgPPR_Benefits" runat="server" ImageUrl="~/images/PPR_Grey.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="InitiativeID" Text="Show All Versions" DataNavigateUrlFormatString="~/default.aspx?InitiativeID={0}">
                        <HeaderStyle CssClass="mp_headcell" Width="100px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle CssClass="mp_link" />
                    </asp:HyperLinkField>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="mp_headcell" Width="120px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle cssclass="button" />
                        <ItemTemplate>
                            <asp:Button runat="server" id="btnCreateReview" CommandName="CreateReview" CommandArgument=<%# DataBinder.Eval(Container.DataItem,"InitiativeID")%>
                                    Text="New Review" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderStyle CssClass="mp_headcell" Width="90px"  HorizontalAlign="Center"/>
                        <ItemStyle CssClass="mp_incell" HorizontalAlign="Center" />
                        <ControlStyle cssclass="button" />
                        <ItemTemplate>
                            <asp:Button runat="server" id="btnCreatePIR" CommandName="CreatePIR" CommandArgument=<%# DataBinder.Eval(Container.DataItem,"InitiativeID")%>
                                    Text="New PIR" />
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