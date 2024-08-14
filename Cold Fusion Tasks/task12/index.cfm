<!---<cfquery name="tableCreate" datasource="train">
	CREATE TABLE name(
		firstname VARCHAR(15),
		lastname VARCHAR(15));
	INSERT INTO name(firstname,lastname)
	VALUES	("Bruce","Banners"),
		("Charles","Xavier"),
		("Peter","Parker"),
		("Reed","Richards"),
		("Stephen","Strange"),
		("Steve","Rogers"),
		("Thor","Odinson"),
		("Tony","Stark"),
		("Victor","Von Doom"),
		("Wade","Wilson");
</cfquery>--->


<cfquery name="GetName" datasource="train">
	SELECT firstname,lastname FROM name;
</cfquery>
<cfform action="" method="post">
	<label>Enter record no.:</label>
	<cfinput name="n" type="number" min="1" max="10">
	<br><cfinput name="btn" type="submit">
</cfform>
<cfif NOT isNull(form.btn)>
	<cfoutput>
		<table border="3 solid black" cellspacing="5" cellpadding="5">
			<caption><b><i>Name</i></b></caption>
			<thead><tr>
				<th align="center">First Name</th>
				<th align="center">Last Name</th>
			</tr></thead>
			<tbody>
				<cfloop query="GetName">
					<tr>
						<td align="right">#GetName.firstname#</td>
						<td align="right">#GetName.lastname#</td>
					</tr>
				</cfloop>
			</tbody>
		</table><br>
		Firstname at record (<b>#form.n#</b>) is <b>#GetName.firstname[form.n]#</b>
	</cfoutput>
</cfif>
