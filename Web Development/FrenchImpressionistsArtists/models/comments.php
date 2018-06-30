<?php
    function comments_all() {
        $file_name = $_SERVER['DOCUMENT_ROOT'].'/french-impressionists-artists/db/comments.dat';
        $comments = unserialize(file_get_contents($file_name));
        return $comments;
    }

    function comments_approved() {
        $comments = array();
        foreach (comments_all() as $comment) {
            if ($comment['is_approved']) {
                array_push($comments, $comment);
            }
        }
        return $comments;
    }
    
    function comments_unapproved() {
        $comments = array();
        foreach (comments_all() as $comment) {
            if (!$comment['is_approved']) {
                array_push($comments, $comment);
            }
        }
        return $comments;
    }

    function comment_find($id) {
        $comments = comments_all();
        foreach ($comments as $comment) {
            if ($comment['id'] == $id) {
                return $comment;
            }
        }
        return NULL;
    }
    
    function comment_create($comment) {
        $comments = comments_all();
        array_push($comments, $comment);
        comments_update($comments);
    }
    
    function comments_update($comments) {
        $file_name = $_SERVER['DOCUMENT_ROOT'].'/french-impressionists-artists/db/comments.dat';
        file_put_contents($file_name, serialize($comments), LOCK_EX);
    }
    
    function comment_delete($id) {
        $comments = comments_all();
        unset($comments[$id-1]);
        comments_update($comments);
        header('Location: index.php');
    }
    
    function comment_approve($id) {
        $comments = comments_all();
        $comments[$id-1]['is_approved'] = true;
        comments_update($comments);
        header('Location: index.php');
    }
