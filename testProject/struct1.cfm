<cfform action="" method="post">
	<label for="key">Enter structure key :</label>
	<cfinput name="key" id="key" type="text"><br>
	<label for="value">Enter structure value :</label>
	<cfinput name="value" id="value" type="text"><br>
	<cfinput name="btn" type="submit">
</cfform>
<cfset srt = structNew()>
<cfparam name="form.btn" default="">
<cfparam name="form.key" default="">
<cfparam name="form.value" default="">
<cfif NOT isNull(form.btn)>
	<cfif StructIsEmpty(srt)>
		<cfset StructInsert(srt,"#form.key#","#form.value#")>
	<cfelse>
		<cfset srt["#form.keys#"] = #form.value#>
	</cfif>
	<cfdump var="#srt#">
</cfif>