<cfcomponent>
	<cffunction name="multiply">
		<cfset p = 1> 
		<cfloop index="i" from="1" to="#ArrayLen(arguments)#"> 
			<cfset p *= #arguments[i]#> 
		</cfloop>
		<cfreturn p>
	</cffunction>
</cfcomponent>