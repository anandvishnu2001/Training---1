<cfif structKeyExists(form,"btn")>
	<cfinclude template="object.cfm">
	<cfset manager.insertUser(form.username,form.name,form.email,form.password)>
</cfif>