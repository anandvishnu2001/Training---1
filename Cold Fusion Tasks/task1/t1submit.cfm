<cfif NOT isNull(form.btn)>
	<cfif form.ifrate EQ "5">
		<cfoutput>Very good</cfoutput>
	<cfelseif form.ifrate EQ "4">
		<cfoutput>Good</cfoutput>
	<cfelseif form.ifrate EQ "3">
		<cfoutput>Fair</cfoutput>
	<cfelseif form.ifrate EQ "2" OR form.ifrate EQ "1">
		<cfoutput>Ok</cfoutput>
	<cfelse>
		<cfoutput>Wrong rating(allowed only from 1 to 5)</cfoutput>
	</cfif>
</cfif>