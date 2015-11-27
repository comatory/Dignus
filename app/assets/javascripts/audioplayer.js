$(document).on('ready', function() {

    $('div.track').click(function(e) {
        var trackDiv = $(e.target);
        var trackAudio = $(e.target).children()[0];
        if (trackAudio.paused == true) {
            trackAudio.play();
            trackDiv.css({'background-color': 'white', 'color': 'black'})
        } else {
            trackAudio.pause();
            trackDiv.css({'background-color': 'grey', 'color': 'black'})
        }
    });
})
