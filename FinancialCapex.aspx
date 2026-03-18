<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FinancialCapex.aspx.cs" Inherits="ProjectPortfolio.Financial" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Add Financial Record</title>
	<LINK href="style.css" type="text/css" rel="stylesheet">    
	<BASE target="_self">
</head>

<script language="javascript">
    
    // used to store intermadiate value for reconciliation difference
    globalResult = 0.0;
    
    // used to store sum of depreciation per line.
    decimalSumLine2 = 0.0;
    decimalSumLine3 = 0.0;
    decimalSumLine4 = 0.0;
  
// this function is used onBlur event
// this function will set the value into Reconciliation Difference
function setValues(obj, blnAdd, intLineNumber)
{    
	//window.alert("gets to set val!");
	//debugger
	element =document.getElementById(obj);	
	result = document.getElementById('txtBoxReconciliation');
    
    var val;    
    
    if ( element.value == "" ) 
        val = "0";
    else
    {        
       val = parseFloat(element.value);      
       if (isNaN(val))            
       {
            val = 0.0;
       };
    }
    
    if ( element != null && result != null )
    {
    
        if ( blnAdd == "1")
        {
            result.value = Math.round( (parseFloat(globalResult) + parseFloat(val)) * 1000000) / 1000000;	
         }   
        else
        {                                   
            result.value = Math.round( (parseFloat(globalResult)* 1000000 - parseFloat(val) * 1000000) ) / 1000000;     
                               
            switch (intLineNumber)
            {
                case 2: 
                    decimalSumLine2 = decimalSumLine2 + (parseFloat(val)*1000000)/1000000;
                    break;
                case 3: 
                    decimalSumLine3 = decimalSumLine3 + (parseFloat(val)*1000000)/1000000;
                    break;
                case 4: 
                    decimalSumLine4 = decimalSumLine4 + (parseFloat(val)*1000000)/1000000;
                    break;                    
            };                       
        }
    }   
    
    // set hidden reconciliation difference
    elementHiddenReconciliation = document.getElementById("hiddenReconciliationDifference");               
    elementHiddenReconciliation.value = result.value;
    
    // set hidden Depreciations SUM
    elementHiddenSum2 = document.getElementById("hiddenDepreciationSum2");
    elementHiddenSum2.value = decimalSumLine2;
    elementHiddenSum3 = document.getElementById("hiddenDepreciationSum3");
    elementHiddenSum3.value = decimalSumLine3;
    elementHiddenSum4 = document.getElementById("hiddenDepreciationSum4");
    elementHiddenSum4.value = decimalSumLine4;
};

// this function is used on onEnter event
// this function will get the value from controls
function  getValues(obj, blnAdd, intLineNumber)
{
    //window.alert("gets to get val!");
    //debugger
    element =document.getElementById(obj);	
	result = document.getElementById('txtBoxReconciliation');
	
	var val;
	
	if ( element.value == "" ) 
	    val = "0";
    else
    {
       val = parseFloat(element.value);      
       if (isNaN(val))            
       {
            val = 0.0;
       };
	 };   
	
	if ( element != null && result != null )
    {
    
        if ( blnAdd == "1")
        {
            globalResult = parseFloat(result.value ) - parseFloat(val);	
         }   
        else
        {                                   
            globalResult = parseFloat(result.value ) + parseFloat(val);
            
            switch (intLineNumber)
            {
                case 2: 
                    decimalSumLine2 = decimalSumLine2 - (parseFloat(val)*1000000)/1000000;
                    break;
                case 3: 
                    decimalSumLine3 = decimalSumLine3 - (parseFloat(val)*1000000)/1000000;
                    break;
                case 4: 
                    decimalSumLine4 = decimalSumLine4 - (parseFloat(val)*1000000)/1000000;
                    break;                    
            }; 
        }
    } 	
    
    globalResult = Math.round ( globalResult * 1000000) / 1000000;   
    
    // set hidden Depreciations SUM
    elementHiddenSum2 = document.getElementById("hiddenDepreciationSum2");
    elementHiddenSum2.value = decimalSumLine2;
    elementHiddenSum3 = document.getElementById("hiddenDepreciationSum3");
    elementHiddenSum3.value = decimalSumLine3;
    elementHiddenSum4 = document.getElementById("hiddenDepreciationSum4");
    elementHiddenSum4.value = decimalSumLine4;
};

