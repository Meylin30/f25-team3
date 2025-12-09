<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${title! "Homepage"}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">
</head>

<body>

<header>
    <a href="/" class="logo">Spartan Fitness<span>.</span></a>

    <nav class="navbar">
        <#if customerId?? || providerId??>

            <#-- CUSTOMER LOGGED IN -->
            <#if customerId??>
                <a href="/customers/explore">Workouts</a>
                <a href="/customers/dashboard">Profile</a>
                <a href="/customers/logout">Logout</a>

            <#-- PROVIDER LOGGED IN -->
            <#else>
                <a href="/providers/${providerId}/workouts">Workouts</a>
                <a href="/providers/${providerId}/dashboard">Profile</a>
                <a href="/providers/logout">Logout</a>
            </#if>

        <#-- NO ONE LOGGED IN -->
        <#else>
            <a href="/signin">Sign In</a>
            <a href="/signup">Sign Up</a>
        </#if>
    </nav>

    <div class="container">
        <form>
            <input type="search" placeholder="Search here..." id="search-box">
            <label for="search-box" class="fas fa-search"></label>
        </form>
    </div>
</header>

<section class="home">
    <div class="content">
        <h3>Get Fit, Stay Strong</h3>

        <p>
            Join Spartan Fitness today and embark on a transformative fitness journey.
            Our expert trainers and customized workout plans help you reach your goals—
            whether you're a beginner or a seasoned athlete.
        </p>
         
    <#if customerId??>
    <a href="/customers/explore" class="btn">Explore Workouts</a>
    </#if>

        <#-- Extra actions for logged-in provider -->
        <#if providerId??>
            <a href="/providers/${providerId}/workouts" class="btn">Your Workouts</a>
            <a href="/providers/workouts/create" class="btn">Create Workout</a>
        </#if>
    </div>

    <div class="image">
        <img src="/images/home-fitness.png" alt="Fitness">
    </div>
</section>

</body>
</html>

