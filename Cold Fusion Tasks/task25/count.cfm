<cfquery name="findCount" datasource="train">
	SELECT WORD,COUNT(WORD) AS COUNT FROM PARAGRAPH
	GROUP BY WORD HAVING LENGTH(WORD) >= 3
	ORDER BY COUNT(WORD) DESC,
		LENGTH(WORD) DESC,
		WORD ASC;
</cfquery>
<cfinclude template="style.cfm">
<cfoutput query="findCount">
	<span class="style">-#word#(#count#)</span><br>
</cfoutput>
<cfdump var="#tableStruct#">