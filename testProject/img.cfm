<cfform action="" method="post">
	<label>Enter keyword:</label>
	<cfinput name="ketyword" type="text" pattern="[^\s]{4}">
	<cfinput name="keyword" type="file" pattern="[^\s]+\.(jpg|jpeg|png|gif|bmp)$" accept="image/*">
	<br><cfinput name="btn" type="submit">
</cfform>
<cfif NOT isNull(form.btn)>
</cfif>