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
<script>
	let e = document.getElementsByClassName('week');
	for(let i = 0;i < e.length; i++){
	switch(e[i].innerHTML){
		case 'Sunday':	e[i].style.color = 'red';
				break;
		case 'Monday':	e[i].style.color = 'green';
				break;
		case 'Tuesday':	e[i].style.color = 'orange';
				break;
		case 'Wednesday':e[i].style.color = 'yellow';
				break;
		case 'Thursday':e[i].style.color = 'black';
				e[i].style.fontWeight = 'bold';
				break;
		case 'Friday':	e[i].style.color = 'blue';
				break;
		case 'Saturday':e[i].style.color = 'red';
				e[i].style.fontWeight = 'bold';
				break;
	}}
</script>