<cfcomponent>
	<cffunction name="checkPass" access="public" returnType="string">
		<cfargument name="name" type="string">
		<cfargument name="pass" type="string">
		<cfquery datasource="train" name="getPass" result="res">
			SELECT 
				password,salt 
			FROM 
				userlog 
			WHERE 
				username = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfif res.RECORDCOUNT GT 0>
			<cfoutput query="getPass">
				<cfset local.hashedPass = "#password#">
				<cfset local.salt = "#salt#">
			</cfoutput>
			<cfset local.checkPass = hasher(arguments.pass,local.salt)>
			<cfif local.checkPass EQ local.hashedPass>
				<cfreturn true>
			<cfelse>
				<cfreturn false>
			</cfif>	
		<cfelse> 
			<cfreturn false>
		</cfif>
	</cffunction>
	<cffunction name="hasher" access="private">
		<cfargument name="pass" type="string">
		<cfargument name="salt" type="string">
		<cfset local.saltedPass = arguments.pass & arguments.salt>
		<cfset local.hashedPass = hash(local.saltedPass,"SHA-256","UTF-8")>	
		<cfreturn local.hashedPass/>
	</cffunction>
</cfcomponent>