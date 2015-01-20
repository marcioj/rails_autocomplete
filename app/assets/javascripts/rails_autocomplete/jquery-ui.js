$(function() {
  $('input[data-autocomplete]').each(function() {
    var $this = $(this);
    var url = $this.data('autocomplete-url');
    var modelClass = $this.data('autocomplete-model-class');
    var field = $this.data('autocomplete-field');
    var searchType = $this.data('autocomplete-search-type');

    $this.autocomplete({
      minLength: 2,
      source: function(request, response) {
        request.model_class = modelClass;
        request.field = field;
        request.search_type = searchType;

        $.ajax({
          url: url,
          data: request,
          dataType: "json",
          success: function(data) {
            response(data);
          },
          error: function() {
            response([]);
          }
        });
      }
    });
  });
});
