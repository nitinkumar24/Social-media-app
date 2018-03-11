
ready = ->
  $('#typed-sample').typed
    strings: [" Be Awesome and Explore SocioGrams ","Connect with your buddies..." ,"Not for Hookups"]

    loop: true
    typeSpeed:40

$(document).on('turbolinks:load', ready)
console.log("typed")