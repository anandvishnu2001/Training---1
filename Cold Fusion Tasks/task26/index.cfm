<form action="" method="post" enctype="multipart/form-data">
	<label for="paragraph">Enter text file:</label>
	<input type="file" name="paragraph" id="paragraph" placeholder="Attach text file" accept=".txt">
	<br><input name='btn' type='submit'>
</form>
<cfif structKeyExists(form,'btn') AND structKeyExists(form,"paragraph")>
	<cfset upload = expandPath('./uploads/')>
	<cffile action="upload" fileField="paragraph" destination="#upload#" nameConflict="makeUnique" result="res">
	<cffile action="read" file="#upload#/#res.SERVERFILE#" variable="uploadedPara">
	<cfset table = createObject('component','tagCloud')>
	<cfset table.submit(uploadedPara)>
	<cfset quer = table.init()>
	<cfoutput query='quer'>
		<cfset record = table.style('#word#')>
		<span style="font-size:#record[word].size#em;background:#record[word].color#">-#word#(#count#)</span><br>
	</cfoutput>
</cfif>