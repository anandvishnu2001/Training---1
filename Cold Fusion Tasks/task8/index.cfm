<cfset session.srt = structNew("Ordered")>
<cfapplication name="STRUCT3" sessionManagement="yes" sessionTimeOut=#CreateTimeSpan(0,0,2,0)#>
<cfform action="" method="post">
	<label for="key">Enter structure key :</label>
	<cfinput name="key" id="key" type="text"><br>
	<label for="value">Enter structure value :</label>
	<cfinput name="value" id="value" type="text"><br>
	<cfinput name="btn" type="submit">
</cfform>
<cfif NOT isNull(form.btn)>
	<cfset session.srt["#form.key#"] = #form.value#>
	<cfdump var="#session.srt#">
</cfif>