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
<script>
	let form = document.getElementById("form");
	form.addEventListener("submit",function(event){
		let num = document.getElementById("num").value;
		if(isNaN(num)){
			event.preventDefault();
			alert("Only Number is Allowed");
			document.getElementById("output").innerHTML = "";
		}
	});
	let item = document.getElementsByClassName("color");
	for(let i=0; i<item.length; i++){
		if(item[i].innerHTML%2 == 0)
			item[i].style.color = 'green';
		else
			item[i].style.color = 'blue';
	}
</script>