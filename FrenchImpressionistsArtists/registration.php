<?php
    if (isset($_POST['email'])) { //user sent information
        require_once 'models/users.php';
        $new_user = array();
        $new_user['id'] = 0;
        $users = users_all();
        foreach ($users as $user) {
            if ($user['id'] > $new_user['id']) {
                $new_user['id'] = $user['id'];
            }
        }
        $new_user['id']++;
        $new_user['login'] = trim($_POST['login']);
        $new_user['email'] = trim($_POST['email']);
        $new_user['password'] = $_POST['password'];
        $new_user['full_name'] = trim($_POST['full_name']);
        $new_user['is_banned'] = false;

        $error = user_create($new_user);
        if ($error == NULL) {
            header('Location: login.html');
        } else {
            include 'views/registration.php';
        }
    } else {
        include 'views/registration.php';
    }
