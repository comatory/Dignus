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


   function bindInputs() {
        $('#tagInputField').tagsInput();
        $('#searchTextField').geocomplete({
            types: ["geocode", "establishment"]
        });
   }


   bindInputs();
   shortenDescription();

});
