<cfcomponent>
	<cfproperty name="tableStruct" type="struct">
	<cffunction name="init" access="public" returnType="query">
		<cfquery name="findCount" datasource="train" result="res">
			SELECT 
				word, count(word) AS count 
			FROM 
				paragraph
			GROUP BY 
				word 
			HAVING 
				length(word) >= 3
			ORDER BY 
				count DESC, length(word) DESC, word ASC;
		</cfquery>
		<cfreturn findCount>
	</cffunction>
	<cffunction name="submit">
		<cfargument name="para" type="string" required="true">
		<cfquery name="clearWords" datasource="train">
			TRUNCATE paragraph;
		</cfquery>
		<cfset delimitedPara = REReplace(para,"[^a-zA-Z]",",","all")>
		<cfloop list="#delimitedPara#" index="i">
			<cfquery name="enterWords" datasource="train">
				INSERT INTO 
					paragraph(word)
				VALUES
					(<cfqueryparam value="#i#" cfsqltype="cf_sql_varchar" maxlength="45">);
			</cfquery>
		</cfloop>
	</cffunction>
	<cffunction name="style" returnType="struct">
		<cfargument name="record" type="string" required="yes">
		<cfset colour = [ ["maroon","brown","olive","navy","black"],["red","yellow","green","blue","white"] ]>
		<cfset col = colour[2][findCount.count]>
		<cfset bg = colour[1][findCount.count]>
		<cfset tableStruct[record] = {size="#findCount.count#" , color="#col#" , background="#bg#"}>
		<cfreturn tableStruct>
	</cffunction>
</cfcomponent>