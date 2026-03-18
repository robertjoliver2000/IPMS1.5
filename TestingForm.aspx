<%@ Page language="c#" Inherits="ProjectPortfolio.TestingForm" CodeFile="TestingForm.aspx.cs" %>
<%@ Register TagPrefix="uc_SecL" TagName="SectionI" Src="Controls/SectionI.ascx" %>
<%@ Register TagPrefix="uc_SecK" TagName="SectionH" Src="Controls/SectionH.ascx" %>
<%@ Register TagPrefix="uc_SecH" TagName="SectionJ" Src="Controls/SectionJ.ascx" %>
<%@ Register TagPrefix="uc_SecF" TagName="SectionF" Src="Controls/SectionF.ascx" %>
<%@ Register TagPrefix="uc_SecE" TagName="SectionE" Src="Controls/SectionE.ascx" %>
<%@ Register TagPrefix="uc_PM" TagName="PM" Src="Controls/ProgrammeManager.ascx" %>
<%@ Register TagPrefix="uc_A" TagName="IGA" Src="Controls/IGAudit.ascx" %>
<%@ Register TagPrefix="uc_Admin" TagName="Admin" Src="Controls/Admin_Period.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>TEST</title>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript" type="text/javascript">
		function JavaScript_Testing()
		{
		    debugger
		    
		    var returnCode
			returnCode = "|Overall, Please select, 0||Cost, Amber, 2||Deliverables, Red, 3||Time, Green, 1||Risks, Amber, 2||Benefits, Please select, 0|";
		    
		    //lets stick this into an array
		    //var PPR_RAG_Indicators = new Array();
		    
		  //  var arrayPos;
		    var max;
		    var currentPosition, nextPosition;
		    var pprItem;
		    var pprStatus;
		    var pprStatusID;
		    
		    arrayPos = 0;  // holds the "column" ref beign currently used for the array
		    max = returnCode.length;
		    currentPosition = 0 //returnCode.indexOf("|");
		    		    
		    while (currentPosition < max)
		    {//  SAMPLE STRING:
		     //  "|Overall, Please select, 0||Cost, Amber, 2|"
		     
		        //pre    Set all values to ""
		        pprItem = "";
		        pprStatus = "";
		        pprStatusID = "";
		        		     
		     
		        //start
		        currentPosition = returnCode.indexOf("|", currentPosition);
		        		        
		        //PPR Item
		        //find the next comma, after the "|" character
		        nextPosition = returnCode.indexOf(",", currentPosition);		        
		        pprItem =  returnCode.substring(currentPosition + 1, nextPosition).replace(" ", "");
		        currentPosition = nextPosition;
		        
		        //Status
		        //find the next comma
		        //currentPosition = returnCode.indexOf(",", currentPosition);
		        //find the first comma after the one above
		        nextPosition = returnCode.indexOf(",", currentPosition+1);
		        pprStatus =  returnCode.substring(currentPosition + 1, nextPosition).replace(" ", "");
		        currentPosition = nextPosition;
		        
		        //StatusID
		        //find the next pipe 
		        nextPosition = returnCode.indexOf("|", currentPosition+1);
		        pprStatusID =  returnCode.substring(currentPosition + 1, nextPosition).replace(" ", "");
		        currentPosition = nextPosition;
		        
		        //adjustment to current pos
		        currentPosition = currentPosition + 1;
		        
		        
		        //put these values into the array
//		        PPR_RAG_Indicators[arrayPos,0] = pprItem;
//		        PPR_RAG_Indicators[arrayPos,1] = pprStatus;
//		        PPR_RAG_Indicators[arrayPos,2] = pprStatusID;    
//		        
//		        arrayPos = arrayPos + 1;
		        	        
		    }
		    
		    
		
		}
		</script>   
	</HEAD>
	<BODY onload="javascript:JavaScript_Testing();">
		<form id="frmMain" method="post" runat="server">
		    <uc_Admin:Admin id="ctlAdmin" runat="server"></uc_Admin:Admin>
		    <br>
		    <br>
		    <asp:Button id="btnUpdate" runat="server" Text="Update" onclick="btnUpdate_Click" Visible="false"></asp:Button>
		</form>
	</BODY>
</HTML>
