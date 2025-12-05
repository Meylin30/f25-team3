<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${provider.name}'s Reviews</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>

<div class="card reviews-card">

    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJq1STQvo8NE2C5hQKqkX1R-PDGWnKUl3beA&s"
         alt="${provider.name}"
         class="profile-img">

    <h1>${provider.name}'s Reviews</h1>

    <div class="button-group">
        <a href="/providers/${provider.id}/dashboard" class="btn-1">Dashboard</a>
        <a href="/providers/logout" class="logout-btn">Logout</a>
    </div>

    <h2 class="section-title">All Reviews</h2>

    <#if reviews?? && reviews?size gt 0>

        <#list reviews as review>

            <div class="review-item">

                <div class="review-top">
                    <strong>${review.customer.name!"Unknown"}</strong>

                    <div class="stars">
                        <#list 1..5 as i>
                            <i class="fa-solid fa-star ${i <= review.rating?int ? then('filled','')}"></i>
                        </#list>
                    </div>

                    <span class="review-date">
                        ${review.createdAt?datetime("yyyy-MM-dd'T'HH:mm")?string("MMM dd, yyyy h:mm a")}
                    </span>
                </div>

                <p class="review-text">"${review.comment!"No comment"}"</p>

                <#if review.providerResponse??>

                    <div class="response-box">
                        <small>Your Response:</small>
                        <p>${review.providerResponse}</p>

                        <#if review.providerResponseDate??>
                            <span class="response-date">
                                ${review.providerResponseDate?datetime("yyyy-MM-dd'T'HH:mm")?string("MMM dd, yyyy h:mm a")}
                            </span>
                        </#if>
                    </div>

                <#else>

                    <form action="/providers/${provider.id}/reviews/${review.id}/reply" method="post" class="reply-box">
                        <textarea name="providerResponse" placeholder="Write a response..." required></textarea>
                        <button type="submit" class="btn-1">Send Reply</button>
                    </form>

                </#if>

            </div>

        </#list>

    <#else>
        <p>No reviews found.</p>
    </#if>

</div>

</body>
</html>
