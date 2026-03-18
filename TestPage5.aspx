<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestPage5.aspx.cs" Inherits="TestPage5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>

    <script type="text/javascript">
      function Navigate(button)
      {
        //javascript:window.open("http://www.microsoft.com");
        javascript:button.Disabled=true;
        return true;
      }    

    </script>

    
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h4>Click to navigate to Microsoft.com:</h4>     

      <asp:button id="Button1"
       usesubmitbehavior="true"
       text="Open Web site"
       onclientclick="javascript:this.disabled=true"
       runat="server" onclick="Button1_Click" />

       <p></p>
      <asp:label id="Label1"
        runat="server">
      </asp:label>

    </div>
    </form>
</body>
</html>
