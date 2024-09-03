<cfcomponent>
	<cffunction name="insert" access="public">
		<cfargument name="username" type="string">
		<cfargument name="name" type="string">
		<cfargument name="email" type="string">
		<cfargument name="password" type="string">
		<cfset local.salt = generateSecretKey("AES")>
		<cfset local.hashedPass = hasher(arguments.password,local.salt)>
		<cfquery name="insertData" datasource="train">
			INSERT INTO
				log_user(
					username,
					name,
					email,
					password,
					salt
				)
			VALUES(
				<cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#local.hashedPass#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#local.salt#" cfsqltype="cf_sql_varchar">
			);
		</cfquery>
	</cffunction>

	<cffunction name="exist" access="remote" returnFormat="JSON">
		<cfargument name="check" type="string">
		<cfargument name="item" type="string">
		<cfquery name="local.existCheck" datasource="train">
			SELECT 
				#arguments.check#
			FROM
				address_user
			WHERE
				#arguments.check#=<cfqueryparam value="#arguments.item#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfif local.existCheck.recordCount EQ 0>
			<cfset local.flag=true>
		<cfelse>
			<cfset local.flag=false>
		</cfif>
		<cfreturn local.flag>
	</cffunction>

	<cffunction name="confirm" access="remote" returnFormat="JSON">
		<cfargument name="password" type="string">
		<cfargument name="rePassword" type="string">
		<cfif local.password EQ local.rePassword>
			<cfset local.flag=true>
		<cfelse>
			<cfset local.flag=false>
		</cfif>
		<cfreturn local.flag>
	</cffunction>

	<cffunction name="hasher" access="private">
		<cfargument name="pass" type="string">
		<cfargument name="salt" type="string">
		<cfset local.saltedPass = arguments.pass & arguments.salt>
		<cfset local.hashedPass = hash(local.saltedPass,"SHA-256","UTF-8")>	
		<cfreturn local.hashedPass/>
	</cffunction>
</cfcomponent>