(function() {
  $(document).ready(function() {
    $('#search_achievement').on('change keyup paste', function(e) {
      $.ajax({
        url: '/achievements/autocomplete_achievement_description',
        method: 'GET',
        data: 'term=' + $('#search_achievement').val(),
        dataType: 'json',
        success: function(response) {
          var find, i, obj;
          if (response.length !== 0) {
            $('.achievement-content').children('.achievements').hide();
            i = 0;
            while (i < response.length) {
              obj = response[i];
              find = $('a[href$="/achievements/' + obj.id + '"]').parent('.achievements');
              find.show();
              i++;
            }
          } else {
            if ($('#search_achievement').val() === '') {
              $('.achievement-content').children('.achievements').show();
            } else {
              $('.achievement-content').children('.achievements').hide();
            }
          }
        }
      });
    });
    $('#search_achievement_form').submit(function(e) {
      e.preventDefault();
    });
  });

  $(document).on('click', '#add-achievement', function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).attr('href'),
      data: $(this).serialize(),
      method: 'PUT',
      success: function() {}
    });
  });

  $(document).on('click', '#remove-achievement', function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).attr('href'),
      data: $(this).serialize(),
      method: 'DELETE',
      success: function() {}
    });
  });

}).call(this);
