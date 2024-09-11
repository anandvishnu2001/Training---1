<cfset session.check = false>
<cfset session.userid = "">
<cfset session.username = "">

<cfif structKeyExists(form,"btn")>
	<cfinclude template="object.cfm">
	<cfset access = manager.checkPass(form.username,form.password)>
	<cfset session.check = access>
	<cfif session.check>
		<cflocation url="logbook.cfm" addToken="no" statusCode="302">
	<cfelse>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
</cfif>
