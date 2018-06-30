<?php
    require_once 'models/comments.php';
    require_once 'models/users.php';
    if (isset($_POST['content'])) { //comment sent information
        session_start();
        if ($_SESSION['current_user'] == NULL) { header("Location: login.php"); } else {
            $new_comment = array();
            $new_comment['id'] = 0;
            $comments = comments_all();
            foreach ($comments as $comment) {
                if ($comment['id'] > $new_comment['id']) {
                    $new_comment['id'] = $comment['id'];
                }
            }
            $new_comment['id']++;
            $new_comment['content'] = trim($_POST['content']);
            $user = $_SESSION['current_user'];
            $new_comment['author_name'] = $user['full_name'];
            $new_comment['is_approved'] = false;

            comment_create($new_comment);
            header('Location: comments.php');
        }
    } else {
        $comments = comments_approved();
        include 'views/comments.php';
    }
