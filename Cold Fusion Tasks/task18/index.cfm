<cfset manualQuery = queryNew("ID,name,email","Integer,Varchar,Varchar",
				[	[1,"Tony Stark","ironman@avengers.com"],
					[2,"Steve Rogers","captain@avengers.com"],
					[3,"Bruce Banner","hulk@avengers.com"]	])>
<table>
<cfoutput>  
	<table border="3 solid black" cellspacing="5" cellpadding="5">
		<caption><b><i>Manual Query</i></b></caption>
			<thead><tr>
				<th align="center">ID</th>
				<th align="center">Name</th>
				<th align="center">Email</th>
			</tr></thead>
			<tbody>
				<cfloop query="manualQuery">
					<tr>
						<td align="right">#ID#</td>
						<td align="left">#name#</td>
						<td align="left">#email#</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
</cfoutput>