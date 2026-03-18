<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SectionJ.ascx.cs" Inherits="Controls_SectionJ" %>
<script language="javascript">

function popupWindowProject(initiativeID, prjID)
{
	var dialogwidth = 440
	var dialogheight = 430
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"

	var returnCode;
	
	if(prjID==0)
	{
	    returnCode = window.showModalDialog("Project.aspx?InitiativeID=" + initiativeID,  
					        "project_dialog", "dialogWidth:430px;dialogHeight:440px;status:no;resizable:no;scroll:yes");
	}
	else
	{
	    returnCode=window.showModalDialog("Project.aspx?InitiativeID=" + initiativeID + "&ProjectID=" + prjID, 
            					"project_dialog", "dialogWidth:500px;dialogHeight:440px;status:no;resizable:no;scroll:yes");
    }
    
    if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            AllowOneTimeSubmit();
            window.document.forms[0].submit();
        }
    }
}

function popupImportProjects(initiativeID)
{
	var dialogwidth = 440
	var dialogheight = 430
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"

	returnCode=window.showModalDialog("ProjectsImport.aspx?InitiativeID=" + initiativeID,  
					        "project_dialog", "dialogWidth:600px;dialogHeight:440px;status:no;resizable:no;scroll:yes");	
					        
	if (returnCode==1)
    {
        if(window.document.forms[0].onsubmit())
        {
            AllowOneTimeSubmit();
            window.document.forms[0].submit();
        }
    }				        
    
}
</script>

<table class="def">
	<tr class="ms-WPHeader">
		<td class="controltitle" width="1000" colSpan="3">J) Initiative Financial BEN Reconciliation</td>
	</tr>
	<tr>
		<td colSpan="3" height="5"></td>
	</tr>
	<tr>
	    <td style="width: 3px; height: 229px"></td>
	    <td align="left" style="width: 887px; height: 229px">
				<asp:repeater id="repeaterProject" EnableViewState="False" runat="server" OnItemCommand="repeaterProject_ItemCommand" OnItemDataBound="repeaterProject_ItemDataBound">
					<HeaderTemplate>
					<table cellSpacing="0" cellPadding="2" style="border-collapse: collapse; border-color: #CCCCCC;">
						<tr height="20">
							<td class="headcell" style="border-left: 1px solid #CCCCCC;  border-top: 1px solid #CCCCCC;" width="90"><asp:Label id="lblProjectID" runat="server"></asp:Label></td>
							<td class="headcell" style="border-top: 1px solid #CCCCCC; text-align:left;" width="190"><asp:Label id="lblProjectName" runat="server"></asp:Label></td>
							<td class="headcell" style="border-top: 1px solid #CCCCCC;" width="155"><asp:Label id="lblProjectDesc" runat="server"></asp:Label></td>
							<td class="headcell" style="border-top: 1px solid #CCCCCC;" width="190"><asp:Label id="lblProgramName" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;" width="80"><asp:Label id="lblProjectType" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;" width="135"><asp:Label id="lblIGAmount" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;" width="135"><asp:Label id="lblTotalEUR" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;" width="135"><asp:Label id="lblIGApproval" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;" width="135"><asp:Label id="lblTotalLocal" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC;" width="135"><asp:Label id="lblBaseCurrency" runat="server"></asp:Label></td>
							<td class="headcell" style="text-align:center; border-top: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC;" width="135"><asp:Label id="lblFXRate" runat="server"></asp:Label></td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr height="20">
						    <td class="incell">
						        <table>
						            <tr>
						                <td> <asp:ImageButton runat="server" ID="delProjectID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeProjectID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td> 
							            <td class="incell"><%# DataBinder.Eval(Container.DataItem,"ExternalProjectID")%></td>
							        </tr>
							     </table>
							</td>
							<td class="incell"><a runat="server" id="lnkEditProject" href="#" onclick='<%# "javascript:popupWindowProject(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeProjectID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"ProjectName")%></a></td>
							<td class="incell"><%# DataBinder.Eval(Container.DataItem,"ProjectDescription")%></td>
							<td class="incell"><%# DataBinder.Eval(Container.DataItem,"ProgramName")%></td>
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"ProjectType")%></td>
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "IGAmountRequested", "{0:C}")%></td>
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "TotalPlanEUR", "{0:C}")%></td>
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem,"PercentRequired").ToString()+" %"%></td>					
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem, "TotalPlanLocalCurrency", "{0:C}")%></td>	
							<td class="incell" align="center"><%# DataBinder.Eval(Container.DataItem,"BaseCurrency")%></td>	
							<td class="incell" align="right"><%# DataBinder.Eval(Container.DataItem,"FXRate")%></td>	
	                </tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr height="20">
						    <td class="alternateincell">
						        <table>
						            <tr>
						                <td> <asp:ImageButton runat="server" ID="delProjectID" ImageUrl="~/Images/delete.gif" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"InitiativeProjectID")%>' CommandName="Delete" CausesValidation="false"></asp:ImageButton></td> 
							            <td class="alternateincell"><%# DataBinder.Eval(Container.DataItem,"ExternalProjectID")%></td>
							        </tr>
							     </table>
							</td>
							<td class="alternateincell"><a runat="server" id="lnkEditProject" href="#" onclick='<%# "javascript:popupWindowProject(" + DataBinder.Eval(Container.DataItem,"InitiativeID") + ", " + DataBinder.Eval(Container.DataItem,"InitiativeProjectID") + "); return false; "%>'><%# DataBinder.Eval(Container.DataItem,"ProjectName")%></a></td>
							<td class="alternateincell"><%# DataBinder.Eval(Container.DataItem,"ProjectDescription")%></td>
							<td class="alternateincell"><%# DataBinder.Eval(Container.DataItem,"ProgramName")%></td>
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"ProjectType")%></td>
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "IGAmountRequested", "{0:C}")%></td>
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "TotalPlanEUR", "{0:C}")%></td>
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem,"PercentRequired").ToString()+" %"%></td>					
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem, "TotalPlanLocalCurrency","{0:C}")%></td>	
							<td class="alternateincell" align="center"><%# DataBinder.Eval(Container.DataItem,"BaseCurrency")%></td>	
							<td class="alternateincell" align="right"><%# DataBinder.Eval(Container.DataItem,"FXRate")%></td>	
						</tr>
					</AlternatingItemTemplate>
					<FooterTemplate>
					    <tr height="20px">
					        <td colspan="5" class="emptycell" style="border-left: 1px solid #CCCCCC;  border-bottom: 1px solid #CCCCCC; background-color:#ffcc00; font-weight:bold;" ></td>
					        <td class="totalcell" align="right"><%# GetIGAmountRequested()%></td>
					        <td class="totalcell" align="right"><%# GetTotalPlan()%></td>
					        <td colspan="4" class="emptycell" style="border-right: 1px solid #CCCCCC;  border-bottom: 1px solid #CCCCCC; background-color:#ffcc00; font-weight:bold;"></td>
					    </tr>
						<tr>
						    <td class="empty" height="0px" colspan="11"></td>
						</tr>					
					</table>
					</FooterTemplate>
				</asp:repeater>
            <button runat="server" id="btnAddMultipleProjects" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button" visible="false">Add Multiple Projects</button>&nbsp;&nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            </td>
		<td style="height: 229px"></td>
		<td style="height: 229px; width: 3px;"></td>
	</tr>