function depreciationAddLine()
{       
    //window.alert("gets to add line!");
    //debugger
    // Depreciation lines where you can delete are from 2 to 4
    for (i=2; i<5; i++) 
    {
        line = document.getElementById("trDepreciationLine"+i);
        result = document.getElementById('txtBoxReconciliation');
        
        if (line.style.visibility == "hidden")
        {
            line.style.visibility = "visible";
            
            switch (i)
            {
            case 2:
                globalResult = parseFloat(result.value) - parseFloat(decimalSumLine2);
                
                // set hidden filed
                hidden = document.getElementById("hiddenDepreciationStatus2");
                hidden.value = "insert";
                break;
            case 3:
                globalResult = parseFloat(result.value) - parseFloat(decimalSumLine3);
                
                // set hidden filed
                hidden = document.getElementById("hiddenDepreciationStatus3");
                hidden.value = "insert";
                break;
            case 4:
                globalResult = parseFloat(result.value) - parseFloat(decimalSumLine4);
                
                // set hidden filed
                hidden = document.getElementById("hiddenDepreciationStatus4");
                hidden.value = "insert";   
                break;            
            };
            
            result.value = globalResult;                         
            
            return;
        };                
    };
    alert("You can add only 4 depreciation lines !");
};

function depreciationDelLine(intLine)
{
    //window.alert("gets to del line!");
    //debugger
    line = document.getElementById("trDepreciationLine"+intLine);
    line.style.visibility = "hidden";
      
    result = document.getElementById('txtBoxReconciliation');
    
    switch (intLine)
    {
        case 2:
            globalResult = parseFloat(result.value) + parseFloat(decimalSumLine2);
            
            // set hidden filed
            hidden = document.getElementById("hiddenDepreciationStatus2");
            hidden.value = "delete";
            break;
        case 3:
            globalResult = parseFloat(result.value) + parseFloat(decimalSumLine3);
            
            // set hidden filed
            hidden = document.getElementById("hiddenDepreciationStatus3");
            hidden.value = "delete";
            break;
        case 4:
            globalResult = parseFloat(result.value) + parseFloat(decimalSumLine4);   
            
            // set hidden filed
            hidden = document.getElementById("hiddenDepreciationStatus4");
            hidden.value = "delete";
            break;            
    };
    
    result.value = globalResult;    
    
};

