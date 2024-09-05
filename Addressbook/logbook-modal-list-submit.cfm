<cfif structKeyExists(form,"create")>
	<cfinclude template="object.cfm">
	<cfset manager.insertContact( session.check[1],
					form.title,
					form.firstname,
					form.lastname,
					form.gender,
					form.date_of_birth,
					form.house_flat,
					form.street,
					form.city,
					form.state,
					form.country,
					form.pincode,
					form.email,
					form.phone )>
</cfif>