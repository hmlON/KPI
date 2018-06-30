<?php
    require_once '../models/users.php';
    session_start();
    if (!user_is_admin($_SESSION['current_user'])) {
        header('Location: ../index.html');
    } else {
        require_once '../models/comments.php';

        if (isset($_GET['action'])) {
            switch ($_GET['action']) {
                case 'user_ban':
                    user_ban($_GET['id']);
                    break;
                case 'user_unban':
                    user_unban($_GET['id']);
                    break;
                case 'comment_approve':
                    comment_approve($_GET['id']);
                    break;
                case 'comment_delete':
                    comment_delete($_GET['id']);
                    break;
            }
            header('Location: index.php');
        }

        $users = users_all();
        $approved_comments = comments_approved();
        $unapproved_comments = comments_unapproved();
        include '../views/admin.php';
    }
