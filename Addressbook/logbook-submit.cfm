<cfif structKeyExists(session,"check") AND session.check>
	<cfif structKeyExists(form,"btn")>
		<cfset session.check = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>