<cfset session.srt = structNew()>
<cfapplication name="STRUCT4" sessionManagement="yes" sessionTimeOut=#CreateTimeSpan(0,0,2,0)#>
<form action="" method="post">
	<label for="key">Enter structure key :</label>
	<input name="key" id="key" type="text"><br>
	<label for="value">Enter structure value :</label>
	<input name="value" id="value" type="text"><br>
	<input name="btn" type="submit">
</form>
<cfif NOT isNull(form.btn)>
	<cfif StructKeyExists(session.srt,"#form.key#")>
		<cfoutput>#form.key# is already present. Cannot add again!!!</cfoutput>
	<cfelse>
		<cfset session.srt["#form.key#"] = #form.value#>
	</cfif>
	<cfdump var="#session.srt#">
</cfif>