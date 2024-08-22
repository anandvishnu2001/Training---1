<cfcomponent>
	<cffunction name="check" access="remote" returnFormat="JSON">
		<cfargument name="email" type="string">
		<cfquery name="checkEmail" datasource="train" result="res">
			SELECT 
				name,email
			FROM
				subscription
			WHERE
				email="#arguments.email#";
		</cfquery>
		<cfif res.RECORDCOUNT GT 0>
			<cfset local.result="yes">
		<cfelse>
			<cfset local.result="no">
		</cfif>
		<cfreturn local.result/>
	</cffunction>
	<cffunction name="insert">
		<cfquery name="insertData" datasource="train">
			INSERT INTO
				subscription(name,email)
			VALUES
				(<cfqueryparam value="#form.name#" cfsqltype="cf_sql_varchar">,
				 <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">);
		</cfquery>
	</cffunction>
</cfcomponent>