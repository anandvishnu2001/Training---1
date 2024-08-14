<table cellspacing="20" cellpadding="20">
	<cfloop from="1" to="3" index="i">
		<tr>
			<cfloop from="0" to="6" step="3" index="j">
				<th><cfoutput>#j+i#</cfoutput></th>
			</cfloop>
		</tr>
	</cfloop>
</table>