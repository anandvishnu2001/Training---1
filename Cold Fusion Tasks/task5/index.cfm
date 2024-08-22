<form>
	<label>Enter User's Date-of-Birth:</label>
	<input name="user" type="date"/>
	<label>Enter Mother's Date-of-Birth:</label>
	<input name="mother" type="date"/>
	<input name="btn" type="submit">
</form>
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