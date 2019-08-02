
$( document ).ready(function() {
    if (document.getElementById("array1").value !== null) {
      var array = document.getElementById("array1").value.substr(1).slice(0,-1).split(',');
    }

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

    $( function() {


      $( "#requested_date" ).datepicker({
    dateFormat: 'dd-mm-yy',
    beforeShowDay: function(date) {
        var newDate = jQuery.datepicker.formatDate('yy-mm-dd', date);
        if (array.includes(newDate)) {
            return [false, "dateNA", ""];
        } else {
            return[true, "dateA", ""]
        }
    }
    });
    });
});

//use above line to retrieve array from the hidden field
