//-- Confirm Password in logbook.cfm

$(document).ready(function(){
	$.ajax({
		url: './components/manager.cfc?method=getList',
		type: 'GET',
		data: { id: user },
		success: function(data){
			let listObj = JSON.parse(data);
			if (listObj.DATA == ''){
				alert('Contacts is Empty');
			}
			else{
				for(let i=0;i< listObj.DATA.length;i++){	let row = `<tr id="${listObj.DATA[i][0]}">`;
					row += `<td><img class="img-fluid rounded-circle mx-auto d-block" src="./images/signup.png" alt="Address Book" width="30" height="30"></td>`;
					row += `<td class="contactname">${listObj.DATA[i][2]}</td>`;
					row += `<td class="contactemail">${listObj.DATA[i][3]}</td>`;
					row += `<td class="contactphone">${listObj.DATA[i][4]}</td>`;
					row += `<td class="no-print"><button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modal" data-bs-whatever="view">View</button></td>`;
					row += `<td class="no-print"><button type="button" class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modal" data-bs-whatever="edit">Edit</button></td>`;
					row += `<td class="no-print"><button type="button" class="1dlt btn btn-sm btn-outline-danger">Delete</button></td> </tr>`;
					$("#contactList").append(row);
				}
			}
		}
	});
	$('#modal').on('show.bs.modal',function(event){
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
					$('#e_title').val(editObj.DATA[0][0]);
					$('#e_firstname').val(editObj.DATA[0][1]);
					$('#e_lastname').val(editObj.DATA[0][2]);
					$('#e_gender').val(editObj.DATA[0][3]);
					let date = new Date(editObj.DATA[0][4]);
					date.setDate(date.getDate() + 1);
					$('#e_date_of_birth').val(date.toISOString().split('T')[0]);
					$('#e_house_flat').val(editObj.DATA[0][6]);
					$('#e_street').val(editObj.DATA[0][7]);
					$('#e_city').val(editObj.DATA[0][8]);
					$('#e_state').val(editObj.DATA[0][9]);
					$('#e_country').val(editObj.DATA[0][10]);
					$('#e_pincode').val(editObj.DATA[0][11]);
					$('#e_email').val(editObj.DATA[0][12]);
					$('#e_phone').val(editObj.DATA[0][13]);
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
					console.log(viewObj.DATA);
					$('#v-name').html(viewObj.DATA[0][0]);
					$('#v-gender').html(viewObj.DATA[0][1]);
					let date = new Date(viewObj.DATA[0][2]);
					date.setDate(date.getDate() + 1);
					$('#v-dob').html(date.toISOString().split('T')[0]);
					$('#v-address').html(viewObj.DATA[0][4]);
					$('#v-pincode').html(viewObj.DATA[0][5]);
					$('#v-mail').html(viewObj.DATA[0][6]);
					$('#v-phone').html(viewObj.DATA[0][7]);
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