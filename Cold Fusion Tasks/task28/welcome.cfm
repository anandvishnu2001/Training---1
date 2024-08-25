<cfif structKeyExists(session,"check") AND session.check>
	<cfif structKeyExists(form,"logout")>
		<cfset session.check = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>
<cfset page = createObject('component','manager')>
<cfset pages = page.getPageID()>
<h1>Welcome to Page List</h1>
<table>
	<cfoutput query="#pages#">
		<tr>
			<th>Page ID :  #pages.pageid#</th>
			<cfif session.role>
				<td><button>Edit</button></td>
				<td><button>Delete</button></td>
			</cfif>
		</tr>
	</cfoutput>
</table>
<button>Add</button> <button>Log out</button>