</table>
<br>
<table width="100%" class="def">
    <tr>
        <td align="left" colspan="1" style="width: 25%">
            &nbsp; <span style="text-decoration: underline">Add Single Project</span></td>
        <td align="left" colspan="1" style="width: 75%">
            <span style="text-decoration: underline">Add Multiple Projects</span></td>
    </tr>
    <tr>
        <td align="left" colspan="1" style="width: 25%">
            1. 
			<button runat="server" id="btnAddProject" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" type="button">Add Project</button></td>
        <td align="left" colspan="1" style="width: 75%">
            1.
            Download Excel Template and Save to Local Drive.
            <asp:Image ID="Image1" runat="server" Height="16px" ImageUrl="~/Images/iconExcel.gif" Width="19px" />&nbsp;
            <asp:LinkButton ID="DownLoadTemplate" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" runat="server" OnClick="DownLoadTemplate_Click">DownLoad Template</asp:LinkButton></td>
    </tr>
    <tr>
        <td align="left" colspan="1" style="width: 25%">
            &nbsp; &nbsp;&nbsp;
        </td>
        <td align="left" colspan="1" style="width: 75%">
            <asp:GridView ID="gvProjects" runat="Server" OnPageIndexChanging="gvProjects_PageIndexChanging"
                PagerSettings-Mode="NextPrevious" PagerSettings-NextPageText="Next..." PagerSettings-PreviousPageText="Prev..."
                PageSize="5" Visible="False">
                <PagerSettings Mode="NextPrevious" NextPageText="Next..." PreviousPageText="Prev..." />
                <RowStyle BackColor="White" />
                <PagerStyle Font-Bold="True" HorizontalAlign="Right" />
                <HeaderStyle BackColor="Navy" Font-Bold="True" Font-Size="Smaller" ForeColor="White" />
                <AlternatingRowStyle BackColor="Gainsboro" Wrap="True" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td align="left" colspan="1" style="width: 25%">
        </td>
        <td align="left" colspan="1" style="width: 75px">
        </td>
    </tr>
    <tr>
        <td align="left" colspan="1" style="width: 25%; height: 21px;" valign="bottom">
            </td>
        <td align="left" colspan="1" style="width: 75%; height: 21px;" valign="bottom">
            2.
            Browse For Saved File.<asp:FileUpload ID="FileUpload1" runat="server" CssClass="def" /></td>
    </tr>
    <tr>
        <td align="left" colspan="1" style="width: 25%">
        </td>
        <td align="left" colspan="1" style="width: 75%">
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td align="left" colspan="1" style="width: 25%">
            </td>
        <td align="left" colspan="1" style="width: 75%">
            3. Upload File.
            <asp:Button ID="btnPopGrid" runat="server" CssClass="def" EnableViewState="False"
                OnClick="btnPopGrid_Click" Text="Upload Data" />
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td align="left" colspan="1" style="width: 25%">
            &nbsp; &nbsp;&nbsp;
        </td>
        <td align="left" colspan="1" style="width: 75%">
        </td>
    </tr>
    <tr>
        <td align="left" colspan="1" style="width: 25%">
            </td>
        <td align="left" colspan="1" style="width: 75%">
            4. Confirm and Save Project Data.
            <asp:Button ID="btnSaveProjects" runat="server" CssClass="def" Enabled="False" EnableViewState="False"
                OnClick="btnSaveProjects_Click" Text="Save Projects" /></td>
    </tr>
</table>

