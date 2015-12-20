$(document).ready(function() {

    var profileText = $('div.profile-description').text();
    var link = $('<a>').text("Show more").addClass('show-more-link');

    function displayShowMoreLink() {
        if (profileText.length > 150) {
            profileText.append(link)

        }
    }

    function sortTable() {
        $('table#performers').stupidtable();
    }

    function toggleSaveButton(disable) {
        var button = $('input#form-save-button');
        if (disable) {
            $(button).attr('disabled', true);
            $(button).addClass('disabled');
        } else {
            $(button).attr('disabled', false);
            $(button).removeClass('disabled');
        }
    }

    function checkForFilledName() {
        var input = $('input#user_name');

        function profileToggleSaveButton() {
            if ($(input).val().length < 1) {
                toggleSaveButton(true);
            } else {
                toggleSaveButton(false);
            }
        }

        $(input).on('keyup', function() {
            profileToggleSaveButton();
        });
        
        if (input.length > 0) {
            profileToggleSaveButton();
        } 
    }

    function checkForFilledEventFields() {
        var inputs = $('input#event_name, input#searchTextField, input#event_start_time, input#event_end_time');

        function eventToggleSaveButton() {
            if (validateFields(inputs)) {
                toggleSaveButton(false);
            } else {
                toggleSaveButton(true);
            }
        }

        eventToggleSaveButton();

        $(inputs).on('keyup focus blur change', eventToggleSaveButton);
        $('span.input-group-addon').on('click', eventToggleSaveButton);
    }

    function validateFields(fields) {
        var validations = [];
        $(fields).each(function(input){
            if ($(fields[input]).val().length < 1) {
                validations.push(false);
            } else {
                validations.push(true);
            }
        });

        if (validations.every(function(el){ return el === true })) {
            return true
        } else {
            return false
        }
    }

    displayShowMoreLink();
    sortTable();
    checkForFilledName();
    checkForFilledEventFields();
});
