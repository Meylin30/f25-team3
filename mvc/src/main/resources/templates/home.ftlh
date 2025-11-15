<!DOCTYPE html>
<html>
<head>
    <title>${title! "Homepage"}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/customer-style.css">
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
        <div class="container">
                <form action="">
                    <input type="search" name="" placeholder="Search here..." id="search-box">
                    <label for="search-box" class="fas fa-search"></label>
                </form>
        </div>
    </header>

    <section class="home" id="home">
            <div class="content">
                <h3>Get Fit, Stay Strong</h3>
                <p>Join Spartan Fitness today and embark on a transformative fitness journey. Our expert trainers and personalized workout plans are designed to help you achieve your health and wellness goals. Whether you're a beginner or a seasoned athlete, we have something for everyone. Start your journey with us and become the best version of yourself!</p>
                <a href="customers/explore" class="btn">Explore Workouts</a>
                <#if providerId??>
                <a href="providers/workouts" class="btn">Create Workout</a>
                <#/if>
            </div>

            <div class="image">
                <img src="" alt="">
            </div>
    </section>
</body>
</html>