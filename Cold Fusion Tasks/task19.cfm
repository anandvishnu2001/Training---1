<cfapplication name="createcookie" setClientCookies="yes">
<cfform>
	<cfinput name="btn" type="submit">
</cfform>
<cfif NOT isNull(form.btn)>
	<cfif isDefined("cookie.VisitsCounter")>
		<cfset cookie.VisitsCounter = cookie.VisitsCounter+1>
	<cfelse>
		<cfcookie name="VisitsCounter" value="0">
		<cfset cookie.VisitsCounter=1>
	</cfif>
	<cfoutput>Visited=#cookie.VisitsCounter#</cfoutput>
	<cfdump var="#cookie#">
</cfif>