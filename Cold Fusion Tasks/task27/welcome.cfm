<cfif structKeyExists(session,"result") AND session.result>
	<cfif structKeyExists(form,"logout")>
		<cfset session.result = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>
<cfoutput>Welcome</cfoutput>
<form action="" method="post">
	<input type="submit" name="logout" value="Logout">
</form>