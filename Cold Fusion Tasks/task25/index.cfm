<!DOCTYPE html>
<html lang="en">
	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>task25</title>
	</head>
<body>
<form action='' method='post'>
	<textarea name='paragraph'></textarea>
	<input name='btn' type='submit'>
</form>
</body>
</html>
<cfif structKeyExists(form,'btn')>
	<cfset table = createObject('component','tagCloud')>
	<cfset table.submit(form.paragraph)>
	<cfset quer = table.init()>
	<cfoutput query='quer'>
		<span class='style'>-#word#(#count#)</span><br>
		<cfset record = table.style('#word#')>
	</cfoutput>
	<cfdump var="#record#">
	<cfset jsonRecord = serializeJSON(record)>
	<script src="./js/script.js"></script>
</cfif>