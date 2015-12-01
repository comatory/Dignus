$(document).ready(function() {
    $(function() {
       $('.alert').delay(500).fadeIn('normal', function() {
          $(this).delay(2500).fadeOut();
       });
    });
})
