(function($) {
    "use strict";

    /*-------------------------------------------
        1. jQuery MeanMenu
    --------------------------------------------- */
    jQuery('nav#dropdown').meanmenu();

    /*************************
        2. tooltip
    *************************/
    $('[data-toggle="tooltip"]').tooltip();

    /*************************
        3. Service Carousel
    *************************/
    $('.service-carousel').slick({
        arrows: false,
        dots: false,
        infinite: false,
        speed: 300,
        slidesToShow: 4,
        slidesToScroll: 3,
        responsive: [
            { breakpoint: 991, settings: { slidesToShow: 3, slidesToScroll: 2 } }, // Tablet
            { breakpoint: 767, settings: { slidesToShow: 2, slidesToScroll: 1 } }, // Large Mobile
            { breakpoint: 479, settings: { slidesToShow: 1, slidesToScroll: 1 } }  // Small Mobile
        ]
    });
})(jQuery);


/* ********************************************
    4. STICKY sticky-header
******************************************** */
    var hth = $('.header-top-bar').height();
    $(window).on('scroll', function() {
        if ($(this).scrollTop() > hth){
            $('#sticky-header').addClass("sticky");
        }
        else{
            $('#sticky-header').removeClass("sticky");
        }
    });
/* ********************************************************* */
