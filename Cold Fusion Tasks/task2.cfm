<cfform>
	<label>Enter rating(1-5):</label>
	<cfinput name="ifrate" type="text"></cfinput>
	<cfinput name="btn" type="submit">submit</cfinput>
</cfform>
<cfif NOT isNull(form.btn)>
	<cfswitch  expression="#form.ifrate#">
		<cfcase value="5">
			<cfoutput>Very good</cfoutput>
		</cfcase>
		<cfcase value="4">
			<cfoutput>Good</cfoutput>
		</cfcase>
		<cfcase value="3">
			<cfoutput>Fair</cfoutput>
		</cfcase>
		<cfcase value="2">
			<cfoutput>Ok</cfoutput>
		</cfcase>
		<cfcase value="1">
			<cfoutput>Ok</cfoutput>
		</cfcase>
		<cfdefaultcase>
			<cfoutput>Wrong rating(allowed only from 1 to 5)</cfoutput>
		</cfdefaultcase>
	</cfswitch>
</cfif>