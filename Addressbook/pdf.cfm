<cfinclude template="object.cfm">
<cfset log = DeserializeJSON(manager.getList(session.userid))>
<cfheader name="Content-Disposition" value="attachment; filename=example.pdf">
<cfheader name="Content-Type" value="application/pdf">

<cfcontent type="application/pdf" reset="true">

<cfdocument format="PDF" orientation="portrait">
	<h1 style="text-align: center;">Address Book</h1>
	<table border="1" cellpadding="5" cellspacing="0">	
		<thead>
			<tr>
				<th>Name</th>
				<th>Email</th>
				<th>Phone</th>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#log#" index="i">
				<cfoutput>
					<tr>
						<td>#i.name#</td>
						<td>#i.email#</td>
						<td>#i.phone#</td>
					</tr>
				</cfoutput>
			</cfloop>
		</tbody>
	</table>
</cfdocument>