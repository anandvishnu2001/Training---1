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
					row += `<td><img class="img-fluid rounded-circle mx-auto d-block" src="./uploads/${listObj.RESULTSET[i]["profile"]}" alt="Address Book" width="30" height="30"></td>`;
					row += `<td class="contactname">${listObj.RESULTSET[i]["name"]}</td>`;
					row += `<td class="contactemail">${listObj.RESULTSET[i]["email"]}</td>`;
					row += `<td class="contactphone">${listObj.RESULTSET[i]["phone"]}</td>`;
					row += `<td class="no-print"><button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modal" data-bs-whatever="view">View</button></td>`;
					row += `<td class="no-print"><button type="button" class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modal" data-bs-whatever="edit">Edit</button></td>`;
					row += `<td class="no-print"><button type="button" class="1dlt btn btn-sm btn-outline-danger">Delete</button></td> </tr>`;
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
			$.ajax({
				url: './components/manager.cfc?method=getEdit',
				type: 'GET',
				data: { log_id: button.closest('tr').attr('id'),
					user_id: user },
				success: function(data){
					let editObj = JSON.parse(data);
					$('#e_id').val(button.closest('tr').attr('id'));
					$('#e_title').val(editObj.RESULTSET[0]["title"]);
					$('#e_firstname').val(editObj.RESULTSET[0]["firstname"]);
					$('#e_lastname').val(editObj.RESULTSET[0]["lastname"]);
					$('#e_gender').val(editObj.RESULTSET[0]["gender"]);
					$("#contact").attr("src",`./uploads/${editObj.RESULTSET[0]["profile"]}`);
					let date = new Date(editObj.RESULTSET[0]["date_of_birth"]);
					date.setDate(date.getDate() + 1);
					$('#e_date_of_birth').val(date.toISOString().split('T')[0]);
					$('#e_house_flat').val(editObj.RESULTSET[0]["house_flat"]);
					$('#e_street').val(editObj.RESULTSET[0]["street"]);
					$('#e_city').val(editObj.RESULTSET[0]["city"]);
					$('#e_state').val(editObj.RESULTSET[0]["state"]);
					$('#e_country').val(editObj.RESULTSET[0]["country"]);
					$('#e_pincode').val(editObj.RESULTSET[0]["pincode"]);
					$('#e_email').val(editObj.RESULTSET[0]["email"]);
					$('#e_phone').val(editObj.RESULTSET[0]["phone"]);
				}
			});
		}
		if(button.data('bs-whatever') === "view"){
			$("#h-view").removeClass("d-none");
			$("#modalView").removeClass("d-none");
			$.ajax({
				url: './components/manager.cfc?method=getView',
				type: 'GET',
				data: { log_id: button.closest('tr').attr('id'),
					user_id: user },
				success: function(data){
					let viewObj = JSON.parse(data);
					console.log(viewObj.RESULTSET[0]);
					$('#v-name').html(viewObj.RESULTSET[0]["name"]);
					$('#v-gender').html(viewObj.RESULTSET[0]["gender"]);
					$("#contact").attr("src",`./uploads/${viewObj.RESULTSET[0]["profile"]}`);
					let date = new Date(viewObj.RESULTSET[0]["date_of_birth"]);
					date.setDate(date.getDate() + 1);
					$('#v-dob').html(date.toISOString().split('T')[0]);
					$('#v-address').html(viewObj.RESULTSET[0]["address"]);
					$('#v-pincode').html(viewObj.RESULTSET[0]["pincode"]);
					$('#v-mail').html(viewObj.RESULTSET[0]["email"]);
					$('#v-phone').html(viewObj.RESULTSET[0]["phone"]);
				}
			});

		}
	});
	$(document).on('click','.1dlt',function(){
		$.ajax({
			url: './components/manager.cfc?method=deleteRecord',
			type: 'GET',
			data: { log_id: $(this).closest('tr').attr('id'),
				user_id: user },
			success: function(response){
				if(response == 1)
					window.location.href = "logbook.cfm";
			}
		});
	});
	$("#printbtn").click(function(){
		window.print();
	});
});