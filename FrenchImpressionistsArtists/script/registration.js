document.getElementById("registration-form").addEventListener("submit", function(event){
    var password = document.getElementById("password").value;
    var confirm_password = document.getElementById("confirm_password").value;
    if (password !== confirm_password) {
        alert("Error! Passwords don't match!");
        event.preventDefault()
    }
});