$(document).ready(function(){
    // $("#flip").click(function(){
    //     $("#saved").slideToggle("slow");
    // });


    $('#flip').click(function(){
    $('#saved').animate({height: 'toggle'}, 1000);
});
});