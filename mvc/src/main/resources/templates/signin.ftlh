<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpartanFitness.com</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">

    <style>
        :root {
            --main: #0F2044;
            --secondary: #FFB71B;
            --font: #FFFFFF;
            --font-secondary: #BEC0C2;
        }

        body {
            background-color: var(--main);
            color: var(--font);
        }

        .user-type {
            display: flex;
            gap: 20px;
            margin: 20px 0;
        }

        .user-type label {
            display: flex;
            align-items: center;
            cursor: pointer;
            gap: 8px;
            font-weight: bold;
            color: var(--font);
        }

        .user-type input[type="radio"] {
            display: none;
        }

        .custom-radio {
            width: 18px;
            height: 18px;
            border: 2px solid var(--secondary);
            border-radius: 50%;
            background-color: var(--main);
            position: relative;
        }

        .user-type input[type="radio"]:checked + .custom-radio::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 10px;
            height: 10px;
            background-color: var(--secondary);
            border-radius: 50%;
        }
    </style>
</head>

<body class="login">

    <div class="wrapper">
        <form method="post" id="loginForm">
            <h1>Login</h1>

            <!-- User type selection -->
            <div class="user-type">
                <label>
                    <input type="radio" name="userType" value="customer">
                    <span class="custom-radio"></span>
                    Customer
                </label>

                <label>
                    <input type="radio" name="userType" value="provider">
                    <span class="custom-radio"></span>
                    Provider
                </label>
            </div>

            <!-- Email -->
            <div class="input-box">
                <input type="email" name="email" placeholder="Email" required>
            </div>

            <!-- Password -->
            <div class="input-box">
                <input type="password" name="password" placeholder="Password" required>
            </div>

            <!-- Remember + forgot -->
            <div class="remember-forgot">
                <label><input type="checkbox"> Remember me</label>
                <a href="#">Forgot Password?</a>
            </div>

            <!-- Button -->
            <button type="submit" class="btn">Login</button>

            <!-- Sign up link -->
            <div class="register-link">
                <p>Don't have an account?  
                    <a href="/customers/signup">Sign Up |</a>
                    <a href="/providers/signup">Register</a>
                </p>
            </div>
        </form>
    </div>

    <script>
        const form = document.getElementById("loginForm");

        form.addEventListener("submit", function (e) {
            const userType = document.querySelector('input[name="userType"]:checked');

            if (!userType) {
                e.preventDefault();
                alert("Please select Customer or Provider before logging in.");
                return;
            }

            if (userType.value === "customer") {
                form.action = "/customers/signin";
            } else {
                form.action = "/providers/signin";
            }
        });
    </script>

</body>
</html>