function popupWindowSelectItem(categoryID,txtBoxID,hiddenTxtBoxID)
{
    //window.alert("window Select Item!");
    //debugger
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

function ValidateDepreciation(source, arguments)
{
    var idStr = source.id;
    var lineNo = idStr.substr( idStr.length - 1, 1 );
    
    var line = document.getElementById( "trDepreciationLine" + lineNo );
    var ddl = document.getElementById( "ddlSpend" + lineNo );
    
    arguments.IsValid = false;

    if ( line )
    {
        if ( ( line.style.visibility == "hidden" ) || ( ddl.selectedIndex > 0 ) )
            arguments.IsValid = true;
    }
}

</script>


<script src="js/DatePicker.js" type="text/javascript"></script>

<body>
    <form id="frmMain" runat="server">
    <div style="overflow: auto; ">
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
		            <!-- Only CAPEX should be displayed -->
		            <asp:DropDownList Font-Bold="true" Font-Size="10px" Runat="server" ID="ddlCategory" CssClass="textselect" Width="220px" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
		                <asp:ListItem Text="Capital Hardware Expense" Value="6"></asp:ListItem>
		                <asp:ListItem Text="Building/Premises Expense" Value="7"></asp:ListItem>
		                <asp:ListItem Text="Capital Software Expense" Value="8"></asp:ListItem>
		                <asp:ListItem Text="Market Data" Value="15"></asp:ListItem> 
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
        		    <asp:DropDownList Runat="server" ID="ddlType" CssClass="textselect" Width="223px" TabIndex="1" AutoPostBack="True" OnSelectedIndexChanged="ddlType_SelectedIndexChanged"></asp:DropDownList>
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
         
	     
     <table border="0" cellspacing="0" cellpadding="0" width="100%" >
        <tr>
        <td>
            <hr width=95%  color=Silver  size=1/>
        </td>
        </tr>
     	<tr height="10px">
     		<td></td>
     	</tr>
     </table>     	    
	 
	 <table border="0" cellspacing="0" cellpadding="0"  >
	 	<tr>
	 		<td width="10px"/>
	 		
	 		<td>	 
	     
	           <table border="0" cellspacing="0" cellpadding="0"  >
	           <!--
	            <tr>
	                <td class="summarylabel" width="100px">Depreciation</td>
	                <td width="10px"></td>
	                <td class="summarylabel">SPEND(€M)</td>
	            </tr>
	            
	            <tr> 
	                <td height="5px"> </td>
	            </tr>
	            -->
	 	        <tr>
	 	            <td>
	 	            <!--
        	 	        <table border="0" cellspacing="0" cellpadding="0" >
        	 	        	<tr height="17px">
        	 	        		<td class="summarylabel"> </td>
        	 	        		<td class="summarylabel"> </td>
        	 	        	</tr>
        	 	        	<tr height="4px">
        	 	        	    
        	 	        	</tr>
        	 	        	<tr>
        	 	        	    <td><a href="">Add</a></td>
        	 	        	    <td><asp:DropDownList Runat="server" ID="DropDownList2" CssClass="textselect" Width="70px"></asp:DropDownList></td>
        	 	        	</tr>
        	 	        </table>
        	 	        -->        
	 	            </td>
	 	            
	 	            <td width="10px"></td>
	 	            
	 		        <td>
                    <table border="1" cellspacing="0" cellpadding="0" >
            	        <tr>
                            <asp:DataList runat="Server" RepeatDirection="Horizontal" EnableViewState="true" ID="dataListDepreciation" OnItemDataBound="dataListDepreciation_ItemDataBound">
                               <ItemTemplate>
                                    <td runat="Server" id="tdContent" style="padding-left:0px" align="center"></td>
                               </ItemTemplate>             
                            </asp:DataList></tr>
                    </table>           
                    
	 		        </td>
	 	        </tr>
	         </table>
	 
	    </td>
	    </tr>	       	    
	 </table>
	 
    
    <!-- Ionut -->
    <table cellpadding="0" cellspacing="0" width="400px">
        <tr>
            <td width="45px"></td>
            <td class="summarylabel" width="225px">Depreciation</td>
            <td class="summarylabel">SPEND(€M)</td>
        </tr> 
        <tr>
            <td height="10px" colspan="3"></td>
        </tr>       
    </table>
    <Table border="0" cellspacing="0" cellpadding="0">
    
    <!-- Header -->    
    <tr>
        <td width="15px" style="height: 29px"></td>
        <td width="30px" style="height: 29px"></td>
        <td width="200px" style="height: 29px"></td>
        
        <!-- Repeater for Header -->        
        <td style="height: 29px">                       
            <asp:DataList runat="Server" RepeatDirection="Horizontal" EnableViewState="true" ID="dataListHeaders" OnItemDataBound="dataListHeaders_ItemDataBound">
               <ItemTemplate>
                    <td runat="Server" id="tdContent" style="padding-left:0px" align="center"></td>
               </ItemTemplate>             
            </asp:DataList>
        </td>                
        <td style="height: 29px"></td>
    </tr>
        
    <tr ID="trDepreciationLine1" runat="server">
        <td width="15px"></td>
        <td width="30px"><a href="#" ID="lnkAdd" onclick="depreciationAddLine();">Add</a></td>
        <td nowrap>
            <asp:DropDownList Font-Bold="true" Font-Size="10px" Runat="server" ID="ddlSpend1" CssClass="textselect" Width="220px">            
            </asp:DropDownList>&nbsp;<asp:CustomValidator ID="cuvSpend1" runat="server" ClientValidationFunction="ValidateDepreciation"
            ControlToValidate="ddlSpend1" ValidateEmptyText="True">*</asp:CustomValidator>
        </td>               
        <td>
            <asp:DataList runat="Server" RepeatDirection="Horizontal" EnableViewState="true" ID="dataListSpend1" OnItemDataBound="dataListSpend_ItemDataBound">
               <ItemTemplate>
                    <td runat="Server" id="tdContent" style="padding-left:0px" align="center"></td>
               </ItemTemplate>             
            </asp:DataList>
        </td>
        <td><input type="hidden" ID="hiddenDepreciationStatus1" runat="server" /></td>        
        <td><input type="hidden" ID="hiddenDepreciationFinancialID1" runat="server" /></td>        
    </tr>        
    
    <tr ID="trDepreciationLine2" runat="server">
        <td width="15px"></td>
        <td width="30px"><a href="#" ID="lnkDel2" onclick="depreciationDelLine(2);">Del</a></td>
        <td>
            <asp:DropDownList Font-Bold="true" Font-Size="10px" Runat="server" ID="ddlSpend2" CssClass="textselect" Width="220px">            
            </asp:DropDownList>&nbsp;<asp:CustomValidator ID="cuvSpend2" runat="server" ClientValidationFunction="ValidateDepreciation"
            ControlToValidate="ddlSpend2" ValidateEmptyText="True">*</asp:CustomValidator>
        </td>               
        <td>
            <asp:DataList runat="Server" RepeatDirection="Horizontal" EnableViewState="true" ID="dataListSpend2" OnItemDataBound="dataListSpend_ItemDataBound">
               <ItemTemplate>
                    <td runat="Server" id="tdContent" style="padding-left:0px" align="center"></td>
               </ItemTemplate>             
            </asp:DataList>
        </td>            
        <td><input type="hidden" ID="hiddenDepreciationStatus2" runat="server" /></td>   
        <td><input type="hidden" ID="hiddenDepreciationFinancialID2" runat="server" /></td>         
    </tr>
        
    <tr ID="trDepreciationLine3" runat="server" >
        <td width="15px"></td>
        <td width="30px"><a href="#" ID="lnkDel3" onclick="depreciationDelLine(3);">Del</a></td>
        <td>
            <asp:DropDownList Font-Bold="true" Font-Size="10px" Runat="server" ID="ddlSpend3" CssClass="textselect" Width="220px">            
            </asp:DropDownList>&nbsp;<asp:CustomValidator ID="cuvSpend3" runat="server" ClientValidationFunction="ValidateDepreciation"
            ControlToValidate="ddlSpend3" ValidateEmptyText="True">*</asp:CustomValidator>
        </td>               
        <td>
            <asp:DataList runat="Server" RepeatDirection="Horizontal" EnableViewState="true" ID="dataListSpend3" OnItemDataBound="dataListSpend_ItemDataBound">
               <ItemTemplate>
                    <td runat="Server" id="tdContent" style="padding-left:0px" align="center"></td>
               </ItemTemplate>             
            </asp:DataList>
        </td>     
        <td><input type="hidden" ID="hiddenDepreciationStatus3" runat="server" /></td>  
        <td><input type="hidden" ID="hiddenDepreciationFinancialID3" runat="server" /></td>         
    </tr>                    
    
    <tr ID="trDepreciationLine4" runat="server">
        <td width="15px"></td>
        <td width="30px"><a href="#" ID="lnkDel4" onclick="depreciationDelLine(4);">Del</a></td> 
        <td>
            <asp:DropDownList Font-Bold="true" Font-Size="10px" Runat="server" ID="ddlSpend4" CssClass="textselect" Width="220px">            
            </asp:DropDownList>&nbsp;<asp:CustomValidator ID="cuvSpend4" runat="server" ClientValidationFunction="ValidateDepreciation"
            ControlToValidate="ddlSpend4" ValidateEmptyText="True">*</asp:CustomValidator>
        </td>
        <td>
            <asp:DataList runat="Server" RepeatDirection="Horizontal" EnableViewState="true" ID="dataListSpend4" OnItemDataBound="dataListSpend_ItemDataBound">
               <ItemTemplate>
                    <td runat="Server" id="tdContent" style="padding-left:0px" align="center"></td>
               </ItemTemplate>             
            </asp:DataList>
        </td>      
        <td><input type="hidden" ID="hiddenDepreciationStatus4" runat="server" /></td>    
        <td><input type="hidden" ID="hiddenDepreciationFinancialID4" runat="server" /></td>         
    </tr> 
        
    </Table>  
	 <table border="0" cellspacing="0" cellpadding="0" width="100%" >
	 
        <tr>
            <td width="15px"></td>
            <td height="15px"/>
        </tr>	    
        
        <tr>            
            <td width="15px"></td>
            <td class="summarylabel" align="right">Reconciliation Difference</td>
        </tr>      
        
        <tr>            
            <td width="15px" style="height: 24px"></td>
            <td align="right" style="height: 24px">
                <asp:RangeValidator ID="rvReconciliationDifference" runat="server" ControlToValidate="txtBoxReconciliation"
                    MaximumValue="0" MinimumValue="0">* Reconciliation Difference should be 0.</asp:RangeValidator>
                <asp:TextBox Runat="server" ID="txtBoxReconciliation" CssClass="textinputgreen" MaxLength="50" Width="80px" ReadOnly="True"></asp:TextBox>
                <input type="hidden" ID="hiddenReconciliationDifference" runat="server"/>
            </td>
            <td width="30px" style="height: 24px"></td>
        </tr>
        
        <tr>
            <td width="15px"></td>
            <td height="10px" colspan="3"/>
        </tr>	    
        
	    <tr>
	        <td width="15px"></td>	         
	        <td align="left">
	            <asp:Button runat="server" ID="btnOK" Text="OK" Width="70px" CssClass="def" OnClick="btnOK_Click" TabIndex="20" />
	            <asp:Button runat="server" ID="btnCancel" Text="Cancel" Width="70px" CssClass="def" TabIndex="21" />
	        </td>
	    </tr>	
	 </table>           
      
        <!-- Hidden depreciations SUMs -->
        <input type="hidden" ID="hiddenDepreciationSum2" runat="server"/>
        <input type="hidden" ID="hiddenDepreciationSum3" runat="server"/>
        <input type="hidden" ID="hiddenDepreciationSum4" runat="server"/>              	
</div>		              	
              	     
    </form>
</body>
<script language="javascript">
    // Set the reconciliation value
    //window.alert("gets to here!");
    //debugger
    elementReconciliation = document.getElementById("txtBoxReconciliation");
    elementHiddenReconciliation = document.getElementById("hiddenReconciliationDifference");
    if ( elementReconciliation !=null && elementHiddenReconciliation!=null)
    {
        if ( elementHiddenReconciliation.value == "" )
            elementReconciliation.value = 0;
        else
            elementReconciliation.value = elementHiddenReconciliation.value;
    };
    
    // Set depreciation lines SUM from hidden fields.        
    elementHiddenSum2 = document.getElementById("hiddenDepreciationSum2");
    if ( elementHiddenSum2 != null )
    {
        if (elementHiddenSum2.value == "")
            decimalSumLine2 = 0.0;
        else
            decimalSumLine2 = elementHiddenSum2.value;
    }
    else
    {
        decimalSumLine2 = 0.0;
    };
    
    elementHiddenSum3 = document.getElementById("hiddenDepreciationSum3");
    if ( elementHiddenSum3 != null )
    {
        if (elementHiddenSum3.value == "")
            decimalSumLine3 = 0.0;
        else
            decimalSumLine3 = elementHiddenSum3.value;
    }
    else
    {
        decimalSumLine3 = 0.0;
    };
    
    elementHiddenSum4 = document.getElementById("hiddenDepreciationSum4");
    if ( elementHiddenSum4 != null )
    {
        if (elementHiddenSum4.value == "")
            decimalSumLine4 = 0.0;
        else
            decimalSumLine4 = elementHiddenSum4.value;
    }
    else
    {
        decimalSumLine4 = 0.0;
    };
    
</script>
</html>
