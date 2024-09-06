//-- Confirm Password in logbook.cfm

$(document).ready(function(){
	$.ajax({
		url: './components/manager.cfc?method=getList',
		type: 'GET',
		data: { id: user },
		success: function(data) {	
			let listObj = JSON.parse(data);
			if (listObj.DATA == '') {
				alert('Contacts is Empty');
			}
			else {
				for(let i=0;i< listObj.DATA.length;i++){	let row = `<tr id="${listObj.DATA[i][0]}">`;
					row += `<td><img class="img-fluid rounded-circle mx-auto d-block" src="./images/signup.png" alt="Address Book" width="30" height="30"></td>`;
					row += `<td>${listObj.DATA[i][2]}</td> <td>${listObj.DATA[i][3]}</td> <td>${listObj.DATA[i][4]}</td>`;
					row += `<td><button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#recordModal" data-bs-whatever="view">View</button></td>`;
					row += `<td><button type="button" class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#recordModal" data-bs-whatever="edit">Edit</button></td>`;
					row += `<td><button type="button" class="btn btn-sm btn-outline-danger">Delete</button></td> </tr>\n`;
					$("#contactList").append(row);
				}
			}
		}
	});
	$('#').on('show.bs.modal',function(event){
		let button = $(event.relatedTarget);
		$.ajax({
			url: './components/manager.cfc?method=getRecord',
			type: 'GET',
			data: { id: button.closest('tr').attr('id') },
			success: function(data) {
				$(this).
			}
		});
	});
});