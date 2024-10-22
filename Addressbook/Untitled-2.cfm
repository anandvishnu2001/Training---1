//---arguments
<cfset local.message = {
	error = [],
	pending = ""
}>
		<cfset variables.title = manager.selectTitle>
		<cfif structKeyExists(arguments.data,'title')>
			<cfif len(trim(arguments.data.title)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*title field is required.")>
			<cfelseif NOT listFind(local.result.titleList,arguments.data.title)>
				<cfset arrayAppend(local.message.errors,"*invalid value for title field")>
			</cfif>
		<cfelseif structKeyExists(arguments.data,'titleName')>
			<cfif len(trim(arguments.data.titleName)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*title field is required.")>
			<cfelseif NOT listFind(local.result.titleNameList,arguments.data.titleName)>
				<cfset arrayAppend(local.message.errors,"*invalid value for title field")>
			</cfif>			
		<cfelse>
			<cfset arrayAppend(local.message.errors,"*title field is missing")>
		</cfif>
		<cfif NOT structKeyExists(arguments, "title") OR (structKeyExists(arguments,"title") AND len(arguments.title) EQ 0)>
			<cfset arrayAppend(error,"*Title field to be selected")>
		<cfelseif NOT listFind(structKeyList(variables.title),trim(arguments.title))>
			<cfset arrayAppend(error,"*Selection of Title field is Invalid")>
		<cfelseif (NOT queryKeyExists(quer,"title")) OR len(quer.title) EQ 0>
			<cfset pending = arrayAppend(pending,"Title",",")>
		<cfelse>
			<cfset structDelete(variables,"qtitle")>
			<cfset checkTitle=StructFindValue(variables.title,trim(quer.title))>
			<cfif arrayLen(checkTitle) NEQ 0>
				<cfset qtitle=val(checkTitle[1].key)>
			<cfelse>
				<cfset pending = arrayAppend(pending,"Title(Valid)",",")>
			</cfif>
		</cfif>
		</cfif>
		<cfif len(arguments.firstname) EQ 0>
			<cfset arrayAppend(error,"*Firstname field is Empty")>
		</cfif>
		<cfif len(arguments.lastname) EQ 0>
			<cfset arrayAppend(error,"*Lastname field is Empty")>
		</cfif>
		<cfset variables.gender = manager.selectGender>
		<cfif NOT structKeyExists(arguments, "gender") OR (structKeyExists(arguments,"gender") AND len(arguments.gender) EQ 0)>
			<cfset arrayAppend(error,"*Gender field to be selected")>
		<cfelseif NOT listFind(structKeyList(variables.gender),trim(arguments.gender))>
			<cfset arrayAppend(error,"*Selection of Gender field is Invalid")>
		</cfif>
		<cfif len(arguments.date_of_birth) EQ 0>
			<cfset arrayAppend(error,"*Date_of_birth field is Empty")>
		<cfelseif NOT isDate(arguments.date_of_birth) OR (isDate(arguments.date_of_birth) AND arguments.date_of_birth GT now())>
			<cfset arrayAppend(error,"Input of Date_of_birth field is Invalid")>
		</cfif>
		<cfif len(arguments.profile) EQ 0 AND len(arguments.id) EQ 0>
			<cfset arrayAppend(error,"*Profile pic field is Empty")>
		<cfelse>
			<cfif arguments.profile NEQ "">
				<cfset uploadDir = expandPath('./uploads/')>        
				<cfif not directoryExists(uploadDir)>
					<cfdirectory action="create" directory="#uploadDir#">
				</cfif>
				<cffile action="upload"
					filefield="profile"
					destination="#uploadDir#"
					nameConflict="makeunique">
				<cfset filename = cffile.serverFile>
			<cfelse>
				<cfset filename = "">
			</cfif>
			<cfif NOT len(arguments.profile) EQ 0>
				<cfset ext = "jpg,jpeg,png,gif,bmp,tiff">
				<cfif NOT listFindNoCase(ext,listLast(filename,"."))>
					<cffile action = "delete" 
						file = "#uploadDir##filename#">
					<cfset arrayAppend(error,"Input of Profile pic field is Invalid")>
				</cfif>
			</cfif>
		</cfif>
		<cfif len(arguments.house_flat) EQ 0>
			<cfset arrayAppend(error,"*House_flat field is Empty")>
		</cfif>
		<cfif len(arguments.street) EQ 0>
			<cfset arrayAppend(error,"*Street field is Empty")>
		</cfif>
		<cfif len(arguments.city) EQ 0>
			<cfset arrayAppend(error,"*City field is Empty")>
		</cfif>
		<cfif len(arguments.state) EQ 0>
			<cfset arrayAppend(error,"*State field is Empty")>
		</cfif>
		<cfif len(arguments.country) EQ 0>
			<cfset arrayAppend(error,"*Country field is Empty")>
		</cfif>
		<cfif len(arguments.pincode) EQ 0>
			<cfset arrayAppend(error,"*Pincode field is Empty")>
		</cfif>
		<cfif len(arguments.email) EQ 0>
			<cfset arrayAppend(error,"*Email field is Empty")>
		<cfelseif NOT REFindNoCase("^[\w]+@[\w]+\.[a-zA-Z]{2,}$",arguments.email)>
			<cfset arrayAppend(error,"Input of Email field is Invalid")>
		</cfif>
		<cfif len(arguments.phone) EQ 0>
			<cfset arrayAppend(error,"*Phone field is Empty")>
		<cfelseif NOT REFindNoCase("[0-9]{10}",arguments.phone)>
			<cfset arrayAppend(error,"*Input of Phone field is Invalid")>
		</cfif>
		<cfset variables.hobbies = manager.selectHobbies>
		<cfif NOT structKeyExists(arguments,"hobbies") OR (structKeyExists(arguments,"hobbies") AND listLen(arguments.hobbies) EQ 0)>
			<cfset arrayAppend(error,"*Hobbies field to be selected")>
		<cfelse>
			<cfset tflag=0>
			<cfloop list="#arguments.hobbies#" item="i">
				<cfif NOT listFind(structKeyList(variables.hobbies),i)>
					<cfset tflag=1>
				</cfif>
			</cfloop>
			<cfif tflag EQ 1>
				<cfset arrayAppend(error,"*Selection of Hobbies field is Invalid")>
			</cfif>
		</cfif>

//---xls
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