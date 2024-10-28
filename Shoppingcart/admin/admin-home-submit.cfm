<cfif structKeyExists(session,"check") 
	AND session.check.access>
    
<cfelse>
	<cflocation url="admin-login.cfm" addToken="no">
</cfif>