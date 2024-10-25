$(document).ready(function () {
  $('#subcategories').hide();
  
  $('#products').hide();

  $.ajax({
    url: './components/control.cfc?method=getCategory',
    type: 'GET',
    success: function(data){
      let listObj = JSON.parse(data);
      if (listObj == ''){
				alert('Contacts is Empty');
			}
			else{
        $.each(listObj,function(_,value){
          console.log(value.status === 1);
          if (value.status === 1) {
            let row = `<li class="list-group-item d-flex justify-content-end gap-2">
            <button class="py-2 px-3 list-group-item-action">${value.name}</button>
            <button class="btn btn-sm fw-bold btn-outline-success btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="edit" data-bs-id="${value.id}">Edit</button>
            <button class="btn btn-sm fw-bold btn-outline-danger btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="delete" data-bs-id="${value.id}">Delete</button>
            </li>`;
            $('#categories #categorylist').append(row);
            }
        });
			}
    }
  });

  $('#modal').on('show.bs.modal',function(event){
    let button = $(event.relatedTarget);
    $('#modal .modify-mode').hide();
    $('#modal .delete-mode').hide();
	});
});