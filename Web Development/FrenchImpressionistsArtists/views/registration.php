<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="img/favicon.png">
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <link rel="stylesheet" type="text/css" href="style/forms.css">
    <title>Sign up</title>
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
        <form action="registration.php" method="post" id="registration-form" onsubmit="validate_confirm_password()">
            <h3>Registration</h3>
            <div class="errors">
                <?= $error ?>
            </div>
            <div class="fieldset">
                <input type="text" name="login" id="login" placeholder="Login" required><br>
            </div>
            <div class="fieldset">
                <input type="password" name="password" id="password" placeholder="Password" required><br>
            </div>
            <div class="fieldset">
                <input type="password" name="confirm_password" id="confirm_password" placeholder="Confirm password" required><br>
            </div>
            <div class="fieldset">
                <input type="email" name="email" id="email" placeholder="Email" required><br>
            </div>
            <div class="fieldset">
                <input type="text" name="full_name" id="full_name" placeholder="Full name" required>
            </div>
            <input type="submit" value="Submit">
        </form>
    </div>
    <script src="script/registration.js"></script>
</body>
</html>