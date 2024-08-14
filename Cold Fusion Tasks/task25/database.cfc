<cfcomponent>
	<cffunction name="init" access="public">
		<cfquery name="clearWords" datasource="train">
			TRUNCATE PARAGRAPH;
		</cfquery>
	</cffunction>
	<cffunction name="submit">
		<cfargument name="para" type="string" required="true">
		<cfset delimitedPara = REReplace(para, "[^a-zA-Z]", ",", "all")>
		<cfloop list="#delimitedPara#" index="i">
			<cfquery name="enterWords" datasource="train">
				INSERT INTO PARAGRAPH(WORD)
				VALUES(<cfqueryparam value="#i#" cfsqltype="cf_sql_varchar" maxlength="45">);
			</cfquery>
		</cfloop>
	</cffunction>
</cfcomponent>