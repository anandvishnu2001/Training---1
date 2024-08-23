<form action="" method="post">
	Enter username:<input type="text" name="username">
	<br>Enter Password:<input type="text" name="password" placeholder="Atleast 8 characters" pattern="^.{8,}$" required>
	<br><input type="submit" name="submit"/>
</form>
<cfif structKeyExists(form,"submit")>
	<cfset salt = generateSecretKey("AES")>
	<cfset saltedPassword = form.passWord & salt>
	<cfset hashedPassword = hash(saltedPassword,"SHA-256","UTF-8")>
	<cfquery datasource="train" name="insertUser">
		INSERT INTO 
			USERLOG(username,password,salt) 
		VALUES (<cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#hashedPassWord#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#salt#" cfsqltype="cf_sql_varchar">);
	</cfquery>
</cfif>