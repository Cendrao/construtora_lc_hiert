$(function() {
	const form = $('.js-ajax-form-animation');
	let responseData;

	$(form).submit(function(e) {
		e.preventDefault();

		const formResponse = $(e.target).parent().find($('.js-ajax-form-animation-response'));

		$.post({
			url: $(e.target).attr('action'),
			data: $(e.target).serialize()
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
			$(e.target).slideUp('slow', function() {
				$(formResponse).text(responseData);
			});
		});
	});
});
