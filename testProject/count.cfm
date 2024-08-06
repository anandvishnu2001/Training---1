<cfset search = "the quick brown fox jumps over the lazy dog">
<cfform action="" method="post">
	<label>Enter keyword:</label>
	<cfinput name="keyword" type="text">
	<br><cfinput name="btn" type="submit">
</cfform>
<cfif NOT isNull(form.btn)>
	<cfset count = ListValueCountNoCase(search,form.keyword,' ')>
	<cfif count NEQ 0>
		<cfoutput>Found the keyword #count# times in - #search#</cfoutput>
	<cfelse>
		<cfoutput>Keyword #count# not found in - #search#</cfoutput>
	</cfif>
</cfif>