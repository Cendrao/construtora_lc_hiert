$(function() {
  $('.dropbtn').on('click', function(event) {
    $(event.target).parent().find('.dropdown-content').toggleClass("show");
  });

  $(document).on('click', function(event) {
    if (!event.target.matches('.dropbtn')) {
      let dropdowns = $(".dropdown-content");
      let i;

      for (i = 0; i < dropdowns.length; i++) {
        let openDropdown = dropdowns[i];

        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  });
});
