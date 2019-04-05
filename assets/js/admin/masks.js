$(function() {
  $('.js-currency-mask').on('keyup', function (e) {
    this.value = this.value.replace(/\D/g, '');
    this.value = this.value.replace(/(\d)(?=(\d{3})+(?!\d))/g,'$1.')
  });
})
