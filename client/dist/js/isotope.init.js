(function($){
    // use $ here safely

    $('.blog-teaser-list .isotope-container').imagesLoaded( function() {
        $('.isotope-container').isotope({
            itemSelector: '.isotope-item'
        });
    });

})(jQuery);
