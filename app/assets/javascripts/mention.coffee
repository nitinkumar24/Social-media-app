class @Post
  @add_atwho = ->
    $('#post_content').atwho
      at: '@'
      displayTpl:"<li class='mention-item' </li>" +
        "<img class=\"h-pro-image\" alt=\"\" src=${image}>"+
        "<span  data-value='(${name},${real_name},${atwho_order})'>${name}${real_name}${atwho_order}"+"<br>"
      callbacks: remoteFilter: (query, callback) ->
        if (query.length < 1)
          return false
        else
          $.getJSON '/mentions', { q: query }, (data) ->
            console.log(data)
            callback data

jQuery ->
  Post.add_atwho()