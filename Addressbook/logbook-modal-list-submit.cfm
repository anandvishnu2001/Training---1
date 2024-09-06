<cfif structKeyExists(form,"create")>
	<cfset manager.insertContact( session.check[1],
					form.title,
					form.firstname,
					form.lastname,
					form.gender,
					form.date_of_birth,
					form.profile,
					form.house_flat,
					form.street,
					form.city,
					form.state,
					form.country,
					form.pincode,
					form.email,
					form.phone )>
</cfif>