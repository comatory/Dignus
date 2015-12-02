$(document).ready(function() {

    $('input#query').bindWithDelay('keyup', searchDB, 1000);
    $('input#query').on('keyup', function() {
        $('#loader').show();
    })

    function searchDB() {
        var query = $(this).val();

        $.ajax({
            url: '/api/v1/search',
            data: { 'query': query },
            type: 'POST',
            dataType: 'json',
            success: constructResults
        })
    }

    function constructResults(response) {
        $('#loader').hide();
        var tableBody = $('#search-table-body');
        tableBody.empty();
        response.forEach(function(obj) {
            var row = $('<tr>');
            var badge = $('<td>').addClass('col-md-1');
            var name = $('<td>').addClass('col-md-2');
            var description = $('<td>').addClass('col-md-9');
            var link = $('<a>')
            for (var prop in obj) {
                if (obj.hasOwnProperty(prop)) {
                    link.text(prop);
                    link.attr('href', obj[prop]['link']);
                    name.append(link);
                    var badgeData = $('<span>').addClass(obj[prop]['role'] + '-badge resource-badge');
                    badge.append(badgeData);
                    var descriptionCollapse = $('<span>').addClass('profile-description');
                    descriptionCollapse.text(obj[prop]['description'].substring(0, 120) + ' ...');
                    description.append(descriptionCollapse);
                }
                row.append(badge, name, description);
            }
            tableBody.append(row);
        })

    }

})
