(function() {
  $(document).on('ready page:load', function() {
    $('#search_user').on('change keyup paste', function(e) {
      $.ajax({
        url: '/users/autocomplete_user_name',
        method: 'GET',
        data: 'term=' + $('#search_user').val(),
        dataType: 'json',
        success: function(response) {
          var find, i, obj, results;
          if (response.length !== 0) {
            $('.user-content').children('.users').hide();
            i = 0;
            results = [];
            while (i < response.length) {
              obj = response[i];
              find = $('a[href$="/users/' + obj.id + '"]').parent('.users');
              find.show();
              results.push(i++);
            }
            return results;
          } else {
            if ($('#search_user').val() === '') {
              return $('.user-content').children('.users').show();
            } else {

            }
          }
        }
      });
      $('.user-content').children('.users').hide();
      return;
    });
    $('#search_user_form').submit(function(e) {
      e.preventDefault();
    });
  });

  $(document).on('ready page:load', function() {
    return $('#search_user').bind('railsAutocomplete.select', function(event, data) {
      $(location).attr('href', 'http://localhost:3000/users/' + data.item.id);
    });
  });

  $(document).on('ready page:load', function() {
    return $("#search_user").keypress(function(e) {
      if (e.which === 13) {
        return $(location).attr('href', 'http://localhost:3000/users/' + $("#search_user").val());
      }
    });
  });

  return;

}).call(this);
