<cfif form.e_profile NEQ "">
	<cfset uploadDir = expandPath('./uploads/')>        
	<cfif not directoryExists(uploadDir)>
		<cfdirectory action="create" directory="#uploadDir#">
	</cfif>
	<cffile action="upload"
		filefield="e_profile"
		destination="#uploadDir#"
		nameConflict="makeunique">
	<cfset filename = cffile.serverFile>
<cfelse>
	<cfset filename = "">
</cfif>