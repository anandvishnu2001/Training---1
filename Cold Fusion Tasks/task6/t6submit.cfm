<cfset srt = structNew()>
<cfif structKeyExists(form.btn)>
	<cfif StructIsEmpty(srt)>
		<cfset StructInsert(srt,"#form.key#","#form.value#")>
	<cfelse>
		<cfset srt["#form.keys#"] = #form.value#>
	</cfif>
	<cfdump var="#srt#">
</cfif>