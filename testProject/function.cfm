<cffunction name="multiply" >
	<cfset p = 1> 
	<cfloop index="i" from="1" to="#ArrayLen(arguments)#"> 
		<cfset p *= #arguments[i]#> 
	</cfloop>
	<cfreturn p>
</cffunction>
<cfset res = multiply(1,2)>
<cfdump var="#res#">
<br>
<cfset res = multiply(1,2,3)>
<cfdump var="#res#">
<br>
<cfset res = multiply(1,2,3,4)>
<cfdump var="#res#"> 