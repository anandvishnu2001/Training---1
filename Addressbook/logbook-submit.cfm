<cfif structKeyExists(session,"check") AND session.check.access>
	<cfset error = []>
	<cfif structKeyExists(form,"btn")>
		<cfset session.check.access = false>
		<cflocation url="index.cfm" addToken="no">
	<cfelseif structKeyExists(form,"modalbtn")>
		<cfset formData = {
			"title" = form.title,
			"firstname" = form.firstname,
			"lastname" = form.lastname,
			"gender" = form.gender,
			"DOB" = form.date_of_birth,
			"profile" = form.profile,
			"house" = form.house_flat,
			"street" = form.street,
			"city" = form.city,
			"state" = form.state,
			"country" = form.country,
			"pincode" = form.pincode,
			"email" = form.email,
			"phone" = form.phone,
			"hobbies" = listToArray(form.hobbies)
		}>
		<cfif len(form.id) NEQ 0>
			<cfset formData["id"] = form.id>
		</cfif>
		<cfset errors = manager.contactValidate(formData)>
		<cfset variables.title = manager.selectTitle>
		<cfif NOT structKeyExists(form, "title") OR (structKeyExists(form,"title") AND len(form.title) EQ 0)>
			<cfset arrayAppend(error,"*Title field to be selected")>
		<cfelseif NOT listFind(structKeyList(variables.title),trim(form.title))>
			<cfset arrayAppend(error,"*Selection of Title field is Invalid")>
		</cfif>
		<cfif len(form.firstname) EQ 0>
			<cfset arrayAppend(error,"*Firstname field is Empty")>
		</cfif>
		<cfif len(form.lastname) EQ 0>
			<cfset arrayAppend(error,"*Lastname field is Empty")>
		</cfif>
		<cfset variables.gender = manager.selectGender>
		<cfif NOT structKeyExists(form, "gender") OR (structKeyExists(form,"gender") AND len(form.gender) EQ 0)>
			<cfset arrayAppend(error,"*Gender field to be selected")>
		<cfelseif NOT listFind(structKeyList(variables.gender),trim(form.gender))>
			<cfset arrayAppend(error,"*Selection of Gender field is Invalid")>
		</cfif>
		<cfif len(form.date_of_birth) EQ 0>
			<cfset arrayAppend(error,"*Date_of_birth field is Empty")>
		<cfelseif NOT isDate(form.date_of_birth) OR (isDate(form.date_of_birth) AND form.date_of_birth GT now())>
			<cfset arrayAppend(error,"Input of Date_of_birth field is Invalid")>
		</cfif>
		<cfif len(form.profile) EQ 0 AND len(form.id) EQ 0>
			<cfset arrayAppend(error,"*Profile pic field is Empty")>
		<cfelse>
			<cfif form.profile NEQ "">
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
			<cfif NOT len(form.profile) EQ 0>
				<cfset ext = "jpg,jpeg,png,gif,bmp,tiff">
				<cfif NOT listFindNoCase(ext,listLast(filename,"."))>
					<cffile action = "delete" 
						file = "#uploadDir##filename#">
					<cfset arrayAppend(error,"Input of Profile pic field is Invalid")>
				</cfif>
			</cfif>
		</cfif>
		<cfif len(form.house_flat) EQ 0>
			<cfset arrayAppend(error,"*House_flat field is Empty")>
		</cfif>
		<cfif len(form.street) EQ 0>
			<cfset arrayAppend(error,"*Street field is Empty")>
		</cfif>
		<cfif len(form.city) EQ 0>
			<cfset arrayAppend(error,"*City field is Empty")>
		</cfif>
		<cfif len(form.state) EQ 0>
			<cfset arrayAppend(error,"*State field is Empty")>
		</cfif>
		<cfif len(form.country) EQ 0>
			<cfset arrayAppend(error,"*Country field is Empty")>
		</cfif>
		<cfif len(form.pincode) EQ 0>
			<cfset arrayAppend(error,"*Pincode field is Empty")>
		</cfif>
		<cfif len(form.email) EQ 0>
			<cfset arrayAppend(error,"*Email field is Empty")>
		<cfelseif NOT REFindNoCase("^[\w]+@[\w]+\.[a-zA-Z]{2,}$",form.email)>
			<cfset arrayAppend(error,"Input of Email field is Invalid")>
		</cfif>
		<cfif len(form.phone) EQ 0>
			<cfset arrayAppend(error,"*Phone field is Empty")>
		<cfelseif NOT REFindNoCase("[0-9]{10}",form.phone)>
			<cfset arrayAppend(error,"*Input of Phone field is Invalid")>
		</cfif>
		<cfset variables.hobbies = manager.selectHobbies>
		<cfif NOT structKeyExists(form,"hobbies") OR (structKeyExists(form,"hobbies") AND listLen(form.hobbies) EQ 0)>
			<cfset arrayAppend(error,"*Hobbies field to be selected")>
		<cfelse>
			<cfset tflag=0>
			<cfloop list="#form.hobbies#" item="i">
				<cfif NOT listFind(structKeyList(variables.hobbies),i)>
					<cfset tflag=1>
				</cfif>
			</cfloop>
			<cfif tflag EQ 1>
				<cfset arrayAppend(error,"*Selection of Hobbies field is Invalid")>
			</cfif>
		</cfif>
		<cfif arrayLen(error) GT 0>
			<div class="bg-body d-flex flex-wrap mt-5 mx-3 pt-5">
				<cfoutput>
					<cfloop array="#error#" index="i">
						<p class="border my-1 mx-2">#i#</p>
					</cfloop>
				</cfoutput>
			</div>
		<cfelse>
			<cfset manager.modifyContact(
				log_id = (len(form.id) NEQ 0 ? form.id : ""),
				title = form.title,
				firstname = form.firstname,
				lastname = form.lastname,
				gender = form.gender,
				date_of_birth = form.date_of_birth,
				profile = filename,
				house_flat = form.house_flat,
				street = form.street,
				city = form.city,
				state = form.state,
				country = form.country,
				pincode = form.pincode,
				email = form.email,
				phone = form.phone,
				hobbies = form.hobbies
			)>
		</cfif>
	<cfelseif structKeyExists(form,"uploadbtn")>
		<cfif form.upload NEQ "">
			<cfset theDir = expandPath('./uploads/')>
			<cffile action="upload"
				filefield="form.upload"
				destination="#theDir#"
				nameConflict="makeunique">
			<cflocation url="xls.cfm?action=upload&excel=#URLEncodedFormat(theDir)##URLEncodedFormat(cffile.SERVERFILE)#" addToken="no">
			<cflocation url="logbook.cfm" addToken="no">
		<cfelse>
			<div class="bg-body d-flex flex-wrap mt-5 mx-3 pt-5">
				<p class="border my-1 mx-2">*Excel file not uploaded</p>
			</div>
		</cfif>
	<cfelseif structKeyExists(form,"deletebtn")>
		<cfset manager.deleteRecord( form.d_id )>
	<cfelseif structKeyExists(form,"return")>
		<cflocation url="logbook.cfm" addToken="no">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no">
</cfif>