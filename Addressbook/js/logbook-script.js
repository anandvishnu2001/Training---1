//-- Confirm Password in logbook.cfm

$(document).ready(function(){
	$.ajax({
		url: './components/manager.cfc?method=getList',
		type: 'GET',
		data: { id: user },
		success: function(data){
			let listObj = JSON.parse(data);
			console.log(listObj);
			if (listObj == ''){
				alert('Contacts is Empty');
			}
			else{
				$.each(listObj,function(key,record){
					console.log(record);
					let row = `<tr id="${record[1]}">`;
					row += `<td><img class="img-fluid img-thumbnail rounded-circle mx-auto d-block" src="./uploads/${record[2]}" alt="Address Book" width="50" height="50"></td>`;
					row += `<td class="contactname">${record[3]}</td>`;
					row += `<td class="contactemail">${record[4]}</td>`;
					row += `<td class="contactphone">${record[5]}</td>`;
					row += `<td class="no-print"><button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="view">View</button></td>`;
					row += `<td class="no-print"><button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="edit">Edit</button></td>`;
					row += `<td class="no-print"><button class="1dlt btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="delete">Delete</button></td>`;
					row += `<td class="no-print"><button class="printpage btn btn-sm btn-outline-primary">Print</button></td>`;
					row += `</tr>`;
					$("#contactList").append(row);
				});
			}
		}
	});
	$('#modal').on('show.bs.modal',function(event){
		$("#contact").attr("src","./uploads/signup.png");
		let button = $(event.relatedTarget);
		let id = button.closest('tr').attr('id');
		if(!$(".contentEdit").hasClass("d-none"))
			$(".contentEdit").addClass("d-none");
		if(!$(".contentDelete").hasClass("d-none"))
			$(".contentDelete").addClass("d-none");
		if(button.data('bs-action') === "delete"){
			$(".contentDelete").removeClass("d-none");
			$('#d_id').val(id);
		}
		else{
			$(".contentEdit").removeClass("d-none");
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
			if(button.data('bs-action') === "add"){
				$("#h-add").removeClass("d-none");
				$("#modalAdd").removeClass("d-none");
			}
			else if(button.data('bs-action') === "edit"){
				$("#h-edit").removeClass("d-none");
				$("#modalEdit").removeClass("d-none");
				$.ajax({
					url: './components/manager.cfc?method=getEdit',
					type: 'GET',
					data: { user_id: user,
						log_id: id },
					success: function(data){
						let editObj = JSON.parse(data);
						$('#e_id').val(id);
						$('#e_title').val(editObj[1]);
						$('#e_firstname').val(editObj[2]);
						$('#e_lastname').val(editObj[3]);
						$('#e_gender').val(editObj[4]);
						$("#contact").attr("src",`./uploads/${editObj[6]}`);
						let date = new Date(editObj[5]);
						date.setDate(date.getDate() + 1);
						$('#e_date_of_birth').val(date.toISOString().split('T')[0]);
						$('#e_house_flat').val(editObj[7]);
						$('#e_street').val(editObj[8]);
						$('#e_city').val(editObj[9]);
						$('#e_state').val(editObj[10]);
						$('#e_country').val(editObj[11]);
						$('#e_pincode').val(editObj[12]);
						$('#e_email').val(editObj[13]);
						$('#e_phone').val(editObj[14]);
					}
				});
			}
			else if(button.data('bs-action') === "view"){
				$("#h-view").removeClass("d-none");
				$("#modalView").removeClass("d-none");
				$.ajax({
					url: './components/manager.cfc?method=getView',
					type: 'GET',
					data: { user_id: user,
						log_id: id },
					success: function(data){
						let viewObj = JSON.parse(data);
						$('#v-name').html(viewObj[1]);
						$('#v-gender').html(viewObj[2]);
						$("#contact").attr("src",`./uploads/${viewObj[4]}`);
						let date = new Date(viewObj[3]);
						date.setDate(date.getDate() + 1);
						$('#v-dob').html(date.toISOString().split('T')[0]);
						$('#v-address').html(viewObj[5]);
						$('#v-pincode').html(viewObj[6]);
						$('#v-mail').html(viewObj[7]);
						$('#v-phone').html(viewObj[8]);
					}
				});
			}
		}
	});
	$(document).on("click",".printpage",function(){
		
    // Get the ID of the closest table row
    var rowId = $(this).closest('tr').attr('id');
    
    // Send the data via AJAX
    $.post('print.cfm', { id: rowId }, function(response) {
        // Handle the response here
        window.open('print.cfm');
    });});
	$("#printbtn").click(function(){
		window.print();
	});
});