<cfform action="" method="post">
	Enter email:<cfinput name="email" id="email" type="text"><br>
	<cfset key=generateSecretKey(("BLOWFISH"),128)>
	<cfimage action="captcha" width="300" height="50" text="#mid(key,1,6)#" difficulty="medium"><br>
	Enter captcha:<cfinput name="captcha" id="captcha" type="text"><br>
	<cfinput name="btn" type="submit">
</cfform>