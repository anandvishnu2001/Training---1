<cfform>
	<label>Enter User's Date-of-Birth:</label>
	<cfinput name="user" type="date"/>
	<label>Enter Mother's Date-of-Birth:</label>
	<cfinput name="mother" type="date"/>
	<cfinput name="btn" type="submit">submit</cfinput>
</cfform>
<cfif NOT isNull(form.btn)>
	<cfoutput>Age of User is #dateDiff('yyyy',form.user,now())#<br>
	Age of User's mother when user was delivered #dateDiff('yyyy',form.mother,form.user)#</cfoutput>
	<cfif form.user.setYear(Year(now())) GT now()>
		<cfoutput><br>Birthday of User comes in #dateDiff('d',now(),form.user.setYear(Year(now())))# days</cfoutput>
	<cfelse>
		<cfoutput><br>Birthday of User comes in #dateDiff('d',now(),form.user.setYear(Year(now())+1))# days</cfoutput>
	</cfif>
	<cfif form.mother.setYear(Year(now())) GT now()>
		<cfoutput><br>Birthday of User's mother comes in #dateDiff('d',now(),form.mother.setYear(Year(now())))# days</cfoutput>
	<cfelse>
		<cfoutput><br>Birthday of User's mother comes in #dateDiff('d',now(),form.mother.setYear(Year(now())+1))# days</cfoutput>
	</cfif>
</cfif>