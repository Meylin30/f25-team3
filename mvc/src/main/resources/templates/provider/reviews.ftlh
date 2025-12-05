<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${provider.name!''}’s Reviews</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="/css/style.css">

    <style>
        .reviews-card {
            max-width: 850px;
            margin: 40px auto;
            padding: 25px;
            background: rgba(255,255,255,0.06);
            border-radius: 12px;
            border: 1px solid rgba(255,255,255,0.15);
            color: white;
        }

        .profile-img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            margin: 0 auto 15px;
            border: 3px solid #FFB71B;
        }

        .review-item {
            padding: 18px;
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 10px;
            margin-bottom: 18px;
        }

        .review-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .review-text {
            font-size: 0.95rem;
            margin-top: 12px;
            line-height: 1.5;
        }

        .response-box {
            margin-top: 12px;
            padding: 10px;
            border-left: 3px solid #FFB71B;
            background: rgba(255,255,255,0.05);
        }

        .reply-box textarea {
            width: 100%;
            min-height: 80px;
            padding: 8px;
            margin-top: 10px;
            border-radius: 6px;
            border: none;
            outline: none;
        }

        .btn-1 {
            background: #FFB71B;
            padding: 8px 18px;
            border-radius: 6px;
            color: black;
            font-weight: bold;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }

        .logout-btn {
            background: #ff4d4d;
            padding: 8px 18px;
            border-radius: 6px;
            color: white;
            text-decoration: none;
        }

        .stars i {
            margin-right: 2px;
            font-size: 18px;
        }

        .filled {
            color: #FFB71B;
        }
    </style>
</head>

<body>

<div class="reviews-card">

    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJq1STQvo8NE2C5hQKqkX1R-PDGWnKUl3beA&s"
         alt="${provider.name!''}"
         class="profile-img">

    <h1 style="text-align:center;">
        ${provider.name!''}’s Reviews
    </h1>

    <div style="text-align:center; margin:15px 0;">
        <a href="/providers/${provider.id}/dashboard" class="btn-1">Dashboard</a>
        <a href="/providers/logout" class="logout-btn">Logout</a>
    </div>

    <h2 class="section-title">All Reviews</h2>

    <#if reviews?? && reviews?size gt 0>

        <#list reviews as review>

            <div class="review-item">

                <div class="review-top">

                    <!-- CUSTOMER NAME -->
                    <strong>
                        <#if review.customer??>
                            ${review.customer.name! "Unknown"}
                        <#else>
                            Unknown
                        </#if>
                    </strong>

                    <!-- ⭐ STAR RATING ⭐ -->
                    <div class="stars">

                        <#assign rating = 0>
                        <#if review.rating??>
                            <#assign rating = review.rating?number>
                        </#if>

                        <#list 1..5 as i>
                            <#if i <= rating>
                                <i class="fa-solid fa-star filled"></i>
                            <#else>
                                <i class="fa-regular fa-star"></i>
                            </#if>
                        </#list>

                    </div>

                    <!-- DATE -->
                    <span class="review-date">
                        ${review.createdAt!"Unknown date"}
                    </span>

                </div>

                <!-- REVIEW TEXT -->
                <p class="review-text">
                    "${review.comment!"No comment"}"
                </p>

                <!-- PROVIDER RESPONSE -->
                <#if review.providerResponse??>

                    <div class="response-box">
                        <small><b>Your Response:</b></small>
                        <p>${review.providerResponse!""}</p>

                        <#if review.providerResponseDate??>
                            <span class="response-date">
                                ${review.providerResponseDate!"N/A"}
                            </span>
                        </#if>
                    </div>

                <#else>

                    <form action="/providers/${provider.id}/reviews/${review.id}/reply"
                          method="post"
                          class="reply-box">

                        <textarea name="providerResponse"
                                  placeholder="Write a response..."
                                  required></textarea>

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
