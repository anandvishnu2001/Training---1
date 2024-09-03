<cfif structKeyExists(session,"check") AND session.check>
	<cfif structKeyExists(form,"btn")>
		<cfset session.check=false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>
<form method="post">
	<button onclick="addPage()">Add</button>
	<input name="btn" type="submit" value="Log out">
</form>