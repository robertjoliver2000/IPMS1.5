<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PPR_RagStatusSelect.aspx.cs" Inherits="PPR_RagStatusSelect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>RAG Status Select</title>
    <base target="_self" />
    <style type="text/css">


        .PPRCommentsBox .def		{
                                    width:70px;
                                    }
                                    
        .error                      {
                                    display:block;
                                    width:100%;
                                    padding:1em;
                                    color:white;
                                    background-color:red;
                                    text-align:center;
                                    vertical-align:middle;
                                    }
        h1                          {
                                    font:bold 11px Verdana, Arial, Helvetica, sans-serif;
                                    text-align:left;
                                    margin:2px 0px;
                                    }
    </style>
    
     
      
      
      
    <script type="text/javascript" language="javascript">

//    function doHide( elt )
//    {
//	    elt.style[ "display" ] = "none";
//    }

//    function doShow( childElt)
//    {
//        var ifr = childElt.parentNode.getElementsByTagName( 'IFRAME' )[ 0 ];
//        ifr.src = "imagelist.html?targetId=" + childElt.id;
//	    ifr.style[ "display" ] = "block"; 
//    }

//    function doSelect( elt, calledUrl )
//    {
//	    var img = elt.getElementsByTagName( 'IMG' )[ 0 ];
//    	
//	    try
//	    {
//	        var args = calledUrl.split( '=' );
//	        var targetId = args[ args.length - 1 ];
//	        var targetElt = document.getElementById( targetId );
//    	    
//	        doHide( targetElt.parentNode.getElementsByTagName( 'IFRAME' )[ 0 ] );

//	        var targetImg = targetElt.parentNode.getElementsByTagName( 'IMG' )[ 0 ];
//	        targetImg.src = img.src;
//	        targetImg.alt = img.alt;
//	        targetImg.title = targetImg.alt;
//    	    
//		    var newId, newText;
//	        switch( img.alt.substring( img.alt.length - 4 ).toLowerCase() )
//	        {
//	            case " red": newId = 3; newText = "Red";	break;
//			    case "mber": newId = 2; newText = "Amber";	break;
//			    case "reen": newId = 1; newText = "Green";	break;
//			    default : newId = 0; newText = "Please select"; break;
//	        }

//	        targetElt.parentNode.getElementsByTagName( 'INPUT' )[ 0 ].value = newText;
//	        targetElt.parentNode.getElementsByTagName( 'INPUT' )[ 1 ].value = newId;

//            recalcOverall( targetElt.parentNode.getElementsByTagName( 'INPUT' )[ 1 ] );
//            
//            SetDirtyFlag();

//        }
//        catch( e )
//	    {
//	    }
//    }

//    function recalcOverall( elt )
//    {
//        try
//        {
//            var parts = elt.id.split( '_' );
//            var tail = parts[ parts.length - 1 ];
//            var eltMeasureName = tail.substring( 0, tail.length - 8 );
//            
//            if ( eltMeasureName != 'Overall' )
//            {
//                var calcdStatus = "0";
//                var oneMeasureElt;
//                var measureIdPrefix = elt.id.substring( 0, elt.id.length - eltMeasureName.length - 15);
//                var measureNames = [ 'Cost', 'Deliverables', 'Time', 'Risks', 'Benefits' ];
//                
//                for ( var i = 0; i < measureNames.length; i++ )
//                {
//                    oneMeasureElt = document.getElementById( measureIdPrefix + 'hdnPPR_' + measureNames[ i ] + 'StatusId');
//                    if ( oneMeasureElt.value > calcdStatus ) calcdStatus = oneMeasureElt.value;
//                }
//                
//                var newStatusId, newStatus, newSrc, newAlt;
//                
//                switch( calcdStatus )
//                {
//                    case "3": newStatusId = calcdStatus; newStatus = "Red"; break;
//                    case "2": newStatusId = calcdStatus; newStatus = "Amber"; break;
//                    case "1": newStatusId = calcdStatus; newStatus = "Green"; break;
//                    default: newStatusId = "0"; newStatus = "Please select"; break;
//                }
//                
//                if ( newStatusId == "0" )
//                {
//                    newSrc = "PPR_Grey.gif";
//                    newAlt = "- - Please select";
//                }
//                else
//                {
//                    newSrc = "PPR_" + newStatus + ".gif";
//                    newAlt = newStatus.charAt( 0 ) + " - " + newStatus;
//                }
//                
//                newSrc = "Images/" + newSrc;
//                
//                document.getElementById( measureIdPrefix + 'hdnPPR_OverallStatusId').value = newStatusId;
//                document.getElementById( measureIdPrefix + 'hdnPPR_OverallStatus').value = newStatus;

//                var overallImg = document.getElementById( measureIdPrefix + 'imgPPR_Overall');

//                overallImg.src = newSrc;
//                overallImg.alt = newAlt;
//                overallImg.title = overallImg.alt;
//            }
//        }
//        catch ( e )
//        {
//        }
//    }

    </script>


    <link href="Style.css" rel="stylesheet" type="text/css" />      
   <script src="js/PprStatus.js" type="text/javascript"></script>
</head>
 
<body>
<form id="form1" runat="server">
     <div class="" style="margin-left:10px">
     &nbsp;
        <asp:Label ID="lblMessage" runat="server" Text="" Visible="false" CssClass="error"></asp:Label>
        <h1 id="lblInitiativeName" runat="server" >Initiative not found</h1>
        <table class="topPositionRelative PPRSelect" cellspacing="0" cellpadding="0" style="margin-left:-5px;">
                        <tr class="summarylabel">
                            <th>O</th>
                            <th style="width: 15px">&nbsp; &nbsp; &nbsp; &nbsp;
                            </th>
                            <th>C</th>
                            <th>D</th>
                            <th>T</th>
                            <th>R/I</th>
                            <th>B</th>
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
                    </div>
    <table width="100%">
        <tr style="height:20px;"><td></td></tr>
        <tr style="height:20px;"><td></td></tr>
        <tr style="height:20px;"><td></td></tr>
        <tr >
            <td align ="right" >                
            </td>
            <td align ="right" >
            <asp:Button ID="btnSave" runat="server" Text=" Save " CssClass="def" OnClick="btnSave_Click" /> &nbsp;
                <button id="btnCancel" value="Cancel" class="def" onclick="window.close();">Cancel</button>
            </td>
           </tr>
           <tr>
            <td align ="right"style="height:5px;">                
            </td>
        </tr>          
    </table>
    
   </form>
  
</body>
</html>
