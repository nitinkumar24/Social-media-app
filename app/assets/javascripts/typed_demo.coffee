ready = ->
    $('#typed-sample').typed
        strings: [" Don't let your college memories die. " ]
        loop: true

$(document).on('turbolinks:load', ready)
