$( document ).ready(function() {

    $( function() {
      $( "#check_in" ).datepicker({
        dateFormat : 'yy-mm-dd',
        changeMonth : true,
        changeYear : true,
        onClose: function(){
            $( "#check_out" ).datepicker('change',{
                minDate: new Date($("#check_in").datepicker('getDate'))
            });
        }
      });

      $( "#check_out" ).datepicker({
        dateFormat : 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        yearRange: '2019:2021',
        minDate: new Date(2019, 08 - 1, 01),
        maxDate: '+1Y',
      });
    });

    $( function() {
      $( "#available_from" ).datepicker({
        dateFormat : 'yy-mm-dd',
        changeMonth : true,
        changeYear : true,
        onClose: function(){
            $( "#available_to" ).datepicker('change',{
                minDate: new Date($("#available_from").datepicker('getDate'))
            });
        }
      });
      $( "#available_to" ).datepicker({
        dateFormat : 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        yearRange: '2019:2021',
        minDate: new Date(2019, 08 - 1, 01),
        maxDate: '+1Y',
      });
    });
});
