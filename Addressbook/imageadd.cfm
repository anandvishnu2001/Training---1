<cfset uploadDir = expandPath('./uploads/')>        
<cfif not directoryExists(uploadDir)>
      <cfdirectory action="create" directory="#uploadDir#">
</cfif>
<cffile action="upload"
        filefield="profile"
        destination="#uploadDir#"
        nameConflict="makeunique">
<cfset filename = cffile.serverFile>