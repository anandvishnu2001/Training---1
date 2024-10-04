//-- Confirm Password in logbook.cfm

$(document).ready(function(){
	$.ajax({
		url: './components/manager.cfc?method=getList',
		type: 'GET',
		success: function(data){
			let listObj = JSON.parse(data);
			console.log(listObj);
			if (listObj == ''){
				alert('Contacts is Empty');
			}
			else{
				$.each(listObj,function(key,record){
					let row = `<tr>`;
					row += `<td><img class="img-fluid img-thumbnail rounded-circle mx-auto d-block" src="./uploads/${record.profile}" alt="profile" width="50" height="50"></td>`;
					row += `<td class="contactname">${Object.values(record.title)[0]+' '+record.firstname+' '+record.lastname}</td>`;
					row += `<td class="contactemail">${record.email}</td>`;
					row += `<td class="contactphone">${record.phone}</td>`;
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
						if(button.data('bs-action') === "edit"){
							$("#modalhead").html("Edit Contact");
							$("#modalForm").removeClass("d-none");
							$("#modalbtn").html("Edit");
							$('#id').val(id);
							$('#title').val(Object.keys(recordObj[id].title));
							$('#firstname').val(recordObj[id].firstname);
							$('#lastname').val(recordObj[id].lastname);
							$('#gender').val(Object.keys(recordObj[id].gender));
							$('#profile').removeAttr("required");
							$("#contact").attr("src",`./uploads/${recordObj[id].profile}`);
							let date = new Date(recordObj[id].date_of_birth);
							date.setDate(date.getDate() + 1);
							$('#date_of_birth').val(date.toISOString().split('T')[0]);
							$('#house_flat').val(recordObj[id].house_flat);
							$('#street').val(recordObj[id].street);
							$('#city').val(recordObj[id].city);
							$('#state').val(recordObj[id].state);
							$('#country').val(recordObj[id].country);
							$('#pincode').val(recordObj[id].pincode);
							$('#email').val(recordObj[id].email);
							$('#phone').val(recordObj[id].phone);
							$('#hobbies').val();
							$('#hobbies option').prop('selected', false);
							Object.keys(recordObj[id].hobbies).forEach(function(value){
								$('#hobbies option[value="' + value + '"]').prop('selected', true);
							});
						}
						else if(button.data('bs-action') === "view"){
							$("#modalhead").html("Contact Details");
							$("#modalView").removeClass("d-none");
							$('#v-name').html(Object.values(recordObj[id].title)+" "+recordObj[id].firstname+" "+recordObj[id].lastname);
							$('#v-gender').html(Object.values(recordObj[id].gender));
							$("#contact").attr("src",`./uploads/${recordObj[id].profile}`);
							let date = new Date(recordObj[id].date_of_birth);
							date.setDate(date.getDate() + 1);
							$('#v-dob').html(date.toISOString().split('T')[0]);
							$('#v-address').html(`${recordObj[id].house_flat}, <br>${recordObj[id].street}, <br>${recordObj[id].city}, <br>${recordObj[id].state}, <br>${recordObj[id].country}`);
							$('#v-pincode').html(recordObj[id].pincode);
							$('#v-mail').html(recordObj[id].email);
							$('#v-phone').html(recordObj[id].phone);
							$('#v-hobbies').html(Object.values(recordObj[id].hobbies).join(',<br>'));
						}
					}
				});
			}
		}
	});

	$("#uploadbtn").click(function() {
		setTimeout(function() {
			window.location.href="logbook.cfm";
		},1000);
	});

	$(document).on("click",".printpage",function(){
		let id = $(this).data('bs-id');
		window.open("print.cfm?logid="+id,"_blank");
	});

	$("#printbtn").click(function(){
		window.print();
	});
});