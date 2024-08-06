<cfform>
	<label>Enter array:</label>
	<cfinput name="box" type="text" placeholder="1,2,3"/>
	<cfinput name="btn" type="submit"/>
</cfform>
<cfset arr = ListToArray("#form.box#")>
<cfset s = arrayNew(1)>
<cfloop array="#arr#" index="i" item="n">
	<cfif n % 3 NEQ 0>
		<cfcontinue>
	</cfif>
	<cfset ArrayAppend(s , #n#)>
</cfloop>
<cfset r = ArrayToList(s)>
<cfoutput>#r#</cfoutput>