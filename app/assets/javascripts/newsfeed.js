
$(document).on('turbolinks:load', function() {
  var x;
if ($('.pagination').length) {
  x = [];
  $(window).scroll(function() {
    var url;
  if ($(window).scrollTop() > $(document).height() - $(window).height() - 30) {
    url = $('.pagination .next_page').attr('href');
    console.log(url);
    if (url) {
      x.push(url);
      $('.pagination').text("").css("text-align", "center");
      return $.getScript(url);
    }
  }
  });
  return $(window).scroll();
}
});
