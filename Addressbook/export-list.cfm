<cfif url.action CONTAINS "excel">
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

	<cfif url.action NEQ "excelPlain">
		<cfinclude template="object.cfm">
		<cfset log = manager.getList()>
	</cfif>

	<cfif url.action EQ "excelResult" AND structKeyExists(url, "sheet")>
		<cfset spreadsheetSetCellValue(spreadsheetObj, "Result", 1, 15, "STRING")>
		<cfset SpreadSheetSetColumnWidth(spreadsheetObj,15,35)>
		<cfset SpreadsheetAddRows(spreadsheetObj, url.sheet, 1, 1, true, [], true)>
		<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Upload-Result.xlsx">
	<cfelse>
		<cfif url.action EQ "excelPlain">
			<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Plain-Template.xlsx">

		<cfelseif url.action EQ "excelData">
			<cfloop array="#log#" index="i" item="j">
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.title.value#", i+1, 1, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.firstname#", i+1, 2, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.lastname#", i+1, 3, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.gender.value#", i+1, 4, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#dateFormat(j.date_of_birth,"yyyy/mm/dd")#", i+1, 5)>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.house_flat#", i+1, 6, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.street#", i+1, 7, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.city#", i+1, 8, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.state#", i+1, 9, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.country#", i+1, 10, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.pincode#", i+1, 11, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.email#", i+1, 12, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#j.phone#", i+1, 13, "STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj, "#arrayToList(arrayMap(j.hobbies, function(item){
					return item.value;
				}))#", i+1, 14, "STRING")>
				<cfif i%2 EQ 0>
					<cfset SpreadsheetFormatRow(
						spreadsheetObj,
						{	fgcolor="grey_25_percent",
							verticalalignment="vertical_center"
						},
						i
					)>
				</cfif>
			</cfloop>
			<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-DataIncluded-Template.xlsx">
		</cfif>
		<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>
	</cfif>
	<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#">
	
<cfelseif url.action EQ "pdf">
	<cfinclude template="object.cfm">
	<cfset log = manager.getList()>
	<cfheader name="Content-Disposition" value="attachment; filename=example.pdf">
	<cfheader name="Content-Type" value="application/pdf">
	<cfcontent type="application/pdf" reset="true">
	<cfdocument format="PDF" orientation="portrait">
		<h1 style="text-align: center;">Address Book</h1>
		<table border="1" cellpadding="5" cellspacing="0">	
			<thead>
				<tr>
					<th></th>
					<th>Name</th>
					<th>Email</th>
					<th>Phone</th>
					<th>Hobbies</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput>
					<cfloop array="#log#" item="i">
						<tr>
							<td><img src="./uploads/#i.profile#" width="50" height="50"></td>
							<td>#i.title.value# #i.firstname# #i.lastname#</td>
							<td>#i.email#</td>
							<td>#i.phone#</td>
							<td>
								<cfloop array="#i.hobbies#" index="j" item="k">
									#k.value#
									<cfif j NEQ arrayLen(i.hobbies)>,<br></cfif>
								</cfloop>
							</td>
						</tr>
					</cfloop>
				</cfoutput>
			</tbody>
		</table>
	</cfdocument>
</cfif>