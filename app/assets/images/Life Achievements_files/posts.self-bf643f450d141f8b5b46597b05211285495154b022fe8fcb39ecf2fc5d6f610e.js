(function() {
  $(document).on('ready page:load', function() {
    $('#masonry-container').imagesLoaded(function() {
      return $('#masonry-container').masonry({
        itemSelector: '.box',
        columnWidth: 318.3333,
        gutterWidth: 0
      });
    });
    ({
      isFitWidth: true
    });
  });

}).call(this);
