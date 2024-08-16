<cfcomponent>
	<cffunction name="init" access="public">
		<cfset color = ["black","red","blue","green","yellow"]>
		<cfset tableStruct = structNew()>
	</cffunction>
	<cffunction name="style">
		<cfargument name="record" type="string" requiired="yes">
		<cfset recArray = ListToArray(record)>
		<cfset tableStruct[recArray[1]] = {size = "#recArray[2]#"}>
	</cffunction>
</cfcomponent>