<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="../img/favicon.png">
    <link rel="stylesheet" type="text/css" href="../style/style.css">
    <title>Admin</title>
</head>
<body>
    <header>
        <img id="logo" src="../img/logo.png" alt="logo">
        <nav>
            <span class="grad-left"></span>
            <a href="../index.html">Homepage</a>
            <a href="../expositions.html">Expositions</a>
            <a href="../painters.html">Painters</a>
            <a href="../gallery.html">Gallery</a>
            <a href="../comments.php">Comments</a>
            <a href="../registration.php">Registration</a>
            <a href="../login.php">Login</a>
            <span class="grad-right"></span>
        </nav>
    </header>

    <div class="container">
        <table class="users">
            <h3>Users</h3>
            <tr>
                <th>ID</th>
                <th>Login</th>
                <th>Email</th>
                <th>Password</th>
                <th>Full name</th>
                <th>Banned?</th>
            </tr>
            <?php foreach ($users as $u): ?>
                <tr>
                    <td><?= $u['id'] ?></td>
                    <td><?= $u['login'] ?></td>
                    <td><?= $u['email'] ?></td>
                    <td><?= $u['password'] ?></td>
                    <td><?= $u['full_name'] ?></td>
                    <td>
                        <?php if (!$u['is_banned']): ?>
                        Not Banned
                        <form action="index.php">
                            <input type="hidden" name="id" value="<?= $u['id'] ?>">
                                <input type="hidden" name="action" value="user_ban">
                                <input type="submit" value="Ban">
                        </form>
                        <?php else: ?>
                            Banned
                            <form action="index.php">
                                <input type="hidden" name="id" value="<?= $u['id'] ?>">
                                <input type="hidden" name="action" value="user_unban">
                                <input type="submit" value="Unban">
                            </form>
                        <?php endif ?>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
        <table class="comments comments-unapproved">
            <h3>Unapproved Comments</h3>
            <tr>
                <th>Comment</th>
                <th>Author</th>
                <th>Approve/Delete</th>
            </tr>
            <?php foreach ($unapproved_comments as $c): ?>
                <tr>
                    <td><?= $c['content'] ?></td>
                    <td>
                        <?= $c['author_name'] ?>
                    </td>
                    <td>
                        <form action="index.php">
                            <input type="hidden" name="id" value="<?= $c['id'] ?>">
                                <input type="hidden" name="action" value="comment_approve">
                                <input type="submit" value="Approve">
                        </form>
                        <form action="index.php">
                            <input type="hidden" name="id" value="<?= $c['id'] ?>">
                                <input type="hidden" name="action" value="comment_delete">
                                <input type="submit" value="Delete">
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
        <table class="comments comments-approved">
            <h3>Approved Comments</h3>
            <tr>
                <th>Comment</th>
                <th>Author</th>
                <th>Delete</th>
            </tr>
            <?php foreach ($approved_comments as $c): ?>
                <tr>
                    <td><?= $c['content'] ?></td>
                    <td>
                        <?= $c['author_name'] ?>
                    </td>
                    <td>
                        <form action="index.php">
                            <input type="hidden" name="id" value="<?= $c['id'] ?>">
                            <input type="hidden" name="action" value="comment_delete">
                            <input type="submit" value="Delete">
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>

</body>
</html>