<cfif structKeyExists(url,"action")>
	<cfset spreadsheetObj  =  SpreadsheetNew("AddressBook","true")>
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
	<cfinclude template = "object.cfm">
	<cfset log  =  manager.getList()>
	<cfif url.action EQ "upload" AND structKeyExists(url,"excel")>
		<cfset select  =  manager.selectSet()>
		<cfspreadsheet
			action = "read"
			headerrow = "1"
			excludeHeaderRow = "true"
			src = "#url.excel#"
			query = "inputExcel">
		<cfset inputExcel.addColumn("Result","varchar",arrayNew(1))>
		<cfoutput query = "inputExcel">
			<cfset pending  =  "">
			<cfif (NOT queryKeyExists(inputExcel,"title")) OR len(inputExcel.title) EQ 0>
				<cfset pending  =  listAppend(pending,"Title",",")>
			<cfelse>
				<cfset structDelete(variables,"qtitle")>
				<cfset checkTitle = StructFindValue(select.title,trim(inputExcel.title))>
				<cfif arrayLen(checkTitle) NEQ 0>
					<cfset qtitle = val(checkTitle[1].key)>
				<cfelse>
					<cfset pending  =  listAppend(pending,"Title(Valid)",",")>
				</cfif>
			</cfif>
			<cfif (NOT queryKeyExists(inputExcel,"firstname")) OR len(inputExcel.firstname) EQ 0>
				<cfset pending  =  listAppend(pending,"Firstname",",")>
			</cfif>
			<cfif (NOT queryKeyExists(inputExcel,"lastname")) OR len(inputExcel.lastname) EQ 0>
				<cfset pending  =  listAppend(pending,"Lastname",",")>
			</cfif>
			<cfif (NOT queryKeyExists(inputExcel,"gender")) OR len(inputExcel.gender) EQ 0>
				<cfset pending  =  listAppend(pending,"Gender",",")>
			<cfelse>
				<cfset structDelete(variables,"qgender")>
				<cfset checkGender = StructFindValue(select.gender,trim(inputExcel.gender))>
				<cfif arrayLen(checkGender) NEQ 0>
					<cfset qgender = val(checkGender[1].key)>
				<cfelse>
					<cfset pending  =  listAppend(pending,"Gender(Valid)",",")>
				</cfif>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"DOB") OR len(inputExcel.DOB) EQ 0>
				<cfset pending  =  listAppend(pending,"DOB",",")>
			<cfelseif NOT isDate(inputExcel.DOB) OR (isDate(inputExcel.DOB) AND inputExcel.DOB GT now())>
				<cfset pending  =  listAppend(pending,"DOB(Valid)",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"house") OR len(inputExcel.house) EQ 0>
				<cfset pending  =  listAppend(pending,"House",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"street") OR len(inputExcel.street) EQ 0>
				<cfset pending  =  listAppend(pending,"Street",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"city") OR len(inputExcel.city) EQ 0>
				<cfset pending  =  listAppend(pending,"City",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"state") OR len(inputExcel.state) EQ 0>
				<cfset pending  =  listAppend(pending,"State",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"country") OR len(inputExcel.country) EQ 0>
				<cfset pending  =  listAppend(pending,"Country",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"pincode") OR len(inputExcel.pincode) EQ 0>
				<cfset pending  =  listAppend(pending,"Pincode",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"email") OR len(inputExcel.email) EQ 0>
				<cfset pending  =  listAppend(pending,"Email",",")>
			<cfelseif NOT REFindNoCase("^[\w]+@[\w]+\.[a-zA-Z]{2,}$",inputExcel.email)>
				<cfset pending  =  listAppend(pending,"Email(Valid)",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"phone") OR len(inputExcel.phone) EQ 0>
				<cfset pending  =  listAppend(pending,"Phone",",")>
			<cfelseif NOT REFindNoCase("[0-9]{10}",inputExcel.phone)>
				<cfset pending  =  listAppend(pending,"Phone(Valid)",",")>
			</cfif>
			<cfif NOT queryKeyExists(inputExcel,"hobbies") OR listLen(inputExcel.hobbies) EQ 0>
				<cfset pending  =  listAppend(pending,"Hobbies",",")>
			<cfelse>
				<cfset flag = 0>
				<cfset hobby = listMap(inputExcel.hobbies,function(item){
					checkHobbies = StructFindValue(select.hobbies,trim(item));
					if(arrayLen(checkHobbies) NEQ 0)
						return checkHobbies[1].key;
					else
						flag  =  1;
				})>
				<cfif flag EQ 1>
					<cfset pending  =  listAppend(pending,"Hobbies(Valid)",",")>
				</cfif>
			</cfif>
			<cfif len(pending) NEQ 0>
				<cfset QuerySetCell(inputExcel,"Result",pending&" missing",inputExcel.currentRow)>
			<cfelse>
				<cfset idStruct = manager.getIdByEmail(inputExcel.email)>
				<cfset manager.modifyContact( log_id = (idStruct.check ? idStruct.id : ""),
					title = qtitle,
					firstname = inputExcel.firstname,
					lastname = inputExcel.lastname,
					gender = qgender,
					date_of_birth = dateformat(inputExcel.DOB,"yyyy-mm-dd"),
					profile = (idStruct.check ? log[idStruct.id].profile : "signup.png"),
					house_flat = inputExcel.house,
					street = inputExcel.street,
					city = inputExcel.city,
					state = inputExcel.state,
					country = inputExcel.country,
					pincode = inputExcel.pincode,
					email = inputExcel.email,
					phone = inputExcel.phone,
					hobbies = hobby
				)>
				<cfif idStruct.check>
					<cfset QuerySetCell(inputExcel,"Result","updated",inputExcel.currentRow)>
				<cfelse>
					<cfset QuerySetCell(inputExcel,"Result","added",inputExcel.currentRow)>
				</cfif>
				</cfif>
		</cfoutput>
		<cfset error  =  arrayNew(1)>
		<cfset success  =  arrayNew(1)>
		<cfset QueryEach(inputExcel,function(any obj){
				if(find("missing",obj.result))
					arrayAppend(error,obj);
				else
					arrayAppend(success,obj);
			})>
		<cfset sortExcel  =  QueryNew(
			"Title,
				Firstname,
				Lastname,
				Gender,
				DOB,
				House,
				Street,
				City,
				State,
				Country,
				Pincode,
				Email,
				Phone,
				Hobbies,
				Result",
			"VARCHAR,
				VARCHAR,
				VARCHAR,
				VARCHAR,
				DATE,
				VARCHAR,
				VARCHAR,
				VARCHAR,
				VARCHAR,
				VARCHAR,
				VARCHAR,
				VARCHAR,
				VARCHAR,
				VARCHAR,
				VARCHAR")>
		<cfset sortExcel.addRow(error)>
		<cfset sortExcel.addRow(success)>
		<cfset SpreadsheetAddRows(spreadsheetObj,sortExcel,1,1,true,[],true)>
		<cfset head = {color = "gold",fgcolor = "teal",bold = "true",alignment = "center",fontsize = "13"}>
		<cfset SpreadsheetFormatRow(spreadsheetObj,head,1)>
		<cfset session.excel  =  spreadsheetObj>
	<cfelse>
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
		<cfif url.action EQ "data">
			<cfset j = 1>
			<cfloop collection = "#log#" item = "i">
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].title[StructKeyList(log[i].title)[1]]#",j+1,1,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].firstname#",j+1,2,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].lastname#",j+1,3,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].gender[StructKeyList(log[i].gender)[1]]#",j+1,4,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#dateFormat(log[i].date_of_birth,"yyyy/mm/dd")#",j+1,5)>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].house_flat#",j+1,6,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].street#",j+1,7,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].city#",j+1,8,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].state#",j+1,9,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].country#",j+1,10,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].pincode#",j+1,11,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].email#",j+1,12,"STRING")>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#log[i].phone#",j+1,13,"STRING")>
				<cfset hobbies  =  listMap(StructKeyList(log[i].hobbies), function(item) {
						return log[i].hobbies[item];
					})>
				<cfset spreadsheetSetCellValue(spreadsheetObj,"#hobbies#",j+1,14,"STRING")>
				<cfset j++>
			</cfloop>
			<cfloop from = "1" to = "#1+structCount(log)#" index = "i">
				<cfif i%2 EQ 0>
					<cfset SpreadsheetFormatRow(spreadsheetObj,{fgcolor = "grey_25_percent",verticalalignment = "vertical_center"},i)>
				</cfif>
			</cfloop>
			<cfset binary  =  SpreadsheetReadBinary(spreadsheetObj)>
			<cfheader name = "Content-Disposition" value = "attachment; filename = AddressBook-DataIncluded-Template.xlsx">
		<cfelseif url.action EQ "download" AND structKeyExists(session,"excel")>
			<cfset binary  =  SpreadsheetReadBinary(session.excel)>
			<cfheader name = "Content-Disposition" value = "attachment; filename = AddressBook-Upload-Result.xlsx">
		<cfelseif url.action EQ "plain">
			<cfset binary  =  SpreadsheetReadBinary(spreadsheetObj)>
			<cfheader name = "Content-Disposition" value = "attachment; filename = AddressBook-Plain-Template.xlsx">
		</cfif>
	<cfset head = {color = "gold",fgcolor = "teal",bold = "true",alignment = "center",fontsize = "13"}>
	<cfset SpreadsheetFormatRow(spreadsheetObj,head,1)>
	<cfcontent type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable = "#binary#">
	</cfif>
<cfelse>
	<div class = "bg-body w-100 h-100 d-flex flex-wrap mt-5 mx-3 pt-5">
		<p class = "border h1 my-1 mx-2">Excel file not uploaded</p>
	</div>
</cfif>