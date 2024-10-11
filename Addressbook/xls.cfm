<cfset spreadsheetObj = SpreadsheetNew("AddressBook","true")>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,1,6)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,2,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,3,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,4,8)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,5,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,6,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,7,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,8,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,9,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,10,15)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,11,10)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,12,25)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,13,13)>
<cfset SpreadSheetSetColumnWidth(spreadsheetObj,14,35)>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Title",1,1,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Firstname",1,2,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Lastname",1,3,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Gender",1,4,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"DOB",1,5,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"House",1,6,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Street",1,7,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"City",1,8,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"State",1,9,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Country",1,10,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Pincode",1,11,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Email",1,12,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Phone",1,13,"STRING")>
<cfset spreadsheetSetCellValue(spreadsheetObj,"Hobbies",1,14,"STRING")>
<cfset head={color="gold",fgcolor="teal",bold="true",alignment="center",fontsize="13"}>
<cfset SpreadsheetFormatRow(spreadsheetObj,head,1)>
<cfif url.action NEQ "plain">
	<cfinclude template="object.cfm">
	<cfset log = manager.getList()>
</cfif>
<cfif  url.action EQ "upload" AND structKeyExists(form,"uploadbtn")>
	<cfif len(form.upload) EQ 0>
		<div class="bg-body d-flex flex-wrap mt-5 mx-3 pt-5">
			<p class="border my-1 mx-2">*Excel File Not Uploaded</p>
		</div>
	<cfelse>
		<cfset theDir = expandPath('./uploads/')>
		<cffile action="upload"
			filefield="form.upload"
			destination="#theDir#"
			nameConflict="makeunique">
		<cfspreadsheet
			action="read"
			headerrow="1"
			excludeHeaderRow="true"
			src="#arguments.excel#"
			query="quer">
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
				<cfset flag=0>
				<cfset hobby=listMap(quer.hobbies,function(item){
						checkHobbies=StructFindValue(select.hobbies,trim(item));
						if(arrayLen(checkHobbies) NEQ 0)
							return item;
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
				<cfset log = getList()>
				<cfset idStruct=manager.getIdByEmail(quer.email)>
				<cfset modifyContact( log_id=(idStruct.check ? idStruct.id : ""),
					title=qtitle,
					firstname=quer.firstname,
					lastname=quer.lastname,
					gender=qgender,
					date_of_birth=dateformat(quer.DOB,"yyyy-mm-dd"),
					profile=(idStruct.check ? log[idStruct.id].profile : "signup.png"),
					house_flat=quer.house,
					street=quer.street,
					city=quer.city,
					state=quer.state,
					country=quer.country,
					pincode=quer.pincode,
					email=quer.email,
					phone=quer.phone,
					hobbies=hobby )>
				<cfif idStruct.check>
					<cfset QuerySetCell(quer,"Result","updated",quer.currentRow)>
				<cfelse>
					<cfset QuerySetCell(quer,"Result","added",quer.currentRow)>
				</cfif>
			</cfif>
		</cfoutput>
		<cfset error = arrayNew(1)>
		<cfset success = arrayNew(1)>
		<cfset QueryEach(quer,function(any obj){
				if(find(obj.result,"missing"))
					arrayAppend(error,obj);
				else
					arrayAppend(success,obj);
			})>
		<cfset sortquer = QueryNew()>
		<cfset sortquer.addRow(error)>
		<cfset sortquer.addRow(success)>
		<cflocation url="xls.cfm?action=upload&" addToken="no" statusCode="302">
	</cfif><!---
	<cfset SpreadsheetAddRows(spreadsheetObj,sortquer,1,1,true,[],true)>
	<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Upload-Result.xlsx">--->
	<cfdump var="#form.upload#">
<cfelseif url.action EQ "plain">
	<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Plain-Template.xlsx">
<cfelseif url.action EQ "data">
	<cfset j=1>
	<cfloop collection="#log#" item="i">
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].title[StructKeyList(log[i].title)[1]]#",j+1,1,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].firstname#",j+1,2,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].lastname#",j+1,3,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].gender[StructKeyList(log[i].gender)[1]]#",j+1,4,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].date_of_birth#",j+1,5,"DATE")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].house_flat#",j+1,6,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].street#",j+1,7,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].city#",j+1,8,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].state#",j+1,9,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].country#",j+1,10,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].pincode#",j+1,11,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].email#",j+1,12,"STRING")>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].phone#",j+1,13,"NUMERIC")>
		<cfset hobbies = listMap(StructKeyList(log[i].hobbies), function(item) {
				return log[i].hobbies[item];
			})>
		<cfset spreadsheetSetCellValue(spreadsheetObj,"#hobbies#",j+1,14,"STRING")>
		<cfset j++>
	</cfloop>
	<cfloop from="1" to="#1+structCount(log)#" index="i">
		<cfif i%2 EQ 0>
			<cfset SpreadsheetFormatRow(spreadsheetObj,{fgcolor="grey_25_percent",verticalalignment="vertical_center"},i)>
		</cfif>
	</cfloop>
	<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-DataIncluded-Template.xlsx">
</cfif>
<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#">