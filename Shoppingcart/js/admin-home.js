$(document).ready(function () {
  $('#subcategories').hide();
  
  $('#products').hide();

  /*$.ajax({
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
  });*/

  const url = new URLSearchParams(window.location.search);

  if(url.has('cat')) {
    $('#subcategories').show();
  }

  if(url.has('sub')) {
    $('#products').show();
  }

  $('#modal').on('hidden.bs.modal',function(event){
    $('#modalForm').find('input','textarea','select').removeAttr('required').val();
    $('#modalForm')[0].reset();
    $('#recordId').val();
  });

  $('#modal').on('show.bs.modal',function(event){
    let button = $(event.relatedTarget);
    if(!$('.categoryText').hasClass("d-none"))
      $('.categoryText').addClass("d-none");
    if(!$('.categorySelect').hasClass("d-none"))
      $('.categorySelect').addClass("d-none");
    if(!$('.subcategoryText').hasClass("d-none"))
      $('.subcategoryText').addClass("d-none");
    if(!$('.subcategorySelect').hasClass("d-none"))
      $('.subcategorySelect').addClass("d-none");
    if(!$('#product').hasClass("d-none"))
      $('#product').addClass("d-none");
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
      $.ajax({
        url: '/components/control.cfc?method=getCategory',
        type: 'GET',
        data:  { "category": button.data("bs-set") == "category" ? button.data("bs-id") : undefined },
        success: function(data){
          let listObj = JSON.parse(data);
          if(button.data("bs-set") == "category") {
            $('.categoryText').removeClass("d-none");
            if(button.data("bs-action") == "edit") {
              $('#categoryText').val(listObj[0].name);
              $('#categoryText').attr('required', 'true');
            }
          }
          else if (button.data("bs-set") == "subcategory") {
            $('.categorySelect').removeClass("d-none");
            $.each(listObj, function(_, category) {
              $('#categorySelect').append(
                $('<option>', { value: category.id, text: category.name, selected: category.id == url.get('cat') })
              );
            });
            $.ajax({
              url: '/components/control.cfc?method=getSubcategory',
              type: 'GET',
              data: {
                "category": url.get('cat'),
                "subcategory": button.data("bs-set") == "subcategory" ? button.data("bs-id") : undefined
              },
              success: function(data){
                let listObj = JSON.parse(data);
                console.log(listObj);
                if(button.data("bs-set") == "subcategory") {
                  $('#subcategoryText').val(listObj[0].name);
                  $('.subcategoryText').removeClass("d-none");
                  $('#subcategoryText').attr('required', 'true');
                }
                else if (button.data("bs-set") == "product") {
                  $('.subcategorySelect').removeClass("d-none");
                  $.each(listObj, function(_, category) {
                    $('#subcategorySelect').append(
                      $('<option>', { value: category.id, text: category.name, selected: category.id == url.get('sub') })
                    );
                  });
                  $.ajax({
                    url: '/components/control.cfc?method=getProduct',
                    type: 'GET',
                    data: {
                      "subcategory": url.get('sub'),
                      "product": button.data("bs-id")
                    },
                    success: function(data){
                      let listObj = JSON.parse(data);
                      if(button.data("bs-set") == "subcategory") {
                        $('#productName').val(listObj[0].name);
                        $('#product').removeClass("d-none").find('input','textarea','select').attr('required', 'true');
                        $('#subcategoryText').attr('required', 'true');
                      }
                    }
                  });
                }
              }
            });
          }
        }
      });
      if(button.data("bs-action") == "edit") {
        $('#okbtn').html('Update');
        $('#editImageView').removeClass("d-none");
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