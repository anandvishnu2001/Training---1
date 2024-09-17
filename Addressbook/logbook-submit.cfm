<cfif structKeyExists(session,"check") AND session.check>
	<cfif structKeyExists(form,"btn")>
		<cfset session.check = false>
		<cflocation url="index.cfm" addToken="no" statusCode="302">
	</cfif>
<cfelse>
	<cflocation url="index.cfm" addToken="no" statusCode="302">
</cfif>
<cfif structKeyExists(form,"view")>
	<cfset viewModal = manager.getView( session.userid,
									form.log_id )>	
</cfif>
<cfif structKeyExists(form,"edit")>
	<cfset editModal = manager.getEdit( session.userid,
									form.log_id )>
	<cfset form.e_title=editModal[RESULTSET][0]["title"]>
	<div class="float-right"><cfdump var="#editModal#"></div>
</cfif>
<cfif structKeyExists(form,"delete")>
	<cfset deleteModal = manager.deleteRecord( session.userid,
										form.log_id )>
</cfif>