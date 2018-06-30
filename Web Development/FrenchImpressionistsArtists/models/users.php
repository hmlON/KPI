<?php
    function users_all() {
        $file_name = $_SERVER['DOCUMENT_ROOT'].'/french-impressionists-artists/db/users.dat';
        $users = unserialize(file_get_contents($file_name));
        return $users;
    }

    function user_find($id) {
        $users = users_all();
        foreach ($users as $user) {
            if ($user['id'] == $id) {
                return $user;
            }
        }
        return NULL;
    }

    function user_log_in($login, $password) {
        foreach (users_all() as $user) {
            if ($user['login'] == $login && $user['password'] == $password) {
                if ($user['is_banned']) {
                    return 'Sorry. You are banned.';
                }
                session_start();
                $_SESSION['current_user'] = $user;
                return NULL;
            }
        }
        return 'User with this login and password not found';
    }

    function user_create($new_user) {
        $users = users_all();
        foreach ($users as $user) {
            if($user['email'] == $new_user['email']) {
                return 'Sorry. User with this email is already registered.';
            }
            if($user['login'] == $new_user['login']) {
                return 'Sorry. User with this login is already registered.';
            }
        }
        array_push($users, $new_user);
        users_update($users);
        return NULL;
    }

    function users_update($users) {
        $file_name = $_SERVER['DOCUMENT_ROOT'].'/french-impressionists-artists/db/users.dat';
        file_put_contents($file_name, serialize($users), LOCK_EX);
    }

    function user_ban($id) {
        $users = users_all();
        $users[$id-1]['is_banned'] = true;
        users_update($users);
        header('Location: index.php');
    }

    function user_unban($id) {
        $users = users_all();
        $users[$id-1]['is_banned'] = false;
        users_update($users);
        header('Location: index.php');
    }

    function user_is_admin($user) {
        return ($user['login'] == "adm" && $user['password'] == 'in');
    }
