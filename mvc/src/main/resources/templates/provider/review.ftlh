<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${provider.name}'s Reviews</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>

<body class="profile">

<div class="header__wrapper">

    <!-- LEFT COLUMN -->
    <div class="col__left">
        <div class="img__container">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJq1STQvo8NE2C5hQKqkX1R-PDGWnKUl3beA&s"
                 alt="${provider.name}">
        </div>

        <h2>${provider.name}</h2>
        <p>Provider</p>

        <a href="/providers/${provider.id}/edit" class="btn-1">Edit Profile</a>
        <a href="/providers/logout" class="btn-1 logout-btn">Logout</a>
    </div>

    <!-- RIGHT COLUMN -->
    <div class="right__col">

        <nav>
            <ul>
                <li><a href="/providers/${provider.id}/dashboard">Overview</a></li>
                <li><a href="/providers/workouts/create">Workout Plans</a></li>
                <li><a href="#" class="active">Reviews</a></li>
            </ul>
        </nav>

        <!-- REVIEW SECTION -->
<section class="reviews-section">
    <h2>All Reviews</h2>

    <#if reviews?? && reviews?size gt 0>

        <#list reviews as review>

            <div class="review-card">

                <div class="review-header">
                    <strong class="review-name">${review.customer.name!"Unknown"}</strong>
                    
                    <!-- Stars -->
                    <span class="stars">
                        <#list 1..5 as i>
                            <i class="fa-solid fa-star ${i <= review.rating?int?then('filled','')}"></i>
                        </#list>
                    </span>

                    <span class="review-date">
                        ${review.createdAt?datetime("yyyy-MM-dd'T'HH:mm")?string("MMM dd, yyyy h:mm a")}
                    </span>
                </div>

                <p class="review-comment">"${review.comment!"No comment"}"</p>

                <#if review.providerResponse??>
                    <div class="provider-response-box">
                        <small>Your Response:</small>
                        <p>${review.providerResponse}</p>

                        <#if review.providerResponseDate??>
                            <span class="response-date">
                                ${review.providerResponseDate?datetime("yyyy-MM-dd'T'HH:mm")?string("MMM dd, yyyy h:mm a")}
                            </span>
                        </#if>
                    </div>

                <#else>
                    <form action="/providers/${provider.id}/reviews/${review.id}/reply" method="POST" class="reply-form">
                        <textarea name="providerResponse" required placeholder="Write a response..."></textarea>
                        <button type="submit" class="btn-1 small-btn">Send Reply</button>
                    </form>
                </#if>

            </div>

        </#list>

    <#else>
        <p>No reviews found.</p>
    </#if>

</section>


        <a href="/providers/${provider.id}/dashboard" class="btn-1">Back to Dashboard</a>

    </div>
</div>

</body>
</html>