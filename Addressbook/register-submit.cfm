<cfif structKeyExists(session,"check") AND session.check.access>
	<cflocation url="logbook.cfm" addToken="no" statusCode="302">
<cfelse>
	<cfset session.check = structNew()>
	<cfset session.check.access=false>
</cfif>
<cfif structKeyExists(form, "btn")>
	<cfinclude template="object.cfm">
	<cfset manager.insertUser(
		username = form.username,
		name = form.name,
		email = form.email,
		password = form.password)>
</cfif>