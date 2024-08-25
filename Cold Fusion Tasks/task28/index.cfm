<cfset session.check = false>

<cfif structKeyExists(form,"login")>
	<cfset log = createObject('component','manager')>
	<cfset session.check = log.checkPass(form.userid,form.username,form.role,form.pass)>
	<cfoutput>
		<cfif session.check>
			<cfif listFind("admin,editor",form.role)>
				<cfdump var="#listFind("admin,editor",form.role)#">
				<cfset session.role = true>
			<cfelse>
				<cfset session.role = false>
			</cfif>
			<cflocation url="welcome.cfm" addToken="no" statusCode="302">
		<cfelse>
			Unauthorized access!!
		</cfif>
	</cfoutput>
</cfif>

<form action="" method="post">
	<label for="userid">User ID:</label>
	<input name="userid" id="userid" type="text" required>
	<br><label for="username">User Name:</label>
	<input name="username" id="username" type="text" required>
	<br><label for="role">Role:</label>
	<select name="role" id="role" required>
		<option value="">select role</option>
		<option value="admin">admin</option>
		<option value="editor">editor</option>
		<option value="user">user</option>
	</select>
	<br><label for="user">Password:</label>
	<input name="pass" id="pass" type="password" placeholder="Atleast 8 characters" pattern="^.{8,}$" required>
	<br><input type="submit" name="login" value="Login"/>
</form>