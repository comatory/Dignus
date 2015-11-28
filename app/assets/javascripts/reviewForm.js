$(document).ready(function() {

    var rotations = {
    }

    $('div.reveal').click(function(e) {
        var targetId = $(e.target).attr('data-review');
        if ($(this).hasClass('rotated')) {
            $(this).removeClass('rotated');
            rotations[targetId] -= 90 
            $('div.review-form[data-review="' + targetId + '"]').slideUp();
        } else {
            $(this).addClass('rotated');
            rotations[targetId] += 90 
            $('div.review-form[data-review="' + targetId + '"]').slideDown();
        }

        $('div.reveal' + '[data-review="' + targetId + '"]').rotate(rotations[targetId]);
    });

    $('div.reveal[data-review]').each(function(el) {
        rotations[($('div.reveal[data-review]')[el].getAttribute('data-review'))] = 0;
    })


    jQuery.fn.rotate = function(degrees) {
        $(this).css({'-webkit-transform' : 'rotate('+ degrees +'deg)',
                     '-moz-transform' : 'rotate('+ degrees +'deg)',
                     '-ms-transform' : 'rotate('+ degrees +'deg)',
                     'transform' : 'rotate('+ degrees +'deg)'});
        return $(this);
    };

});
