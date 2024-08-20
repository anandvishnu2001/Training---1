<form action="" method="post">
	<textarea name="paragraph"></textarea>
	<input name="btn" type="submit">
</form>
<cfif structKeyExists(form,"btn")>
	<cfset insert = createObject("component","tagCloud")>
	<cfset insert.init()>
	<cfset insert.submit(form.paragraph)>
<cfquery name="findCount" datasource="train">
	SELECT WORD,COUNT(WORD) AS COUNT FROM PARAGRAPH
	GROUP BY WORD HAVING LENGTH(WORD) >= 3
	ORDER BY COUNT(WORD) DESC,
		LENGTH(WORD) DESC,
		WORD ASC;
</cfquery>
<cfset style = createObject("component","tagCloud")>

<cfoutput query="findCount">
	<span class="style">-#word#(#count#)</span><br>
</cfoutput><cfset style.init()>
<cfloop query="findCount">
	<cfset style.style("#word#,#count#")>
</cfloop>
<cfdump var="#tableStruct#">
</cfif>