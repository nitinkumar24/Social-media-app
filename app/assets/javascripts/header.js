$(document).on('turbolinks:load', function() {
    var is_mobile = window.matchMedia("(max-width: 700px)");
    if(is_mobile.matches) {
        var lastScrollTop = 200;
        $(window).scroll(function (event) {
            var st = $(this).scrollTop();
            if (st > lastScrollTop) {
                // downscroll code
                $('mobile .top').hide();
                lastScrollTop = st;
            } else {
                // upscroll code
                $('mobile .top').show();
            }


        });
    }
});
