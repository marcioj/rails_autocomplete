$(function() {
  $('input[data-autocomplete]').each(function() {
    var $this = $(this);
    var url = $this.data('autocomplete-url');
    $this.autocomplete({
      source: url,
      minLength: 2,
      select: function( event, ui ) {
      }
    });
  });
});
