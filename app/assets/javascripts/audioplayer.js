$(document).ready(function() {

    function initializeTracks() {
        $('div.track').each(function(tr) {
            var track = $('.track')[tr];
            var tr_id = $(track).uniqueId();
            var seekBarId = 'sk' + tr_id.prop('id');
            var seekBar = $('progress')[tr];
            $(seekBar).prop('id', seekBarId);
        })
    }

    $('div.track div.track-title').click(function(e) {
        var trackDiv = $(e.target).parent();
        var seekBar = $('progress#' + 'sk' + trackDiv.attr('id'));
        var trackAudio = trackDiv.children('audio')[0];
        var trackDuration = trackAudio.duration;

        if (trackAudio.paused == true) {
            trackAudio.play();
            trackDiv.addClass('track-playing');
            $(seekBar).attr('max', trackDuration);

            $(trackAudio).on('timeupdate', function() {
                $(seekBar).attr('value', trackAudio.currentTime);
            })

        } else if (trackAudio.paused == false){
            trackAudio.pause();
            trackDiv.removeClass('track-playing');
        }
    });

    initializeTracks();
})
