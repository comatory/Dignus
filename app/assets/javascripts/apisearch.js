$(document).ready(function() {

    $('input#query').bindWithDelay('keyup', searchDB, 1000);

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
        var tableBody = $('#search-table-body');
        tableBody.empty();
        response.forEach(function(obj) {
            var row = $('<tr>');
            var name = $('<td>');
            var description = $('<td>');
            var link = $('<a>')
            for (var prop in obj) {
                if (obj.hasOwnProperty(prop)) {
                    link.text(prop);
                    link.attr('href', obj[prop]['link']);
                    name.append(link);
                    description.text(obj[prop]['description']);
                }
                row.append(name, description);
            }
            tableBody.append(row);
        })
    }

})
