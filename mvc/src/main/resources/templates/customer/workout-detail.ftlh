<!DOCTYPE html>
<html>
<head>
    <title>${title! "Homepage"}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">
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
        <h2>Strength Plan</h2>
        <div class="trainer">
          <i class="fas fa-user-circle"></i>
          <span><a href="..\Provider-prototype\provider-profile.html">Dr. Mike</a></span>
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
      <p>This strength plan focuses on progressive overload, building muscle, and improving core strength over 4 weeks.</p>

      <ul>
        <li>⏱ Duration: 4 Weeks</li>
        <li>🔥 Intensity: Intermediate</li>
        <li>📅 Frequency: 4 Days/Week</li>
      </ul>

      <div class="buttons">
        <button class="subscribe-btn">Subscribe</button>
        <button class="unsubscribe-btn">Unsubscribe</button>
      </div>
    </div>
  </div>

  <div class="feedback-section">
    <h3>Leave Feedback</h3>

    <div class="star-rating" id="feedback-stars">
      <i class="far fa-star" data-value="1"></i>
      <i class="far fa-star" data-value="2"></i>
      <i class="far fa-star" data-value="3"></i>
      <i class="far fa-star" data-value="4"></i>
      <i class="far fa-star" data-value="5"></i>
    </div>

    <textarea rows="4" placeholder="Write your comments here..."></textarea>

    <button class="submit-btn">Submit Feedback</button>
  </div>
</div>

    <script>
        // Interactive feedback stars
        const stars = document.querySelectorAll('#feedback-stars .fa-star');

        stars.forEach((star, idx) => {
            star.addEventListener('mouseenter', () => {
                stars.forEach((s, i) => {
                    s.classList.toggle('hovered', i <= idx);
                });
            });

            star.addEventListener('mouseleave', () => {
                stars.forEach(s => s.classList.remove('hovered'));
            });

            star.addEventListener('click', () => {
                stars.forEach((s, i) => {
                    s.classList.remove('selected');
                    if (i <= idx) s.classList.add('selected');
                });
            });
        });
    </script>

</body>
</html>