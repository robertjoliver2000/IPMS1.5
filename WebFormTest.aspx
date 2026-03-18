
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebFormTest.aspx.cs" Inherits="WebFormTest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
  
    <script language="javascript" type="text/javascript">
    function script2()
      { 
                //debugger;
                 var btn;
		        btn = document.getElementById("Button1");  
		        btn.disabled = true;
           return confirm('Hello!');
             
    		    
    			    
            
      } 
      


        function ShowWaitBox()

        {

        document.getElementById("waitBox").style.display = 'block';

        }



      
    </script>    

    </head>
    <body>

        <form id="Form2" runat="server">
            <asp:Button ID="Button1" OnClick="script1" OnClientClick="script2();" 
            Text="Click Me" runat="server" /> 
            <br />
            <asp:label id="lblMsg" runat="server" />
            <br />
            <br />
            <div>

                Select a file: <asp:FileUpload ID="fu1" runat="server" />

                <br />

                <br />

                <asp:Button ID="Btn_Upload" onmouseup="ShowWaitBox()" runat="server" Text="Upload" OnClick="Btn_Upload_Click " />  <!-- -->

                <div id="waitBox"  style=" background:#FFFF66;position:absolute;top:400px;left:300px;right:550px;font-family:Verdana;display:none;">
                        <!--background:#FFFF66 url(images/waitIndicator.gif) no-repeat right top;-->
                  Please wait while the file is being uploaded...

                </div>

            </div>

        </form>


    </body>
</html>
    
    