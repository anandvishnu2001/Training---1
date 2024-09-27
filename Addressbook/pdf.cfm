<cfinclude template="object.cfm">
<cfset log = manager.getList()>
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
			<cfoutput>
				<cfloop collection="#log#" item="i">
					<tr>
						<td><img src="./uploads/#log[i].profile#" width="50" height="50"></td>
						<td>#log[i].title[StructKeyList(log[i].title)[1]]# #log[i].firstname# #log[i].lastname#</td>
						<td>#log[i].email#</td>
						<td>#log[i].phone#</td>
						<td>
							<cfloop list="#StructKeyList(log[i].hobbies)#" item="j">
								#log[i].hobbies[j]#
								<cfif j NEQ listLast(StructKeyList(log[i].hobbies),",")>,<br></cfif>
							</cfloop>
						</td>
					</tr>
				</cfloop>
			</cfoutput>
		</tbody>
	</table>
</cfdocument>