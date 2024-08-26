<cfcomponent>
	<cffunction name="check" access="remote" returnFormat="JSON">
		<cfargument name="email" type="string">
		<cfquery name="local.checkEmail" datasource="train" result="result">
			SELECT 
				name,
				email
			FROM
				subscription
			WHERE
				email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">;
		</cfquery>
		<cfif result.RECORDCOUNT GT 0>
			<cfset local.output="yes">
		<cfelse>
			<cfset local.output="no">
		</cfif>
		<cfreturn local.output/>
	</cffunction>
	<cffunction name="insert">
		<cfquery name="local.insertData" datasource="train">
			INSERT INTO
				subscription(
						name,
						email
				)
			VALUES(
				<cfqueryparam value="#form.name#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
			);
		</cfquery>
	</cffunction>
</cfcomponent>