<!DOCTYPE html>
<html>
<head>
    <title>${title! "Explore"}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">

    <style>
    .search-results-container {
        display: flex;
        gap: 2rem; /* space between columns */
        margin: 2rem;
    }

    .search-results-container .column {
        flex: 1;
        background: #f8f8f8;
        padding: 1rem 2rem;
        border-radius: 0.5rem;
    }

    .search-results-container .column h3 {
        margin-top: 0;
        margin-bottom: 1rem;
        font-size: 2rem;
    }

    .search-results-container ul {
        list-style: none;
        padding-left: 0;
    }

    .search-results-container li {
        margin-bottom: 0.8rem;
        font-size: 1.6rem;
    }

    .search-results-container a {
        text-decoration: none;
        color: var(--main);
    }

    .search-results-container a:hover {
        color: var(--secondary);
    }

    </style>
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
            <form action="/customers/explore" method="get">
                <input type="search" name="search" placeholder="Search here..." id="search-box">
                <label for="search-box" class="fas fa-search"></label>
                <button type="submit" style="display:none;"></button>
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

    <#-- Only show search results if there is a search -->
    <#if searchWorkouts?size gt 0 || searchProviders?size gt 0>
      <div class="search-results-container">
          <div class="column workouts-column">
              <h3>Workouts</h3>
              <ul>
                  <#list searchWorkouts as workout>
                      <li>
                          <a href="/customers/explore/${workout.id}">${workout.title}</a> - ${workout.description!""}
                      </li>
                  </#list>
              </ul>
          </div>
          <div class="column providers-column">
              <h3>Trainers</h3>
              <ul>
                  <#list searchProviders as provider>
                      <li>
                          <a href="/customers/explore/trainer/${provider.id}">${provider.name}</a>
                      </li>
                  </#list>
              </ul>
          </div>
      </div>
    </#if>


    <div class="workout-tabs">
        <h2>Workout Categories</h2>

        <div class="tab-buttons">
            <div class="tab-button active-tab" data-tab="beginner" onclick="showWorkoutTab('beginner')">Beginner</div>
            <div class="tab-button" data-tab="intermediate" onclick="showWorkoutTab('intermediate')">Intermediate</div>
            <div class="tab-button" data-tab="advanced" onclick="showWorkoutTab('advanced')">Advanced</div>
            <div class="tab-button" data-tab="all" onclick="showWorkoutTab('all')">All Workouts</div>
        </div>

        <div class="tab-content active-tab-content" id="beginner">
            <ul class="workout-links">
                <#list beginnerWorkouts as workout>
                    <li>
                        <a href="/customers/explore/${workout.id}">${workout.title}</a> - ${workout.description!""}
                    </li>
                </#list>
            </ul>
        </div>

        <div class="tab-content" id="intermediate">
            <ul class="workout-links">
                <#list intermediateWorkouts as workout>
                    <li>
                        <a href="/customers/explore/${workout.id}">${workout.title}</a> - ${workout.description!""}
                    </li>
                </#list>
            </ul>
        </div>

        <div class="tab-content" id="advanced">
            <ul class="workout-links">
                <#list advancedWorkouts as workout>
                    <li>
                        <a href="/customers/explore/${workout.id}">${workout.title}</a> - ${workout.description!""}
                    </li>
                </#list>
            </ul>
        </div>

        <div class="tab-content" id="all">
            <ul class="workout-links">
                <#list workouts as workout>
                    <li>
                        <a href="/customers/explore/${workout.id}">${workout.title}</a> - ${workout.description!""}
                    </li>
                </#list>
            </ul>
        </div>

    </div>    

    <#noparse>
    <script defer>
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
    </#noparse>
</body>
</html>