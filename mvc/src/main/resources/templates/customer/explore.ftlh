<!DOCTYPE html>
<html>
<head>
    <title>${title! "Homepage"}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">
</head>
<body>
    <header>
        <a href="/" class="logo">Spartan Fitness<span>.</span></a>       
        <nav class="navbar">
        <#if customerId??>
                <a href="/customers/explore">Workouts</a>
                <a href="/customers/dashboard">Profile</a>
                <a href="/customers/logout">Logout</a>
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

    <div class="carousel">
        <div class="carousel-item active">
            <img src="https://media.istockphoto.com/id/891602094/photo/spotive-man-and-woman-lifting-heavy-barbells.jpg?s=612x612&w=0&k=20&c=rW-K_ao8hhO6rnoLJ0km_tVZfQY9i7xq8EfgHcEW-0s=" alt="Workout 1">
            <div class="carousel-caption">
                <h3>Full Body Workout</h3>
                <p>Get fit with our comprehensive full body workout plan.</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="https://t3.ftcdn.net/jpg/03/05/59/32/360_F_305593240_tsLw1F5Nk22hVpuVUNjOPdQrE4WF6zyq.jpg" alt="Workout 2">
            <div class="carousel-caption">
                <h3>Yoga for Beginners</h3>
                <p>Start your yoga journey with our beginner-friendly sessions.</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="https://media.istockphoto.com/id/1311041275/photo/muscles-loading-please-wait.jpg?s=612x612&w=0&k=20&c=BG57z3VIml2Gw51Ic2NU86JeusEXrosfoma9m8EWk50=" alt="Workout 3">
            <div class="carousel-caption">
                <h3>HIIT Training</h3>
                <p>Boost your metabolism with high-intensity interval training.</p>
            </div>
        </div>

        <button class="carousel-control prev" onclick="prevSlide()">&#10094;</button>
        <button class="carousel-control next" onclick="nextSlide()">&#10095;</button>
    </div>

    <div class="workout-tabs">
        <h2>Workout Categories</h2>

        <div class="tab-buttons">
            <div class="tab-button active-tab" data-tab="strength" onclick="showWorkoutTab('strength')">Strength Training</div>
            <div class="tab-button" data-tab="cardio" onclick="showWorkoutTab('cardio')">Cardio</div>
            <div class="tab-button" data-tab="yoga" onclick="showWorkoutTab('yoga')">Yoga</div>
        </div>

        <div class="tab-content active-tab-content" id="strength">
            <ul class="workout-links">
                <li><a href="view-workout.html">Strength Plan</a> - 4-week full-body muscle-building plan</li>
                <li><a href="#">Push Day</a> - Chest, shoulders, and triceps routine</li>
                <li><a href="#">Pull Day</a> - Back and biceps hypertrophy workout</li>
                <li><a href="#">Leg Day</a> - Quads, hamstrings, and glutes training</li>
                <li><a href="#">Core Strength</a> - Abdominal and lower back focus</li>
            </ul>
        </div>

        <div class="tab-content" id="cardio">
            <ul class="workout-links">
                <li><a href="view-workout.html">HIIT Express</a> - 20-minute high-intensity interval session</li>
                <li><a href="#">Treadmill Burn</a> - Endurance run for fat loss</li>
                <li><a href="#">Jump Rope Blast</a> - Cardio circuit with jump rope</li>
                <li><a href="#">Stair Climber Challenge</a> - Leg-intensive cardio routine</li>
                <li><a href="#">Bodyweight Cardio</a> - No-equipment fat-burning workout</li>
            </ul>
        </div>

        <div class="tab-content" id="yoga">
            <ul class="workout-links">
                <li><a href="view-workout.html">Morning Flow</a> - Gentle sequence to start your day</li>
                <li><a href="#">Evening Wind Down</a> - Stretch and relax before bed</li>
                <li><a href="#">Balance & Core</a> - Improve stability and strength</li>
                <li><a href="#">Power Yoga</a> - More dynamic, strength-based flow</li>
                <li><a href="#">Beginner's Guide</a> - Intro to yoga postures and breathing</li>
            </ul>
        </div>
    </div>    

    <script>
        let currentSlide = 0;
        const slides = document.querySelectorAll('.carousel-item');

        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.classList.toggle('active', i === index);
            });
        }

        function nextSlide() {
            currentSlide = (currentSlide + 1) % slides.length;
            showSlide(currentSlide);
        }

        function prevSlide() {
            currentSlide = (currentSlide - 1 + slides.length) % slides.length;
            showSlide(currentSlide);
        }

        setInterval(nextSlide, 10000);   
  
        function showWorkoutTab(tabId) {
        document.querySelectorAll('.tab-button').forEach(btn =>
        btn.classList.remove('active-tab')
        );

        document.querySelectorAll('.tab-content').forEach(content =>
        content.classList.remove('active-tab-content')
        );

        document.querySelector(`.tab-button[data-tab="${tabId}"]`).classList.add('active-tab');

        document.getElementById(tabId).classList.add('active-tab-content');
        }
    </script>

</body>
</html>