<cfinclude template="object.cfm">
<cfset log = manager.getList()>
<cfset theDir = expandPath('./uploads/')>

<cffile action="upload"
	filefield="form.upload"
	destination="#theDir#"
	nameConflict="makeunique">

<cfspreadsheet
	action="read"
	headerrow="1"
	excludeHeaderRow = "true"
	src="#theDir##cffile.ServerFile#"
	query="quer">
<cfdump var="#quer#">

<cfset quer.addColumn("Result","varchar",arrayNew(1))>

<cfoutput query="quer">
		<cfset pending = "">
		<cfif (NOT queryKeyExists(quer,"title")) OR len(quer.title) EQ 0>
			<cfset pending = listAppend(pending,"Title",",")>
		<cfelse>
			<cfset structDelete(variables,"qtitle")>
			<cfset checkTitle=StructFindValue(select.title,trim(quer.title))>
			<cfif arrayLen(checkTitle) NEQ 0>
				<cfset qtitle=val(checkTitle[1].key)>
			<cfelse>
				<cfset pending = listAppend(pending,"Title(Invalid)",",")>
			</cfif>
		</cfif>
		<cfif (NOT queryKeyExists(quer,"firstname")) OR len(quer.firstname) EQ 0>
			<cfset pending = listAppend(pending,"Firstname",",")>
		</cfif>
		<cfif (NOT queryKeyExists(quer,"lastname")) OR len(quer.lastname) EQ 0>
			<cfset pending = listAppend(pending,"Lastname",",")>
		</cfif>
		<cfif (NOT queryKeyExists(quer,"gender")) OR len(quer.gender) EQ 0>
			<cfset pending = listAppend(pending,"Gender",",")>
		<cfelse>
			<cfset structDelete(variables,"qgender")>
			<cfset checkGender=StructFindValue(select.gender,trim(quer.gender))>
			<cfif arrayLen(checkGender) NEQ 0>
				<cfset qgender=val(checkGender[1].key)>
			<cfelse>
				<cfset pending = listAppend(pending,"Gender(Invalid)",",")>
			</cfif>
		</cfif>
		<cfif NOT queryKeyExists(quer,"DOB") OR len(quer.DOB) EQ 0>
			<cfset pending = listAppend(pending,"DOB",",")>
		<cfelseif NOT isDate(quer.DOB) OR (isDate(quer.DOB) AND quer.DOB GT now())>
			<cfset pending = listAppend(pending,"DOB(Invalid)",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"house") OR len(quer.house) EQ 0>
			<cfset pending = listAppend(pending,"House",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"street") OR len(quer.street) EQ 0>
			<cfset pending = listAppend(pending,"Street",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"city") OR len(quer.city) EQ 0>
			<cfset pending = listAppend(pending,"City",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"state") OR len(quer.state) EQ 0>
			<cfset pending = listAppend(pending,"State",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"country") OR len(quer.country) EQ 0>
			<cfset pending = listAppend(pending,"Country",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"pincode") OR len(quer.pincode) EQ 0>
			<cfset pending = listAppend(pending,"Pincode",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"email") OR len(quer.email) EQ 0>
			<cfset pending = listAppend(pending,"Email",",")>
		<cfelseif NOT REFindNoCase("^[\w]+@[\w]+\.[a-zA-Z]{2,}$",quer.email)>
			<cfset pending = listAppend(pending,"Email(Invalid)",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"phone") OR len(quer.phone) EQ 0>
			<cfset pending = listAppend(pending,"Phone",",")>
		<cfelseif NOT REFindNoCase("[0-9]{10}",quer.phone)>
			<cfset pending = listAppend(pending,"Phone(Invalid)",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"hobbies") OR listLen(quer.hobbies) EQ 0>
			<cfset pending = listAppend(pending,"Hobbies",",")>
		<cfelse>
			<cfset hobby="">
			<cfset flag=0>
			<cfset arrayHobbies=listToArray(quer.hobbies)>
			<cfset arrayEach(arrayHobbies,function(value){
					checkHobbies=StructFindValue(select.hobbies,trim(value));
					if(arrayLen(checkHobbies) NEQ 0)
						hobby = listAppend(hobby,checkHobbies[1].key,",");
					else
						flag = 1;
				})>
			<cfif flag EQ 1>
				<cfset pending = listAppend(pending,"Hobbies(Invalid)",",")>
			</cfif>
		</cfif>
		<cfif len(pending) NEQ 0>
			<cfset QuerySetCell(quer,"Result",pending&" missing",quer.currentRow)>
		<cfelse>
			<cfset idStruct=manager.getIdByEmail(quer.email)>
				<cfset manager.modifyContact( (idStruct.check ? idStruct.id : ""),
						qtitle,
						quer.firstname,
						quer.lastname,
						qgender,
						dateformat(quer.DOB,"yyyy-mm-dd"),
						(idStruct.check ? log[idStruct.id].profile : "signup.png"),
						quer.house,
						quer.street,
						quer.city,
						quer.state,
						quer.country,
						quer.pincode,
						quer.email,
						quer.phone,
						hobby )>
			<cfif idStruct.check>
				<cfset QuerySetCell(quer,"Result","updated",quer.currentRow)>
			<cfelse>
				<cfset QuerySetCell(quer,"Result","added",quer.currentRow)>
			</cfif>
		</cfif>
