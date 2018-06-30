<?php
    if (isset($_POST['password'])) { //user sent information
        require_once 'models/users.php';
        $error = user_log_in(trim($_POST['login']), $_POST['password']);
        if ($error == NULL) {
            header('Location: index.html');
        } else {
            include 'views/login.php';
        }
    } else {
        include 'views/login.php';
    }