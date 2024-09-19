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
	<cfset session.check = manager.checkPass(form.username,form.password)>
	<cfif session.check.access>
		<cflocation url="logbook.cfm" addToken="no" statusCode="302">
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
</cfif>
