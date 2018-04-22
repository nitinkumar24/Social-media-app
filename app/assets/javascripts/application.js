// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require typed
//= require tooltipster.bundle.min
//= require turbolinks
//= require jquery.noty.packaged.min.js
//= require social-share-button
//= require papercrop
//= require typeahead
// = require jquery.atwho
//= require jcrop
//= require_tree .

// Loads all Semantic javascripts
//= require semantic-ui


// document.addEventListener("turbolinks:load", function() {
//     $('.logo').addClass('loader');
//     $('.logo').fadeOut(600);
// });

document.addEventListener("turbolinks:request-start", function() {
    $('.logo').addClass('loader');
    $('.mob_logo').css('display',"none");
    $('.mob_loader').css('display',"block");
    $('.logo').fadeOut(600);
    $('.mob_logo').fadeOut(600);
});


$(document).on('turbolinks:request-end', function(){
    $('.logo').removeClass('loader');
    $('.mob_logo').css('display',"block");
    $('.mob_loader').css('display',"none");
});

$(document).on('load', function(){
    $('.ui.dropdown')
        .dropdown()
    ;
});

// import 'turbolinks-animate';
//
// document.addEventListener( 'turbolinks:load', function() {
//     TurbolinksAnimate.init({ animation: 'fadeinright', duration: '1s', delay: 1000 });
//     console.log(TurbolinksAnimate.appear());
//
// });
//
// $(function() {
//     $("#users , #users .pagination ").on("click", 'th a' ,'a', function() {
//         $.getScript(this.href);
//         return false;
//     });
//     $("#products_search input").keyup(function() {
//         $.get($("#products_search").attr("action"), $("#products_search").serialize(), null, "script");
//         return false;
//     });
// });
//
// var textarea = document.querySelector('textarea');
//
// textarea.addEventListener('keydown', autosize);
//
//
