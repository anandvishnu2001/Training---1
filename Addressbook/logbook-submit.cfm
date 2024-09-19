<cfif structKeyExists(session,"check") AND session.check.access>
	<cfif structKeyExists(form,"btn")>
		<cfset session.check.access = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	<cfelse>
		<cfif structKeyExists(form,"addbtn")>
		<cfinclude template="imageadd.cfm">
		<cfset manager.insertContact( session.userid,
						form.a_title,
						form.a_firstname,
						form.a_lastname,
						form.a_gender,
						form.a_date_of_birth,
						filename,
						form.a_house_flat,
						form.a_street,
						form.a_city,
						form.a_state,
						form.a_country,
						form.a_pincode,
						form.a_email,
						form.a_phone,
						form.a_hobbies )>
		</cfif>
		<cfif structKeyExists(form,"editbtn")>
			<cfinclude template="imageedit.cfm">
			<cfset manager.updateContact( session.userid,
							form.e_id,
							form.e_title,
							form.e_firstname,
							form.e_lastname,
							form.e_gender,
							form.e_date_of_birth,
							filename,
							form.e_house_flat,
							form.e_street,
							form.e_city,
							form.e_state,
							form.e_country,
							form.e_pincode,
							form.e_email,
							form.e_phone,
							form.e_hobbies )>
		</cfif>
		<cfif structKeyExists(form,"deletebtn")>
			<cfset manager.deleteRecord( session.userid,
							form.d_id )>
		<cfelseif structKeyExists(form,"return")>
			<cflocation url="logbook.cfm" addToken="no" statusCode="302">
		</cfif>
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>