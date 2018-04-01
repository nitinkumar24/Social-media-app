this.Post = class Post {
    static add_atwho() {
        return $('#post_content').atwho({
            at: '@',
            searchKey: 'real_name',
            displayTpl: "<li class='mention-item' </li>" + "<img class=\"h-pro-image\" alt=\"\" src=${image}>" + " "+ "<span  data-value='(${real_name},)'>${real_name}" + "<br>",
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
    }

};

this.Comment = class Comment {
    static add_atwho() {
        return $('#comment_form').atwho({
            at: '@',
            searchKey: 'real_name',
            displayTpl: "<li class='mention-item' </li>" + "<img class=\"h-pro-image\" alt=\"\" src=${image}>" + "<span  data-value='(${name},${real_name},)'>${name}${real_name}" + "<br>",
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
    }

};

this.Reply = class Reply {
    static add_atwho() {
        return $('#reply_form').atwho({
            at: '@',
            searchKey: 'real_name',
            displayTpl: "<li class='mention-item' </li>" + "<img class=\"h-pro-image\" alt=\"\" src=${image}>" + "<span  data-value='(${name},${real_name},)'>${name}${real_name}" + "<br>",
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
    }

};

$(document).on('turbolinks:load', function() {
    return Post.add_atwho();
});

$(document).on('turbolinks:load', function() {
    return Comment.add_atwho();
});

$(document).on('turbolinks:load', function() {
    return Reply.add_atwho();
});