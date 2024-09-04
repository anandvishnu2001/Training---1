<cfset list = manager.getList(id=session.check[1])>
<table class="table align-middle table-borderless table-hover table-sm">	
	<thead>
		<th></th>
		<th class="text-primary">Name</th>
		<th class="text-primary">Email</th>
		<th class="text-primary">Phone</th>
	</thead>
	<tbody>
		<cfoutput query="list">
			<tr>
				<td>
					<img class="img-fluid rounded-circle mx-auto d-block" src="./images/signup.png" alt="Address Book" width="30" height="30">
				</td>
				<td>#list.name#</td>
				<td>#list.email#</td>
				<td>#list.phone#</td>
				<td>
					<button type="button" class="btn btn-sm btn-outline-primary">View</button>
				</td>
				<td>
					<button type="button" class="btn btn-sm btn-outline-warning">Edit</button>
				</td>
				<td>
					<button type="button" class="btn btn-sm btn-outline-danger">Delete</button>
				</td>
			</tr>
		</cfoutput>
	</tbody>
</table>