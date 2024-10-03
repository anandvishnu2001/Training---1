<cfinclude template="object.cfm">
<cfset log = manager.getList()>

<cffile action="upload"
	filefield="form.upload"
	destination="#expandPath('./uploads/')#"
	nameConflict="makeunique">
<cfdump var="#cffile#">

<cfspreadsheet
	action="read"
	headerrow="2"
	src="#expandPath('./uploads/')##cffile.ServerFile#"
	query="quer">

<cfoutput query="quer">
		<cfif quer.currentRow GT 2><cfdump var="#quer.currentRow#"><cfif QueryKeyExists(quer, "profile") >
	<cfdump var="#quer.profile#"></cfif>
<!---
OR (structKeyExists(form,"title") AND len(form.title) EQ 0)>
		<cfset arrayAppend(error,"*Title field to be selected")>
	<cfelseif NOT listFind(structKeyList(select.title),trim(form.title))>
		<cfset arrayAppend(error,"*Selection of Title field is Invalid")>
	</cfif>
	<cfif len(form.firstname) EQ 0>
		<cfset arrayAppend(error,"*Firstname field is Empty")>
	</cfif>
	<cfif len(form.lastname) EQ 0>
		<cfset arrayAppend(error,"*Lastname field is Empty")>
	</cfif>
	<cfif NOT structKeyExists(form, "gender") OR (structKeyExists(form,"gender") AND len(form.gender) EQ 0)>
		<cfset arrayAppend(error,"*Gender field to be selected")>
	<cfelseif NOT listFind(structKeyList(select.gender),trim(form.gender))>
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
		<cfinclude template="image.cfm">
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
	<cfif NOT structKeyExists(form,"hobbies") OR (structKeyExists(form,"hobbies") AND listLen(form.hobbies) EQ 0)>
		<cfset arrayAppend(error,"*Hobbies field to be selected")>
	<cfelse>
		<cfset tflag=0>
		<cfloop list="#form.hobbies#" item="i">
			<cfif NOT listFind(structKeyList(select.hobbies),i)>
				<cfset tflag=1>
				</cfif>
		</cfloop>
		<cfif tflag EQ 1>
			<cfset arrayAppend(error,"*Selection of Hobbies field is Invalid")>
		</cfif>
	</cfif>--->
</cfif>
</cfoutput><!---
<cfset SpreadsheetAddColumn(quer,"Result")>

<cfset binary = SpreadsheetReadBinary(quer)>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook-Upload-Result.xlsx">

<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#">--->



