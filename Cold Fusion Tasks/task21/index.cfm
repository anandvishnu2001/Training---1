<form name="birthday" id="birthday" action="email.cfm" method="post" enctype="multipart/form-data">
	Birthday Baby Name :<input name="name" id="name" type="text"><br>
	His Email Id :<input name="email" id="email" type="email"><br>
	Birthday Wishes :<textarea name="wishes" id="wishes"></textarea><br>
	Greeting image :<input name="image" id="image" type="file" accept="image/*"><br>
	<input name="btn" type="submit">
</form>
<script>
	document.forms["birthday"].addEventListener("submit", (event) => {
		let valid = true;
		let form = document.forms["birthday"].elements;
		for(let i = 0;i < form.length-1;i++){
			if(document.getElementById(`${i}`))
				document.getElementById(`${i}`).remove();
			if(form[i].value == "" || form[i].value == null){
				valid = false;
				form[i].insertAdjacentHTML('afterend',`<div id="${i}">*${form[i].attributes["name"].value} is required!</div>`);
			}
		}
		if(!valid){
			event.preventDefault();
		}
	});
</script>