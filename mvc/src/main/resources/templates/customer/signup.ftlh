<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpartanFitness.com</title>
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">
</head>
<body>

<header>
        <a href="/" class="logo">Spartan Fitness<span>.</span></a>       
        <nav class="navbar">
        <#if customerId?? || providerId??>
            <#if customerId??>
                <a href="customers/explore">Workouts</a>
                <a href="/customers/dashboard">Profile</a>
                <a href="/customers/logout">Logout</a>
            <#else>
                <a href="/providers/workouts">Workouts</a>
                <a href="/providers/dashboard">Profile</a>
                <a href="/providers/logout">Logout</a>    
            </#if>
        <#else>
            <a href="/signin">Sign In</a>
            <a href="/signup">Sign Up</a>
        </#if>    
        </nav>
        <div class="container">
                <form action="">
                    <input type="search" name="" placeholder="Search here..." id="search-box">
                    <label for="search-box" class="fas fa-search"></label>
                </form>
        </div>
    </header>

    <main>
      <div class="register-container">
        <form id="signup-form" action="/customers/signup" method="post">
            <div class="progress-dots">
                <span class="dot active"></span>
                <span class="dot"></span>
                <span class="dot"></span>
            </div>
          <!-- Step 1 -->
          <div class="form-step active">
            <h2>Step 1: Account Info</h2>
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required placeholder="Enter your email" />

            <label for="username">Username</label>
            <input type="text" id="username" name="name" required placeholder="Choose a username" />

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Create a password" />

            <div class="buttons">
              <div></div>
              <button type="button" class="next-btn">Next</button>
            </div>
          </div>

          <!-- Step 2 -->
          <div class="form-step">
            <h2>Step 2: Personal Info</h2>
            
            <label for="dob">Date of Birth</label>
            <input type="date" id="dob" name="dob" />

            <label for="height">Height</label>
            <input type="text" id="height" name="height" placeholder="Your height (optional)" /> 

            <label for="weight">Weight</label>
            <input type="text" id="weight" name="weight" placeholder="Your weight (optional)" />


            <div class="buttons">
              <button type="button" class="prev-btn">Previous</button>
              <button type="button" class="next-btn">Next</button>
            </div>
          </div>

          <div class="form-step">
            <h2>Step 3: Fitness Info</h2>

            <label for="fitness-level">Fitness Level</label>
            <select id="fitness-level">
              <option value="" disabled selected>Select your level</option>
              <option value="beginner">Beginner</option>
              <option value="intermediate">Intermediate</option>
              <option value="advanced">Advanced</option>
            </select>

            <label for="goal">Fitness Goal</label>
            <select id="goal">
              <option value="" disabled selected>Select your goal</option>
              <option value="lose-weight">Lose Weight</option>
              <option value="build-muscle">Build Muscle</option>
              <option value="improve-endurance">Improve Endurance</option>
              <option value="general-health">General Health</option>
            </select>

            <div class="buttons">
              <button type="button" class="prev-btn">Previous</button>
            </div>
            <button type="submit" id="create-account-btn" class="submit-btn">Create Account</button>
          </div>
        </form>
      </div>
    </main>

    <script>
      const form = document.getElementById('signup-form');
      const steps = Array.from(document.querySelectorAll('.form-step'));
      const nextBtns = document.querySelectorAll('.next-btn');
      const prevBtns = document.querySelectorAll('.prev-btn');
      const dots = document.querySelectorAll('.progress-dots .dot');
      const createAccountBtn = document.getElementById('create-account-btn');

      let currentStep = 0;

      function showStep(step) {
        steps.forEach((s, i) => {
          s.classList.toggle('active', i === step);
        });
        updateDots(step);
      }

      function updateDots(step) {
        dots.forEach((dot, index) => {
          dot.classList.toggle('active', index === step);
        });
      }

      showStep(currentStep);

      nextBtns.forEach(btn => {
        btn.addEventListener('click', () => {
          const inputs = steps[currentStep].querySelectorAll('input, select');
          let valid = true;
          inputs.forEach(input => {
            if (!input.checkValidity()) {
              input.reportValidity();
              valid = false;
            }
          });
          if (!valid) return;

          if (currentStep < steps.length - 1) {
            currentStep++;
            showStep(currentStep);
          }
        });
      });

      prevBtns.forEach(btn => {
        btn.addEventListener('click', () => {
          if (currentStep > 0) {
            currentStep--;
            showStep(currentStep);
          }
        });
      });

      form.addEventListener('submit', e => {
        e.preventDefault();

        const inputs = steps[currentStep].querySelectorAll('input, select');
        let valid = true;
        inputs.forEach(input => {
          if (!input.checkValidity()) {
            input.reportValidity();
            valid = false;
          }
        });
        if (!valid) return;

        form.submit();
      });

    </script>

</body>
</html> 