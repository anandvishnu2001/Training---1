<cfif structKeyExists(session,"check")>
	<cfif session.check.access>
		<cflocation url="logbook.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cfset session.check = structNew()>
	<cfset session.check.access=false>
</cfif>
<cfif structKeyExists(form,"btn")>
	<cfinclude template="object.cfm">
	<cfset manager.insertUser(form.username,
					form.name,
					form.email,
					form.password)>
</cfif>