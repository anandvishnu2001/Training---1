<cfif structKeyExists(session, "check") 
    AND session.check.access>
	    <cflocation url="./admin-home.cfm" addToken="no">
<cfelse>
	<cfset session.check = {
        "access" = false
    }>
</cfif>
<cfif structKeyExists(form, "btn")>
    <cfinvoke 
        component="components.control" 
        method="adminLogin">
            <cfinvokeargument 
            name="admin" 
            value="#form.admin#">
            <cfinvokeargument 
            name="password" 
            value="#form.password#">
    </cfinvoke>
    <cfif session.check.access>
		<cflocation url="admin-home.cfm" addToken="no">
	<cfelse>
		<cflocation url="admin-login.cfm" addToken="no">
	</cfif>
</cfif>