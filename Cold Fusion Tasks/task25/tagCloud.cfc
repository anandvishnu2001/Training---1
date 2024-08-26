<cfcomponent>
	<cfproperty name="tableStruct" type="struct">
	<cffunction name="init" access="public" returnType="query">
		<cfquery name="findCount" datasource="train">
			SELECT 
				word,
				count(word) AS count 
			FROM 
				paragraph
			GROUP BY 
				word 
			HAVING 
				length(word) >= 3
			ORDER BY 
				count DESC,
				length(word) DESC,
				word ASC;
		</cfquery>
		<cfreturn findCount>
	</cffunction>
	<cffunction name="submit">
		<cfargument name="para" type="string" required="true">
		<cfquery name="local.clearWords" datasource="train">
			TRUNCATE paragraph;
		</cfquery>
		<cfset local.delimitedPara = REReplace(arguments.para,"[^a-zA-Z]",",","all")>
		<cfloop list="#local.delimitedPara#" index="i">
			<cfquery name="local.enterWords" datasource="train">
				INSERT INTO 
					paragraph(
						word
					)
				VALUES(
					<cfqueryparam value="#i#" cfsqltype="cf_sql_varchar" maxlength="45">
				);
			</cfquery>
		</cfloop>
	</cffunction>
	<cffunction name="style" returnType="struct">
		<cfargument name="record" type="string" required="yes">
		<cfset local.colour = ["red","green","blue","maroon","yellow","white","brown","olive","navy","black"]>
		<cfset local.col = local.colour[findCount.count]>
		<cfset tableStruct[arguments.record] = {size="#findCount.count#" , color="#local.col#"}>
		<cfreturn tableStruct>
	</cffunction>
</cfcomponent>