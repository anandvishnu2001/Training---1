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
		<cfset variables.title  =  manager.selectTitle()>
		<cfset checkTitle = StructFindValue(variables.title,trim(inputExcel.title))>
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
		<cfset variables.gender  =  manager.selectGender()>
		<cfset checkGender = StructFindValue(variables.gender,trim(inputExcel.gender))>
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
		<cfset variables.hobbies  =  manager.selectHobbies()>
		<cfset hobby = listMap(inputExcel.hobbies,function(item){
			checkHobbies = StructFindValue(variables.hobbies,trim(item));
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
<cfset arrayAppend(error, success, "true")>
<cfreturn error>