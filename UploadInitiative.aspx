<%@ Page language="c#" Inherits="ProjectPortfolio.UploadInitiative" CodeFile="UploadInitiative.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	
	<HEAD>
		<title id="pageTitle" runat="server">Upload Initiative</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<BASE target="_self">
		
		<script type="text/javascript" src="js/BrainJar.js"></script>
        <script type="text/javascript" src="js/utils.js"></script>
		<script type="text/javascript">
		
		function BeginUpload()
		{   
		    // disable the button
		    var btn;
		    btn = document.getElementById("btnUpload");  
		    btn.disabled = true;
		    
		    //show the working label
		    var lbl;
		    lbl = document.getElementById("lblShortUploadResponse"); 		  
		    lbl.innerText = "Working...";		  
		    
		    
		    //show the popup window plus gif
		    
		    var popUp;
		    //popUp = document.getElementById("popUpMsgContent"); 
		    //popUp.innerText = ""
		    
		    //utils.js 
		    togglePopup('divPopUp');
		    //togglePopup('iframePopUp');		    
		    
		    return true;
		}
		//<!-- OnClientClick="return BeginCommit()"-->
		function BeginCommit()
		{
		      // disable the button
		    var btn;
		    btn = document.getElementById("btnCommitChanges");  
		    btn.disabled = true;
		    
		    //show the working label
		    var lbl;
		    lbl = document.getElementById("lblShortCommitResponse"); 		  
		    lbl.innerText = "Working...";		
		    		    
		    //utils.js 
		    togglePopup('divPopUp');
		    
		    return true;		    
		}
		
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
		
		</script> 
	</HEAD>
	
	
	<body style="text-align: left" >
		<form id="frmUploadInitiative" method="post" runat="server">

        <table class="def" style="width: 80%">
            <tr>
                <td align="left" colspan="1" style="width: 143%">
                    <span style="text-decoration: underline">Upload Initiatives:</span></td>
            </tr>
            <tr>
                <td align="left" colspan="1" style="width: 143%; height: 20px;">
                    1.
                    Download Excel Template and Save to Local Drive.
                    <asp:Image ID="Image1" runat="server" Height="16px" ImageUrl="~/Images/iconExcel.gif" Width="19px" />&nbsp;
                    <asp:LinkButton ID="DownLoadTemplate" style="FONT-SIZE: 10px; FONT-FAMILY: Verdana" runat="server" OnClick="DownLoadTemplate_Click">DownLoad Template</asp:LinkButton></td>
            </tr>           
            <tr>
                <td align="left" colspan="1" style="width: 143%">
                    </td>
            </tr>
            <tr>
                <td align="left" colspan="1" style="width: 143%; height: 21px;" valign="bottom">
                    2.
                    Browse For Upload Template File.<asp:FileUpload ID="FileUpload1" runat="server" CssClass="def" Width="451px" /></td>
            </tr>
            <tr>
                <td align="left" colspan="1" style="width: 143%">
                </td>
            </tr>
            <tr>
                <td align="left" colspan="1" style="width: 143%">
                    3. Upload Template.&nbsp;&nbsp;<asp:Button ID="btnPopGrid" runat="server" CssClass="def" EnableViewState="False"
                        OnClick="btnPopGrid_Click" Text="Upload" visible="false"/> &nbsp;
                    <input id="btnUpload" type="button" onclick="BeginUpload();" onserverclick="btnPopGrid_Click" class="def" value="Upload" runat="server" />&nbsp;
                    <asp:Label ID="lblShortUploadResponse" Text="" runat="server"></asp:Label>
                   
                    <asp:HiddenField ID="hidUploadID" runat="server" />
                    &nbsp;
                </td>
            </tr>
             
            <tr>
                <td align="left" colspan="1" style="width: 143%">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="left" colspan="1" style="width: 143%">
                    4. Confirm and apply this Upload Data. &nbsp;
                        <input id="btnCommitChanges" type="button" onclick="BeginCommit();" onserverclick="btnCommitChanges_Click" class="def" value="Commit Changes" runat="server"  disabled="true"/>
                        &nbsp;
                    <asp:Label ID="lblShortCommitResponse" runat="server" Width="188px"></asp:Label></td>
            </tr>
             <tr>
                <td align="left" colspan="1" style="width: 143%">
                    &nbsp;
                </td>
            </tr>
            <tr>
               <td align="left" colspan="1" style="width: 143%">
                    &nbsp;
                    <table>
                    <tr>
                    <td style="width:5%"></td>
                    <td style="width:95%">
                     
                     <asp:Panel ID="pnlUnresolvedContacts" runat="server" Height="50px" Width="100%" Visible = "false">
                        &nbsp;
                        <asp:Label ID="lblUnresovledContactMsg" runat="server" Text="The following people could not be resolved...."
                            Visible="True" Width="552px"></asp:Label>                            
                        
                        <br />
                             <asp:GridView ID="gvUnresolvedContacts" runat="Server" 
                                PagerSettings-Mode="NextPrevious" PagerSettings-NextPageText="Next..." PagerSettings-PreviousPageText="Prev..."
                                PageSize="5" EnableViewState="False" AutoGenerateColumns="True" OnRowDataBound="gvUnresolvedContacts_RowDataBound" >
                                <PagerSettings Mode="NextPrevious" NextPageText="Next..." PreviousPageText="Prev..." />
                                <RowStyle BackColor="White" />
                                <PagerStyle Font-Bold="True" HorizontalAlign="Right" />
                                <HeaderStyle BackColor="SteelBlue" Font-Bold="True" Font-Size="Smaller" ForeColor="White" />
                                <AlternatingRowStyle BackColor="Gainsboro" Wrap="True" /> 
                             </asp:GridView>
                             
                             <!-- ERW 18 Mar 2009 these two hidden fields have been so that I can use existing functionality for
                                    pop-up contacts select window with minimum alterations
                                -->
                             <input id="hContact" runat="server"  type="hidden" />
                             <input id="hContactID" runat="server" type="hidden" />                                 
                        <br />                        
                         <asp:LinkButton ID="lnkValidate" runat="server" OnClick="lnkValidate_Click" Visible="false" >xxx</asp:LinkButton> <br />
                         <asp:Label ID="lblUnresolvedContactAlt" runat="server" Text="Label">xxx</asp:Label></asp:Panel> 
                        
                     <asp:Panel ID="pnlUploadDetails" runat="server" Height="50px" Width="100%" Visible = "false">
                        &nbsp;
                        <asp:Label ID="lblUploadMessage" runat="server" Text="All Tabs validated / X, Y , Z did not validate successfully"
                            Visible="False" Width="552px"></asp:Label>                            
                        <br />
                        <asp:GridView ID="gvProjects" runat="Server" OnPageIndexChanging="gvProjects_PageIndexChanging"
                            PagerSettings-Mode="NextPrevious" PagerSettings-NextPageText="Next..." PagerSettings-PreviousPageText="Prev..."
                            PageSize="5" EnableViewState="False" AutoGenerateColumns="True" OnDataBinding="gvProjects_DataBinding" OnDataBound="gvProjects_DataBound" OnRowDataBound="gvProjects_RowDataBound">
                            <PagerSettings Mode="NextPrevious" NextPageText="Next..." PreviousPageText="Prev..." />
                            <RowStyle BackColor="White" />
                            <PagerStyle Font-Bold="True" HorizontalAlign="Right" />
                            <HeaderStyle BackColor="Navy" Font-Bold="True" Font-Size="Smaller" ForeColor="White" />
                            <AlternatingRowStyle BackColor="Gainsboro" Wrap="True" />  
                                          
                        </asp:GridView>
                        <br />                        
                    </asp:Panel> 
                    
                     <asp:Panel ID="pnlResult" runat="server" Height="50px" Width="100%" Visible="False">
                       <asp:Label ID="lblResult" runat="server" Text="Upload completed / failed" Width="556px"></asp:Label>
                       <br />
                         <asp:GridView ID="gvRowsCommitted" runat="Server" OnPageIndexChanging="gvProjects_PageIndexChanging"
                            PagerSettings-Mode="NextPrevious" PagerSettings-NextPageText="Next..." PagerSettings-PreviousPageText="Prev..."
                            PageSize="5">
                            <PagerSettings Mode="NextPrevious" NextPageText="Next..." PreviousPageText="Prev..." />
                            <RowStyle BackColor="White" />
                            <PagerStyle Font-Bold="True" HorizontalAlign="Right" />
                            <HeaderStyle BackColor="LightSteelBlue" Font-Bold="True" Font-Size="Smaller" ForeColor="White" />
                            <AlternatingRowStyle BackColor="Gainsboro" Wrap="True" />                            
                        </asp:GridView>
                    </asp:Panel>
                        &nbsp;
                    </td></tr>
                    </table> 
                                         
                </td>
            </tr>
        </table>
			
			   
			  <div id="divPopUp"
				   style="position:absolute;top:200px;left:200px;z-index:100;display:none;width:250px;height:auto;background-color:white; border:solid 1px black;">
                   <table style="width:100%;" cellpadding="0" cellspacing="0">
                                <colgroup>
                                    <col style="width:10px;text-align:left;" />
                                    <col style="width:230px;text-align:center;" />
                                    <col style="width:10px;text-align:right;" />
                                </colgroup>
                                <tr style="background-color:#eaeaea; font-weight:bold;">                                    
                                    <td colspan="3" align="center" onmousedown="dragStart(event, 'divPopUp')" style="height: 13px">IPMS</td>                                    
                                </tr>
                                <tr style="vertical-align:top;">
                                    <td colspan="1"> 
                                        <img alt="working..." src="images\working.gif"/></td>
                                        <td id="xpopUpMsgContent" valign="middle">Working ... Please Wait</td>
                                </tr>
                    </table>
                </div>
			
		</form>
		<!--
		 <iframe id="iframePopUp" style="display:none;" src="Admin.aspx" >
			    
			          <div>
			             <table style="width:100%;" cellpadding="0" cellspacing="0">
                                <colgroup>
                                    <col style="width:10px;text-align:left;" />
                                    <col style="width:230px;text-align:center;" />
                                    <col style="width:10px;text-align:right;" />
                                </colgroup>
                                <tr style="background-color:#eaeaea; font-weight:bold;">                                    
                                    <td colspan="3" align="center" onmousedown="dragStart(event, 'divPopUp')" style="height: 13px">IPMS</td>                                    
                                </tr>
                                <tr style="vertical-align:top;">
                                    <td colspan="1"> 
                                        </td>
                                        <td id="Td1" valign="middle">Working ... Please Wait</td>
                                </tr>
                    </table>			            
                   </div>
	       </iframe>
		-->
	</body>
</HTML>
