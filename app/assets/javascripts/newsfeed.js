$(document).on('turbolinks:load', function() {
    jQuery(function() {
        if ($('.pagination').length) {
            $(window).scroll(function() {
                var url;
                url = $('.pagination .next_page').attr('href');
                if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 125) {
                    $('.pagination').text("Loading");
                    return $.getScript(url);
                }
            });
            return $(window).scroll();
        }
    });
});


//
// $(document).on('turbolinks:load', function() {
//     var x;
//     if ($('.pagination').length) {
//         x = [];
//         console.log(x);
//         $(window).scroll(function() {
//             var url;
//             if ($(window).scrollTop() > $(document).height() - $(window).height() - 30) {
//                 url = $('.pagination .next_page').attr('href');
//
//                     if (url) {
//                         var p = url.split("page")[1];
//                         $('.pagination').css("display", "none");
//                         $('.loading_more').css("display", "block");
//                         if (x.indexOf(p) === -1){
//                             console.log(x);
//                             console.log(url);
//                             x.push(p);
//                             $.getScript(url);
//
//
//                         }
//s
//                     }
//
//             }
//         });
//         return $(window).scroll();
//     }
// });
