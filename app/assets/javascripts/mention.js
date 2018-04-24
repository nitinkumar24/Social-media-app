
$(document).on('turbolinks:load', function() {
    $('#post_content').atwho({
        at: '@',
        searchKey: 'real_name',
        displayTpl: "<li class='mention-item' </li>" + "<img class=\"h-pro-image\" alt=\"\" src=${image}>"  + "<span  data-value='(${real_name},)'>${real_name}" + "<br>",
        callbacks: {
            remoteFilter: function(query, callback) {
                if (query.length < 1) {
                    return false;
                } else {
                    return $.getJSON('/mentions', {
                        q: query
                    }, function(data) {
                        console.log(data);
                        return callback(data);
                    });
                }
            }
        }
    });

});

$(document).on('turbolinks:load', function() {
    $('.comment-input').atwho({
        at: '@',
        searchKey: 'real_name',
        displayTpl: "<li class='mention-item' </li>" + "<img class=\"h-pro-image\" alt=\"\" src=${image}>"  + "<span  data-value='(${real_name},)'>${real_name}" + "<br>",
        callbacks: {
            remoteFilter: function(query, callback) {
                if (query.length < 1) {
                    return false;
                } else {
                    return $.getJSON('/mentions', {
                        q: query
                    }, function(data) {
                        console.log(data);
                        return callback(data);
                    });
                }
            }
        }
    });
});

$(document).on('turbolinks:load', function() {

    $('.reply-input').atwho({
        at: '@',
        searchKey: 'real_name',
        displayTpl: "<li class='mention-item' </li>" + "<img class=\"h-pro-image\" alt=\"\" src=${image}>"  + "<span  data-value='(${real_name},)'>${real_name}" + "<br>",
        callbacks: {
            remoteFilter: function(query, callback) {
                if (query.length < 1) {
                    return false;
                } else {
                    return $.getJSON('/mentions', {
                        q: query
                    }, function(data) {
                        console.log(data);
                        return callback(data);
                    });
                }
            }
        }
    });
});