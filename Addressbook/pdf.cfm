<cfinclude template="object.cfm">
<cfset log = manager.getList(session.userid)>
<cfheader name="Content-Disposition" value="attachment; filename=example.pdf">
<cfheader name="Content-Type" value="application/pdf">

<cfcontent type="application/pdf" reset="true">

<cfdocument format="PDF" orientation="portrait">
	<h1 style="text-align: center;">Address Book</h1>
	<table border="1" cellpadding="5" cellspacing="0">	
		<thead>
			<tr>
				<th></th>
				<th>Name</th>
				<th>Email</th>
				<th>Phone</th>
				<th>Hobbies</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#structCount(log)#" index="i">
				<cfoutput>
					<tr>
						<td><img src="./uploads/#log[i][2]#" width="50" height="50"></td>
						<td>#log[i][3]#</td>
						<td>#log[i][4]#</td>
						<td>#log[i][5]#</td>
						<td>#log[i][6]#</td>
					</tr>
				</cfoutput>
			</cfloop>
		</tbody>
	</table>
</cfdocument>