$('form[method="get"]').submit(function() {
  $(this).find(':input').each(function() {
    var input = $(this);

    if (!input.val()) {
      input.remove();
    }
  });
});
