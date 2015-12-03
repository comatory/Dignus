$(document).ready(function() {

    // DISPLAY REVIEW FORM
    var rotations = {
    }

    $('div.reveal').click(function(e) {
            var targetId = $(e.target).attr('id');
            if ($(this).hasClass('rotated')) {
                $(this).removeClass('rotated');
                rotations[targetId] -= 90 
                $('div.review-form#' + targetId).slideUp('fast');
            } else {
                $(this).addClass('rotated');
                rotations[targetId] += 90 
                $('div.review-form#' + targetId).slideDown('fast');
            }

            $('div.reveal#' + targetId).rotate(rotations[targetId]);
        });

     $('div.reveal').each(function(el) {
            var reveal = $('div.reveal')[el]
            var revealId = $(reveal).uniqueId();
            rotations[$(reveal).attr('id')] = 0;
            var reviewForm = $(this).parent().next();
            $(reviewForm).attr('id', revealId.attr('id'));
        })


    jQuery.fn.rotate = function(degrees) {
        $(this).css({'-webkit-transform' : 'rotate('+ degrees +'deg)',
                     '-moz-transform' : 'rotate('+ degrees +'deg)',
                     '-ms-transform' : 'rotate('+ degrees +'deg)',
                     'transform' : 'rotate('+ degrees +'deg)'});
        return $(this);
    };


    // STAR RATING 
    $('.star-rating a').click(function(e) {
        var rating = $(e.target)[0].innerHTML;
        var id = $(e.target).first().parent().prop('id');
        field = $('div.review-form[data-review="' + id + '"] form input#review_rating').first().val(rating);
           
    })

});
