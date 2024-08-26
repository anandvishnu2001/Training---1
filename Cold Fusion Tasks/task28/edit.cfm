<cfset page = createObject('component','manager')>
<cfif structKeyExists(form,"btn")>
	<cfset page.editPage(form.id,form.name,form.desc)>
	Data updated successfully!!!
</cfif>
<cfset info = page.getPageInfo(#url.value#)>
<cfoutput query="info">
	<form action="" method="post">
		<br><label for="id">Page ID :</label>
		<input name="id" id="id" type="text" value="#pageid#" readonly>
		<br><label for="name">Page Name :</label>
		<input name="name" id="name" type="text" value="#pagename#">
		<br><label for="desc">Page Description :</label>
		<textarea name="desc" id="desc" rows="4" cols="50">#pagedescs#</textarea>
		<br><input name="btn" type="submit">
	</form>
</cfoutput>