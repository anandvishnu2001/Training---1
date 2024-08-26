<cfcomponent>
	<cffunction name="checkPass" access="public" returnType="string">
		<cfargument name="name" type="string">
		<cfargument name="pass" type="string">
		<cfquery datasource="train" name="local.getPass" result="result">
			SELECT 
				password,
				salt 
			FROM 
				userlog 
			WHERE 
				username = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfif result.RECORDCOUNT GT 0>
			<cfoutput query="local.getPass">
				<cfset local.hashedPass = "#local.getPass.password#">
				<cfset local.salt = "#local.getPass.salt#">
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