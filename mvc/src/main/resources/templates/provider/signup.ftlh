<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Provider Registration</title>

<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>

<body>

 <div class="register-container">
    
    <h2>Provider Registration</h2>

    <form id="provider-signup-form" action="/providers/signup" method="post">

        <div class="progress-dots">
            <span class="dot active"></span>
            <span class="dot"></span>
        </div>

        
        <div class="form-step active">
            <h3 style="margin-bottom: 15px; color: var(--secondary); font-size: 20px;">Your Details</h3>

            <label>Email</label>
            <input type="email" name="email" required placeholder="Email">

            <label>Name</label>
            <input type="text" name="name" required placeholder="Full Name">

            <label>Password</label>
            <input type="password" name="password" required placeholder="Create Password">

        </div>

       
        <div class="form-step">
            <h3 style="margin-bottom: 15px; color: var(--secondary); font-size: 20px;">Professional Info</h3>

            <label>Bio</label>
            <textarea name="bio" placeholder="Short bio (optional)"></textarea>

            <label>Specialty</label>
            <input type="text" name="specialty" placeholder="E.g., Strength Training">

            <div class="button-group">
                
                <button type="submit" class="submit-btn btn-1">Create Account</button>
            </div>
        </div>

    </form>

    <a href="/" class="back-link"><i class="fas fa-arrow-left"></i> Back to Home</a>
</div>

<script>
const form = document.getElementById('provider-signup-form');
const steps = Array.from(document.querySelectorAll('.form-step'));
const nextBtns = document.querySelectorAll('.next-btn');
const prevBtns = document.querySelectorAll('.prev-btn');
const dots = document.querySelectorAll('.progress-dots .dot');
let currentStep = 0;

function showStep(step) {
    steps.forEach((s, i) => s.classList.toggle('active', i === step));
    dots.forEach((d, i) => d.classList.toggle('active', i === step));
}

nextBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        const inputs = steps[currentStep].querySelectorAll('input, textarea');
        for (const i of inputs) {
            if (!i.checkValidity()) {
                i.reportValidity();
                return;
            }
        }
        currentStep++;
        showStep(currentStep);
    });
});

prevBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        currentStep--;
        showStep(currentStep);
    });
});

showStep(currentStep);
</script>

</body>
</html>


