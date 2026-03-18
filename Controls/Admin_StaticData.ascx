<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Admin_StaticData.ascx.cs" Inherits="ProjectPortfolio.Controls.Admin_StaticData" %>
<script type="text/javascript">
// <!CDATA[

function TABLE1_onclick() {

}

// ]]>
</script>


<asp:SqlDataSource ID="sdsReferences" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PMOToolkit_ProjectPortfolio2006ConnectionString %>" 
            SelectCommand="SELECT * FROM Reference WHERE IsDeleted=0 ORDER BY SortOrder"
            InsertCommand="INSERT INTO Reference(ReferenceID, Description, CategoryID, Category) VALUES(@ReferenceID, @Description, @CategoryID, @Category)"
            DeleteCommand="UPDATE Reference SET IsDeleted=1 WHERE ReferenceID=@ReferenceID AND CategoryID=@CategoryID" 
            UpdateCommand="UPDATE Reference SET Description=@Description WHERE ReferenceID=@ReferenceID AND CategoryID=@CategoryID" 
            OnUpdated="sdsReferences_Updated">
    <InsertParameters>
        <asp:ControlParameter name="ReferenceID" controlid="hReferenceID" propertyname="Value"/>
        <asp:ControlParameter name="Description" controlid="hDescription" propertyname="Value" />
        <asp:ControlParameter name="CategoryID" controlid="ddlCategory" propertyname="SelectedValue" />
        <asp:ControlParameter name="Category" controlid="ddlCategory" propertyname="SelectedItem.Text" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="ReferenceID" Type="String" />
        <asp:Parameter Name="CategoryID" Type="String" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="ReferenceID" Type="String" />
        <asp:Parameter Name="CategoryID" Type="String" />
        <asp:Parameter Name="Description" Type="String" />        
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sdsApprovalStatus" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PMOToolkit_ProjectPortfolio2006ConnectionString %>" 
            SelectCommand="SELECT ReferenceID, Description, CategoryID, Category, IsDeleted, IsApproved, IsNull(ReportingCategory, 0) AS ReportingCategory FROM Reference WHERE (IsDeleted = 0) AND (CategoryID = 5) ORDER BY SortOrder"
            InsertCommand="INSERT INTO Reference (ReferenceID, Description, CategoryID, Category) VALUES (@ReferenceID,@Description,@CategoryID,@Category) "
            DeleteCommand="UPDATE Reference SET IsDeleted=1 WHERE ReferenceID=@ReferenceID AND CategoryID=@CategoryID" 
            UpdateCommand="UPDATE Reference SET Description=@Description, ReportingCategory=CASE WHEN @ReportingCategory = 0 THEN NULL ELSE @ReportingCategory END WHERE ReferenceID=@ReferenceID AND CategoryID=@CategoryID" 
            OnUpdated="sdsReferences_Updated">
    <InsertParameters>
        <asp:ControlParameter name="ReferenceID" controlid="hReferenceID" propertyname="Value"/>
        <asp:ControlParameter name="Description" controlid="hDescription" propertyname="Value" />
        <asp:ControlParameter name="CategoryID" controlid="ddlCategory" propertyname="SelectedValue" />
        <asp:ControlParameter name="Category" controlid="ddlCategory" propertyname="SelectedItem.Text" />
        <asp:ControlParameter name="Approved" controlid="hApproved" propertyname="Value" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="ReferenceID" Type="String" />
        <asp:Parameter Name="CategoryID" Type="String" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="ReferenceID" Type="String" />
        <asp:Parameter Name="CategoryID" Type="String" />
        <asp:Parameter Name="Description" Type="String" />        
        <asp:Parameter Name="ReportingCategory" />
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sdsApplications" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PMOToolkit_ProjectPortfolio2006ConnectionString %>" 
            SelectCommand="SELECT * FROM Application WHERE IsDeleted=0"
            InsertCommand="INSERT INTO Application(ApplicationInstanceName, ExternalApplicationID) VALUES(@ApplicationInstanceName, @ExternalApplicationID)"
            DeleteCommand="UPDATE Application SET IsDeleted=1 WHERE ApplicationID=@ApplicationID" 
            UpdateCommand="UPDATE Application SET ApplicationInstanceName=@ApplicationInstanceName, ExternalApplicationID=@ExternalApplicationID WHERE ApplicationID=@ApplicationID">
    <InsertParameters>
        <asp:ControlParameter name="ApplicationInstanceName" controlid="hInsertParameter1" propertyname="Value" />
        <asp:ControlParameter name="ExternalApplicationID" controlid="hInsertParameter2" propertyname="Value" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="ApplicationID" Type="String" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="ApplicationID" Type="String" />
        <asp:Parameter Name="ApplicationInstanceName" Type="String" />
        <asp:Parameter Name="ExternalApplicationID" Type="String" />        
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sdsServers" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PMOToolkit_ProjectPortfolio2006ConnectionString %>" 
            SelectCommand="SELECT * FROM Server WHERE IsDeleted=0"
            InsertCommand="INSERT INTO Server(ServerNodeName, ExternalServerNodeID) VALUES(@ServerNodeName, @ExternalServerNodeID)"
            DeleteCommand="UPDATE Server SET IsDeleted=1 WHERE ServerID=@ServerID" 
            UpdateCommand="UPDATE Server SET ServerNodeName=@ServerNodeName, ExternalServerNodeID=@ExternalServerNodeID WHERE ServerID=@ServerID">
    <InsertParameters>
        <asp:ControlParameter name="ServerNodeName" controlid="hInsertParameter1" propertyname="Value" />
        <asp:ControlParameter name="ExternalServerNodeID" controlid="hInsertParameter2" propertyname="Value" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="ServerID" Type="String" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="ServerID" Type="String" />
        <asp:Parameter Name="ServerNodeName" Type="String" />
        <asp:Parameter Name="ExternalServerNodeID" Type="String" />        
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sdsPrimaryFunctionalDomain" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PMOToolkit_ProjectPortfolio2006ConnectionString %>" 
            SelectCommand="SELECT ReferenceID, Description&#13;&#10;FROM Reference&#13;&#10;WHERE CategoryID = 2 AND ParentReferenceID = ReferenceID AND IsDeleted=0&#13;&#10;union&#13;&#10;SELECT 0, 'Please select'">
