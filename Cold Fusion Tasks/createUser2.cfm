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
	<br><input type="submit" name="submit"/>
</form>
<cfif structKeyExists(form,"submit")>
	<cfset salt = generateSecretKey("AES")>
	<cfset saltedPassword = form.pass & salt>
	<cfset hashedPassword = hash(saltedPassword,"SHA-256","UTF-8")>
	<cfquery datasource="train" name="insertUser">
		INSERT INTO 
			USER(userid,username,role,password,salt) 
		VALUES (<cfqueryparam value="#form.userid#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#form.role#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#salt#" cfsqltype="cf_sql_varchar">);
	</cfquery>
</cfif>