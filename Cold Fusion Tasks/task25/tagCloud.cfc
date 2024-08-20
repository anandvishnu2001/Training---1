<cfcomponent>
	<cffunction name="init" access="public">

	</cffunction>
	<cffunction name="submit">
		<cfargument name="para" type="string" required="true">
		<cfquery name="clearWords" datasource="train">
			TRUNCATE PARAGRAPH;
		</cfquery>
		<cfset delimitedPara = REReplace(para, "[^a-zA-Z]", ",", "all")>
		<cfloop list="#delimitedPara#" index="i">
			<cfquery name="enterWords" datasource="train">
				INSERT INTO PARAGRAPH(WORD)
				VALUES(<cfqueryparam value="#i#" cfsqltype="cf_sql_varchar" maxlength="45">);
			</cfquery>
		</cfloop>
	</cffunction>
	<cffunction name="style">
		<cfargument name="record" type="string" requiired="yes">
		<cfset tableStruct = structNew()>
		<cfset colorHex = 010101>
		<cfset recArray = ListToArray(record)>
		<cfif recArray[2] GT 1>
			<cfset colorHex += 10000>
		</cfif>
		<cfset tableStruct[recArray[1]] = {size="#recArray[2]#" , color = "#"+colorHex}>
		<cfdump var="#tableStruct#">
	</cffunction>
</cfcomponent>