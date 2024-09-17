//-- Confirm Password in logbook.cfm

$(document).ready(function(){
	$.ajax({
		url: './components/manager.cfc?method=getList',
		type: 'GET',
		data: { id: user },
		success: function(data){
			let listObj = JSON.parse(data);
			console.log(listObj);
			if (listObj.RESULTSET == ''){
				alert('Contacts is Empty');
			}
			else{
				for(let i=0;i< listObj.RESULTSET.length;i++){	let row = `<tr id="${listObj.RESULTSET[i]["log_id"]}">`;
					row += `<td><img class="img-fluid rounded-2 mx-auto d-block" src="./uploads/${listObj.RESULTSET[i]["profile"]}" alt="Address Book" width="80" height="80"></td>`;
					row += `<td class="contactname">${listObj.RESULTSET[i]["name"]}</td>`;
					row += `<td class="contactemail">${listObj.RESULTSET[i]["email"]}</td>`;
					row += `<td class="contactphone">${listObj.RESULTSET[i]["phone"]}</td>`;
					row += `<form action=""> <input type="hidden" id="log_id" name="log_id" value="${listObj.RESULTSET[i]["log_id"]}">`;
					row += `<td class="no-print"><button name="view" id="view" type="submit" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modal" data-bs-whatever="view">View</button></td>`;
					row += `<td class="no-print"><button name="edit" id="edit" type="submit" class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modal" data-bs-whatever="edit">Edit</button></td>`;
					row += `<td class="no-print"><button name="delete" id="delete" type="submit" class="1dlt btn btn-sm btn-outline-danger">Delete</button></td>`;
					row += `<td class="no-print"><button name="print" id="print" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modal" data-bs-whatever="print">Print</button></td>`;

					row += `</form></tr>`;
					$("#contactList").append(row);
				}
			}
		}
	});
	$('#modal').on('show.bs.modal',function(event){
		$("#contact").attr("src","./uploads/signup.png");
		let button = $(event.relatedTarget);
		if(!$("#h-add").hasClass("d-none"))
			$("#h-add").addClass("d-none");
		if(!$("#h-edit").hasClass("d-none"))
			$("#h-edit").addClass("d-none");
		if(!$("#h-view").hasClass("d-none"))
			$("#h-view").addClass("d-none");
		if(!$("#modalAdd").hasClass("d-none"))
			$("#modalAdd").addClass("d-none");
		if(!$("#modalEdit").hasClass("d-none"))
			$("#modalEdit").addClass("d-none");
		if(!$("#modalView").hasClass("d-none"))
			$("#modalView").addClass("d-none");
		if(button.data('bs-whatever') === "add"){
			$("#h-add").removeClass("d-none");
			$("#modalAdd").removeClass("d-none");
		}
		else if(button.data('bs-whatever') === "edit"){
			$("#h-edit").removeClass("d-none");
			$("#modalEdit").removeClass("d-none");
		}
		if(button.data('bs-whatever') === "view"){
			$("#h-view").removeClass("d-none");
			$("#modalView").removeClass("d-none");
		}
	});
	$("#printbtn").click(function(){
		window.print();
	});
});