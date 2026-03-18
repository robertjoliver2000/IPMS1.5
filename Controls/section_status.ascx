<%@ Control Language="C#" AutoEventWireup="true" CodeFile="section_status.ascx.cs" Inherits="ProjectPortfolio.Controls.section_status" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr class="ms-WPHeader">
		<td class="controltitle">STATUS) Workflow Actions</td>
	</tr>
	<tr>
	    <td align="left">
            <table border="0" id="SubmitTable" runat="server">
	            <tr>
		            <td colspan="5" height="5"></td>
	            </tr>
	            <tr>
		            <td class="summarylabel" width="220px">&nbsp;1) SUBMIT FOR APPROVAL:</td>
		            <td class="summarylabel" width="170px"><asp:Button runat="server" ID="btnSubmit" Text="Submit for Review" Width="150px" CssClass="button" OnClick="btnSubmit_Click" ValidationGroup="SubmitForReview"/></td>
		            <td width="15px"></td>
	            </tr>
            </table>
            <table border="0" id="ApprovalTable" runat="server">
	            <tr>
		            <td colspan="5" style="height: 5px"></td>
	            </tr>
	            <tr>
		            <td class="summarylabel" width="220px">&nbsp;1) NEW STATUS:</td>
		            <td><asp:DropDownList Runat="server" ID="ddlIGApprovalStatus" CssClass="textselect" Width="180px"></asp:DropDownList></td>
		            <td width="40px"></td>
		            <td class="summarylabel">
		                <button id="btnChangeStatus" onclick="submitChangeStatus()">Accept Status</button>
	                    <asp:Button runat="server" style="visibility: hidden" ID="btnNewStatus" Text="" Width="150px" CssClass="button" OnClick="btnNewStatus_Click" ValidationGroup="SubmitForReview"/>
	                    <asp:Button runat="server" style="visibility: hidden" ID="btnDraftStatus" Text="" Width="150px" CssClass="button" OnClick="btnNewStatus_Click" ValidationGroup=""/>
		            </td>
		                
		            <td width="15px"></td>
	            </tr>
            </table>
        </td>
     </tr>
</table>
<asp:ValidationSummary ID="WorkflowValidationSummary" runat="server" ValidationGroup="SubmitForReview" />
<script>
function moveStatus() {
    var dropDown=document.forms[0]["ctlWorkflowAction:ctlSectionStatus:ddlIGApprovalStatus"];
    var textStatus=document.forms[0]["ctlWorkflowAction:ctlSectionD:txtIGApprovalStatus"]
    var intStatus=document.forms[0]["ctlWorkflowAction:ctlSectionD:txtIGApprovalStatusID"]
    textStatus.value=dropDown.options[dropDown.selectedIndex].text;
    intStatus.value=dropDown.options[dropDown.selectedIndex].value;
}

function assignMoveStatus() {
    if (document.forms[0]["ctlWorkflowAction:ctlSectionStatus:btnNewStatus"])
        Events_chainEvent(document.forms[0]["ctlWorkflowAction:ctlSectionStatus:btnNewStatus"], "onclick", "moveStatus()");
}

Events_chainEvent(document.body, "onload", "assignMoveStatus()");
</script>


<script language="javascript" type="text/javascript">

function disableWorkflowButton()
{
	var ctl;
	ctl = document.getElementById( "btnChangeStatus" )
	if ( !ctl ) ctl = document.getElementById( "ctlWorkflowAction_ctlSectionStatus_btnSubmit" )
	if ( !ctl ) ctl = document.getElementById( "ctlReview_WorkflowAction_ctlSectionStatus_btnSubmit" );
	if ( ctl )
		ctl.disabled = true;
}

disableWorkflowButton();

</script>
