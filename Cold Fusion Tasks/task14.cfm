<cfform action="" method="post" enctype="multipart/form-data">
	<div>
		<label>Enter Image name:</label>
		<cfinput name="imgname" type="text" message="Image name Required" required><br>
		<label>Enter Image description:</label>
		<cftextarea name="imgdesc" size="1" message="Image description Required" required></cftextarea>
	</div>
	<label>Upload Image:</label>
	<cfinput name="img" type="file" accept="image/*" message="Image Required" required>
	<br><cfinput name="btn" type="submit">
</cfform>
<cfif NOT isNull(form.btn)>
	<cfif structKeyExists(form, "img") AND isDefined("form.img") AND len(trim(form.img))>
		<cfset upload = expandPath('./uploads/')>
		<cfif NOT directoryExists(upload)>
			<cfdirectory action="create" directory="#upload#">
		</cfif>
		<cffile action="upload" filefield="img" destination="#upload#" nameConflict="makeunique">
		<cfset extensions = "jpg,png,gif">
		<cfif ListContainsNoCase(extensions,cffile.serverFileExt) AND cffile.fileSize/1024 LTE 1024>
			<cfset img = ImageNew("#upload##cffile.serverFile#")>
			<cfset ImageResize(img,"50%","50%")>
			<cfimage source="#img#" action="writeToBrowser">
			<cfform action="image.cfm" method="post">
				<cfinput name="name" type="hidden" value="#form.imgname#">
				<cfinput name="description" type="hidden" value="#form.imgdesc#">
				<cfinput name="image" type="hidden" value="#upload##cffile.serverFile#">
				<cfinput name="submit" type="submit" value="#form.imgname#">
			</cfform>
		<cfelse>
			<cfif NOT ListContainsNoCase(extensions,cffile.serverFileExt)>
				<cfoutput>#cffile.serverFile# has invalid file format. Accepted formats(jpg/png/gif)</cfoutput>
			</cfif>
			<cfif NOT cffile.fileSize/1024 LTE 1024>
				<cfoutput>#cffile.serverFile# has size exceeding 1 MB.</cfoutput>
			</cfif>
		</cfif>
	</cfif>
</cfif>