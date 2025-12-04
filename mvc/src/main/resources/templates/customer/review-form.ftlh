<!DOCTYPE html>
<html>
<head>
    <title>Reviews for ${workout.title}</title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
    <link rel="stylesheet" href="/css/customer-style.css" />

    <style>
        .review-card {
            padding: 16px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: #fafafa;
        }

        .review-rating i {
            color: gold;
        }

        .star-rating i {
            cursor: pointer;
            font-size: 28px;
            color: #ccc;
        }

        .star-rating i.selected {
            color: gold;
        }

        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
        }

        .submit-btn {
            margin-top: 10px;
            padding: 10px 20px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 6px;
        }

        .back-link {
            margin-top: 20px;
            display: inline-block;
            text-decoration: underline;
            color: var(--primary);
        }

        .load-more-btn {
           display: inline-block;
           margin-top: 1rem;
           font-size: 1.6rem;
           color: #007BFF; /* blue color */
           text-decoration: underline;
           cursor: pointer;
           transition: color 0.2s ease, transform 0.2s ease;
        }

        .load-more-btn:hover {
           color: #0056b3; /* darker blue on hover */
           transform: translateY(-1px); /* subtle lift effect */
        }
    </style>
</head>

<body>

<header>
    <a href="/" class="logo">Spartan Fitness<span>.</span></a>

    <nav class="navbar">
        <a href="/customers/explore">Workouts</a>
        <a href="/customers/dashboard">Profile</a>
        <a href="/customers/logout">Logout</a>
    </nav>
</header>
<div class="review-container">

    <div class="latest-review-section">
        <h3>Reviews</h3>

        <#if sortedByLatestReviews?exists && sortedByLatestReviews?has_content>

            <#-- Show the latest review (index 0) -->
            <#assign latest = sortedByLatestReviews[0] />

            <div class="review-card review-item" style="display: block;">
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
                        "></i>
                    </#list>
                </div>

                <p style="margin:10px 0;">
                    ${latest.comment! "No comment left."}
                </p>

                <div style="color:#555;">
                    <i class="fas fa-user-circle"></i>
                    ${latest.customer.name!""}
                </div>
            </div>

            <#-- Remaining reviews (hidden, shown by JS) -->
            <#list sortedByLatestReviews[1..] as review>
                <div class="review-card review-item" style="display:none;">
                    <div class="review-rating">
                        <#list 1..5 as i>
                            <i class="
                                <#if i <= review.rating>
                                    fas fa-star
                                <#elseif (i - review.rating) < 1>
                                    fas fa-star-half-alt
                                <#else>
                                    far fa-star
                                </#if>
                            "></i>
                        </#list>
                    </div>

                    <p style="margin:10px 0;">
                        ${review.comment! "No comment left."}
                    </p>

                    <div style="color:#555;">
                        <i class="fas fa-user-circle"></i>
                        ${review.customer.name!""}
                    </div>
                </div>
            </#list>

            <span id="loadMoreBtn" class="load-more-btn" style="display:none;">
                See more reviews →
            </span>

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


    const items = document.querySelectorAll('.review-item');
    const loadMoreBtn = document.getElementById('loadMoreBtn');

    let visibleCount = 1;       // the first review is already visible
    const batchSize = 10;

    function showNextBatch() {
        for (let i = visibleCount; i < visibleCount + batchSize && i < items.length; i++) {
            items[i].style.display = "block";
        }
        visibleCount += batchSize;

        if (visibleCount >= items.length) {
            loadMoreBtn.style.display = "none";
        }
    }

    // initialize
    if (items.length > 1) {
        loadMoreBtn.style.display = "inline-block";
    }

    </script>
    </#noparse>

</body>
</html>
