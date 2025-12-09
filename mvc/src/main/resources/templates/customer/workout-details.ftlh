<!DOCTYPE html>
<html>
<head>
    <title>Details for ${workout.title}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">
    <style>
      /* Subscribed button style */
      .buttons button.subscribed,
      .buttons button.subscribed:disabled {
          background-color: gray;
          color: var(--font-secondary);
          cursor: default;
          opacity: 0.7;
      }

      /* Remove hover effect for subscribed button */
      .buttons button.subscribed:hover {
          background-color: gray;
          color: var(--font-secondary);
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

    <div class="workout-container">

      <div class="workout-header workout-flex">
        <div class="image-wrapper">
          <img src="https://images.pexels.com/photos/841130/pexels-photo-841130.jpeg" alt="Strength Plan" class="workout-img"> 
          <div class="image-overlay">
            <h2>${workout.title}</h2>
            <div class="trainer">
              <i class="fas fa-user-circle"></i>
              <span><a href="/customers/explore/trainer/${workout.provider.id}" class="name-link">${workout.provider.name}</a></span>
            </div>
            <div class="rating">
              <#list 1..5 as i>
                <i class="
                  <#if i <= averageRating>
                    fas fa-star
                  <#elseif (i - averageRating) < 1>
                    fas fa-star-half-alt
                  <#else>
                    far fa-star
                  </#if>
                " style="color:gold;"></i>
              </#list>
              <span class="reviews">
                <#if reviews?exists>
                  ${reviews?size} review<#if reviews?size != 1>s</#if>
                <#else>
                  0 reviews
                </#if>
              </span>
            </div>
          </div>
        </div>
      </div>

      <div class="workout-details">
        <h3>Workout Details</h3>
        <ul>
          <li> Duration: 4 Weeks</li>
          <li> Fitness Level: ${workout.fitnessLevel}</li>
        </ul>
        <h4>Description:</h4>
        <p>${workout.description?has_content?then(workout.description, "no description available")}</p>

        <div class="buttons">
          <#if subscribed>
            <button class="subscribe-btn" type="submit" disabled>Subscribed</button>
          <#else>  
          <form action="/customers/explore/${workout.id}/subscribe" method="post">
            <label for="subscriptionType">Choose a subscription type:</label>
              <select name="subscriptionType" id="subscriptionType" required>
                <#list ["ONE_TIME", "BIWEEKLY", "MONTHLY", "YEARLY"] as type>
                  <option value="${type}">${type?replace("_"," ")?cap_first}</option>
                </#list>
              </select>
            <button class="subscribe-btn" type="submit">Subscribe</button>
          </form>
          </#if>
        </div>
      </div>

      <div class="latest-review-section">
        <h3>Latest Review</h3>

        <#if reviews?exists && reviews?has_content>
            <#assign sortedReviews = reviews?sort_by("createdAt")?reverse>
            <#assign latest = sortedReviews[0] />
            <div class="review-card">
                <div class="review-author">
                    <i class="fas fa-user-circle"></i> 
                    ${latestCustomerName}
                </div>
                
                <div class="review-rating">

                    <#list 1..5 as i>
                      <i class="
                          <#if i <= latest.rating>
                              fas fa-star
                          <#elseif (i - latest.rating) < 1>
                              fas fa-star-half-alt
                          <#else>
                              far fa-star
                          </#if>
                      " style="color:gold;"></i>
                    </#list>

                </div>

                <p style="margin:10px 0;">
                    ${latest.comment! "No comment left."}
                </p>

                
            </div>

            <a href="/customers/explore/${workout.id}/review"
               style="display:inline-block; margin-bottom:25px; text-decoration:underline; color:var(--primary);">
                View all reviews →
            </a>

        <#else>
            <p>No reviews yet. Be the first to leave one!</p>
        </#if>
      </div>

      <div class="feedback-section">
        <h3>Leave Feedback</h3>
  
        <form action="/customers/explore/${workout.id}/review" method="post"> 
          <div class="star-rating" id="feedback-stars">
            <i class="far fa-star" data-value="1"></i>
            <i class="far fa-star" data-value="2"></i>
            <i class="far fa-star" data-value="3"></i>
            <i class="far fa-star" data-value="4"></i>
            <i class="far fa-star" data-value="5"></i>
          </div>
  
          <input type="hidden" name="rating" id="rating" required>
          <textarea name="comment" rows="4" placeholder="Write your comments here..."></textarea>
  
          <button class="submit-btn" type="submit">Submit Feedback</button>
        </form>  
      </div>

    </div> 

    <#noparse>
    <script>
      const stars = document.querySelectorAll('#feedback-stars .fa-star');
      const ratingInput = document.getElementById('rating');
      let selectedRating = 0;
    
      stars.forEach((star, idx) => {
          star.addEventListener('mouseenter', () => {
              stars.forEach((s, i) => {
                  if (i <= idx) s.classList.add('hovered');
                  else s.classList.remove('hovered');
              });
          });
    
          star.addEventListener('mouseleave', () => {
              stars.forEach((s, i) => s.classList.remove('hovered'));
              stars.forEach((s, i) => {
                  s.classList.toggle('selected', i < selectedRating);
              });
          });
    
          // Click sets rating
          star.addEventListener('click', () => {
              selectedRating = idx + 1;
              ratingInput.value = selectedRating;
              stars.forEach((s, i) => {
                  if (i < selectedRating) {
                      s.classList.add('selected');
                      s.classList.replace('far', 'fas'); // fill the star
                  } else {
                      s.classList.remove('selected');
                      s.classList.replace('fas', 'far'); // outline for unselected
                  }
              });
          });
      });
    </script>
    </#noparse>     
</body>
</html>