<%@ Page language="c#" Inherits="ProjectPortfolio.DatePicker" CodeFile="DatePicker.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Pick a date</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<style type="text/css">
		BODY { PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 4px; PADDING-TOP: 0px }
		BODY { FONT-SIZE: 9pt; FONT-FAMILY: Verdana, Geneva, Sans-Serif }
		TABLE { FONT-SIZE: 9pt; FONT-FAMILY: Verdana, Geneva, Sans-Serif }
		TR { FONT-SIZE: 9pt; FONT-FAMILY: Verdana, Geneva, Sans-Serif }
		TD { FONT-SIZE: 9pt; FONT-FAMILY: Verdana, Geneva, Sans-Serif }
		</style>
		<LINK href="style.css" type="text/css" rel="stylesheet">
	</head>
	<body onblur="this.window.focus();" ms_positioning="FlowLayout">
		<form id="Form1" method="post" runat="server">
			<div align="center">
				<asp:calendar id="ctrlCalendar" runat="server" bordercolor="#999999" BackColor="White" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="7pt" ForeColor="Black" Height="180px" Width="200px">
					<todaydaystyle forecolor="Black" backcolor="#CCCCCC"></todaydaystyle>
					<selectorstyle backcolor="#CCCCCC"></selectorstyle>
					<nextprevstyle VerticalAlign="Bottom"></nextprevstyle>
					<dayheaderstyle backcolor="Gainsboro" Font-Bold="True" Font-Size="8pt" BorderStyle="None" BorderWidth="1px"></dayheaderstyle>
					<selecteddaystyle font-bold="True" backcolor="#666666" ForeColor="White"></selecteddaystyle>
					<titlestyle font-bold="True" backcolor="Silver" BorderColor="DarkGray" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt"></titlestyle>
					<othermonthdaystyle forecolor="Gray"></othermonthdaystyle>
                    <WeekendDayStyle BackColor="#FFFFCC" />
                    <DayStyle Font-Names="Verdana" Font-Size="8pt" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
				</asp:calendar>
			</div>
		</form>
	</body>
</html>
