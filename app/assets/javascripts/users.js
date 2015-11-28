$(document).ready(function() {

    var profileText = $('div.profile-description').text();
    var link = $('<a>').text("Show more").addClass('show-more-link');

    function displayShowMoreLink() {
        if (profileText.length > 150) {
            profileText.append(link)

        }
    }

    displayShowMoreLink();
});
