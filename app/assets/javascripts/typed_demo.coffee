ready = ->
    $('#typed-sample').typed
        strings: ['hi Hello']
        loop: true

$(document).on('turbolinks:load', ready)
