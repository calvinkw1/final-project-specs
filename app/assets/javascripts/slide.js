$(document).ready(function(){
    // $("#flip").click(function(){
    //     $("#saved").slideToggle("slow");
    // });


    $('#flip').click(function(){
    $('#saved').animate({width: 'toggle'}, 1000);
});
});