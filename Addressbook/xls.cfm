<cfinclude template="object.cfm">
<cfset log = manager.getList(session.userid)>

<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>

<cfset SpreadsheetAddRow(spreadsheetObj,'user,,#now()#')>
<cfset SpreadsheetAddRow(spreadsheetObj,'Name,email,phone')>
<cfloop array="#log.RESULTSET#" index="i">
	<cfset SpreadsheetAddRow(spreadsheetObj,'#i.name#,#i.email#,#i.phone#')>
</cfloop>

<cfset SpreadsheetMergeCells(spreadsheetObj,1,1,1,2)>

<cfset title={color="blue",fgcolor="aqua",bold="true",alignment="center",fontsize="23"}>
<cfset date={fgcolor="aqua",bold="true",alignment="right",verticalalignment="vertical_top"}>
<cfset head={color="blue",fgcolor="teal",bold="true",alignment="center",fontsize="20"}>
<cfset data={fgcolor="grey_25_percent"}>

<cfset SpreadsheetFormatCell(spreadsheetObj,title,1,1)>
<cfset SpreadsheetFormatCell(spreadsheetObj,date,1,3)>
<cfset SpreadsheetFormatRow (spreadsheetObj,head,2)>
<cfloop from="3" to="#3+log.RECORDCOUNT#" index="i">
	<cfif i%2 EQ 0>
		<cfset SpreadsheetFormatRow(spreadsheetObj,data,i)>
	</cfif>
</cfloop>
<cfloop from="1" to="#SpreadsheetGetColumnCount(spreadsheetObj,'AddressBook')#" index="i">
	<cfset SpreadSheetSetColumnWidth (spreadsheetobj,i,30)>
</cfloop>

<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >