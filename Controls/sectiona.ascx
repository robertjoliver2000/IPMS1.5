<%@ Control Language="c#" Inherits="ProjectPortfolio.Controls.SectionA" CodeFile="SectionA.ascx.cs" %>
<%@ Register Src="ImageDdl.ascx" TagName="ImageDdl" TagPrefix="uc2" %>
<%@ Register Src="PPR_Status_DDL.ascx" TagName="PPR_Status_DDL" TagPrefix="uc1" %>
<script src="Js/utils.js" language="javascript" type="text/javascript" ></script>
<script src="Js/ImageDdl.js" language="javascript" type="text/javascript" ></script>
<xscript language="javascript" type="text/javascript">
<!--
function toggleMenu( childElt )
{
    //debugger;
    if ( childElt )
    {
        var par = childElt.parentNode;
        while( par )
        {
            if( par.className == 'imageddl' )
            {
                par.className = 'imageddlclosed';
                break;   
            }
            else if( par.className == 'imageddlclosed' )
            {
                par.className = 'imageddl';
                break;   
            }
            else
            {
                par = par.parentNode;
            }
        }
    }
    window.event.cancelBubble = true;
    return false;
}


function doSelect( childElt )
{
    if ( childElt )
    {
        var par = childElt.parentNode;
        while( par )
        {
            if( par.className == 'imageddl' )
            {
                break;   
            }
            else if( par.className == 'imageddlclosed' )
            {
                break;   
            }
            else
            {
                par = par.parentNode;
            }
        }
        
        if( par )
        {
            var topImg = par.getElementsByTagName( 'IMG' )[ 0 ];
            var selImg = childElt.getElementsByTagName( 'IMG' )[ 0 ];
            
            topImg.src = selImg.src;
            topImg.alt = selImg.alt;
            
            var hdn = par.getElementsByTagName( 'INPUT' )[ 0 ];
            var hdnId = par.getElementsByTagName( 'INPUT' )[ 1 ];
            var status = topImg.alt.substring( 4 );

            switch( status )
            {
                case 'Red':     hdn.value = status; hdnId.value = '3'; break;
                case 'Amber':   hdn.value = status; hdnId.value = '2'; break;
                case 'Green':   hdn.value = status; hdnId.value = '1'; break;
                default:        hdn.value = 'Please select'; hdnId.value = '0'; break;
            }
            
            // get summary elt id from par
            // recalcSummary( summaryEltId );
        }
    }

    toggleMenu( childElt );

    return false;

}


function recalcSummary( summaryEltId )
{
    try
    {
        var summaryElt = document.getElementById( summaryEltId );
        var overall = 0;
        var subs = summaryElt.getAttribute( "Summarises" ).split( "," );
        var subElt;
        var subValue;
        for ( var i = 0; i < subs.length; i++ )
        {
            subElt = document.getElementById( subs[ i ] );
            if ( subElt )
            {
                subValue = subElt.getElementsByTagName[ 1 ].value;
                if ( subValue > overall ) overall = subValue;
            }
        }
        
        // apply overall to control
        // ...
        
    }
    catch( e )
    {
        // do nothing
    }

}
-->
</xscript>
<script language="javascript" type="text/javascript">

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

function popupWindowSelectApplication(initiativeID, txtBoxID, txtBox2ID, hiddenTxtBoxID, lblInvestmentStrategyID, hInvestmentStrategyID)
{
     var dialogwidth = 340
	var dialogheight = 445
	var leftpos = (screen.width - dialogwidth) / 2
	var toppos = (screen.height - dialogheight) / 2
	var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		dialogwidth + ",height=" + dialogheight + 
		",titlebar=no,status=no,dependent=yes"
  
	dlgwindow = window.open("SelectItem.aspx?InitiativeID=" + initiativeID + "&CategoryID=2&ControlID="+txtBoxID+"&Control2ID="+txtBox2ID+"&HiddenControlID="+hiddenTxtBoxID+"&Control3ID="+lblInvestmentStrategyID+"&Control4ID="+hInvestmentStrategyID, 
					"selectitem_dialog", attr)
					
	dlgwindow.focus();
}
</script>

<!-- for PPR Select -->
<script type="text/javascript" language="javascript">

function doHide( elt )
{
	elt.style[ "display" ] = "none";
}

function doShow( childElt)
{
    var ifr = childElt.parentNode.getElementsByTagName( 'IFRAME' )[ 0 ];
    ifr.src = "imagelist.html?targetId=" + childElt.id;
	ifr.style[ "display" ] = "block"; 
}

function doSelect( elt, calledUrl )
{
	var img = elt.getElementsByTagName( 'IMG' )[ 0 ];
	
	try
	{
	    var args = calledUrl.split( '=' );
	    var targetId = args[ args.length - 1 ];
	    var targetElt = document.getElementById( targetId );
	    
	    doHide( targetElt.parentNode.getElementsByTagName( 'IFRAME' )[ 0 ] );

	    var targetImg = targetElt.parentNode.getElementsByTagName( 'IMG' )[ 0 ];
	    targetImg.src = img.src;
	    targetImg.alt = img.alt;
	    targetImg.title = targetImg.alt;
	    
		var newId, newText;
	    switch( img.alt.substring( img.alt.length - 4 ).toLowerCase() )
	    {
	        case " red": newId = 3; newText = "Red";	break;
			case "mber": newId = 2; newText = "Amber";	break;
			case "reen": newId = 1; newText = "Green";	break;
			default : newId = 0; newText = "Please select"; break;
	    }

	    targetElt.parentNode.getElementsByTagName( 'INPUT' )[ 0 ].value = newText;
	    targetElt.parentNode.getElementsByTagName( 'INPUT' )[ 1 ].value = newId;

        recalcOverall( targetElt.parentNode.getElementsByTagName( 'INPUT' )[ 1 ] );
        
        SetDirtyFlag();

    }
    catch( e )
	{
	}
}

function recalcOverall( elt )
{
    try
    {
        var parts = elt.id.split( '_' );
        var tail = parts[ parts.length - 1 ];
        var eltMeasureName = tail.substring( 0, tail.length - 8 );
        
        if ( eltMeasureName != 'Overall' )
        {
            var calcdStatus = "0";
            var oneMeasureElt;
            var measureIdPrefix = elt.id.substring( 0, elt.id.length - eltMeasureName.length - 15);
            var measureNames = [ 'Cost', 'Deliverables', 'Time', 'Risks', 'Benefits' ];
            
            for ( var i = 0; i < measureNames.length; i++ )
            {
                oneMeasureElt = document.getElementById( measureIdPrefix + 'hdnPPR_' + measureNames[ i ] + 'StatusId');
                if ( oneMeasureElt.value > calcdStatus ) calcdStatus = oneMeasureElt.value;
            }
            
            var newStatusId, newStatus, newSrc, newAlt;
            
            switch( calcdStatus )
            {
                case "3": newStatusId = calcdStatus; newStatus = "Red"; break;
                case "2": newStatusId = calcdStatus; newStatus = "Amber"; break;
                case "1": newStatusId = calcdStatus; newStatus = "Green"; break;
                default: newStatusId = "0"; newStatus = "Please select"; break;
            }
            
            if ( newStatusId == "0" )
            {
                newSrc = "PPR_Grey.gif";
                newAlt = "- - Please select";
            }
            else
            {
                newSrc = "PPR_" + newStatus + ".gif";
                newAlt = newStatus.charAt( 0 ) + " - " + newStatus;
            }
            
            newSrc = "Images/" + newSrc;
            
            document.getElementById( measureIdPrefix + 'hdnPPR_OverallStatusId').value = newStatusId;
            document.getElementById( measureIdPrefix + 'hdnPPR_OverallStatus').value = newStatus;

            var overallImg = document.getElementById( measureIdPrefix + 'imgPPR_Overall');

            overallImg.src = newSrc;
            overallImg.alt = newAlt;
            overallImg.title = overallImg.alt;
        }
    }
    catch ( e )
    {
    }
}

</script>
<table cellpadding="0" cellspacing="0" border="0"  style="position:relative; display:block;">
	<tr class="ms-WPHeader">
		<td colspan="5" class="controltitle" style="height: 19px">A) Initiative Header - Summary Detail</td>
	</tr>
     <tr>
        <td align="center" style="width: 2395px">
            <table border="0" xstyle="position:relative; display:block;">
	            <tr>
		            <td colspan="7" height="5"></td>
	            </tr>
	            <tr>
		            <td class="summarylabel">&nbsp;1) PERFORMANCE STATUS:
		            <%--
	                    <table style="position:relative; display:block; z-index:1000;">
	                        <tr><th>O</th><th>C</th><th>D</th><th>T</th><th>R/I</th><th>B</th></tr>
	                        <tr><td>
                                <uc2:ImageDdl ID="ddlPPROverall" runat="server" />
                            </td><td>
                                <uc2:ImageDdl ID="ddlPPRCost" runat="server" />
                            </td><td>
                                <uc2:ImageDdl ID="ddlPPRDelivery" runat="server" />
                            </td><td>
                                <uc2:ImageDdl ID="ddlPPRTime" runat="server" />
                            </td><td>
                                <uc2:ImageDdl ID="ddlPPRRisks" runat="server" />
                            </td><td>
                                <uc2:ImageDdl ID="ddlPPRBenefits" runat="server" />
                            </td></tr>
	                    </table>
	                --%>
	                </td><td>
	                <table class="topPositionRelative PPRSelect" cellspacing="0" cellpadding="0" style="margin-left:-5px;">
                        <tr class="summarylabel">
                            <th>O</th>
                            <th style="width: 15px">&nbsp; &nbsp; &nbsp; &nbsp;
                            </th>
                            <th>C</th>
                            <th>D</th>
                            <th>T</th>
                            <th>R/I</th>
                            <th>
                                B</th>
                        </tr>
                        <tr>
                            <td style="width:30px;"><a runat="server" onclick="doShow( this ); return false;" id="lnkO"><asp:Image runat="server" ID="imgPPR_Overall" style="border:none; padding-left:10px;" /><img src="Images/Expand_tiny.gif" class="ddl_flag" alt="expand" /></a><asp:HiddenField ID="hdnPPR_OverallStatus" runat="server" /><asp:HiddenField ID="hdnPPR_OverallStatusID" runat="server" /><iframe scrolling="no" onmouseout="doHide( this );" src="imagelist.html" frameborder="0"></iframe></td>
                            <td style="width: 10px"></td>
                            <td style="width:30px;"><a runat="server" onclick="doShow( this ); return false;" id="lnkC"><asp:Image runat="server" ID="imgPPR_Cost" style="border:none; padding-left:10px;" /><img src="Images/Expand_tiny.gif" class="ddl_flag" alt="expand" /></a><asp:HiddenField ID="hdnPPR_CostStatus" runat="server" /><asp:HiddenField ID="hdnPPR_CostStatusID" runat="server" /><iframe scrolling="no" onmouseout="doHide( this );" src="imagelist.html" frameborder="0"></iframe></td>
                            <td style="width:30px;"><a runat="server" onclick="doShow( this ); return false;" id="lnkD"><asp:Image runat="server" ID="imgPPR_Deliverables" style="border:none; padding-left:10px;" /><img src="Images/Expand_tiny.gif" class="ddl_flag" alt="expand" /></a><asp:HiddenField ID="hdnPPR_DeliverablesStatus" runat="server" /><asp:HiddenField ID="hdnPPR_DeliverablesStatusID" runat="server" /><iframe scrolling="no" onmouseout="doHide( this );" src="imagelist.html" frameborder="0"></iframe></td>
                            <td style="width:30px;"><a runat="server" onclick="doShow( this ); return false;" id="lnkT"><asp:Image runat="server" ID="imgPPR_Time" style="border:none; padding-left:10px;" /><img src="Images/Expand_tiny.gif" class="ddl_flag" alt="expand" /></a><asp:HiddenField ID="hdnPPR_TimeStatus" runat="server" /><asp:HiddenField ID="hdnPPR_TimeStatusID" runat="server" /><iframe scrolling="no" onmouseout="doHide( this );" src="imagelist.html" frameborder="0"></iframe></td>
                            <td style="width:30px;"><a runat="server" onclick="doShow( this ); return false;" id="lnkR"><asp:Image runat="server" ID="imgPPR_Risks" style="border:none; padding-left:10px;" /><img src="Images/Expand_tiny.gif" class="ddl_flag" alt="expand" /></a><asp:HiddenField ID="hdnPPR_RisksStatus" runat="server" /><asp:HiddenField ID="hdnPPR_RisksStatusID" runat="server" /><iframe scrolling="no" onmouseout="doHide( this );" src="imagelist.html" frameborder="0"></iframe></td>
                            <td style="width:30px;"><a runat="server" onclick="doShow( this ); return false;" id="lnkB"><asp:Image runat="server" ID="imgPPR_Benefits" style="border:none; padding-left:10px;" /><img src="Images/Expand_tiny.gif" class="ddl_flag" alt="expand" /></a><asp:HiddenField ID="hdnPPR_BenefitsStatus" runat="server" /><asp:HiddenField ID="hdnPPR_BenefitsStatusID" runat="server" /><iframe scrolling="no" onmouseout="doHide( this );" src="imagelist.html" frameborder="0"></iframe></td>
                        </tr>
                    </table>
		                <asp:TextBox Runat="server" ID="txtName" CssClass="textinput" ReadOnly="true" Width="425px" MaxLength="100" Visible="False"></asp:TextBox></td>
		            <td></td>
		            <td style="width: 3px"></td>
		            <td class="summarylabel">&nbsp;7) INVESTMENT TIER:
		            </td>
		            <td>
                        <asp:TextBox ID="txtInvestmentTier" runat="server" CssClass="textinputgreen" Enabled="False" Width="145px"></asp:TextBox></td>
		            <td></td>
	            </tr>
	            <tr>
	                <td colspan="2" style="padding-left:2em;">
	                    <asp:TextBox Runat="server" ID="txtPPRComments" CssClass="textinput" Width="480px" MaxLength="200" Rows="2" TextMode="MultiLine" onkeyup="textLimit(this, 200);" onchange="textLimit(this, 200);" ></asp:TextBox>
                    </td>
                    <td></td>
		            <td class="summarysep" style="width: 3px"></td>
		            <td class="summarylabel" width="250px">
			            &nbsp;8) GTO MANAGING BUSINESS AREA:
		            </td>
		            <td><asp:TextBox Runat="server" ID="txtGTOManagingBusinessArea" CssClass="textinput" Width="230px" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="sectionA_rvGTOManagingBusinessArea" runat="server" ControlToValidate="txtGTOManagingBusinessArea"
                            ErrorMessage="GTO Managing Business Area must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator></td>
                    <td></td>
                </tr>
	            <tr>
		            <td class="summarylabel" width="220px">
			            &nbsp;2) PRIMARY SPONSORING BUSINESS &nbsp; &nbsp;&nbsp; &nbsp;UNIT:
		            </td>
		            <td style="width: 280px">
                        <asp:DropDownList Runat="server" ID="ddlPrimarySBU" Width="265px" CssClass="textselect">
                        </asp:DropDownList><asp:CompareValidator ID="sectionA_rvPrimarySponsoringArea" runat="server"
                            ControlToValidate="ddlPrimarySBU" ErrorMessage="Primary Sponsoring Business Unit must not be blank or Legacy"
                            Operator="GreaterThan" ValidationGroup="SubmitForReview" ValueToCompare="0" Width="1px">*</asp:CompareValidator></td>
                    <td></td>
                    <td></td>
		            <td class="summarylabel" width="250px">
			            &nbsp;9) GTO INITIATIVE MANAGER:
		            </td>
		            <td>
		                <asp:TextBox Runat="server" ID="txtGTOInitiativeManager" CssClass="textinput" Width="230px" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="sectionA_rvGTOInitiativeManager" runat="server" ControlToValidate="txtGTOInitiativeManager"
                            ErrorMessage="GTO Initiative Manager must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
                        <asp:HiddenField runat="server" ID="hGTOInitiativeManagerID" />
                    </td>
                    <td>
				        <a runat="server" ID="lnkGTOInitiativeManager"><img src="Images/pick.jpg" border="0" ></a>
		            </td>
	            </tr>
	            <tr>
		            <td class="summarylabel">
			            &nbsp;3) OTHER SPONSORING BUSINESS UNIT:
		            </td>
		            <td style="width: 280px">
		            <asp:TextBox Runat="server" ID="txtOtherSponsoringAreas" CssClass="textinput" Width="265px" MaxLength="50"></asp:TextBox>
		            <asp:RequiredFieldValidator ID="sectionA_rvOtherSponsoringAreas" runat="server" ControlToValidate="txtOtherSponsoringAreas"
                            ErrorMessage="Other Sponsoring Areas must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
                        
		            </td>
                    <td></td>
		            <td class="summarysep" style="width: 3px"></td>
		            <td class="summarylabel" width="250px">
			            10) FUNCTIONAL DOMAIN:
		            </td>
		            <td><asp:DropDownList Runat="server" ID="ddlFunctionalDomain" Width="230px" CssClass="textselect" AutoPostBack="True" OnSelectedIndexChanged="ddlFunctionalDomain_SelectedIndexChanged"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="sectionA_rvFunctionalDomain" runat="server" ControlToValidate="ddlFunctionalDomain"
                            ErrorMessage="Please select correct functional domain" InitialValue="0|0"
                            ValidationGroup="SubmitForReview">*</asp:RequiredFieldValidator><asp:CustomValidator
                                ID="sectionA_cuvFunctionalDomain" runat="server"
                                ControlToValidate="ddlFunctionalDomain" ErrorMessage="Please select correct functional domain"
                                OnServerValidate="sectionA_cuvFunctionalDomain_ServerValidate" ValidationGroup="SubmitForReview" ClientValidationFunction="validateFunctionalDomain">*</asp:CustomValidator></td>
                    <td></td>
	            </tr>
                <tr>
		            <td class="summarylabel">
			            &nbsp;4) BUSINESS SPONSOR NAME:
		            </td>
		            <td style="width: 280px">
		                <asp:TextBox Runat="server" ID="txtBusinessSponsorName" CssClass="textinput" Width="265px" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="sectionA_rvBusinessSponsorName" runat="server" ControlToValidate="txtBusinessSponsorName"
                            ErrorMessage="Business Sponsor Name must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
		                <asp:HiddenField runat="server" ID="hBusinessSponsorID" />
		            </td>
                    <td>
				        <a runat="server" ID="lnkBusinessSponsorName"><img src="Images/pick.jpg" border="0"></a>
		            </td>
		            <td class="summarysep" style="width: 3px"></td>
		            <td class="summarylabel" width="250px">
			            11) SECONDARY FUNCTIONAL DOMAIN:
		            </td>
		            <td><asp:DropDownList Runat="server" ID="ddlSecondaryFunctionalDomain" Width="230px" CssClass="textselect"></asp:DropDownList>
                        <asp:CustomValidator ID="sectionA_cuvSecondaryFunctionalDomain" runat="server" ErrorMessage="Secondary Functional Domain must be blank, or be a sub-domain of the Primary Functional Domain"
                            OnServerValidate="sectionA_cuvSecondaryFunctionalDomain_ServerValidate" Width="1px" ControlToValidate="ddlSecondaryFunctionalDomain" ValidateEmptyText="True" ValidationGroup="SubmitForReview" ClientValidationFunction="validateSecondaryFunctionalDomain">*</asp:CustomValidator></td>
                    <td></td>
	            </tr>
	            <tr>
		            <td class="summarylabel">
			            &nbsp;5) BUSINESS INITIATIVE MANAGER:
		            </td>
		            <td style="width: 280px">
		                <asp:TextBox Runat="server" ID="txtBusinessInitiativeManager" CssClass="textinput" Height="17px" Width="265px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="sectionA_rvBusinessInitiativeManager" runat="server" ControlToValidate="txtBusinessInitiativeManager"
                            ErrorMessage="Business Initiative Manager must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
		                <asp:HiddenField runat="server" ID="hBusinessInitiativeManagerID" />
                    </td>
                    <td>
				        <a runat="server" ID="lnkBusinessInitiativeManager"><img src="Images/pick.jpg" border="0"></a>
		            </td>
		            <td class="summarysep" style="width: 3px"></td>
		            <td class="summarylabel" width="250px">
			            12) TECHNOLOGY FUNCTION:
		            </td>
		            <td>
		                <asp:DropDownList Runat="server" ID="ddlTechnologyFunction" Width="230px" CssClass="textselect"></asp:DropDownList>
		            </td>
                    <td></td>
	            </tr>
	            <tr>
	                <td class="summaryLabel">
	                    &nbsp;6) REGION:
	                </td>
                    <td style="width: 280px">
                        <asp:DropDownList Runat="server" ID="ddlRegion" Width="230px" CssClass="textselect"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="sectionA_rvRegion" runat="server" ControlToValidate="ddlRegion"
                            ErrorMessage="Region must not be blank" InitialValue="0"
                            ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>
                    </td>
                    <td></td>
		            <td class="summarysep" style="width: 3px"></td>
		            <td class="summarylabel">
			            13) MAJOR APPLICATION NAME:
		            </td>
		            <td>
		                <asp:TextBox Runat="server" ID="txtMajorApplicationName" Width="230px" CssClass="textinput" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="sectionA_rvMajorApplicationName" runat="server" ControlToValidate="txtMajorApplicationName"
                            ErrorMessage="Major Application Name must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>
		                <asp:HiddenField runat="server" ID="hMajorApplicationID"></asp:HiddenField>
		                <asp:HiddenField runat="server" ID="hMajorApplicationExternalID"></asp:HiddenField>
		            </td>
                    <td>
                        <a runat="server" ID="lnkMajorApplicationName"><img src="Images/pick.jpg" border="0"></a>
                    </td>
	            </tr>
	            <tr>
	                <td class="summarylabel"></td>
	                <td></td>
		            <td></td>
		            <td class="summarysep" style="width: 3px"></td>
		            <td class="summarylabel"></td>
		            <td>
		                <asp:label runat="server" id="lblMajorApplicationInvestmentStrategy"></asp:label>
		                <asp:HiddenField runat="server" ID="hMajorApplicationInvestmentStrategy"></asp:HiddenField>&nbsp;
		            </td>
                    <td>
                    </td>
	            </tr>
	            <tr>
	                <td class="summarylabel"></td>
	                <td></td>
	                <td></td>
		            <td class="summarysep" style="width: 3px"></td>
                    <td colspan="3"></td>
	            </tr>
	         </table>
	      </td>
	   </tr>
	   <tr><td height="5" style="width: 2395px"></td></tr>
	   <tr>
	      <td align="Center" style="width: 2395px">
	         <table border="0">
	            <tr>
		            <td colspan="5" class="summarylabel">14) INITIATIVE BUSINESS DRIVERS:<asp:RequiredFieldValidator ID="sectionA_rvInitiativeBusinessDrivers"
                            runat="server" ControlToValidate="txtInitiativeBusinessDrivers" ErrorMessage="Initiative Business Drivers must not be blank"
                            ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>&nbsp;<br>
			            &nbsp;&nbsp;<asp:TextBox Runat="server" ID="txtInitiativeBusinessDrivers" CssClass="textinput" TextMode="MultiLine"
				            Width="1045px" Height="80px"></asp:TextBox>
		            </td>
	            </tr>
	            <tr height="5">
		            <td colspan="5"></td>
	            </tr>
	            <tr>
		            <td colspan="5" class="summarylabel" style="height: 103px">15) INITIATIVE SCOPE & OBJECTIVES:
                        <asp:RequiredFieldValidator ID="sectionA_rvInitiativeScopeAndObjectives" runat="server" ControlToValidate="txtInitiativeScopeAndObjectives"
                            ErrorMessage="Initiative Scope & Objectives must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator><br>
			            &nbsp;&nbsp;<asp:TextBox Runat="server" ID="txtInitiativeScopeAndObjectives" CssClass="textinput" TextMode="MultiLine"
				            Width="1045px" Height="80px"></asp:TextBox>
		            </td>
	            </tr>
	            <tr height="5">
		            <td colspan="5"></td>
	            </tr>
	            <tr>
		            <td colspan="5" class="summarylabel">16) INITIATIVE BENEFIT CALCULATION/JUSTIFICATION:
                        <asp:RequiredFieldValidator ID="sectionA_rvInitiativeBenefitCalculation" runat="server" ControlToValidate="txtInitiativeBenefitCalculation"
                            ErrorMessage="Initiative Benefit Calculation must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator>&nbsp;<br>
			            &nbsp;&nbsp;<asp:TextBox Runat="server" ID="txtInitiativeBenefitCalculation" CssClass="textinput" TextMode="MultiLine"
				            Width="1045px" Height="80px"></asp:TextBox>
		            </td>
	            </tr>
	            <tr height="5">
		            <td colspan="5"></td>
	            </tr>
	            <tr>
		            <td colspan="5" class="summarylabel">17) STRATEGIC INITIATIVE INTERFACES:
                        <asp:RequiredFieldValidator ID="sectionA_rvStrategicInitiativeInterfaces" runat="server" ControlToValidate="txtStrategicInitiativeInterfaces"
                            ErrorMessage="Strategic Initiative Interfaces must not be blank" ValidationGroup="SubmitForReview"
                            Width="1px">*</asp:RequiredFieldValidator><br>
			            &nbsp;&nbsp;<asp:TextBox Runat="server" ID="txtStrategicInitiativeInterfaces" CssClass="textinput" TextMode="MultiLine"
				            Width="1045px" Height="40px"></asp:TextBox>
		            </td>
	            </tr>
	            <tr height="5">
		            <td colspan="5"></td>
	            </tr>
	            <tr>
		            <td colspan="5" class="summarylabel">18) INITIATIVE SMARTSOURCING COMPONENT:<asp:RequiredFieldValidator ID="sectionA_rvSmartsourcingComponent"
                            runat="server" ControlToValidate="txtSmartsourcingComponent" ErrorMessage="Initiative Smartsourcing Component must not be blank"
                            ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator>&nbsp;<br>
			            &nbsp;&nbsp;<asp:TextBox Runat="server" ID="txtSmartsourcingComponent" CssClass="textinput" TextMode="MultiLine"
				            Width="1045px" Height="40px"></asp:TextBox>
		            </td>
	            </tr>
	            <tr height="5">
		            <td colspan="5"></td>
	            </tr>
	            <tr>
		            <td colspan="5" class="summarylabel">
		                <table cellpadding="0" cellspacing="0" border="0">
		                    <tr>
		                        <td class="summarylabel">19) INITIATIVE ARCHITECTURAL COMPLIANCE: 
                                    <asp:RequiredFieldValidator ID="sectionA_rvArchitecturalCompliance" runat="server" ControlToValidate="txtArchitecturalCompliance"
                                        ErrorMessage="Initiative Architectural Compliance must not be blank" ValidationGroup="SubmitForReview"
                                        Width="1px">*</asp:RequiredFieldValidator></td>
		                        <td align="right" style="width: 417px"><asp:DropDownList runat="Server" ID="ddlArchitecturalComplianceType" CssClass="textselect" Width="160px"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="sectionA_rvArchitecturalComplianceDDL" runat="server" ControlToValidate="ddlArchitecturalComplianceType"
                                        ErrorMessage="Initiative Architectural Compliance Type must not be blank" InitialValue="0"
                                        ValidationGroup="SubmitForReview" Width="1px">*</asp:RequiredFieldValidator></td>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
	              	                &nbsp;&nbsp;<asp:TextBox Runat="server" ID="txtArchitecturalCompliance" CssClass="textinput" TextMode="MultiLine"
        		    	                Width="1045px" Height="40px"></asp:TextBox>
		                        </td>
		                    </tr>
		                </table>
		            </td>
	            </tr>
            </table>
	    </td>
	</tr>
</table>