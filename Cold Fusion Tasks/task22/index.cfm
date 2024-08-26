<cfset jsondata = '[{"Name":"saravanan","Age":27,"LOCATION":"dubai"},{"Name":"Ram","Age":26,"LOCATION":"Kovilpatti"}]'>
<cfset data = deserializeJSON(jsondata)>
<table cellspacing="10" cellpadding="10">
		<tr>
			<th align="center">Name</th>
			<th align="center">Age</th>
			<th align="center">Location</th>
		</tr>
		<cfloop array="#data#" item="i">
			<tr>
				<cfoutput>
					<td align="left">#i.name#</td>
					<td align="left">#i.age#</td>
					<td align="left">#i.location#</td>
				</cfoutput>
			</tr>
		</cfloop>
</table>