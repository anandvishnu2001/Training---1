<cfset page = createObject('component','manager')>
<cfif structKeyExists(form,"btn")>
	<cfset page.insertPage(form.id,form.name,form.desc)>
	Data inserted successfully!!!
</cfif>
<form action="" method="post">
	<br><label for="id">Page ID :</label>
	<input name="id" id="id" type="text">
	<br><label for="name">Page Name :</label>
	<input name="name" id="name" type="text">
	<br><label for="desc">Page Description :</label>
	<textarea name="desc" id="desc" rows="4" cols="50"></textarea>
	<br><input name="btn" type="submit">
</form>