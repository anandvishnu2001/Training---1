<cfcomponent>
	<cffunction name="multiply">
		<cfset local.p = 1> 
		<cfloop index="i" from="1" to="#ArrayLen(arguments)#"> 
			<cfset local.p *= #arguments[i]#> 
		</cfloop>
		<cfreturn local.p>
	</cffunction>
</cfcomponent>