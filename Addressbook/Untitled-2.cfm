//---arguments
<cfset local.message = {
	errors = []
}>
		<cfset local.title = selectTitle()>
		<cfif structKeyExists(arguments.data,'titleId')>
			<cfif len(trim(arguments.data.titleId)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*Title field is required.")>
			<cfelseif NOT listFind(local.title.id,arguments.data.titleId)>
				<cfset arrayAppend(local.message.errors,"*Invalid value for title field")>
			</cfif>
		<cfelseif structKeyExists(arguments.data,'titleName')>
			<cfif len(trim(arguments.data.titleName)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*Title")>
			<cfelseif NOT listFind(local.title.value,arguments.data.titleName)>
				<cfset arrayAppend(local.message.errors,"*Title(Valid)")>
			</cfif>			
		<cfelse>
			<cfset arrayAppend(local.message.errors,"*Title field is not found")>
		</cfif>
		<cfif structKeyExists(arguments.data,'firstname')>
			<cfset arrayAppend(error,"*Firstname field is not found")>
		<cfelseif len(arguments.data.firstname) EQ 0>
			<cfset arrayAppend(error,"*Firstname field is Empty")>
		</cfif>
		<cfif structKeyExists(arguments.data,'firstname')>
			<cfset arrayAppend(error,"*Lastname field is not found")>
		<cfelseif len(arguments.data.lastname) EQ 0>
			<cfset arrayAppend(error,"*Lastname field is Empty")>
		</cfif>
		<cfset local.gender = selectGender()>
		<cfif structKeyExists(arguments.data,'genderId')>
			<cfif len(trim(arguments.data.genderId)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*Gender field is required.")>
			<cfelseif NOT listFind(local.gender.id,arguments.data.genderId)>
				<cfset arrayAppend(local.message.errors,"*Invalid value for gender field")>
			</cfif>
		<cfelseif structKeyExists(arguments.data,'genderName')>
			<cfif len(trim(arguments.data.genderName)) EQ 0>
				<cfset arrayAppend(local.message.errors,"*Gender")>
			<cfelseif NOT listFind(local.gender.value,arguments.data.genderName)>
				<cfset arrayAppend(local.message.errors,"*Gender(Valid)")>
			</cfif>			
		<cfelse>
			<cfset arrayAppend(local.message.errors,"*Gender field is not found")>
		</cfif>
		<cfif len(arguments.data.date_of_birth) EQ 0>
			<cfset arrayAppend(error,"*Date_of_birth field is Empty")>
		<cfelseif NOT isDate(arguments.data.date_of_birth) OR (isDate(arguments.data.date_of_birth) AND arguments.data.date_of_birth GT now())>
			<cfset arrayAppend(error,"Input of Date_of_birth field is Invalid")>
		</cfif>
		<cfif len(arguments.data.profile) EQ 0 AND len(arguments.data.id) EQ 0>
			<cfset arrayAppend(error,"*Profile pic field is Empty")>
		<cfelse>
			<cfif arguments.data.profile NEQ "">
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
			<cfif NOT len(arguments.data.profile) EQ 0>
				<cfset ext = "jpg,jpeg,png,gif,bmp,tiff">
				<cfif NOT listFindNoCase(ext,listLast(filename,"."))>
					<cffile action = "delete" 
						file = "#uploadDir##filename#">
					<cfset arrayAppend(error,"Input of Profile pic field is Invalid")>
				</cfif>
			</cfif>
		</cfif>
		<cfif len(arguments.data.house_flat) EQ 0>
			<cfset arrayAppend(error,"*House_flat field is Empty")>
		</cfif>
		<cfif len(arguments.data.street) EQ 0>
			<cfset arrayAppend(error,"*Street field is Empty")>
		</cfif>
		<cfif len(arguments.data.city) EQ 0>
			<cfset arrayAppend(error,"*City field is Empty")>
		</cfif>
		<cfif len(arguments.data.state) EQ 0>
			<cfset arrayAppend(error,"*State field is Empty")>
		</cfif>
		<cfif len(arguments.data.country) EQ 0>
			<cfset arrayAppend(error,"*Country field is Empty")>
		</cfif>
		<cfif len(arguments.data.pincode) EQ 0>
			<cfset arrayAppend(error,"*Pincode field is Empty")>
		</cfif>
		<cfif len(arguments.data.email) EQ 0>
			<cfset arrayAppend(error,"*Email field is Empty")>
		<cfelseif NOT REFindNoCase("^[\w]+@[\w]+\.[a-zA-Z]{2,}$",arguments.data.email)>
			<cfset arrayAppend(error,"Input of Email field is Invalid")>
		</cfif>
		<cfif len(arguments.data.phone) EQ 0>
			<cfset arrayAppend(error,"*Phone field is Empty")>
		<cfelseif NOT REFindNoCase("[0-9]{10}",arguments.data.phone)>
			<cfset arrayAppend(error,"*Input of Phone field is Invalid")>
		</cfif>
		<cfset local.hobby = selectHobbies()>
		<cfif structKeyExists(arguments.data,"hobbyIds")>
			<cfloop list="#arguments.data.hobbyIds#" index="local.i">
				<cfif NOT listFind(local.hobby.id,local.i)>
					<cfset arrayAppend(local.message.errors,"*Invalid value for hobbies field")>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfelseif structKeyExists(arguments.data,"hobbieNames")>
			<cfloop list="#arguments.data.hobbieNames#" index="local.i">
				<cfif NOT listFind(local.hobby.value,local.i)>
					<cfset arrayAppend(local.message.errors,"*Invalid value for hobbies field")>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfelse> 
			<cfset arrayAppend(local.message.errors,"*Hobbies field is required.")>
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