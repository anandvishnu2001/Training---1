<cfset search = "the quick brown fox jumps over the lazy dog">
<form action="" method="post">
	<label>Enter keyword:</label>
	<input name="keyword" type="text">
	<br><input name="btn" type="submit">
</form>
<cfif structKeyExists(form,"btn")>
	<cfset count = ListValueCountNoCase(search,form.keyword,' ')>
	<cfif count NEQ 0>
		<cfoutput>Found the keyword #count# times in - #search#</cfoutput>
	<cfelse>
		<cfoutput>Keyword #count# not found in - #search#</cfoutput>
	</cfif>
</cfif>