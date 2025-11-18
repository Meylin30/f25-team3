<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${title!"Provider Dashboard"}</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>

<body class="profile">

<div class="header__wrapper">
    <header></header>

    <div class="col__container">

        <div class="col__left">

            <div class="img__container">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJq1STQvo8NE2C5hQKqkX1R-PDGWnKUl3beA&s"
                     alt="${provider.name}">
                <span></span>
            </div>

            <h2>${provider.name}</h2>
            <p>Provider</p>

            <div class="social__icons">
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#"><i class="fa-brands fa-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
            </div>

            <!-- Edit Profile button -->
            <a href="/providers/${provider.id}/edit" class="btn-1">Edit Profile</a>

            <ul class="programs">
                <li><a href="/providers/${provider.id}/workouts">Workout Plans</a></li>
            </ul>

        </div>

        <div class="right__col">

            <nav>
                <ul>
                    <li><a href="#" class="active">Overview</a></li>
                    <li><a href="/providers/${provider.id}/workouts">Workout Plans</a></li>
                    <li><a href="/providers/${provider.id}/reviews">Reviews</a></li>
                </ul>
            </nav>

            <section class="provider-info-box">
                <h3>Account Information</h3>

                <p><strong>Name:</strong> ${provider.name}</p>
                <p><strong>Email:</strong> ${provider.email}</p>
                <p><strong>Overall Rating:</strong> ${provider.overallRating?string("0.0")}</p>
            </section>

            <section class="workouts-section">
                <h3>Workout Plans</h3>

                <#if provider.workoutPlans?size == 0>
                    <p>No workout plans created yet.</p>
                <#else>
                    <ul class="workout-list">
                        <#list provider.workoutPlans as w>
                            <li>
                                <strong>${w.title!"Untitled Plan"}</strong><br>
                                <span>${w.description!"No description"}</span>
                            </li>
                        </#list>
                    </ul>
                </#if>

                <a href="/providers/${provider.id}/workouts/create" class="btn-1">
                    Create New Workout Plan
                </a>
            </section>

        </div>

    </div>
</div>

</body>
</html>
