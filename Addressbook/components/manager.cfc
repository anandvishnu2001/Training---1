<cfcomponent>
	<cffunction name="insert" access="public">
		<cfargument name="username" type="string">
		<cfargument name="name" type="string">
		<cfargument name="email" type="string">
		<cfargument name="password" type="string">
		<cfset local.salt = generateSecretKey("AES")>
		<cfset local.hashedPass = hasher(arguments.password,local.salt)>
		<cfquery name="local.insertData" datasource="address">
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

	<cffunction name="checkPass" access="public">
		<cfargument name="id" type="string">
		<cfargument name="password" type="string">
		<cfquery name="local.check" datasource="address">
			SELECT
				user_id,
				username,
				password,
				salt
			FROM
				log_user
			WHERE
				username=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
			OR
				email=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfset local.givenPass = hasher(arguments.password,local.check.salt)>
		<cfset local.access = ArrayNew(1)>
		<cfset local.access[1] = local.check.user_id>
		<cfset local.access[2] = local.check.username>
		<cfif local.givenPass EQ local.check.password>
			<cfset local.access[3]=true>
		<cfelse>
			<cfset local.access[3]=false>
		</cfif>
		<cfreturn local.access>
	</cffunction>

	<cffunction name="getList" access="public" returnType="query">
		<cfargument name="id" type="string">
		<cfquery name="local.list" datasource="address" result="result">
			SELECT
				log_id,
				CONCAT(title," ",firstname," ",lastname) AS name,
				email,
				phone
			FROM
				log_book
			WHERE
				user_id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		<cfreturn local.list>
	</cffunction>

	<cffunction name="exist" access="remote" returnFormat="JSON">
		<cfargument name="check" type="string">
		<cfargument name="item" type="string">
		<cfquery name="local.existCheck" datasource="address">
			SELECT 
				#arguments.check#
			FROM
				log_user
			WHERE
				#arguments.check#=<cfqueryparam value="#arguments.item#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfif local.existCheck.recordCount EQ 0>
			<cfreturn false>
		<cfelse>
			<cfreturn true>
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