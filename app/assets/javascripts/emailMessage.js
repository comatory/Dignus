$(document).ready(function() {

    $('#email-button, #save-contents-button').click(function(){
        $(this).addClass('disabled');
        $('#loader').show();
    });
});