</asp:SqlDataSource>

<asp:SqlDataSource ID="sdsFunctionalDomain" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PMOToolkit_ProjectPortfolio2006ConnectionString %>" 
            SelectCommand="SELECT&#9;r.ReferenceID, r.Description, r.CategoryID, r.Category,&#13;&#10;&#9;isnull( r.ParentReferenceID, 0 ) as ParentReferenceID,&#13;&#10;&#9;isnull(&#13;&#10;&#9;&#9; (&#13;&#10;&#9;&#9;&#9;select&#9;pr.Description&#13;&#10;&#9;&#9;&#9;from&#9;Reference pr&#13;&#10;&#9;&#9;&#9;where&#9;pr.ReferenceID = r.ParentReferenceID&#13;&#10;&#9;&#9;&#9;&#9;and pr.CategoryID = r.CategoryID&#13;&#10;&#9;&#9;),&#13;&#10;&#9;&#9;''&#13;&#10;&#9;) AS PrimaryFunctionalDomain,&#13;&#10;&#9;cast( case when r.ParentReferenceID = r.ReferenceID then 1 else 0 end as bit ) as IsPrimaryFunctionalDomain&#13;&#10;FROM&#9;Reference r&#13;&#10;WHERE&#9;r.IsDeleted=0&#13;&#10;ORDER BY r.ReferenceID"
            InsertCommand="INSERT INTO Reference(ReferenceID, Description, CategoryID, Category, ParentReferenceId) VALUES(@ReferenceID, @Description, @CategoryID, @Category, @ParentReferenceId)"
            DeleteCommand="UPDATE Reference SET IsDeleted=1 WHERE ReferenceID=@ReferenceID AND CategoryID=@CategoryID" 
            UpdateCommand="UPDATE Reference SET&#13;&#10;&#9;Description=@Description,&#13;&#10;&#9;ParentReferenceId=(case when @ParentReferenceId = 0 then null else @ParentReferenceId end)&#13;&#10;WHERE&#9;ReferenceID=@ReferenceID&#13;&#10;&#9;AND CategoryID=@CategoryID" 
            OnUpdated="sdsFunctionalDomain_Updated">
    <DeleteParameters>
        <asp:Parameter Name="ReferenceID" Type="String" />
        <asp:Parameter Name="CategoryID" Type="String" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="Description" Type="String" />
        <asp:Parameter Name="ParentReferenceId" Type="String" />
        <asp:Parameter Name="ReferenceID" Type="String" />
        <asp:Parameter Name="CategoryID" Type="String" />
    </UpdateParameters>
    <InsertParameters>
        <asp:ControlParameter name="ReferenceID" controlid="hReferenceID" propertyname="Value"/>
        <asp:ControlParameter name="Description" controlid="hDescription" propertyname="Value" />
        <asp:ControlParameter name="CategoryID" controlid="ddlCategory" propertyname="SelectedValue" />
        <asp:ControlParameter name="Category" controlid="ddlCategory" propertyname="SelectedItem.Text" />
        <asp:ControlParameter ControlID="hInsertParameter1" Name="ParentReferenceId" PropertyName="Value" />
    </InsertParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sdsSponsors" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PMOToolkit_ProjectPortfolio2006ConnectionString %>" 
            SelectCommand="SELECT SponsorID, Name, Owner, shortname, sortorder FROM Sponsor"
            InsertCommand="INSERT INTO Sponsor(Name, Owner, shortname) VALUES(@Name, @Owner, @shortname)"
            UpdateCommand="UPDATE Sponsor SET Name=@Name, Owner=@Owner, shortname=@shortname, sortorder=@sortorder WHERE SponsorID=@SponsorID">
    <InsertParameters>
        <asp:ControlParameter name="Name" controlid="hInsertParameter1" propertyname="Value" />
        <asp:ControlParameter name="Owner" controlid="hInsertParameter2" propertyname="Value" />
        <asp:ControlParameter name="shortname" controlid="hDescription" propertyname="Value" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="SponsorID" Type="String" />
        <asp:Parameter Name="Name" Type="String" />
        <asp:Parameter Name="Owner" Type="String" />
        <asp:Parameter Name="shortname" Type="String" />
        <asp:Parameter Name="sortorder" Type="String" />      
    </UpdateParameters>
