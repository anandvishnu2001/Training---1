<cfparam name="form.submit" default="">
<cfif NOT isNull(form.submit)>
	<cfoutput>
		<div style="	color: white;
				background: black;
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;	">
			<h1>#form.name#</h1>
			<cfimage source="#form.image#" action="writeToBrowser">
			<h3>#form.description#</h3>
		</div>
	</cfoutput>
</cfif>