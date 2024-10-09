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
				<cfset pending = listAppend(pending,"Title(Valid)",",")>
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
				<cfset pending = listAppend(pending,"Gender(Valid)",",")>
			</cfif>
		</cfif>
		<cfif NOT queryKeyExists(quer,"DOB") OR len(quer.DOB) EQ 0>
			<cfset pending = listAppend(pending,"DOB",",")>
		<cfelseif NOT isDate(quer.DOB) OR (isDate(quer.DOB) AND quer.DOB GT now())>
			<cfset pending = listAppend(pending,"DOB(Valid)",",")>
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
			<cfset pending = listAppend(pending,"Email(Valid)",",")>
		</cfif>
		<cfif NOT queryKeyExists(quer,"phone") OR len(quer.phone) EQ 0>
			<cfset pending = listAppend(pending,"Phone",",")>
		<cfelseif NOT REFindNoCase("[0-9]{10}",quer.phone)>
			<cfset pending = listAppend(pending,"Phone(Valid)",",")>
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
				<cfset pending = listAppend(pending,"Hobbies(Valid)",",")>
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

<cfset sortquer = querySort(quer,function(row1,row2){
		if(find("missing",row1.result))
			sortkey1=1;
		else if(row1.result EQ "added")
			sortkey1=2;
		else if(row1.result EQ "updated")
			sortkey1=3;
		if(find("missing",row2.result))
			sortkey2=1;
		else if(row2.result EQ "added")
			sortkey2=2;
		else if(row2.result EQ "updated")
			sortkey2=3;
		return compare(sortkey1,sortkey2);
	})>
<cfdump var="#sortquer#">

<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>

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



<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Upload-Result.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#">--->