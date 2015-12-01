$(document).ready(function() {
    var validTime = new Date();
     //events should start 8 hours from now on
    validTime.setTime(validTime.getTime() + (4*60*60*1000)); 

    $(function () {
        $('#datetimepicker1').datetimepicker({
          locale: 'en-gb',
          format: 'YYYY-MM-DD HH:mm',
          sideBySide: true,
          minDate: validTime 
        });
    })
    
    $(function () {
        $('#datetimepicker2').datetimepicker({
          locale: 'en-gb',
          format: 'YYYY-MM-DD HH:mm',
          sideBySide: true,
          minDate: validTime.getTime() + defaultInterval(2)
        });
    })

    function defaultInterval(hour) {
        return hour*60*60*1000;
    }
});
