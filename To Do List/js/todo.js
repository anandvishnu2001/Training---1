let l = 0;

let list = document.getElementsByTagName("LI");

let u = document.getElementById("items");

let t = document.getElementById("add");

function newItem(){
	//localStorage.setItem(l.toString(),t.value);
	if(t.value == '' || t.value == null)
		alert('No item listed');
	else{
		const n = document.createElement("LI");
		n.innerHTML = t.value + '<button onclick="deItem(event)" class="badge btn-close float-end bg-danger"> </button>';
		n.className = "list-group-item btn text-start float-start rounded";
		n.classList.toggle("bg-warning");
		n.setAttribute('onclick','checkItem(event)');
		u.appendChild(n);
			save();
	}
}

function checkItem(event){
	let k = event.target;
	k.classList.toggle("bg-warning");
	k.classList.toggle("bg-success");
	save();
}

function deItem(event){
	let k = event.target.parentElement;
	k.remove();
	save();
}

function save(){
	let v = u.innerHTML;
	localStorage.setItem('items',v);
}

function restore(){
	u.innerHTML = localStorage.getItem('items');
}

window.onload = restore();