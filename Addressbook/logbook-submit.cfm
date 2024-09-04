<cfif structKeyExists(session,"check") AND session.check[3]>
	<cfif structKeyExists(form,"btn")>
		<cfset session.check[3] = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>