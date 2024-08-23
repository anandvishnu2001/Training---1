<form action="" method="post" enctype="multipart/form-data">
	<div>
		<label>Enter Image name:</label>
		<input name="imgname" type="text" message="Image name Required" required><br>
		<label>Enter Image description:</label>
		<textarea name="imgdesc" size="1" message="Image description Required" required></textarea>
	</div>
	<label>Upload Image:</label>
	<input name="img" type="file" accept="image/*" message="Image Required" required>
	<br><input name="btn" type="submit">
</form>
<cfif NOT isNull(form.btn)>
	<cfif structKeyExists(form, "img") AND len(trim(form.img))>
		<cfset upload = expandPath('./uploads/')>
		<cfif NOT directoryExists(upload)>
			<cfdirectory action="create" directory="#upload#">
		</cfif>
		<cffile action="upload" filefield="img" destination="#upload#" nameConflict="makeunique">
		<cfset extensions = "jpg,png,gif">
		<cfif ListContainsNoCase(extensions,cffile.serverFileExt) AND cffile.fileSize/1024 LTE 1024>
			<cfset img = ImageNew("#upload##cffile.serverFile#")>
			<cfset ImageResize(img,"20","20")>
			<cfimage source="#img#" action="writeToBrowser">
			<form action="image.cfm" method="post">
				<input name="name" type="hidden" value="#form.imgname#">
				<input name="description" type="hidden" value="#form.imgdesc#">
				<input name="image" type="hidden" value="#upload##cffile.serverFile#">
				<input name="submit" type="submit" value="#form.imgname#">
			</form>
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