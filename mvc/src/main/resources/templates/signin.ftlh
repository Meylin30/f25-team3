<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - SpartanFitness</title>
    <link rel="stylesheet" href="/css/style.css">

    <style>
        body {
            background-color: var(--main);
            color: var(--font);
            font-family: "Poppins", sans-serif;
        }

        /* ---------------- Login Page ---------------- */
        body.login {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 100vh;
            background: var(--main);
            background-size: cover;
            background-position: center;
        }

        .input-box input {
            width: 100%;
            height: 100%;
            background: transparent;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 40px;
            outline: none;
            font-size: 16px;
            color: #fff;
            padding: 20px 45px;
        }

        .input-box input::placeholder {
            color: #fff;
        }

        form .button {
            height: 45px;
            margin: 35px 0;
        }

        form .button input {
            height: 100%;
            width: 130%;
            outline: none;
            border-radius: 5px;
            border: none;
            color: #fff;
            font-size: 18px;
            font-weight: 500;
            letter-spacing: 1px;
            cursor: pointer;
            background: var(--main);
        }

        form .button input:hover {
            background: var(--secondary);
        }

        .btn {
            width: 100%;
            height: 45px;
            background: #fff;
            border: none;
            outline: none;
            border-radius: 40px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            font-size: 16px;
            color: #333;
            cursor: pointer;
            font-weight: 600;
        }

        .btn:hover {
            background: var(--secondary);
        }

        .wrapper .register-link {
            text-align: center;
            font-size: 10px;
            margin-top: 20px;
        }

        .wrapper .register-link a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .custom-radio {
            width: 18px;
            height: 18px;
            border: 2px solid var(--secondary);
            border-radius: 50%;
            background-color: var(--main);
            position: relative;
        }

        /* --- FIXED CUSTOM RADIOS --- */

.role-toggle {
    display: flex;
    gap: 20px;
    margin: 20px 0;
}

.role-option {
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    color: var(--font);
    font-weight: bold;
}

/* Hide browser radio */
.role-option input[type="radio"] {
    position: absolute;
    opacity: 0;
    width: 0;
    height: 0;
}

/* Custom radio circle */
.custom-radio {
    width: 18px;
    height: 18px;
    border: 2px solid var(--secondary);
    border-radius: 50%;
    display: inline-block;
    position: relative;
}

/* Checked state */
.role-option input[type="radio"]:checked + .custom-radio::after {
    content: "";
    position: absolute;
    top: 50%;
    left: 50%;
    width: 10px;
    height: 10px;
    transform: translate(-50%, -50%);
    background-color: var(--secondary);
    border-radius: 50%;
}

    </style>
</head>

<body class="auth-bg"

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
                    <span class="custom-radio"></span>
                    <span>Customer</span>
                </label>

                <label class="role-option">
                    <input type="radio" name="userType" value="provider">
                    <span class="custom-radio"></span>
                    <span>Trainer</span>
                </label>
            </div>

            <!-- INPUTS -->
            <input type="email" name="email" class="auth-input" placeholder="Email address" required>
            <input type="password" name="password" class="auth-input" placeholder="Password" required>

            <!-- Button -->
            <button type="submit" class="btn">Login</button>

        </form>

         <!-- FOOTER -->
            <p class="auth-footer">
                New here?
                <a href="/customers/signup">Create Account</a> |
                <a href="/providers/signup">Become a Trainer</a>
            </p>

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






