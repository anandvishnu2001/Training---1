<cfif structKeyExists(url, "action")>
	<cfset spreadsheetObj = SpreadsheetNew("AddressBook", "true")>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Title", 1, 1, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,1,6)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Firstname", 1, 2, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,2,13)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Lastname", 1, 3, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,3,13)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Gender", 1, 4, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,4,8)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "DOB", 1, 5, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,5,13)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "House", 1, 6, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,6,25)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Street", 1, 7, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,7,15)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "City", 1, 8, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,8,15)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "State", 1, 9, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,9,15)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Country", 1, 10, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,10,15)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Pincode", 1, 11, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,11,10)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Email", 1, 12, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,12,25)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Phone", 1, 13, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,13,13)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "Hobbies", 1, 14, "STRING")>
	<cfset SpreadSheetSetColumnWidth(spreadsheetObj,14,35)>
	<cfset head={color="gold",fgcolor="teal",bold="true",alignment="center",fontsize="13"}>
	<cfset SpreadsheetFormatRow(spreadsheetObj, head, 1)>
	<cfif url.action NEQ "plain">
		<cfinclude template="object.cfm">
		<cfset log = manager.getList()>
	</cfif>
	<cfif url.action EQ "download" AND structKeyExists(url, "sheet")>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "Result", 1, 15, "STRING")>
		<cfset SpreadSheetSetColumnWidth(spreadsheetObj,15,35)>
		<cfset SpreadsheetAddRows(spreadsheetObj, url.sheet, 1, 1, true, [], true)>
		<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>
		<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Upload-Result.xlsx">
	<cfelse>
		<cfif url.action EQ "plain">
			<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>
			<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Plain-Template.xlsx">
		<cfelseif url.action EQ "data">
			<cfset j=1>
			<cfloop collection="#log#" item="i">
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].title[StructKeyList(log[i].title)[1]]#", j+1, 1, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].firstname#", j+1, 2, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].lastname#", j+1, 3, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].gender[StructKeyList(log[i].gender)[1]]#", j+1, 4, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#dateFormat(log[i].date_of_birth,"yyyy/mm/dd")#", j+1, 5)>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].house_flat#", j+1, 6, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].street#", j+1, 7, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].city#", j+1, 8, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].state#", j+1, 9, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].country#", j+1, 10, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].pincode#", j+1, 11, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].email#", j+1, 12, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#log[i].phone#", j+1, 13, "STRING")>
				<cfset hobbies = listMap(StructKeyList(log[i].hobbies), function(item) {
						return log[i].hobbies[item];
					})>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#hobbies#", j+1, 14, "STRING")>
				<cfif j%2 EQ 0>
					<cfset SpreadsheetFormatRow(
						spreadsheetObj,
						{	fgcolor="grey_25_percent",
							verticalalignment="vertical_center"
						},
						j
					)>
				</cfif>
				<cfset j++>
			</cfloop>
			<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>
			<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-DataIncluded-Template.xlsx">
		</cfif>
	</cfif>
	<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#">
</cfif>