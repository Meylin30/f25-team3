<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${title!"Provider Dashboard"}</title>

    <link rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>

<div class="card dashboard-card">

    <img src="${provider.profileImageUrl!'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJq1STQvo8NE2C5hQKqkX1R-PDGWnKUl3beA&s'}"
         alt="${provider.name!'Provider'}"
         class="profile-img">

    <h1>${provider.name!"No Name"}</h1>
    <p class="role">Fitness Provider</p>

   
    <div class="social__icons">
        <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
        <a href="#"><i class="fa-brands fa-twitter"></i></a>
        <a href="#"><i class="fa-brands fa-instagram"></i></a>
    </div>

    
    <div class="button-group">
        <a href="/providers/${provider.id}/edit" class="btn-1">Edit Profile</a>
        <a href="/providers/logout" class="logout-btn">Logout</a>
    </div>

    <a href="/" class="back-link">Return to Homepage</a>

    <hr class="divider">

    
    <h2 class="section-title">Account Information</h2>
    <p><strong>Name:</strong> ${provider.name!"N/A"}</p>
    <p><strong>Email:</strong> ${provider.email!"N/A"}</p>
   

    <hr class="divider">

    
    <h2 class="section-title">Your Workout Plans</h2>

    <#if provider.workoutPlans?? && provider.workoutPlans?size gt 0>
        <#list provider.workoutPlans as w>
            <div class="workout-item">
                <strong>${w.title!"Untitled Plan"}</strong>
                <p>${w.description!"No description available."}</p>

                <div class="button-group">
                    <a href="/providers/${provider.id}/workouts/${w.id}/edit" class="btn-1 small-btn">Edit</a>
                    <a href="/providers/${provider.id}/workouts/${w.id}/subscribers" 
                        class="btn-1 small-btn">Subscribers</a>

                    <form action="/providers/${provider.id}/workouts/${w.id}/delete" method="post">
                        <button type="submit" class="btn-delete small-btn">Delete</button>
                    </form>
                </div>
            </div>
        </#list>
    <#else>
        <p>No workouts yet.</p>
    </#if>

    <a href="/providers/workouts/create" class="btn-1 new-plan-btn">Create New Workout Plan</a>

    <hr class="divider">

 
    <h2 class="section-title">Recent Reviews</h2>

    <#if reviews?? && reviews?size gt 0>
        <#list reviews as review>
            <div class="review">
                <div class="review-top">
                    <strong>${review.customer.name!"Unknown"}</strong>
                    <span class="review-date">
                        ${review.createdAt?datetime("yyyy-MM-dd'T'HH:mm")?string("MMM dd, yyyy")}
                    </span>
                </div>

                <p><strong>Rating:</strong> ${review.rating}/5 ★</p>
                <p class="review-text">"${review.comment!"No comment"}"</p>

                <#if review.providerResponse??>
                    <div class="provider-response">
                        <small>Your Response:</small>
                        <p>${review.providerResponse}</p>
                    </div>
                </#if>
            </div>
        </#list>

        <a href="/providers/${provider.id}/reviews" class="btn-1 new-plan-btn">View All Reviews</a>

    <#else>
        <p>No reviews yet.</p>
    </#if>

    <hr class="divider">

<h2 class="section-title">Statistics & Insights</h2>

<p><strong>Total Workouts:</strong> ${provider.workoutPlans?size}</p>
<p><strong>Total Reviews:</strong> ${reviews?size}</p>


<a href="/providers/${provider.id}/stats" class="btn-1" 
   style="display:block; width:100%; margin-top:10px;">
    📊 View Full Analytics
</a>

<hr class="divider">


</div>

</body>
</html>





