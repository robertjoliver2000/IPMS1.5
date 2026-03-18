<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PPR_Comments.aspx.cs" Inherits="PPR_Comments" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>PPR Comments</title>
    <base target="_self" />
    <style type="text/css">
        .PPRCommentsBox				{
                                    width:300px;
                                    text-align:right;
                                    }
        .PPRCommentsBox	textarea	{
                                    width:100%;
                                    height:75px;
                                    margin-bottom:10px;
                                    }
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
    <script language="javascript" type="text/javascript">

        function textLimit(field, maxlen) 
        {
            if (field.value.length > maxlen + 1)
                alert('You have exceeded the text limit of ' + maxlen.toString() + ' characters.');
            if (field.value.length > maxlen)
                field.value = field.value.substring(0, maxlen);
        }
    </script>

    <link href="Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="PPRCommentsBox">
        <asp:Label ID="lblMessage" runat="server" Text="" Visible="false" CssClass="error"></asp:Label>
        <h1 id="lblInitiativeName" runat="server" >Initiative not found</h1>
        <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" CssClass="textinput"
            onkeyup="textLimit(this, 200);" onchange="textLimit(this, 200);" Text=""></asp:TextBox>
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="def" OnClick="btnSave_Click" />
        <button id="btnCancel" value="Cancel" class="def" onclick="window.close();">Cancel</button>
    </div>
    </form>
</body>
</html>
