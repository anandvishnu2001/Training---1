<cfinclude template="object.cfm">
<cfset log = manager.getList(session.userid)>
<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"#session.username#",1,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"#DateFormat(now(),"long")#",1,5)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"",2,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"NAME",2,2)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"EMAIL",2,3)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"PHONE",2,4)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"HOBBIES",2,5)>

<cfset SpreadsheetMergeCells(spreadsheetObj,1,1,1,4)>

<cfset title={color="dark_red",fgcolor="aqua",bold="true",alignment="center",fontsize="23"}>
<cfset date={fgcolor="aqua",bold="true",alignment="right",verticalalignment="vertical_top"}>
<cfset head={color="gold",fgcolor="teal",bold="true",alignment="center",fontsize="20"}>

<cfset SpreadsheetFormatCell(spreadsheetObj,title,1,1)>
<cfset SpreadsheetFormatCell(spreadsheetObj,date,1,5)>
<cfset SpreadsheetFormatRow(spreadsheetObj,head,2)>
<cfloop from="1" to="#structCount(log)#" index="i">
	<cfset image = expandPath("uploads/#log[i][2]#")>
	<cfset SpreadsheetSetRowHeight(spreadsheetObj,i+2,50)>
    	<cfset SpreadsheetAddImage(spreadsheetObj,image,"#i+2#,1,#i+3#,2")>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i][3]#",i+2,2)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,2,20)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i][4]#",i+2,3)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,3,30)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i][5]#",i+2,4)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,4,15)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i][6]#",i+2,5)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,5,50)>
</cfloop>
<cfloop from="3" to="#3+structCount(log)#" index="i">
	<cfif i%2 EQ 0>
		<cfset SpreadsheetFormatRow(spreadsheetObj,{fgcolor="grey_25_percent",verticalalignment="vertical_center"},i)>
	</cfif>
</cfloop>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >