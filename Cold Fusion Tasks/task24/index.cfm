<cfif structKeyExists(form,"btn")>
	<cfset obj=createObject('component','record')>
	<cfset obj.insert()>
</cfif>
<form action="" method="post">
	<div>
		Enter First Name:
		<input type="text" name="name" required/>
	</div>
	<div>
		Enter email:
		<input type="email" name="email" id="email" required/>
		<input type="button" name="check" id="check" value="check" />
	</div>
	<input type="submit" name="btn" id="submit" disabled/>
</form>
<script src="./js/jQuery.js"></script>
<script src="./js/script.js"></script>