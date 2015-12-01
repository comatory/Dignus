$(document).ready(function() {

    $('#email-button').click(function(){
        $(this).addClass('disabled');
        $('#loader').show();
    });
});
