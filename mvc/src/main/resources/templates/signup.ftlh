<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpartanFitness.com</title>
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">

    <link rel="stylesheet" href="/css/customer-style.css">
    <style>
      .ratio-3x4 {
      aspect-ratio: 3/4;
      width: 100%;
      object-fit: cover;
      border-radius: 1rem;
      margin-bottom: 1.5rem;
      }
    </style>
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

<section class="profile-container" style="max-width: 900px;">
    <div style="display: flex; gap: 2rem; flex-wrap: wrap;">
        
        <!-- CARD 1 -->
        <div style="
            flex: 1 1 45%;
            background: #fff;
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 0 1.5rem rgba(0,0,0,0.1);
        ">
            <img src="https://images.pexels.com/photos/4162578/pexels-photo-4162578.jpeg" class="card-img ratio-3x4">
            <h2 style="font-size: 2rem; color: var(--main); margin-bottom: 1rem;">
                Customer
            </h2>
            <p style="font-size: 1.5rem; color: #333;">
                Sign up to explore workouts and track your fitness progress.
            </p>
            <a href="/customers/signup" class="btn">Sign Up</a>
        </div>

        <!-- CARD 2 -->
        <div style="
            flex: 1 1 45%;
            background: #fff;
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 0 1.5rem rgba(0,0,0,0.1);
        ">
            <img src="" class="card-img ratio-3x4">
            <h2 style="font-size: 2rem; color: var(--main); margin-bottom: 1rem;">
                Trainer
            </h2>
            <p style="font-size: 1.5rem; color: #333;">
                Sign up to offer workout plans and manage your clients.
            </p>
            <a href="/providers/signup" class="btn">Sign Up</a>
        </div>

    </div>
</section>

</body>
</html>    