</asp:SqlDataSource>




<table width="100%">
	<tr class="ms-WPHeader">
		<td colspan="4" class="controltitle">Edit Static Data</td>
	</tr>
</table>
<table id="TABLE1" onclick="return TABLE1_onclick()">
    <tr style="height:5px;">
        <td style="width: 12px"></td>
        <td colspan="2">
            <asp:HiddenField runat="Server" id="hReferenceID" /> 
            <asp:HiddenField runat="Server" id="hDescription" /> 
            <asp:HiddenField runat="Server" id="hInsertParameter1" /> 
            <asp:HiddenField runat="Server" id="hInsertParameter2" /> 
            <asp:HiddenField runat="server" ID="hApproved" />
        </td>
        <td></td>
    </tr>
    <tr>
        <td style="width: 12px"></td>
        <td class="summarylabel" style="width: 109px">
            Category: 
        </td>
        <td style="width: 220px;">
            <asp:DropDownList runat="server" id="ddlCategory" CssClass="textselect" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
        </td>
        <td></td>
    </tr>
    <tr style="height:5">
        <td style="width: 12px">
        </td>
        <td class="summarylabel" style="width: 12px">
            <asp:Label ID="lblPrimaryFunctionalDomainPicker" runat="server" Text="Primary Functional Domain:" Width="200px"></asp:Label></td>
        <td style="width: 12px">
            <asp:DropDownList ID="ddlPrimaryFunctionalDomainPicker" runat="server" AutoPostBack="True"
                DataSourceID="sdsPrimaryFunctionalDomain" DataTextField="Description" DataValueField="ReferenceID" OnSelectedIndexChanged="ddlPrimaryFunctionalDomainPicker_SelectedIndexChanged" CssClass="textselect">
            </asp:DropDownList></td>
    </tr>
    <tr style="height: 5px;">
        <td colspan="4"></td>
    </tr>
    <tr>
        <td style="width: 12px"> </td>
        <td colspan="2">
            <asp:GridView ID="gvReferences" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ReferenceID,CategoryID" DataSourceID="sdsReferences" 
                            CssClass="def"  CellPadding="3" CellSpacing="3" BorderStyle="Solid" BorderWidth="1px" OnRowCancelingEdit="gvReferences_RowCancelingEdit" 
                            AllowPaging="True" PageSize="20" OnPreRender="gvReferences_PreRender" OnRowDataBound="gvReferences_RowDataBound">
                <Columns>
                    <asp:CommandField ButtonType="Image" ShowDeleteButton="True" DeleteImageUrl="~/Images/delete.gif"/>
                    <asp:BoundField DataField="ReferenceID" HeaderText="ID" ReadOnly="True" SortExpression="ReferenceID" >
                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                        <HeaderStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                        <ItemStyle Width="350px" />
                    </asp:BoundField>
                    <asp:CommandField ShowEditButton="True" UpdateText="Confirm" />
                </Columns> 
                <PagerSettings Mode="NextPreviousFirstLast" />
                <PagerStyle HorizontalAlign="Right">
                </PagerStyle>
            </asp:GridView>

            <asp:GridView ID="gvApplications" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ApplicationID" DataSourceID="sdsApplications" 
                           Visible="false" CssClass="def"  CellPadding="3" CellSpacing="3" BorderStyle="Solid" BorderWidth="1px"
                            AllowPaging="True" PageSize="20" OnPreRender="gvApplications_PreRender" OnRowCancelingEdit="gvApplications_RowCancelingEdit" OnRowDataBound="gvApplications_RowDataBound">
                <Columns>
                    <asp:CommandField ButtonType="Image" ShowDeleteButton="True" DeleteImageUrl="~/Images/delete.gif"/>
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="300px" DataField="ApplicationInstanceName" HeaderText="Application Instance Name" SortExpression="ApplicationInstanceName" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="150px" DataField="ExternalApplicationID" HeaderText="Application ID" SortExpression="ExternalApplicationID" />
                    <asp:CommandField ButtonType="Link" ShowEditButton="true" EditText="Edit" UpdateText="Confirm" />
                </Columns> 
                <PagerSettings Mode="NextPreviousFirstLast" />
                <PagerStyle HorizontalAlign="Right" CssClass="Pager" />
            </asp:GridView>

            <asp:GridView ID="gvServers" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ServerID" DataSourceID="sdsServers" 
                          Visible="false" CssClass="def"  CellPadding="3" CellSpacing="3" BorderStyle="Solid" BorderWidth="1px"
                            AllowPaging="True" PageSize="20" OnPreRender="gvServers_PreRender" OnRowCancelingEdit="gvServers_RowCancelingEdit" OnRowDataBound="gvServers_RowDataBound">
                <Columns>
                    <asp:CommandField ButtonType="Image" ShowDeleteButton="True" DeleteImageUrl="~/Images/delete.gif"/>
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="300px" DataField="ServerNodeName" HeaderText="Server Node Name" SortExpression="ServerNodeName" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="150px" DataField="ExternalServerNodeID" HeaderText="Server Node ID" SortExpression="ExternalServerNodeID" />
                    <asp:CommandField ButtonType="Link" ShowEditButton="true" EditText="Edit" UpdateText="Confirm"  />
                </Columns> 
                <PagerSettings Mode="NextPreviousFirstLast" />
                <PagerStyle HorizontalAlign="Right" CssClass="Pager" />
            </asp:GridView>
                        
            <asp:GridView ID="gvSponsors" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="SponsorID" DataSourceID="sdsSponsors" 
                          Visible="false" CssClass="def"  CellPadding="3" CellSpacing="3" BorderStyle="Solid" BorderWidth="1px"
                            AllowPaging="True" PageSize="20" OnPreRender="gvSponsors_PreRender" OnRowCancelingEdit="gvSponsors_RowCancelingEdit" OnRowDataBound="gvSponsors_RowDataBound">
                <Columns>
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" DataField="SponsorID" HeaderText="ID" SortExpression="SponsorID" ReadOnly="true"/>
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" DataField="Owner" HeaderText="Owner" SortExpression="Owner" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" DataField="shortname" HeaderText="Shortname" SortExpression="shortname" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Left" DataField="sortorder" HeaderText="Sort Order" SortExpression="sortorder" />
                    <asp:CommandField ButtonType="Link" ShowEditButton="true" EditText="Edit" UpdateText="Confirm"  />
                </Columns> 
                <PagerSettings Mode="NextPreviousFirstLast" />
                <PagerStyle HorizontalAlign="Right" CssClass="Pager" />
            </asp:GridView>
            
            
            
            
            
            
            &nbsp;
        </td>
    </tr>
    <tr>
        <td style="width: 12px">
        </td>
        <td colspan="2">
            
            <asp:GridView ID="gvFunctionalDomain" runat="server" AutoGenerateColumns="False" DataKeyNames="ReferenceID,CategoryID" DataSourceID="sdsFunctionalDomain" 
                            CssClass="def"  CellPadding="3" CellSpacing="3" BorderStyle="Solid" BorderWidth="1px" OnRowCancelingEdit="gvFunctionalDomain_RowCancelingEdit" OnPreRender="gvFunctionalDomain_PreRender" OnRowDataBound="gvFunctionalDomain_RowDataBound" Visible="False" PageSize="15" OnRowUpdating="gvFunctionalDomain_RowUpdating">
                <PagerSettings Mode="NumericFirstLast" />
                <Columns>
                    <asp:CommandField ButtonType="Image" ShowDeleteButton="True" DeleteImageUrl="~/Images/delete.gif"/>
                    <asp:BoundField DataField="ReferenceID" HeaderText="ID" ReadOnly="True"  SortExpression="ReferenceID" >
                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                        <HeaderStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                        <ItemStyle Width="350px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Primary Functional Domain" SortExpression="PrimaryFunctionalDomain">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlPrimaryFunctionalDomain" runat="server" SelectedValue='<%# Bind("ParentReferenceId") %>' DataSourceID="sdsPrimaryFunctionalDomain" DataTextField="Description" DataValueField="ReferenceID">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlPrimaryFunctionalDomain" runat="server" SelectedValue='<%# Bind("ParentReferenceId") %>' Enabled="False" DataSourceID="sdsPrimaryFunctionalDomain" DataTextField="Description" DataValueField="ReferenceID">
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Is Primary" SortExpression="IsPrimaryFunctionalDomain">
                        <EditItemTemplate>
                            <asp:CheckBox ID="cbxIsPrimary" runat="server" Checked='<%# Eval("IsPrimaryFunctionalDomain") %>'/>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="cbxIsPrimary" runat="server" Checked='<%# Eval("IsPrimaryFunctionalDomain") %>' Enabled="false"/>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" UpdateText="Confirm" />
                    <asp:BoundField DataField="ReferenceID" HeaderText="ReferenceID" ReadOnly="True"
                        Visible="False" />
                    <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="ParentReferenceID" HeaderText="OriginalParentReferenceID"
                        Visible="False" />
                </Columns>
                <PagerStyle HorizontalAlign="Right" />
            </asp:GridView>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td style="width: 12px">
        </td>
        <td colspan="2">
            &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;
            <asp:GridView ID="gvApprovalStatuses" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ReferenceID,CategoryID" DataSourceID="sdsApprovalStatus" 
                            CssClass="def"  CellPadding="3" CellSpacing="3" BorderStyle="Solid" BorderWidth="1px" OnRowCancelingEdit="gvApprovalStatuses_RowCancelingEdit" 
                            AllowPaging="True" PageSize="20" OnPreRender="gvApprovalStatuses_PreRender" OnRowDataBound="gvApprovalStatuses_RowDataBound" Visible="False">
                <PagerSettings Mode="NextPreviousFirstLast" />
                <Columns>
                    <asp:CommandField ButtonType="Image" ShowDeleteButton="True" DeleteImageUrl="~/Images/delete.gif"/>
                    <asp:BoundField DataField="ReferenceID" HeaderText="ID" ReadOnly="True"  SortExpression="ReferenceID" >
                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                        <HeaderStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                        <ItemStyle Width="350px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Reporting Category" SortExpression="ReportingCategory">
                        <EditItemTemplate>
                           <asp:DropDownList ID="ddlReportingCategory" runat="server" SelectedValue='<%# Bind("ReportingCategory") %>'>
                                <asp:ListItem Value="0">Please select</asp:ListItem>
                                <asp:ListItem Value="1">Approved</asp:ListItem>
                                <asp:ListItem Value="2">Not Approved</asp:ListItem>
                                <asp:ListItem Value="3">Neutral</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                           <asp:DropDownList ID="ddlReportingCategory" runat="server" SelectedValue='<%# Bind("ReportingCategory") %>' Enabled="false">
                                <asp:ListItem Value="0">Please select</asp:ListItem>
                                <asp:ListItem Value="1">Approved</asp:ListItem>
                                <asp:ListItem Value="2">Not Approved</asp:ListItem>
                                <asp:ListItem Value="3">Neutral</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" UpdateText="Confirm" />
                </Columns>
                <PagerStyle HorizontalAlign="Right" />
            </asp:GridView>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td style="width: 12px"></td>
        <td colspan="2">
            <asp:Button CssClass="button" runat="server" id="btnNew" Text="New Value" OnClick="btnNew_Click" />
        </td>
        <td></td>
    </tr>
</table>