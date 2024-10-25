<cfif structKeyExists(session,"check") AND session.check.access>
    
<cfelse>
	<cflocation url="index.cfm" addToken="no">
</cfif>