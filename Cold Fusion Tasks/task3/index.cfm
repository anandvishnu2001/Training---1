<form>
	<label>Enter array:</label>
	<input name="box" type="text" placeholder="1,2,3"/>
	<input name="btn" type="submit"/>
</form>
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