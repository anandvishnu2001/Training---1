$(document).ready(function () {
  $('#subcategories').hide();
  
  $('#products').hide();

  $.ajax({
    url: '/components/control.cfc?method=getCategory',
    type: 'GET',
    success: function(data){
      let listObj = JSON.parse(data);
      if (listObj == ''){
				$('#categorylist').html('Category is empty');
			}
			else{
        $.each(listObj,function(_,value){
          let row = `<li class="list-group-item d-flex justify-content-end gap-2">
          <a class="py-2 px-3 text-decoration-none list-group-item-action" href="admin-home.cfm?cat=${value.id}">${value.name}</a>
            <button class="btn btn-sm fw-bold btn-outline-success btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="edit" data-bs-set="category" data-bs-id="${value.id}">
              <img src="/images/edit.png" width="40" height="40" class="img-fluid">
            </button>
            <button class="btn btn-sm fw-bold btn-outline-danger btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="delete" data-bs-id="${value.id}">
              <img src="/images/delete.png" width="40" height="40" class="img-fluid">
            </button>
          </li>`;
          $('#categorylist').append(row);
        });
			}
    }
  });

  const url = new URLSearchParams(window.location.search);

  if(url.has('cat')) {
    $('#subcategories').show();
    $.ajax({
      url: '/components/control.cfc?method=getSubcategory',
      type: 'GET',
      data: { "category": url.get('cat') },
      success: function(data){
        let listObj = JSON.parse(data);
        if (listObj == ''){
          $('#subcategorylist').html('Subcategory is empty');
        }
        else{
          $.each(listObj,function(_,value){
            let row = `<li class="list-group-item d-flex justify-content-end gap-2">
            <a class="py-2 px-3 list-group-item-action" href="admin-home.cfm?cat=${value.category}&sub=${value.id}">${value.name}</a>
            <button class="btn btn-sm fw-bold btn-outline-success btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="edit" data-bs-set="subcategory" data-bs-id="${value.id}">
              <img src="/images/edit.png" width="40" height="40" class="img-fluid">
            </button>
            <button class="btn btn-sm fw-bold btn-outline-danger btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="delete" data-bs-id="${value.id}">
              <img src="/images/delete.png" width="40" height="40" class="img-fluid">
            </button>
            </li>`;
            $('#subcategorylist').append(row);
          });
        }
      }
    });
  }

  if(url.has('sub')) {
    $('#products').show();
    $.ajax({
      url: '/components/control.cfc?method=getProduct',
      type: 'GET',
      data: { "subcategory": url.get('sub') },
      success: function(data){
        let listObj = JSON.parse(data);
        console.log(listObj);
        if (listObj == ''){
          $('#productlist').html('Product is empty');
        }
        else{
          $.each(listObj,function(_,value){
            let row = `<li class="list-group-item d-flex justify-content-end gap-2">
            <a class="py-2 px-3 list-group-item-action" href="">${value.name}</a>
            <button class="btn btn-sm fw-bold btn-outline-success btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="edit" data-bs-set="product" data-bs-id="${value.id}">
              <img src="/images/edit.png" width="40" height="40" class="img-fluid">
            </button>
            <button class="btn btn-sm fw-bold btn-outline-danger btn-block" data-bs-toggle="modal" data-bs-target="#modal" data-bs-action="delete" data-bs-id="${value.id}">
              <img src="/images/delete.png" width="40" height="40" class="img-fluid">
            </button>
            </li>`;
            $('#productlist').append(row);
          });
        }
      }
    });
  }

  $('#modal').on('hidden.bs.modal',function(event){
    $('#modalForm').find('input','textarea','select').removeAttr('required');
    $('#recordId').val();
  });

  $('#modal').on('show.bs.modal',function(event){
    let button = $(event.relatedTarget);
    if(!$('.category').hasClass("d-none"))
      $('.category').addClass("d-none");
    if(!$('.subcategory').hasClass("d-none"))
      $('.subcategory').addClass("d-none");
    if(!$('.product').hasClass("d-none"))
      $('.product').addClass("d-none");
    if(!$('#editImageView').hasClass("d-none"))
      $('#editImageView').addClass("d-none");
    if(!$('#okbtn').hasClass("d-none"))
      $('#okbtn').addClass("d-none");
    if(!$('.delete-mode').hasClass("d-none"))
      $('.delete-mode').addClass("d-none");
    if(!$('#dltbtn').hasClass("d-none"))
      $('#dltbtn').addClass("d-none");
    if(button.data("bs-action") != "delete") {
      $('#okbtn').removeClass("d-none");
      switch (button.data("bs-set")) {
        case "product":
          $('.product').removeClass("d-none");
          $('#product').find('input','textarea','select').attr('required', 'true');
        case "subcategory":
          $('.subcategory').removeClass("d-none");
          $('#subcategory').attr('required', 'true');
        case "category":
          $('.category').removeClass("d-none");
          $('#category').attr('required', 'true');
      }
      if(button.data("bs-action") == "edit") {
        $('#okbtn').html('Update');
        $('#editImageView').removeClass("d-none");
        switch (button.data("bs-set")) {
          case "product":
            $.ajax({
              url: '/components/control.cfc?method=getProduct',
              type: 'GET',
              data: {
                "subcategory": url.get('sub'),
                "product": button.data("bs-id")
              },
              success: function(data){
                let listObj = JSON.parse(data);
              }
            });
          case "subcategory":
            $.ajax({
              url: '/components/control.cfc?method=getSubcategory',
              type: 'GET',
              data: {
                "category": url.get('cat'),
                "subcategory": button.data("bs-id")
              },
              success: function(data){
                let listObj = JSON.parse(data);
              }
            });
          case "category":
            $.ajax({
              url: '/components/control.cfc?method=getCategory',
              type: 'GET',
              data: { "category": button.data("bs-id") },
              success: function(data){
                let listObj = JSON.parse(data);
                console.log(listObj);
                $('#category').val(listObj[0].name);
              }
            });
        }
      }
      else if (button.data("bs-action") == "add") {
        $('#okbtn').html('Save');
      }
    }
    else {
      $('.delete-mode').removeClass("d-none");
      $('#dltbtn').removeClass("d-none");
    }
	});
});