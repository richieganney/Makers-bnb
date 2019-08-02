
$( document ).ready(function() {

    $( function() {
      $( "#check_in" ).datepicker({
        dateFormat : 'yy-mm-dd',
      });
      $( "#check_out" ).datepicker({
        dateFormat : 'yy-mm-dd',
      });
    });

    $( function() {
      $( "#available_from" ).datepicker({
        dateFormat : 'yy-mm-dd',
      });
      $( "#available_to" ).datepicker({
        dateFormat : 'yy-mm-dd',
      });
    });
});

//use above line to retrieve array from the hidden field
