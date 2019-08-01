$( document ).ready(function() {

    $( function() {
      $( "#available_from" ).datepicker({
        dateFormat : 'mm-dd-yy',
      });
      $( "#available_to" ).datepicker({
        dateFormat : 'mm-dd-yy',
      });
    });

});
