<cfcomponent>
	<cffunction name="checkPass" access="public" returnType="string">
		<cfargument name="id" type="string">
		<cfargument name="name" type="string">
		<cfargument name="role" type="string">
		<cfargument name="pass" type="string">
		<cfquery datasource="train" name="getPass" result="res">
			SELECT
				password,salt
			FROM
				user
			WHERE
				userid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar"> AND
				username = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar"> AND
				role = <cfqueryparam value="#arguments.role#" cfsqltype="cf_sql_varchar">;
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
	<cffunction name="getPages" access="public" returnType="query">
		<cfquery datasource="train" name="getPageID" result="res">
			SELECT
				pageid
			FROM
				page;
		</cfquery>
		<cfreturn res>
	</cffunction>
	<cffunction name="insertPage" access="public">
	</cffunction>
</cfcomponent>