function adjustNavbarPositions() {
    const mainNavHeight = $('#main-nav').innerHeight();
    $('#category-nav').css('top', mainNavHeight + 'px');
}

$(document).ready(adjustNavbarPositions);
$(window).resize(adjustNavbarPositions);