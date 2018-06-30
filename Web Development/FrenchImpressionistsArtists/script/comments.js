$('form').on('submit', function ( event ) {
    event.preventDefault();
    var comment_content = $('#content').val();
    $.post('comments.php',
        { content: comment_content }
    );
    $('#content').val('');
    $('.notifications').slideUp(0).text('Your comment will appear here after administrator check.').slideDown();
});

$('.notifications').click(function () {
   $(this).slideUp();
});