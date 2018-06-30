$('.paintings>img').hover(
    function(){
        $(this).animate({width: '+=40px'}, 500);
    },
    function(){
        $(this).animate({width: '-=40px'}, 500);
    }
);
