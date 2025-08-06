document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('loginForm');
    if (!loginForm) return;

    loginForm.addEventListener('submit', function (e) {
        e.preventDefault();

        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        // Replace these with your actual credentials or use server-side validation
        const validUsername = 'admin';
        const validPassword = 'pass';

        if (username === validUsername && password === validPassword) {
            // Redirect to the Flask route that renders index.html, usually '/'
            window.location.href = '/home';
            return;
        } else {
            const errorMsg = document.getElementById('errorMsg');
            if (errorMsg) {
                errorMsg.textContent = 'Invalid username or password.';
            }
        }
    });
});
