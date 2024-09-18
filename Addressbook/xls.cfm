<cfinclude template="object.cfm">
<cfset log = manager.getList(session.userid)>
<cfdump var="#structCount(log)#">
<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"#session.username#",1,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"#now()#",1,3)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"NAME",2,1)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"EMAIL",2,2)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"PHONE",2,3)>

<cfset SpreadsheetMergeCells(spreadsheetObj,1,1,1,2)>

<cfset title={color="blue",fgcolor="aqua",bold="true",alignment="center",fontsize="23"}>
<cfset date={fgcolor="aqua",bold="true",alignment="right",verticalalignment="vertical_top"}>
<cfset head={color="blue",fgcolor="teal",bold="true",alignment="center",fontsize="20"}>
<cfset data={fgcolor="grey_25_percent"}>

<cfset SpreadsheetFormatCell(spreadsheetObj,title,1,1)>
<cfset SpreadsheetFormatCell(spreadsheetObj,date,1,3)>
<cfset SpreadsheetFormatRow(spreadsheetObj,head,2)>
<cfloop from="1" to="#structCount(log)#" index="i">
	<!---<cfset path="./uploads/#log[i][2]#">
	<cfset spreadsheetSetCellFormula(spreadsheetObj, 'HYPERLINK("' & path & '", "View Image")', i+2, 1)>--->
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i][3]#",i+2,1)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i][4]#",i+2,2)>
	<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i][5]#",i+2,3)>
</cfloop>
<cfloop from="3" to="#3+structCount(log)#" index="i">
	<cfif i%2 EQ 0>
		<cfset SpreadsheetFormatRow(spreadsheetObj,data,i)>
	</cfif>
</cfloop>
<cfloop from="1" to="#SpreadsheetGetColumnCount(spreadsheetObj,'AddressBook')#" index="i">
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,i,30)>
</cfloop>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >