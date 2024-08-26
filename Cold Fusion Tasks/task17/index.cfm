<form id="form" action="" method="post">
	Enter a number:
	<input name="num" id="num" type="text">
	<br><input name="btn" type="submit">
</form>
<div id="output">
	<cfif NOT isNull(form.btn)>
		<cfloop from="1" to="#form.num#" index="i">
			<span class="color"><cfoutput>#i#</cfoutput></span>
		</cfloop>
	</cfif>
</div>
<script src="./js/script.js"></script>