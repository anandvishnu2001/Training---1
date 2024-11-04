function adjustNavbarPositions() {
    const mainNavHeight = $('#main-nav').innerHeight();
    $('#category-nav').css('top', mainNavHeight + 'px');
}

function changeQuantity(id,change) {
    $.ajax({
        url: '/components/control.cfc?method=editCart',
        type: 'GET',
        data: {
            "cart": id,
            "quantity": change
        },
        success: function(data){
            location.reload();
        }
    });
}

function removeCartProduct(id) {
    $.ajax({
        url: '/components/control.cfc?method=deleteCart',
        type: 'GET',
        data: {
            "cart": id
        },
        success: function(data){
            location.reload();
        }
    });
}

function removeCart(id) {
    $.ajax({
        url: '/components/control.cfc?method=deleteCart',
        type: 'GET',
        data: {
            "user": id
        },
        success: function(data){
            location.reload();
        }
    });
}

$(document).ready(adjustNavbarPositions);
$(window).resize(adjustNavbarPositions);