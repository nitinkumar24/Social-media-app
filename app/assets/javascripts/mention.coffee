class @Post
  @add_atwho = ->
    $('#post_content').atwho
      at: '@'
      searchKey: 'real_name'
      displayTpl:"<li class='mention-item' </li>" +
        "<img class=\"h-pro-image\" alt=\"\" src=${image}>"+
        "<span  data-value='(${name},${real_name},)'>${name}${real_name}"+"<br>"
      callbacks: remoteFilter: (query, callback) ->
        if (query.length < 1)
          return false
        else
          $.getJSON '/mentions', { q: query }, (data) ->
            console.log(data)
            callback data

jQuery ->
  Post.add_atwho()