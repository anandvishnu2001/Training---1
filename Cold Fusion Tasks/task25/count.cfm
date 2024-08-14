<cfquery name="findCount" datasource="train">
	SELECT CONCAT('-',WORD,'(',COUNT(WORD),')') AS COUNT FROM PARAGRAPH
	GROUP BY WORD HAVING LENGTH(WORD) >= 3
	ORDER BY COUNT(WORD) DESC,
		LENGTH(WORD) DESC,
		WORD ASC;
</cfquery>
<cfoutput query="findCount">#count#<br></cfoutput>
<cfinclude template="style.cfm">