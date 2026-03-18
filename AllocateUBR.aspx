<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AllocateUBR.aspx.cs" Inherits="AllocateUBR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

<title>Allocate UBRs</title>
<LINK href="style.css" type="text/css" rel="stylesheet">

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

var bAllowSubmit = false;

function SetDirtyFlag()
{
    document.forms[0].dirty.value = "true";
    //alert('set dirty flag');
}

function ClearDirtyFlag()
{
    document.forms[0].dirty.value = "false";
    //alert('clear dirty flag');
}

function AllowOneTimeSubmit()
{
    bAllowSubmit = true;
    //alert('one time submit - preserve dirty flag');
}

function ConfirmUnload()
{
    if (document.forms[0].dirty.value == "true" && bAllowSubmit == false)
    {
        event.returnValue = "There are unsaved changes on this worksheet.";
    }
    
    bAllowSubmit = false;
}


//-->
</script>

<script type="text/javascript">

function calcSubtotal()
{
    var subtotalValue = 0;
    var eltValue;
    var subtotalElt = null;
    var eltName;
    
    for ( var i = 0; i < document.forms[0].elements.length; i++ )
    {
        var elt = document.forms[0].elements[ i ];
        
        if ( elt[ "name" ] )
        {
            eltName = elt[ "name" ].toString();
            if ( eltName.substring( eltName.length-10 ) == ':txtAmount')
            {
                eltValue = parseFloat( elt.value );
                eltValue = Math.round( eltValue * 100 ) / 100;
                subtotalValue += eltValue;

            }
            else if ( eltName.substring( eltName.length-12 ) == ':txtSubtotal')
            {
                subtotalElt = elt;
            }
        }
    }
    
    if ( isNaN( subtotalValue ) )
    {
        subtotalValue = 'Error';
    }
    else
    {
        subtotalValue = Math.round( subtotalValue * 100 )/100;
    }

    if ( subtotalElt )
    {
        subtotalElt.value = subtotalValue;
    }
 
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


function loadfunc()
{
    var eltName;
    var isReadOnly = true;
    
    if ( document.getElementById( 'btnSaveSponsorUBRs' ) )
    {
        isReadOnly = false;
    }

    for ( var i = 0; i < document.forms[0].elements.length; i++ )
    {
        var elt = document.forms[0].elements[ i ];
        
        if ( elt[ "name" ] )
        {
            eltName = elt[ "name" ].toString();
            
            if ( isReadOnly )
            {
                if ( eltName.substring( eltName.length-10 ) == ':txtAmount' )
                {
                    elt.readOnly = true;
                }
                else if ( eltName == 'btnSaveSponsorUBRs' )
                {
                    elt.style.display = 'none';
                    elt.disabled = true;
                }
            }
            else
            {
                if ( eltName.substring( eltName.length-10 ) == ':txtAmount' )
                {
                    Events_chainEvent( elt, "onchange", "SetDirtyFlag(); validateText(this); calcSubtotal();" );
                    Events_chainEvent( elt, "onkeyup", "SetDirtyFlag(); validateText(this); calcSubtotal();" );
                }
                else if ( eltName == 'btnSaveSponsorUBRs' )
                {
                    Events_chainEvent( elt, "onclick", "ClearDirtyFlag();");
                    elt.disabled = false;
                }
            }
        }
    }

    calcSubtotal();
    
}
</script>
</head>
<body style="margin:0px;" onload="loadfunc()">
    <form id="frmUBRAllocation" runat="server" style="margin:0px;">
        <asp:Panel ID="Panel1" runat="server" Height="470px" ScrollBars="Vertical" Width="470px">
        <table style="margin: 0px;" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center" style="width: 475px; height: 20px;">
                    <strong><span style="font-size: 12pt;">Sponsor
                        <asp:Label ID="lblSponsorType" runat="server"></asp:Label>
                        UBR Allocations</span></strong>
                    <input id="dirty" runat="server" name="dirty" type="hidden" value="false" /></td>
            </tr>
            <tr>
                <td align="left" style="width: 475px">
        <asp:GridView ID="gvUBRs" runat="server" Height="185px" Width="475px" CellPadding="0" GridLines="None" OnRowEditing="gvUBRs_RowEditing1" AutoGenerateColumns="False" ForeColor="#333333" ShowFooter="True" HorizontalAlign="Center">
            <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                    <asp:BoundField DataField="Level10Name" HeaderText="UBR Name" ReadOnly="True"  SortExpression="Level10Name" >
                        <ItemStyle HorizontalAlign="Left" Width="285px" />
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                <asp:TemplateField HeaderText="UBR Code" SortExpression="UBRCode">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("UBRCode") %>'></asp:Label>
                    </EditItemTemplate>
                    <AlternatingItemTemplate>
                        <asp:Label ID="lblUBR" runat="server" Text='<%# Bind("UBRCode") %>'></asp:Label>
                    </AlternatingItemTemplate>
                    <ItemStyle HorizontalAlign="Left" Width="80px" />
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemTemplate>
                        <asp:Label ID="lblUBR" runat="server" Text='<%# Bind("UBRCode") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="SubtotalLabel" runat="server"
                            Text="Subtotal"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;" SortExpression="UBRAllocation">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("UBRAllocation") %>' Width="60px"></asp:TextBox>
                    </EditItemTemplate>
                    <AlternatingItemTemplate>
                        <asp:TextBox ID="txtAmount" runat="server" CssClass="breakdown" Text='<%# Bind("UBRAllocation", "{0:G6}") %>' Width="60px"></asp:TextBox><asp:RangeValidator
                            ID="rvAmount" runat="server" ControlToValidate="txtAmount" MaximumValue="100"
                            MinimumValue="0" Type="Double">*</asp:RangeValidator><asp:RequiredFieldValidator
                                ID="rfvAmount" runat="server" ControlToValidate="txtAmount">*</asp:RequiredFieldValidator>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtSubtotal" runat="server" CssClass="breakdown" Width="60px" BackColor="#1C5E55" BorderStyle="None" Font-Bold="True" ForeColor="White">0.00</asp:TextBox><asp:RangeValidator
                            ID="rvSubtotal" runat="server" ControlToValidate="txtSubtotal" ErrorMessage="Individual allocations and the subtotal must be between 0 and 100" MaximumValue="100" MinimumValue="0" Type="Double">*</asp:RangeValidator>
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="80px" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:TextBox ID="txtAmount" runat="server" CssClass="breakdown" Text='<%# Bind("UBRAllocation", "{0:G6}") %>' Width="60px"></asp:TextBox><asp:RangeValidator
                            ID="rvAmount" runat="server" ControlToValidate="txtAmount" MaximumValue="100"
                            MinimumValue="0" Type="Double">*</asp:RangeValidator><asp:RequiredFieldValidator
                                ID="rfvAmount" runat="server" ControlToValidate="txtAmount">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Percentage (Y/N)" Visible="False">
                    <AlternatingItemTemplate>
                        <asp:CheckBox ID="cbxPercentage" runat="server" Checked='<%# Bind("Percentage") %>'
                            Enabled="false" Text=" " Width="20px" />
                    </AlternatingItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="80px" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:CheckBox ID="cbxPercentage" runat="server" Checked='<%# Bind("Percentage") %>'
                            Enabled="false" Text=" " Width="20px" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
        </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="center" style="WIDTH: 475px">
                    <asp:Button ID="btnSaveSponsorUBRs" runat="server" Text="Save" Width="120px" Enabled="False" OnClick="btnSaveSponsorUBRs_Click" Visible="False" />&nbsp;
                    <input id="btnCancel" style="width: 120px" type="button" value="Cancel" onclick="window.parent.closeReturning(-1);"/>
                    <asp:ValidationSummary ID="vsSummary" runat="server" DisplayMode="SingleParagraph"
                        HeaderText="The fields marked with * have missing or incorrect values. Please make sure all field are correctly filled in before submitting the form!" Height="20px" />
                    <p>&nbsp;</p>
                    </td>
            </tr>
        </table>
        </asp:Panel>
    </form>
</body>
</html>
