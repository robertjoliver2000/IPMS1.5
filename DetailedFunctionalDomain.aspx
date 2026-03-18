<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailedFunctionalDomain.aspx.cs" Inherits="DetailedFunctionalDomain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<base target="_self" />
    <title runat="server" id="pageTitle">Sub-function 3</title>
    <link href="style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript">
        //<!--

        /**
         * Takes an existing event handler, and adds some extra code to it.
         * This allows us to override existing functions, such as document.onclick
         * events without destroying the existing functionality, unless we require it.
         *
         * @param element the element on which the event handler is defined.
         * @param handlerName the name of the handler on the element.
         * @param extraCode the extraCode to be added to the element's handler.
         */
        function Events_chainEvent(element, handlerName, extraCode) {
         var strOldHandlerContent=""
         if (element!=null) {
             if(element[handlerName]!=null) {
              //Get the contents of the old function from the event handler ...
              var strOldHandler=element[handlerName].toString();
              //Retrieve the content of the handler between the outermost { }
              strOldHandlerContent=strOldHandler.match(/\{[\s\S]*\}/g)[0]
              //If it's null, then change to blank ..
              if(strOldHandlerContent==null) strOldHandlerContent=""
              //Now pull off the first and last characters which _should_ be { and }
              if (strOldHandlerContent.length>3)
               strOldHandlerContent=strOldHandlerContent.substring(1,strOldHandlerContent.length-2);
             }
             //Check that extraCode ends with a ;
             if (!extraCode.substring(extraCode.length-1, extraCode.length)==";") extraCode+=";";
             
             //Now redefine the handler, with the new code prepended to the string.
             //*** Has to be a prepend otherwise the code might return before ours is executed
             element[handlerName]=new Function(extraCode+strOldHandlerContent);
          }
        }
    
        function textLimit(field, maxlen) 
        {
            if (field.value.length > maxlen + 1)
                alert('You have exceeded the text limit of ' + maxlen.toString() + ' characters.');
            if (field.value.length > maxlen)
                field.value = field.value.substring(0, maxlen);
        }

        function validateText(textBox)
        {
            if (!isNaN(parseFloat(textBox.value))
                    && textBox.value.lastIndexOf('.') >= 0
                    && textBox.value.length - textBox.value.lastIndexOf('.') > 3)
            {
                    textBox.value = textBox.value.substr(0, (textBox.value.lastIndexOf('.') + 3));
            }
        }
        
        function popupWindowSelectDFD(initiativeID, txtBoxID, hdnControlID)
        {
            var dialogwidth = 340
	        var dialogheight = 445
	        var leftpos = (screen.width - dialogwidth) / 2
	        var toppos = (screen.height - dialogheight) / 2
	        var attr = "left=" + leftpos + ",top=" + toppos + ",resizable=no,scroll=yes,width="+
		        dialogwidth + ",height=" + dialogheight + 
		        ",titlebar=no,status=no,dependent=yes"
          
	        dlgwindow = window.open("SelectItem.aspx?InitiativeID=" + initiativeID + "&CategoryID=4&ControlID="+txtBoxID+"&HiddenControlID="+hdnControlID, 
					        "selectitem_dialog", attr)
        					
	        dlgwindow.focus();
        }

        
        function loadfunc()
        {
            var elt = document.getElementById( "txtAllocation" );
            if ( elt )
            {
                Events_chainEvent( elt, "onchange", "validateText(this);" );
                Events_chainEvent( elt, "onkeyup", "validateText(this);" );
            }
        }
        
        //-->
    </script>
</head>
<body onload="loadfunc()">
    <form id="form1" runat="server">
    <div>
        <br />
        <table>
            <tr>
                <td class="summarylabel">Sub-function 3</td>
                <td>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="textinputgreen"
                        Width="250px" ReadOnly="True"></asp:TextBox><asp:HiddenField ID="hdnReferenceID" runat="server" />
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="rfvDetailedFunctionalDomain" runat="server" ValidationGroup="Summary" ControlToValidate="txtDescription" ErrorMessage="Sub-function 3 must be set">*</asp:RequiredFieldValidator>
                    <a runat="server" ID="hRefDetailedFunctionalDomain"><asp:Image ID="imgPick" runat="server" ImageUrl="~/Images/pick.jpg" /></a></td>
            </tr>
            <tr>
                <td class="summarylabel">% Allocation</td>
                <td>
                    <asp:TextBox ID="txtAllocation" runat="server" Width="250px"></asp:TextBox></td>
                <td>
                    <asp:RangeValidator ID="rvAllocation" runat="server" ControlToValidate="txtAllocation"
                        ErrorMessage="% Allocation must be between 0 and 100" MaximumValue="100.00" MinimumValue="0.00"
                        Type="Double" ValidationGroup="Summary">*</asp:RangeValidator><asp:RequiredFieldValidator ID="rfvAllocation" runat="server" ErrorMessage="% Allocation must be set"
                        ValidationGroup="Summary" ControlToValidate="txtAllocation">*</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="summarylabel">Comments</td>
                <td>
                    <asp:TextBox ID="txtComments" runat="server" Rows="4" Width="250px" TextMode="MultiLine"  onkeyup="textLimit(this, 200);"></asp:TextBox></td>
                <td />
            </tr>
            <tr>
                <td>
                    <asp:HiddenField ID="hdnInitiativeDetailedFunctionalDomainID" runat="server" />
                    <asp:HiddenField ID="hdnInitiativeID" runat="server" />
                </td>
                <td style="text-align:right;"><asp:Button ID="btnSave" runat="server" Text="OK" Width="75px" ValidationGroup="Summary" OnClick="btnSave_Click" Enabled="False" />&nbsp;<input id="btnCancel"
                        type="button" onclick="window.close()" value="Cancel" />
                </td>
                <td />
            </tr>
        </table>
        <asp:ValidationSummary ID="vsSummary" runat="server" ValidationGroup="Summary" Width="375px" />
    </div>
    </form>
</body>
</html>