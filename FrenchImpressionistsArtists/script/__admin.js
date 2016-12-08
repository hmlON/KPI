var users = [
    {id: 1, login: "admin", password: "nik538", email: "nik.knolin@gmail.com", full_name: "Nikita Kholin", is_banned: false},
    {id: 2, login: "Bogdan", password: "128100kp", email: "nik.knolin@gmail.com", full_name: "Yatsuk Bogdan", is_banned: true},
    {id: 3, login: "Kate", password: "428kp", email: "nik.knolin@gmail.com", full_name: "Kate Levoshko", is_banned: false},
    {id: 4, login: "Stas", password: "516kv", email: "nik.knolin@gmail.com", full_name: "Stas Tishchenko", is_banned: false},
    {id: 5, login: "Dima", password: "fivt18", email: "nik.knolin@gmail.com", full_name: "Dima Didenko", is_banned: false}
];

var comments = [
    {id: 1, text: "Make America great again..", user_id: 1, is_approved: true},
    {id: 2, text: "Это мой любимый сайт!", user_id: 2, is_approved: true},
    {id: 3, text: "Hello! My name is Kate!", user_id: 3, is_approved: true},
    {id: 4, text: "And this is not just a regular comment #4. This is THE comment!", user_id: 4, is_approved: true},
    {id: 5, text: "My favourite artist is Vincent van Gogh.", user_id: 5, is_approved: true},
    {id: 6, text: "My English level is C1.", user_id: 1, is_approved: false},
    {id: 7, text: "Подписывайтесь на мой сайт", user_id: 2, is_approved: false},
    {id: 8, text: "Люди в младших классах дергают девочек за косички.", user_id: 3, is_approved: false},
    {id: 9, text: "Это нормально, если дергают за косички на втором курсе?", user_id: 4, is_approved: false},
    {id: 10, text: "Да, если девочка маленькая.", user_id: 5, is_approved: false}
];

var current_user = undefined;

function is_user_logged_in() {
    return current_user !== undefined;
}

function find_user_by_login_password(users, login, password) {
    for (var i = 0; i < users.length; i++) {
        if(users[i].login === login&&users[i].password === password) {
            return users[i];
        }
    }
}

function find_user_by_id(users, id) {
    for (var i = 0; i < users.length; i++) {
        if(users[i].id === id) {
            return users[i];
        }
    }
}

function is_admin(user) {
    if (current_user === undefined) { return false }
    return user.login === "admin"&&user.password === "nik538";
}

function ban_user(id) {
    user = find_user_by_id(users, id);
    user.is_banned = true;
    print_users(1, 5);
}

function unban_user(id) {
    user = find_user_by_id(users, id);
    user.is_banned = false;
    print_users(1, 5);
}

function print_users(start, finish) {
    var usersHTMLTableCode = "<h3>Users</h3><table><tr><th>ID</th><th>Full name</th><th>Email</th><th>Login</th><th>Password</th><th>Banned</th></tr>";
    if (users[finish] === undefined) {
        for (var i = users.length - start; i >= 0; i--) {
            var HTMLBanButton;
            if (users[i].is_banned) {
                HTMLBanButton = '<td><button onclick="unban_user(' + users[i].id + ')">Unban</button></td>';
            } else {
                HTMLBanButton = '<td><button onclick="ban_user(' + users[i].id + ')">Ban</button></td>';
            }
            usersHTMLTableCode += '<tr><td>' + users[i].id + '</td><td>' + users[i].full_name + '</td><td>' + users[i].email + '</td><td>' + users[i].login + '</td><td>' + users[i].password + '</td>' + HTMLBanButton + '</tr>';
        }
    } else {
        for (var i = users.length - start; i >= users.length - finish; i--) {
            var HTMLBanButton;
            if (users[i].is_banned) {
                HTMLBanButton = '<td><button onclick="unban_user(' + users[i].id + ')">Unban</button></td>';
            } else {
                HTMLBanButton = '<td><button onclick="ban_user(' + users[i].id + ')">Ban</button></td>';
            }
            usersHTMLTableCode += '<tr><td>' + users[i].id + '</td><td>' + users[i].full_name + '</td><td>' + users[i].email + '</td><td>' + users[i].login + '</td><td>' + users[i].password + '</td>' + HTMLBanButton + '</tr>';
        }
    }
    usersHTMLTableCode += "</table>";
    var usersHTMLNavigationCode = '<div class="users-navigation">';
    var USER_NAVIGATION_STEP = 5;
    if (start !== 1) {usersHTMLNavigationCode += '<button class="left" onclick="print_users(' + (start - USER_NAVIGATION_STEP) + "," + (finish - USER_NAVIGATION_STEP) + ')">Previous 5 users</button>'}
    if(!(finish >= users.length)) {usersHTMLNavigationCode += '<button class="right" onclick="print_users(' + (start + USER_NAVIGATION_STEP) + "," + (finish + USER_NAVIGATION_STEP) + ')">Next 5 users</button>'}
    usersHTMLTableCode += '</div>';

    document.getElementById("users-list").innerHTML = usersHTMLTableCode + usersHTMLNavigationCode;
}