</cfoutput>
<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>

<cfdump var="#quer#">

<cfset SpreadSheetSetColumnWidth(spreadsheetobj,1,6)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,2,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,3,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,4,8)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,5,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,6,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,7,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,8,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,9,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,10,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,11,10)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,12,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,13,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,14,35)>
<cfset SpreadSheetSetColumnWidth(spreadsheetobj,15,35)>

<cfset head={color="gold",fgcolor="teal",bold="true",alignment="center",fontsize="13"}>

<cfset SpreadsheetFormatRow(spreadsheetObj,head,1)>

<cfset row={miss=2,add=2,update=2}>

<cfoutput query="quer">
	<cfset q=QueryGetRow(quer,quer.currentRow)>
	<cfif find("missing",q.result)>
		<cfset cur=row.miss>
		<cfset row.miss++>
		<cfdump var="#cur#">
	<cfelseif q.result EQ "added>
		<cfset cur=row.add>
		<cfset row.add++>
		<cfdump var="#cur#">
	<cfelseif q.result EQ "updated">
		<cfset cur=row.update>
		<cfset row.update++>
		<cfdump var="#cur#">
	</cfif><!---
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,1),missStart,1)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,2),missStart,2)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,3),missStart,3)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,4),missStart,4)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,5),missStart,5)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,6),missStart,6)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,7),missStart,7)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,8),missStart,8)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,9),missStart,9)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,10),missStart,10)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,11),missStart,11)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,12),missStart,12)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,13),missStart,13)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,14),missStart,14)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,15),missStart,15)>--->
</cfoutput>
<!---
<cfloop from="2" to="#spreadsheetObj.ROWCOUNT#" index="i">
	<cfif find("issing",spreadsheetGetCellValue(spreadsheetObj,i,15))>
		<cfset SpreadsheetShiftRows(spreadsheetObj,missStart,#spreadsheetObj.ROWCOUNT#,1)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,1),missStart,1)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,2),missStart,2)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,3),missStart,3)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,4),missStart,4)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,5),missStart,5)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,6),missStart,6)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,7),missStart,7)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,8),missStart,8)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,9),missStart,9)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,10),missStart,10)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,11),missStart,11)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,12),missStart,12)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,13),missStart,13)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,14),missStart,14)>
		<cfset spreadsheetSetCellValue(spreadsheetObj,spreadsheetGetCellValue(spreadsheetObj,i,15),missStart,15)>
		<cfset missStart++>
	</cfif>
</cfloop>
<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Upload-Result.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#">--->