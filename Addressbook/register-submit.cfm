<cfif structKeyExists(form,"btn")>
	<cfinclude template="object.cfm">
	<cfset manager.insert(form.username,form.name,form.email,form.password)>
</cfif>