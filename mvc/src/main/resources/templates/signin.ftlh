<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - SpartanFitness</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body class="auth-bg">

<div class="auth-container">

    <div class="auth-card">

        <h2 class="auth-title">Welcome Back 👋</h2>
        <p class="auth-subtext">
            Log in to continue your fitness journey
        </p>

        <form method="post" id="loginForm">

            <!-- ROLE SELECTION -->
            <div class="role-toggle">
                <label class="role-option">
                    <input type="radio" name="userType" value="customer">
                    <span>Customer</span>
                </label>

                <label class="role-option">
                    <input type="radio" name="userType" value="provider">
                    <span>Trainer</span>
                </label>
            </div>

            <!-- INPUTS -->
            <input type="email" name="email" class="auth-input" placeholder="Email address" required>
            <input type="password" name="password" class="auth-input" placeholder="Password" required>

            <a href="#" class="auth-forgot">Forgot password?</a>

            <!-- BUTTON -->
            <button type="submit" class="auth-btn">Sign In</button>

            <!-- FOOTER -->
            <p class="auth-footer">
                New here?
                <a href="/customers/signup">Create Account</a> |
                <a href="/providers/signup">Become a Trainer</a>
            </p>

        </form>

    </div>
</div>

<script>
document.getElementById("loginForm").addEventListener("submit", function(e) {
    const selected = document.querySelector('input[name="userType"]:checked');
    if (!selected) {
        e.preventDefault();
        alert("Please select Customer or Trainer before logging in.");
        return;
    }
    this.action = selected.value === "customer" ? "/customers/signin" : "/providers/signin";
});
</script>

</body>
</html>






