<cfquery name="GetName" datasource="train">
	SELECT firstname,lastname FROM name;
</cfquery>
<form action="" method="post">
	<label>Enter record no.:</label>
	<input name="n" type="number" min="1" max="10">
	<br><input name="btn" type="submit">
</form>
<cfif NOT isNull(form.btn)>
	<cfoutput>
		<table border="3 solid black" cellspacing="5" cellpadding="5">
			<caption><b><i>Name</i></b></caption>
			<thead><tr>
				<th align="center">First Name</th>
				<th align="center">Last Name</th>
			</tr></thead>
			<tbody>
				<cfoutput query="GetName">
					<tr>
						<td align="right">#GetName.firstname#</td>
						<td align="right">#GetName.lastname#</td>
					</tr>
				</cfoutput>
			</tbody>
		</table><br>
		Firstname at record (<b>#form.n#</b>) is <b>#GetName.firstname[form.n]#</b>
	</cfoutput>
</cfif>
