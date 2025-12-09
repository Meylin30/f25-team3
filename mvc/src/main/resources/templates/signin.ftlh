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

        .wrapper {
            width: 480px;
            max-width: 90%;
            background: transparent;
            border: 2px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(20px);
            color: #fff;
            border-radius: 10px;
            padding: 30px 40px 40px;
        }

        .wrapper h1 {
            font-size: 36px;
            text-align: center;
        }

        .wrapper .input-box {
            position: relative;
            width: 100%;
            height: 50px;
            margin: 30px 0;
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

        .wrapper .remember-forgot {
            font-size: 14px;
            margin: -15px 0 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: nowrap;
        }

        .wrapper .remember-forgot label {
            font-size: 14px;
            display: inline-flex;          
            align-items: center;    
            gap: 5px;               
            cursor: pointer;
            white-space: nowrap;  
        }

        .wrapper .remember-forgot label input {
            width: 14px;
            height: 14px;
            margin: 0;
            accent-color: var(--secondary);
            vertical-align: middle;
        }

        .wrapper .remember-forgot a {
            color: #fff;
            text-decoration: none;
        }

        .wrapper .remember-forgot a:hover {
            text-decoration: underline;
            color: var(--secondary);
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

        /* ---------------- User Type Radio Buttons ---------------- */
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
                    Trainer
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
