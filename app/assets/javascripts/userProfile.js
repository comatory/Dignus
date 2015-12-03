$(document).ready(function() {

   function shortenDescription() {
       $('.profile-description').expander({
           expandEffect: 'fadeIn',
           slicePoint: 250
       });

       $('.event-description').expander({
           expandEffect: 'fadeIn',
           slicePoint: 500 
       });
   }

   shortenDescription();


});
