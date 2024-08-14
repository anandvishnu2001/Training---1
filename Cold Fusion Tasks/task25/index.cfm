<form action="" method="post">
	<textarea name="paragraph"></textarea>
	<input name="btn" type="submit">
</form>
<cfif structKeyExists(form,"btn")>
	<cfset insert = createObject("component","database")>
	<cfset insert.init()>
	<cfset insert.submit(form.paragraph)>
	<cfinclude template="count.cfm">
</cfif>