<cfif structKeyExists(session,"check") AND session.check>
	<cfif structKeyExists(form,"btn")>
		<cfset session.check=false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>
<cfset page = createObject('component','manager')>
<cfset pages = page.getPageID()>
<h1>Welcome to Page List</h1>
<table border="2" cellpadding="2" cellspacing="5">
	<cfoutput query="pages">
		<tr>
			<td><a href="view.cfm?value=#pageid#">Page ID :  #pageid#</a></td>
			<cfif session.role>
				<td><button onclick="editPage('#pageid#')">Edit</button></td>
				<td><button onclick="deletePage('#pageid#')">Delete</button></td>
			</cfif>
		</tr>
	</cfoutput>
</table>
<br>
<form method="post">
	<button onclick="addPage()">Add</button>
	<input name="btn" type="submit" value="Log out">
</form>
<script src="./js/jQuery.js"></script>
<script src="./js/script.js"></script>