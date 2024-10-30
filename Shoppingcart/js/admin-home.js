$(document).ready(function () {
  $('#subcategories').hide();
  
  $('#products').hide();

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
      if(button.data("bs-set") === "category" && button.data("bs-action") === "add")
        $('.categoryText').removeClass("d-none");
      else {
        let categorydataObj = button.data("bs-set") === "category" 
          ? { "category": button.data("bs-id") }
          : {};
        $.ajax({
          url: '/components/control.cfc?method=getCategory',
          type: 'GET',
          data:  categorydataObj,
          success: function(data){
            let categoryObj = JSON.parse(data);
            if(button.data("bs-set") === "category") {
              $('.categoryText').removeClass("d-none");
              $('#categoryText').val(categoryObj[0].name);
              $('#categoryText').attr('required', 'true');
              $('#recordId').val(categoryObj[0].id);
            }
            else {
              $('.categorySelect').removeClass("d-none");
              $('#categorySelect').html('<option value=""></option>');
              $.each(categoryObj, function(_, category) {
                $('#categorySelect').append(
                  $('<option>', { value: category.id, text: category.name, selected: category.id == url.get('cat') })
                );
              });
              if(button.data("bs-set") === "subcategory" && button.data("bs-action") === "add")
                $('.subcategoryText').removeClass("d-none");
              else {
                let subcategorydataObj = button.data("bs-set") == "subcategory"
                  ? {
                    "category": url.get('cat'),
                    "subcategory":  button.data("bs-id")
                  }
                  : {
                    "category": url.get('cat')
                  };
                  console.log(subcategorydataObj);
                  $.ajax({
                    url: '/components/control.cfc?method=getSubcategory',
                    type: 'GET',
                    data: subcategorydataObj,
                    success: function(data){
                      let subcategoryObj = JSON.parse(data);
                      if (button.data("bs-set") === "subcategory") {
                        $('.subcategoryText').removeClass("d-none");
                        $('#subcategoryText').val(subcategoryObj[0].name);
                        $('#subcategoryText').attr('required', 'true');
                        $('#recordId').val(subcategoryObj[0].id);
                      }
                      else {
                        $('.subcategorySelect').removeClass("d-none");
                        $('#subcategorySelect').html('<option value=""></option>');
                        $.each(subcategoryObj, function(_, category) {
                          $('#subcategorySelect').append(
                            $('<option>', { value: category.id, text: category.name, selected: category.id == url.get('sub') })
                          );
                        });
                        if(button.data("bs-set") === "product" && button.data("bs-action") === "add")
                          $('#product').removeClass("d-none");
                        else {
                          let productdataObj = button.data("bs-set") == "product"
                          ? {
                            "subcategory": url.get('cat'),
                            "product":  button.data("bs-id")
                          }
                          : {
                            "subcategory": url.get('cat')
                          };
                        }
                      }
                    }
                  });
              }
            }
          }
        });
      }
      /*
      else {
            else {
              
              
              //console.log(url.get('cat'));
              
              
                  
                  }
                  else if (button.data("bs-set") == "product") {
                    
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
      }*/
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