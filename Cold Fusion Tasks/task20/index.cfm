<cfform action="" method="post">
	Enter email:<cfinput name="email" id="email" type="email"><br>
	<cfset key=mid(generateSecretKey(("DES"),56),1,6)>
	<cfimage action="captcha" width="300" height="50" text="#key#"><br>
	Enter captcha:<cfinput name="captcha" id="captcha" type="text"><br>
	<cfinput name="key" type="hidden" value="#key#">
	<cfinput name="btn" type="submit">
</cfform>
<cfif NOT isNull(form.btn)>
	<style>
		div{
			width: 50%;
			padding: 20px;
			margin: 0 auto;
			text-align: center;
			color: white;
			box-shadow: 0 5px 10px #00000088;
		}
		.success{
			background: linear-gradient(green,darkgreen,green);
		}
		.warning{
			background: linear-gradient(red,darkred,red);
		}
	</style>
	<cfif form.captcha EQ form.key>
		<div class="success">Email Address successfully subscribe our newsletter</div>
	<cfelse>
		<div class="warning">Invalid Captcha!!!</div>
	</cfif>
</cfif>