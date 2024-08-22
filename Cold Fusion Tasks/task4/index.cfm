<cfset n = DateFormat(now())>
<cfset mnum = Month(now())>
<cfset mal = MonthAsString(#mnum#)>
<cfoutput>#n#<br>#mnum#<br>#mal#<br></cfoutput>
<cfloop from="#now()-1#" to="#now()-7#" index="i" step="#CreateTimeSpan(-1,0,0,0)#">
	<cfif DayOfWeekAsString(DayOfWeek(i)) EQ 'Friday'>
		<cfoutput>#DateFormat(i,'d-mmmm-yyyy - dddd')#</cfoutput>
	</cfif>
</cfloop>
<cfset d = DateFormat(now().setDay(0)+DaysInMonth(now()))>
<cfoutput><br>#d#</cfoutput>
<cfloop from="#now()-1#" to="#now()-5#" index="i" step="#CreateTimeSpan(-1,0,0,0)#">
	<cfoutput><br>#DateFormat(i,'d-mmmm-yyyy - ')#<span class="week">#DayOfWeekAsString(DayOfWeek(i))#</span></cfoutput>
</cfloop>
<script src="./js/script.js"></script>