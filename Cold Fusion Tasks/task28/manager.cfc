<cfcomponent>
	<cffunction name="checkPass" access="public" returnType="string">
		<cfargument name="id" type="string">
		<cfargument name="name" type="string">
		<cfargument name="role" type="string">
		<cfargument name="pass" type="string">
		<cfquery datasource="train" name="local.getPass" result="result">
			SELECT
				password,
				salt
			FROM
				user
			WHERE
				userid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar"> AND
				username = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar"> AND
				role = <cfqueryparam value="#arguments.role#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfif result.RECORDCOUNT GT 0>
			<cfset local.hashedPass = "#local.getPass.password#">
			<cfset local.salt = "#local.getPass.salt#">
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
	<cffunction name="getPageID" access="public" returnType="query">
		<cfquery datasource="train" name="local.getID">
			SELECT
				pageid
			FROM
				page;
		</cfquery>
		<cfreturn local.getID>
	</cffunction>
	<cffunction name="getPageInfo" access="public" returnType="query">
		<cfargument name="id" type="string">
		<cfquery datasource="train" name="local.getInfo">
			SELECT
				pageid,
				pagename,
				pagedescs
			FROM
				page
			WHERE
				pageid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfreturn local.getInfo>
	</cffunction>
	<cffunction name="insertPage" access="public">
		<cfargument name="id" type="string">
		<cfargument name="name" type="string">
		<cfargument name="desc" type="string">
		<cfquery datasource="train" name="local.insert">
			INSERT INTO
				page(
					pageid,
					pagename,
					pagedescs
				)
			VALUES(
				<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.desc#" cfsqltype="cf_sql_varchar">
			);
		</cfquery>
	</cffunction>
	<cffunction name="editPage" access="public">
		<cfargument name="id" type="string">
		<cfargument name="name" type="string">
		<cfargument name="desc" type="string">
		<cfquery datasource="train" name="local.edit">
			UPDATE
				page
			SET
				pagename = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
				pagedescs = <cfqueryparam value="#arguments.desc#" cfsqltype="cf_sql_varchar">
			WHERE
				pageid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">;
		</cfquery>
	</cffunction>>
	<cffunction name="deletePage" access="remote" returnFormat="JSON">
		<cfargument name="id" type="string">
		<cfquery datasource="train" name="local.delete">
			DELETE FROM
				page
			WHERE
				pageid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfreturn 1/>
	</cffunction>
</cfcomponent>