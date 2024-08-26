<cfcomponent>
	<cfif structKeyExists(form,"btn")>
		<cfquery name="local.InsertRecord" datasource="train">
			INSERT INTO 
				EMPLOYMENT(
					POSITION,
					RELOCATION,
					START_DATE,
					PORTFOLIO_WEB,
					RESUME,
					SALARY,
					NAME,
					EMAIL,
					PHONE
				)
			VALUES (
				<cfqueryparam value="#form.position#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.relocation#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.start#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#form.web#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.resume#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.salary#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#form.name#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#form.phone#" cfsqltype="cf_sql_decimal" scale="0">
			);
		</cfquery>
		Form submitted to Database Successfully!!!
	</cfif>
</cfcomponent>