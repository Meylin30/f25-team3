<!DOCTYPE html>
<html>
<head>
    <title>View-Profile</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">
    
    <style>

    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
    }

    /* =======================
       BODY
       ======================= */
    body {
        background: var(--main);
        color: var(--font);
        line-height: 1.6;
        min-height: 100vh;
        padding-top: 100px;
        font-size: 16px;
        line-height: 1.6;
    }

    /* =======================
       WRAPPER & COLUMNS
       ======================= */
    .header__wrapper {
        max-width: 1200px;
        margin: 100px auto 40px; /* top margin to avoid header overlap */
        display: flex;
        gap: 30px;
        flex-wrap: wrap;
        justify-content: center;
    }

    /* LEFT COLUMN */
    .col__left {
        flex: 1;
        min-width: 280px;
        max-width: 300px;
        background: var(--card-bg);
        border: 2px solid var(--card-border);
        border-radius: 12px;
        padding: 20px;
        text-align: center;
    }

    .img__container img {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        border: 3px solid var(--secondary);
        object-fit: cover;
        margin-bottom: 10px;
    }

    .col__left h2 {
        font-size: 22px;
        margin-bottom: 5px;
    }

    .col__left p {
        font-size: 14px;
        color: var(--font-secondary);
        margin-bottom: 15px;
    }

    .social__icons a {
        margin: 0 5px;
        color: var(--font);
        font-size: 16px;
        transition: color 0.3s ease;
    }

    .social__icons a:hover {
        color: var(--secondary);
    }

    .programs {
        margin-top: 15px;
        list-style: none;
        padding: 0;
    }

    .programs li a {
        display: block;
        background: var(--card-bg);
        color: var(--secondary);
        padding: 8px 0;
        margin-bottom: 8px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .programs li a:hover {
        background: var(--secondary);
        color: var(--main);
    }

    /* BUTTONS */
    .btn-1, .small-btn {
        display: inline-block;
        background: var(--main);
        color: var(--font);
        padding: 8px 15px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 0.9rem;
        margin-top: 10px;
        transition: all 0.3s ease;
        border: 1px solid var(--secondary);
        cursor: pointer;
    }

    .btn-1:hover, .small-btn:hover {
        background: var(--secondary);
        color: var(--main);
    }

    /* RIGHT COLUMN */
    .right__col {
        flex: 2;
        min-width: 400px;
        max-width: 700px;
        background: var(--card-bg);
        border: 2px solid var(--card-border);
        border-radius: 12px;
        padding: 20px;
    }

    /* SECTIONS */
    .provider-info-box,
    .workouts-section,
    .reviews-section {
        background: rgba(255,255,255,0.1);
        border-radius: 10px;
        padding: 15px;
        margin-bottom: 20px;
    }

    .workout-item,
    .review {
        background: rgba(255,255,255,0.1);
        padding: 10px 15px;
        margin-bottom: 10px;
        border-left: 4px solid var(--secondary);
        border-radius: 6px;
    }

    .workout-actions a,
    .workout-actions button {
        display: inline-block;
        margin-right: 10px;
        padding: 6px 12px;
        border-radius: 6px;
        text-decoration: none;
        border: 1px solid var(--secondary);
        background: var(--main);
        color: var(--font);
        transition: all 0.3s ease;
    }

    .workout-actions a:hover,
    .workout-actions button:hover {
        background: var(--secondary);
        color: var(--main);
    }

    /* FLEX CONTAINER FOR COLUMNS */
    .profile-wrapper {
        max-width: 1200px;
        margin: 40px auto;
        display: flex;        /* this makes columns side by side */
        gap: 30px;
        flex-wrap: wrap;      /* allows stacking on smaller screens */
        justify-content: center;
    }

    p.email {
        text-transform: none;
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

    <div class="profile-wrapper">

        <!-- LEFT COLUMN -->
        <div class="col__left">

            <div class="img__container">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJq1STQvo8NE2C5hQKqkX1R-PDGWnKUl3beA&s"
                     alt="${provider.name!"Provider"}">
            </div>

            <h2>${provider.name!"No Name"}</h2>
            <p class="email">${provider.email}</p>

            <div class="social__icons">
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#"><i class="fa-brands fa-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
            </div>

        </div>

        <!-- RIGHT COLUMN -->
        <div class="right__col">

            <!-- WORKOUT PLANS -->
            <section class="workouts-section">
                <h3>Workout Plans</h3>
                <#if workouts?? && workouts?size gt 0>
                    <#list workouts as w>
                        <div class="workout-item">
                            <a href="/customers/explore/${w.id}" class="name-link">
                                <strong>${w.title!"Untitled Plan"}</strong>
                            </a>

                            <div class="rating">
                                <#-- Calculate average rating for this workout -->
                                <#assign averageRating = workoutAverageRatings[w.id?string]!0>
                                <#assign reviews = workoutReviews[w.id?string]![]>

                                <#list 1..5 as i>
                                    <i class="
                                        <#if i <= averageRating>
                                            fas fa-star
                                        <#elseif (i - averageRating) < 1>
                                            fas fa-star-half-alt
                                        <#else>
                                            far fa-star
                                        </#if>
                                    " style="color: gold;"></i>
                                </#list>

                                <span class="reviews">
                                    <#if reviews??>
                                        ${reviews?size} review<#if reviews?size != 1>s</#if>
                                    <#else>
                                        0 reviews
                                    </#if>
                                </span>
                            </div>
                        </div>
                    </#list>
                <#else>
                    <p>No workouts found.</p>
                </#if>
            </section>

</body>
</html>