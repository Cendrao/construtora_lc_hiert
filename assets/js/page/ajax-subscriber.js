$(function() {
  const form = $('.js-subscriber-form');
  const formResponse = $('.js-subscriber-form-response');
  let responseData;

  $(form).submit(function(e) {
    e.preventDefault();

    $.post({
      url: $(form).attr('action'),
      data: $(form).serialize()
    })
    .done(function(response) {
      $(formResponse).removeClass('error');
      $(formResponse).addClass('success');

      responseData = response.data;
    })
    .fail(function(response) {
      $(formResponse).removeClass('success');
      $(formResponse).addClass('error');

      responseData = response.responseJSON.data;
    })
    .always(function(response) {
      $(form).slideUp('slow', function() {
        $(formResponse).text(responseData);
      });
    });
  });
});
