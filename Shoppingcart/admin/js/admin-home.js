$(document).ready(function () {
  $('#subcategories').hide();
  
  $('#products').hide();

  $.ajax({
    url: '../components/control.cfc?method=getCategory',
    type: 'GET',
    success: function(data){
      let listObj = JSON.parse(data);
      console.log(listObj);
      if (listObj == ''){
				$('#categories #categorylist').html('Category is empty');
			}
			else{
        $.each(listObj,function(_,value){
          console.log(value.status === 1);
          if (value.status === 1) {
            let row = `<li class="list-group-item d-flex justify-content-end gap-2">
            <a class="py-2 px-3 list-group-item-action" href="admin-login?sub=${value.id}">${value.name}</a>
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
    console.log($('.delete-mode'));
    if(!$('.modify-mode').hasClass("d-none"))
      $('.modify-mode').addClass("d-none");
    if(!$('#okbtn').hasClass("d-none"))
      $('#okbtn').addClass("d-none");
    if(!$('.delete-mode').hasClass("d-none"))
      $('.delete-mode').addClass("d-none");
    if(!$('#dltbtn').hasClass("d-none"))
      $('#dltbtn').addClass("d-none");
    if(button.data("bs-action") != "delete") {
      $('.modify-mode').removeClass("d-none");
      $('#okbtn').removeClass("d-none");
      if (button.data("bs-action") == "add") {
        $('#okbtn').html('Save');
      }
      else if(button.data("bs-action") == "edit") {
        $('#okbtn').html('Update');
      }
    }
    else {
      $('.delete-mode').removeClass("d-none");
      $('#dltbtn').removeClass("d-none");
    }
	});
});