document.forms["birthday"].addEventListener("submit", (event) => {
	let valid = true;
	let form = document.forms["birthday"].elements;
	for(let i = 0;i < form.length-1;i++){
		if(document.getElementById(`${i}`))
			document.getElementById(`${i}`).remove();
		if(form[i].value == "" || form[i].value == null){
			valid = false;
			form[i].insertAdjacentHTML('afterend',`<div id="${i}">*	${form[i].attributes["name"].value} is required!</div>`);
		}
	}
	if(!valid){
		event.preventDefault();
	}
});