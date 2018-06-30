<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="img/favicon.png">
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <link rel="stylesheet" type="text/css" href="style/forms.css">
    <title>Comments</title>
</head>
<body>
<header>
    <img id="logo" src="img/logo.png" alt="logo">
    <nav>
        <span class="grad-left"></span>
        <a href="index.html">Homepage</a>
        <a href="expositions.html">Expositions</a>
        <a href="painters.html">Painters</a>
        <a href="gallery.html">Gallery</a>
        <a href="comments.php">Comments</a>
        <a href="registration.php">Registration</a>
        <a href="login.php">Login</a>
        <span class="grad-right"></span>
    </nav>
</header>

<div class="container">
    <form action="comments.php" method="post" id="comment-form">
        <div class="notifications"></div>
        <div class="errors">
            <?= $error ?>
        </div>
        <div class="fieldset">
            <input type="text" name="content" id="content" placeholder="Comment" required><br>
        </div>
        <input type="submit" value="Add comment">
    </form>
    <table class="comments">
        <h3>Comments</h3>
        <tr>
            <th>Comment</th>
            <th>Author</th>
        </tr>
        <?php foreach ($comments as $c): ?>
            <tr>
                <td><?= $c['content'] ?></td>
                <td>
                    <?= $c['author_name'] ?>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>
</div>

<script src="script/jquery-3.1.1.min.js"></script>
<script src="script/comments.js"></script>

</body>
</html>