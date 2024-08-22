<form action='' method='post'>
	<textarea name='paragraph'></textarea>
	<input name='btn' type='submit'>
</form>
<cfif structKeyExists(form,'btn')>
	<cfset table = createObject('component','tagCloud')>
	<cfset table.submit(form.paragraph)>
	<cfset quer = table.init()>
	<cfoutput query='quer'>
		<cfset record = table.style('#word#')>
		<span style="font-size:#record[word].size#em;background:#record[word].color#">-#word#(#count#)</span><br>
	</cfoutput>
</cfif>