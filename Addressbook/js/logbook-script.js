//-- logbook.cfm

$(document).ready(function(){
	$.ajax({
		url: './components/manager.cfc?method=getList',
		type: 'GET',
		success: function(data){
			let listObj = JSON.parse(data);
			if (listObj == ''){
				alert('Contacts is Empty');
			}
			else{
				$.each(listObj,function(_,value){
					let row = `<tr>`;
					row += `<td><img class="img-fluid img-thumbnail rounded-pill mx-auto d-block" src="./uploads/${value.profile}" alt="profile" width="60" height="60"></td>`;
					row += `<td class="contactname">${value.title.value+' '+value.firstname+' '+value.lastname}</td>`;
					row += `<td class="contactemail">${value.email}</td>`;
					row += `<td class="contactphone">${value.phone}</td>`;
					row += `<td class="no-print"><button class="btn btn-sm btn-outline-primary fw-bold" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="view" data-bs-id="${value.log_id}">View</button></td>`;
					row += `<td class="no-print"><button class="btn btn-sm btn-outline-warning fw-bold" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="edit" data-bs-id="${value.log_id}">Edit</button></td>`;
					row += `<td class="no-print"><button class="1dlt btn btn-sm btn-outline-danger fw-bold" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="delete" data-bs-id="${value.log_id}">Delete</button></td>`;
					row += `<td class="no-print"><button class="printpage btn btn-sm btn-outline-primary fw-bold" data-bs-id="${value.log_id}">Print</button></td>`;
					row += `</tr>`;
					$("#contactList").append(row);
				});
			}
		}
	});

	$('#modal').on('hidden.bs.modal', function() {
		$('#id').val();
	});

	$('#modal').on('show.bs.modal',function(event){
		$("#contact").attr("src","./images/signup.png");
		let button = $(event.relatedTarget);
		let id = button.data('bs-id');
		if(!$(".contentEdit").hasClass("d-none"))
			$(".contentEdit").addClass("d-none");
		if(!$(".contentDelete").hasClass("d-none"))
			$(".contentDelete").addClass("d-none");
		if(!$(".contentUpload").hasClass("d-none"))
			$(".contentUpload").addClass("d-none");
		if(button.data('bs-action') === "upload"){
			$(".contentUpload").removeClass("d-none");
		}
		else if(button.data('bs-action') === "delete"){
			$(".contentDelete").removeClass("d-none");
			$('#d_id').val(id);
		}
		else{
			$(".contentEdit").removeClass("d-none");
			if(!$("#modalForm").hasClass("d-none"))
				$("#modalForm").addClass("d-none");
			if(!$("#modalView").hasClass("d-none"))
				$("#modalView").addClass("d-none");
			$('#profile').attr("required", 'true');
			if(button.data('bs-action') === "add"){
				$("#modalhead").html("Create Contact");
				$("#modalForm").removeClass("d-none");
				$("#modalForm")[0].reset();
				$("#modalbtn").html("Save");
				
			}
			else{
				$.ajax({
					url: './components/manager.cfc?method=getList',
					type: 'GET',
					data: { logid: id },
					success: function(data){
						let recordObj = JSON.parse(data);
						console.log(recordObj);
						if(button.data('bs-action') === "edit"){
							$("#modalhead").html("Edit Contact");
							$("#modalForm").removeClass("d-none");
							$("#modalbtn").html("Edit");
							$('#id').val(id);
							$('#title').val(recordObj[0].title.id);
							$('#firstname').val(recordObj[0].firstname);
							$('#lastname').val(recordObj[0].lastname);
							$('#gender').val(recordObj[0].gender.id);
							$('#profile').removeAttr("required");
							$("#contact").attr("src",`./uploads/${recordObj[0].profile}`);
							let date = new Date(recordObj[0].date_of_birth);
							date.setDate(date.getDate() + 1);
							$('#date_of_birth').val(date.toISOString().split('T')[0]);
							$('#house_flat').val(recordObj[0].house_flat);
							$('#street').val(recordObj[0].street);
							$('#city').val(recordObj[0].city);
							$('#state').val(recordObj[0].state);
							$('#country').val(recordObj[0].country);
							$('#pincode').val(recordObj[0].pincode);
							$('#email').val(recordObj[0].email);
							$('#phone').val(recordObj[0].phone);
							$('#hobbies').val();
							$('#hobbies option').prop('selected', false);
							recordObj[0].hobbies.forEach(function(value){
								$('#hobbies option[value="' + value.id + '"]').prop('selected', true);
							});
						}
						else if(button.data('bs-action') === "view"){
							$("#modalhead").html("Contact Details");
							$("#modalView").removeClass("d-none");
							$('#v-name').html(recordObj[0].title.value+" "+recordObj[0].firstname+" "+recordObj[0].lastname);
							$('#v-gender').html(recordObj[0].gender.value);
							$("#contact").attr("src",`./uploads/${recordObj[0].profile}`);
							let date = new Date(recordObj[0].date_of_birth);
							date.setDate(date.getDate() + 1);
							$('#v-dob').html(date.toISOString().split('T')[0]);
							$('#v-address').html(`${recordObj[0].house_flat}, <br>${recordObj[0].street}, <br>${recordObj[0].city}, <br>${recordObj[0].state}, <br>${recordObj[0].country}`);
							$('#v-pincode').html(recordObj[0].pincode);
							$('#v-mail').html(recordObj[0].email);
							$('#v-phone').html(recordObj[0].phone);
							$('#v-hobbies').html(recordObj[0].hobbies.map(hobby => hobby.value).join(',<br>'));
						}
					}
				});
			}
		}
	});

	$(document).on("click",".printpage",function(){
		let id = $(this).data('bs-id');
		window.open("print.cfm?logid="+id,"_blank");
	});

	$("#printbtn").click(function(){
		window.print();
	});
});