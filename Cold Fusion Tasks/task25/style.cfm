<cfset style = createObject("component","tagCloud")>
<cfset style.init()>
<cfloop query="findCount">
	<cfset style.style("#word#,#count#")>
</cfloop>