<cfset session.result = false>

<cfif structKeyExists(form,"login")>
	<cfset log = createObject('component','password')>
	<cfset session.result = log.checkPass(form.user,form.pass)>
	<cfoutput>
		<cfif session.result>
			<cflocation url="welcome.cfm" addToken="yes" statusCode="302">
		<cfelse>
			Unauthorized access!!
		</cfif>
	</cfoutput>
</cfif>

<form action="" method="post">
	<label for="user">Enter Username:</label>
	<input name="user" id="user" type="text" required>
	<br><label for="user">Enter Password:</label>
	<input name="pass" id="pass" type="password" placeholder="Atleast 8 characters" pattern="^.{8,}$" required>
	<br><input type="submit" name="login" value="Login"/>
</form>