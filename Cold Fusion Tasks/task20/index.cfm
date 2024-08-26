<form action="" method="post">
	Enter email:<input name="email" id="email" type="email"><br>
	<cfset key=mid(generateSecretKey(("DES"),56),1,6)>
	<cfimage action="captcha" width="300" height="50" text="#key#"><br>
	Enter captcha:<input name="captcha" id="captcha" type="text"><br>
	<input name="key" type="hidden" value="#key#">
	<input name="btn" type="submit">
</form>

<cfif NOT isNull(form.btn)>
	<link href="./css/style.css">
	<cfif form.captcha EQ form.key>
		<div class="success">Email Address successfully subscribe our newsletter</div>
	<cfelse>
		<div class="warning">Invalid Captcha!!!</div>
	</cfif>
</cfif>