$(document).ready(function() {

   function shortenDescription() {
       $('.description').expander({
           expandEffect: 'fadeIn',
           slicePoint: 250
       });

       $('.event-description').expander({
           expandEffect: 'fadeIn',
           slicePoint: 500 
       });
       $('.venue-description').expander({
           expandEffect: 'fadeIn',
           slicePoint: 20,
           expandText: '  ...',
           expandPrefix: ''
       });
   }


   var mapObj = {};

   function bindInputs() {
        $('#tagInputField').tagsInput();

        $('input#searchTextField').on('change keypress', function() {
            $('.gmaps_field').val('');
        });

        $('#searchTextField').geocomplete({
            types: ["geocode", "establishment"],
        }).bind('geocode:result', function(e, result) {
            $('#place_latitude').val(result.geometry.location.lat());
            $('#place_longitude').val(result.geometry.location.lng());
            $('#place_id').val(result.place_id);
            $('#place_name').val(result.name);
            $('#place_address').val(result.formatted_address);
            $('#place_website').val(result.website);
            $('#place_url').val(result.url);
        });
   }


   bindInputs();
   shortenDescription();

});
