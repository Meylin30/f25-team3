<!DOCTYPE html>
<html>
<head>
    <title>${title! "Homepage"}</title>
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
            <form action="">
                <input type="search" name="" placeholder="Search here..." id="search-box">
                <label for="search-box" class="fas fa-search"></label>
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
          <span><a href="/providers/${workout.provider.id}">${workout.provider.name}</a></span>
        </div>
        <div class="rating">
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star-half-alt"></i>
          <i class="far fa-star"></i>
          <span class="reviews">(123 reviews)</span>
        </div>
      </div>
    </div>

    <div class="workout-details">
      <h3>Workout Details</h3>
      <p>${workout.description! "no desciption available"}</p>

      <ul>
        <li>⏱ Duration: 4 Weeks</li>
        <li>🔥 Intensity: ${workout.fitnessLevel}</li>
        <li>📅 Frequency: 4 Days/Week</li>
      </ul>

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

    <script>
      const stars = document.querySelectorAll('#feedback-stars .fa-star');
      const ratingInput = document.getElementById('rating');

      stars.forEach((star, idx) => {
          star.addEventListener('mouseenter', () => {
              stars.forEach((s, i) => s.classList.toggle('hovered', i <= idx));
          });
      
          star.addEventListener('mouseleave', () => {
              stars.forEach(s => s.classList.remove('hovered'));
          });
      
          star.addEventListener('click', () => {
              stars.forEach((s, i) => {
                  s.classList.remove('selected');
                  if (i <= idx) s.classList.add('selected');
              });
              ratingInput.value = idx + 1; // Set the hidden input to the selected star value
          });
      });

    </script>

</body>
</html>