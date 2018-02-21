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

class @Comment
  @add_atwho = ->
    $('#comment_form').atwho
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

class @Reply
  @add_atwho = ->
    $('#reply_form').atwho
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

jQuery ->
  Comment.add_atwho()

jQuery ->
  Reply.add_atwho()


