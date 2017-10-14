ready = ->
    $('#typed-sample').typed
        strings: [" Don't let your college memories die... ","Connect with your college buddies..." ]

        loop: true
        typeSpeed:40

$(document).on('turbolinks:load', ready)
