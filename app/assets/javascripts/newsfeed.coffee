# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  if $('.pagination').length
    x = []
    $(window).scroll ->
      if  $(window).scrollTop() > $(document).height() - $(window).height() - 30
        url = $('.pagination .next_page').attr('href')
        console.log(url);
        if url
          x.push url
          $('.pagination').text("").css("text-align","center")
          $.getScript(url);

    $(window).scroll()

