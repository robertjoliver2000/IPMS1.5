<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PPR_Status_DDL.ascx.cs" Inherits="Controls_PPR_Status_DDL" %>
<table class="PPR_Status_DDL">
    <tr><th runat="server" id="PPRHeader" title="?">?</th></tr>
    <tr>
        <td>
            <div style="position:relative; display:inline;">
                <img runat="server" style="display:inline; position:relative;" id="img"
                    src="~/images/PPR_grey.png"
                    alt="- - Please select - Click to edit"
                    onclick="PPR_hideImg( this );"
                />
                <select runat="server" id="ddl" style="display:none; position:absolute; top:5px; left:5px; width:30px;"
				        onblur="PPR_hideDdl( this );" onchange="PPR_hideDdl( this );" onclick="PPR_hideDdl( this );" size="4">
                    <option value="None"  style="background-color:#808080;"	>-</option>
                    <option value="Red"   style="background-color:#ff0000;"	>R</option>
                    <option value="Amber" style="background-color:#ffd800;"	>A</option>
                    <option value="Green" style="background-color:#00ff21;"	>G</option>
                </select>
            </div>
        </td>
    </tr>
</table>