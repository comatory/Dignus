$(document).ready(function() {

    $('div.track').click(function(e) {
        var trackDiv = $(e.target);
        var trackAudio = $(e.target).children()[0];
        var trackDuration = trackAudio.duration;
        var seekBar = $(trackDiv).children().last().children()[0];

        if (trackAudio.paused == true) {
            trackAudio.play();
            trackDiv.addClass('track-playing');
            $(seekBar).attr('max', trackDuration);

            $(trackAudio).on('timeupdate', function() {
                $(seekBar).attr('value', trackAudio.currentTime);
            })

        } else {
            trackAudio.pause();
            trackDiv.removeClass('track-playing');
        }
    });
})