function create_comment() {
    if (!is_user_logged_in()) {
        alert("Failed! To create comments you have to log in!");
    } else {
        var new_comment = {text: document.getElementById("comment").value, is_approved: false};
        new_comment.id = comments[comments.length - 1].id + 1;
        new_comment.user_id = current_user.id;
        comments.push(new_comment);
        alert('Comment "' + new_comment.text + '" successfully added.');
        if (is_admin(current_user)) {
            print_unapproved_comments(1, 5);
        }
    }
}

function get_approved_comments() {
    var result = [];
    comments.forEach(function (comment) {
        if (comment.is_approved) {
            result.push(comment);
        }
    });
    return result;
}

function get_unapproved_comments() {
    var result = [];
    comments.forEach(function (comment) {
        if (!comment.is_approved) {
            result.push(comment);
        }
    });
    return result;
}

function delete_comment(id) {
    for (var i = 0; i < comments.length; i++) {
        if(comments[i].id === id) {
            comments.splice(i, 1);
        }
    }
    print_approved_comments(1, 5);
    print_unapproved_comments(1, 5);
}

function approve_comment(id) {
    for (var i = 0; i < comments.length; i++) {
        if(comments[i].id === id) {
            comments[i].is_approved = true;
        }
    }
    print_approved_comments(1, 5);
    print_unapproved_comments(1, 5);
}

function print_approved_comments(start, finish) {
    var commentsHTMLTableCode = "<h3>Comments</h3><table><tr><th>Comment</th><th>User</th></tr>";
    var comments = get_approved_comments();
    if (is_admin(current_user)){
        if (comments[finish] === undefined) {
            for (var i = comments.length - start; i >= 0; i--) {
                commentsHTMLTableCode += '<tr><td>' + comments[i].text + '</td><td>' + find_user_by_id(users, comments[i].user_id).full_name + '</td><td><button onclick="delete_comment('+ comments[i].id +')">Delete</button></td></tr>';
            }
        } else {
            for (var i = comments.length - start; i >= comments.length - finish; i--) {
                commentsHTMLTableCode += "<tr><td>" + comments[i].text + "</td><td>" + find_user_by_id(users, comments[i].user_id).full_name + '</td><td><button onclick="delete_comment('+ comments[i].id +')">Delete</button></td></tr>';
            }
        }
    } else {
        if (comments[finish] === undefined) {
            for (var i = comments.length - start; i >= 0; i--) {
                commentsHTMLTableCode += "<tr><td>" + comments[i].text + "</td><td>" + find_user_by_id(users, comments[i].user_id).full_name + '</td></tr>';
            }
        } else {
            for (var i = comments.length - start; i >= comments.length - finish; i--) {
                commentsHTMLTableCode += "<tr><td>" + comments[i].text + "</td><td>" + find_user_by_id(users, comments[i].user_id).full_name + '</td></tr>';
            }
        }
    }
    commentsHTMLTableCode += "</table>";
    var commentsHTMLNavigationCode = '<div class="comments-navigation">';
    var COMMENT_NAVIGATION_STEP = 5;
    if (start !== 1) {commentsHTMLNavigationCode += '<button class="left" onclick="print_approved_comments(' + (start - COMMENT_NAVIGATION_STEP) + "," + (finish - COMMENT_NAVIGATION_STEP) + ')">Previous 5 comments</button>'}
    if(!(finish >= comments.length)) {commentsHTMLNavigationCode += '<button class="right" onclick="print_approved_comments(' + (start + COMMENT_NAVIGATION_STEP) + "," + (finish + COMMENT_NAVIGATION_STEP) + ')">Next 5 comments</button>'}
    commentsHTMLTableCode += '</div>';

    document.getElementById("comments").innerHTML = commentsHTMLTableCode + commentsHTMLNavigationCode;
}

