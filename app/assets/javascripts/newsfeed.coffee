# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  if $('.pagination').length
    x = []

    $(window).scroll ->
      if  $(window).scrollTop() > $(document).height() - $(window).height() - 10
        url = $('.pagination .next_page').attr('href')
        if url
          if url not in x
            x.push url
            $('.paagination').text("Fetching more products...")
            $.getScript(url);

    $(window).scroll()