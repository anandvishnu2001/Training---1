<cfif structKeyExists(session, "check") 
	AND session.check.access>
	<cflocation url="logbook.cfm" addToken="no">
<cfelse>
	<cfset session.check = structNew()>
	<cfset session.check.access=false>
</cfif>
<cfif structKeyExists(form, "btn")>
	<cfinclude template="object.cfm">
	<cfset manager.checkPass(id = form.username, password = form.password)>
	<cfif session.check.access>
		<cflocation url="logbook.cfm" addToken="no">
	<cfelse>
		<cflocation url="index.cfm" addToken="no">
	</cfif>
</cfif>
