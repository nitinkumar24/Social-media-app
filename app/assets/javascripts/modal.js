$(document).on('turbolinks:load', function() {

    $('.modal-activate').click(function(e){
        e.stopPropagation();
        image_src = $(this).attr('src');
        $('.modal').find('img').attr('src',image_src);
        $('.modal').show();
    });
    $('.close').click(function(){
        $('.modal').hide();
    });
    $('.modal .content').click(function(e){
        e.stopPropagation();
    });
    $(document).click(function(){
        $('.modal').hide();
    });
});
