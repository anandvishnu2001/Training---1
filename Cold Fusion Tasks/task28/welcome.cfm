<cfif structKeyExists(session,"check") AND session.check>
	<cfif structKeyExists(form,"logout")>
		<cfset session.check = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>
<h1>Welcome to Page List</h1>
<table>
	<cfoutput query=>
		<tr>
			<th></th>
			<td></td>
			<td></td>
		</tr>
	</cfoutput>
</table>
<button>Add</button> <button>Log out</button>