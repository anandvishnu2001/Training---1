<cfif structKeyExists(form,"btn")>
	<cfset d = createObject('component','manager')>
	<cfset d.insert(form.username,form.name,form.email,form.password)>
</cfif>