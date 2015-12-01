$(document).ready(function() {
    var validTime = new Date();
     //events should start 8 hours from now on
    validTime.setTime(validTime.getTime() + (4*60*60*1000)); 

    $(function () {
        if ($('#event_start_time').val()) {
            $('#datetimepicker1').datetimepicker({
              locale: 'en-gb',
              format: 'YYYY-MM-DD HH:mm',
              sideBySide: true,
            }); 
        } else {
            $('#datetimepicker1').datetimepicker({
              locale: 'en-gb',
              format: 'YYYY-MM-DD HH:mm',
              sideBySide: true,
              minDate: validTime 
            }); 
        }
    });
    
    $(function () {
        if ($('#event_end_time').val()) {
            $('#datetimepicker2').datetimepicker({
              locale: 'en-gb',
              format: 'YYYY-MM-DD HH:mm',
              sideBySide: true,
            });
        } else {
            $('#datetimepicker2').datetimepicker({
              locale: 'en-gb',
              format: 'YYYY-MM-DD HH:mm',
              sideBySide: true,
              minDate: validTime.getTime() + defaultInterval(2)
            });
        }
    });

    function defaultInterval(hour) {
        return hour*60*60*1000;
    }
});