function print_unapproved_comments(start, finish) {
    var commentsHTMLTableCode = "<h3>Unapproved Comments</h3><table><tr><th>Comment</th><th>User</th></tr>";
    var comments = get_unapproved_comments();
    if (comments[finish] === undefined) {
        for (var i = comments.length - start; i >= 0; i--) {
            commentsHTMLTableCode += "<tr><td>" + comments[i].text + "</td><td>" + find_user_by_id(users, comments[i].user_id).full_name + '</td><td><button onclick="approve_comment('+ comments[i].id +')">Approve</button></td><td><button onclick="delete_comment('+ comments[i].id +')">Delete</button></td></tr>';
        }
    } else {
        for (var i = comments.length - start; i >= comments.length - finish; i--) {
            commentsHTMLTableCode += "<tr><td>" + comments[i].text + "</td><td>" + find_user_by_id(users, comments[i].user_id).full_name + '</td><td><button onclick="approve_comment('+ comments[i].id +')">Approve</button></td><td><button onclick="delete_comment('+ comments[i].id +')">Delete</button></td></tr>';
        }
    }
    commentsHTMLTableCode += "</table>";
    var commentsHTMLNavigationCode = '<div class="comments-navigation">';
    var COMMENT_NAVIGATION_STEP = 5;
    if (start !== 1) {commentsHTMLNavigationCode += '<button class="left" onclick="print_unapproved_comments(' + (start - COMMENT_NAVIGATION_STEP) + "," + (finish - COMMENT_NAVIGATION_STEP) + ')">Previous 5 comments</button>'}
    if(!(finish >= comments.length)) {commentsHTMLNavigationCode += '<button class="right" onclick="print_unapproved_comments(' + (start + COMMENT_NAVIGATION_STEP) + "," + (finish + COMMENT_NAVIGATION_STEP) + ')">Next 5 comments</button>'}commentsHTMLTableCode += '</div>';

    document.getElementById("unapproved-comments").innerHTML = commentsHTMLTableCode + commentsHTMLNavigationCode;
}

function sign_in() {
    var login = document.getElementById("sign_in_login").value;
    var password = document.getElementById("sign_in_password").value;
    var user = find_user_by_login_password(users, login, password);
    if (user === undefined) {
        alert("Error! There is no such user. You have to register first.")
    } else if (user.is_banned) {
        alert("Error! You can't log in. You are banned.");
    } else {
        current_user = user;
        alert("Welcome, " + user.full_name + "!");
        if (is_admin(user)) {
            print_approved_comments(1, 5);
            print_unapproved_comments(1, 5);
            print_users(1, 5);
        }
    }
}

function sign_up() {
	var login = document.getElementById("sign_up_login").value;
    var password = document.getElementById("sign_up_password").value;
    var confirm_password = document.getElementById("confirm_password").value;
    var email = document.getElementById("email").value;
    var full_name = document.getElementById("full_name").value;

    if (password !== confirm_password) {
        alert("Error! Passwords don't match!");
    } else {
        var new_user = {login: login, password: password, email: email, full_name: full_name, is_banned: false};
        new_user.id = users[users.length - 1].id + 1;
        users.push(new_user);
        current_user = new_user;
        alert("Welcome to this site for the first time, " + new_user.full_name + "!");
    }
}

print_approved_comments(1, 5);
