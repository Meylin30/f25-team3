<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Provider Signup</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">
</head>
<body>

<header>
    <a href="/" class="logo">Spartan Fitness<span>.</span></a>
    <nav class="navbar">
        <a href="/signin">Sign In</a>
        <a href="/signup">Sign Up</a>
    </nav>
</header>

<main>
    <div class="register-container">
        <form id="signup-form" action="/providers/signup" method="post">

            <div class="progress-dots">
                <span class="dot active"></span>
                <span class="dot"></span>
            </div>

            <!-- Step 1 -->
            <div class="form-step active">
                <h2>Step 1: Account Info</h2>

                <label>Email</label>
                <input type="email" name="email" required placeholder="Enter your email">

                <label>Name</label>
                <input type="text" name="name" required placeholder="Enter your name">

                <label>Password</label>
                <input type="password" name="password" required placeholder="Enter password">

                <div class="buttons">
                    <div></div>
                    <button type="button" class="next-btn">Next</button>
                </div>
            </div>

            <!-- Step 2 -->
            <div class="form-step">
                <h2>Step 2: Security Info</h2>

                <label>PIN (4–6 digits)</label>
                <input type="text" name="pin" required placeholder="Enter security PIN">

                <div class="buttons">
                    <button type="button" class="prev-btn">Previous</button>
                    <button type="submit" class="submit-btn">Create Account</button>
                </div>
            </div>

        </form>
    </div>
</main>

<script>
    const form = document.getElementById('signup-form');
    const steps = document.querySelectorAll('.form-step');
    const nextBtns = document.querySelectorAll('.next-btn');
    const prevBtns = document.querySelectorAll('.prev-btn');
    const dots = document.querySelectorAll('.dot');

    let step = 0;

    function showStep(n) {
        steps.forEach((s, i) => s.classList.toggle('active', i === n));
        dots.forEach((d, i) => d.classList.toggle('active', i === n));
    }

    nextBtns.forEach(btn =>
        btn.addEventListener('click', () => {
            const inputs = steps[step].querySelectorAll('input');
            for (let input of inputs) {
                if (!input.checkValidity()) return input.reportValidity();
            }
            step++;
            showStep(step);
        })
    );

    prevBtns.forEach(btn =>
        btn.addEventListener('click', () => {
            step--;
            showStep(step);
        })
    );
</script>

</body>
</html>
