//= require users

var loadFinished = true;
$(window).scroll(function() {
  var url;
  if (loadFinished && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
    loadFinished = false;
    url = $('#load-more').attr('href');
    if (url) {
      $.ajax({
        type: 'GET',
        url: url,
        dataType: 'script',
        success: function (data) {
          loadFinished = true;
        },
      });
    } else {
      console.log('data ended');
    }
  }
});
