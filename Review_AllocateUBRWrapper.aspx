<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Review_AllocateUBRWrapper.aspx.cs" Inherits="Review_AllocateSponsorUBRWrapper" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Allocate UBRs</title>
    <script type="text/javascript">
    
        window.returnValue = -1;
        
        function closeReturning( returnValue )
        {
            window.returnValue = returnValue;
            window.close();
        }
        
    </script>
</head>
<body style="margin:0px;">
    <iframe id="wrappedForm" style="width: 495px; height: 100%;" frameborder="1" scrolling="no"></iframe>
    <form id="form1" runat="server" style="display:none;">
    <div>
    </div>
    </form>
</body>
</html>
