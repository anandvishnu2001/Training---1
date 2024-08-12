<cftry>
    <cffile action="upload" fileField="image" destination="#expandPath('./uploads')#" nameConflict="makeUnique">
    <cfset uploadedFilePath = cffile.serverDirectory & "/" & cffile.serverFile>
    <cfmail
	to="#form.email#"
	from="kronos0styx@gmail.com"
	subject="Happy Birth Day"
	type="text" server="smtp.gmail.com"
	port="25">
	#form.name##form.wishes#	
        <cfmailparam file="#uploadedFilePath#">	
    </cfmail>	
    <cfoutput>
        <p>Email sent successfully with the attached image.</p>
    </cfoutput>

<cfcatch>
    <cfoutput>
        <p>Error: #cfcatch.message#</p>
    </cfoutput>
</cfcatch>
</cftry>