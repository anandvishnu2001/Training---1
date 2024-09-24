//-- Confirm Password in logbook.cfm

$(document).ready(function(){
	$.ajax({
		url: './components/manager.cfc?method=getList',
		type: 'GET',
		data: { userid: user },
		success: function(data){
			let listObj = JSON.parse(data);
			console.log(listObj);
			if (listObj == ''){
				alert('Contacts is Empty');
			}
			else{
				$.each(listObj,function(key,record){
					console.log(record);
					let row = `<tr>`;
					row += `<td><img class="img-fluid img-thumbnail rounded-circle mx-auto d-block" src="./uploads/${record.PROFILE}" alt="Address Book" width="50" height="50"></td>`;
					row += `<td class="contactname">${Object.values(record.TITLE)[0]+' '+record.FIRSTNAME+' '+record.LASTNAME}</td>`;
					row += `<td class="contactemail">${record.EMAIL}</td>`;
					row += `<td class="contactphone">${record.PHONE}</td>`;
					row += `<td class="no-print"><button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="view" data-bs-id="${key}">View</button></td>`;
					row += `<td class="no-print"><button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="edit" data-bs-id="${key}">Edit</button></td>`;
					row += `<td class="no-print"><button class="1dlt btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="delete" data-bs-id="${key}">Delete</button></td>`;
					row += `<td class="no-print"><button class="printpage btn btn-sm btn-outline-primary" data-bs-id="${key}">Print</button></td>`;
					row += `</tr>`;
					$("#contactList").append(row);
				});
			}
		}
	});
	$('#modal').on('show.bs.modal',function(event){
		$("#contact").attr("src","./uploads/signup.png");
		let button = $(event.relatedTarget);
		let id = button.data('bs-id');
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
			else{
				$.ajax({
					url: './components/manager.cfc?method=getList',
					type: 'GET',
					data: { userid: user,
						logid: id },
					success: function(data){
						let recordObj = JSON.parse(data);
						if(button.data('bs-action') === "edit"){
							$("#h-edit").removeClass("d-none");
							$("#modalEdit").removeClass("d-none");
							$('#e_id').val(id);
							$('#e_title').val(Object.keys(recordObj[id].TITLE));
							$('#e_firstname').val(recordObj[id].FIRSTNAME);
							$('#e_lastname').val(recordObj[id].LASTNAME);
							$('#e_gender').val(Object.keys(recordObj[id].GENDER));
							$("#contact").attr("src",`./uploads/${recordObj[id].PROFILE}`);
							let date = new Date(recordObj[id].DATE_OF_BIRTH);
							date.setDate(date.getDate() + 1);
							$('#e_date_of_birth').val(date.toISOString().split('T')[0]);
							$('#e_house_flat').val(recordObj[id].HOUSE_FLAT);
							$('#e_street').val(recordObj[id].STREET);
							$('#e_city').val(recordObj[id].CITY);
							$('#e_state').val(recordObj[id].STATE);
							$('#e_country').val(recordObj[id].COUNTRY);
							$('#e_pincode').val(recordObj[id].PINCODE);
							$('#e_email').val(recordObj[id].EMAIL);
							$('#e_phone').val(recordObj[id].PHONE);
							$('#e_hobbies').val();
							$('#e_hobbies option').prop('selected', false);
							Object.keys(recordObj[id].HOBBIES).forEach(function(value){
								$('#e_hobbies option[value="' + value + '"]').prop('selected', true);
							});
						}
						else if(button.data('bs-action') === "view"){
							$("#h-view").removeClass("d-none");
							$("#modalView").removeClass("d-none");
							$('#v-name').html(Object.values(recordObj[id].TITLE)+" "+recordObj[id].FIRSTNAME+" "+recordObj[id].LASTNAME);
							$('#v-gender').html(Object.values(recordObj[id].GENDER));
							$("#contact").attr("src",`./uploads/${recordObj[id].PROFILE}`);
							let date = new Date(recordObj[id].DATE_OF_BIRTH);
							date.setDate(date.getDate() + 1);
							$('#v-dob').html(date.toISOString().split('T')[0]);
							$('#v-address').html(`${recordObj[id].HOUSE_FLAT}, <br>${recordObj[id].STREET}, <br>${recordObj[id].CITY}, <br>${recordObj[id].STATE}, <br>${recordObj[id].COUNTRY}`);
							$('#v-pincode').html(recordObj[id].PINCODE);
							$('#v-mail').html(recordObj[id].EMAIL);
							$('#v-phone').html(recordObj[id].PHONE);
							$('#v-hobbies').html(Object.values(recordObj[id].HOBBIES).join(',<br>'));
						}
					}
				});
			}
		}
	});
	$(document).on("click",".printpage",function(){
		let id = $(this).data('bs-id');
		window.open("print.cfm?id="+id,"_blank");
	});
	$("#printbtn").click(function(){
		window.print();
	});
});