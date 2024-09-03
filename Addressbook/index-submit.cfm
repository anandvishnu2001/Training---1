<cfset session.check = false>

<cfif structKeyExists(form,"btn")>
	<cfinclude template="object.cfm">
	<cfset session.check = manager.checkPass(form.username,form.password)>
	<cfif session.check>
		<cflocation url="logbook.cfm" addToken="no" statusCode="302">
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
</cfif>
