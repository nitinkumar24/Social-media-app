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
//= require rails_emoji_picker
//= require jquery_ujs
//= require typed
//= require tooltipster.bundle.min
//= require turbolinks
//= require jquery.noty.packaged.min.js

//= require papercrop

//= require jcrop
//= require_tree .

// Loads all Semantic javascripts
//= require semantic-ui


$(function() {
    $("#users , #users .pagination ").on("click", 'th a' ,'a', function() {
        $.getScript(this.href);
        return false;
    });
    $("#products_search input").keyup(function() {
        $.get($("#products_search").attr("action"), $("#products_search").serialize(), null, "script");
        return false;
    });
});

var textarea = document.querySelector('textarea');

textarea.addEventListener('keydown', autosize);

$.noty.defaults.theme = 'relax';
Noty.overrideDefaults({
    layout   : 'topRight',
    theme    : 'mint',
    closeWith: ['click', 'button'],
    animation: {
        open : 'animated fadeInRight',
        close: 'animated fadeOutRight'
    }
});