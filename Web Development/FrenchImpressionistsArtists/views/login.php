<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="img/favicon.png">
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <link rel="stylesheet" type="text/css" href="style/forms.css">
    <title>Log in</title>
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
    <form action="login.php" method="post">
        <h3>Log in</h3>
        <div class="errors">
            <?= $error ?>
        </div>
        <div class="fieldset">
            <input type="text" name="login" placeholder="Login" id="login">
        </div>
        <div class="fieldset">
            <input type="password" name="password" placeholder="Password" id="password">
        </div>
        <input type="submit" value="Log in">
    </form>
</body>
</html>