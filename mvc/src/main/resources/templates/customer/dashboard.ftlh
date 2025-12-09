<!DOCTYPE html>
<html>
<head>
    <title>${title! "Dashboard"}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">

    <style>
      /* Container for all workout subscriptions */
      .workout-subscriptions {
          display: flex;
          flex-direction: column;
          gap: 2rem;
          margin-top: 2rem;
      }

      /* Each subscription "card" */
      .workout-card {
          background: #fff;
          padding: 2rem;
          border-radius: 1rem;
          box-shadow: 0 0 1rem rgba(0,0,0,0.08);
          border-left: 0.7rem solid var(--main);
      }

      /* Header row: name + active badge */
      .workout-card-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
      }

      /* Workout name */
      .workout-name a {
          font-size: 1.8rem;
          font-weight: 600;
          color: var(--main);
      }

      .workout-name a:hover {
          color: var(--secondary);
      }

      /* Status badges */
      .workout-status {
          font-size: 1.3rem;
          padding: 0.4rem 1rem;
          border-radius: 0.5rem;
          color: white;
          text-transform: none;
      }

      .active-status {
          background: #28a745; /* Green, like your style */
      }

      .inactive-status {
          background: #6c757d; /* Gray */
      }

      /* Workout type text */
      .workout-type {
          margin-top: 1rem;
          font-size: 1.5rem;
          color: var(--font-secondary);
      }

      /* Dates (start, end, last session) */
      .workout-dates {
          margin-top: 1.5rem;
          font-size: 1.4rem;
          color: #333;
          line-height: 1.5;
      }

      /* Browse button when no subscriptions */
      .subscribe-btn {
          display: inline-block;
          margin-top: 2rem;
          padding: 1rem 2rem;
          background: black;
          color: white;
          border-radius: 0.5rem;
          font-size: 1.6rem;
      }

      .subscribe-btn:hover {
          background: var(--secondary);
          color: black;
      }

      p.email {
          text-transform: none;
      }

      #meal-prep-form {
          display: flex;
          justify-content: space-between; /* push button to the right */
          align-items: center;
          flex-wrap: wrap;
          margin: 10px 0;
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 8px;
      }

      /* Container for the two input fields stacked */
      .meal-prep-inputs {
          display: flex;
          flex-direction: column; /* stack vertically */
          gap: 5px; /* space between input rows */
      }

      /* Keep labels inline with their input */
      .meal-prep-inputs label {
          font-weight: bold;
      }

      /* Inputs styling */
      .meal-prep-input {
          padding: 5px 8px;
          border: 1px solid var(--main);
          border-radius: 5px;
          background-color: #FFFFFF;
          color: #000000;
          outline: none;
          width: 200px;
      }

      /* Button styling */
      .meal-prep-button {
          padding: 8px 15px;
          background-color: var(--main);
          color: white;
          border: none;
          border-radius: 5px;
          cursor: pointer;
          white-space: nowrap;
      }

      .meal-prep-button:hover {
          background-color: #45a049;
      }

      #meal-prep-container {
          display: flex;
          flex-direction: column; /* stack title, image, instructions vertically */
          align-items: center;    /* center everything horizontally */
          text-align: center;     /* center the text inside */
          margin-top: 15px;
      }

      #meal-prep-container img {
          max-width: 300px;  /* keep image manageable */
          height: auto;
          margin: 10px 0;    /* spacing above/below image */
          border-radius: 8px;
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
                <button type="submit" class="fas fa-search" style="border:none; background:none;"></button>
            </form>
        </div>
    </header>
    <section class="profile-container">
      <div class="profile-header">
        <div class="profile-icon">
          <i class="fas fa-user-circle"></i>
        </div>
        <div class="info">
            <h2>${customer.name}</h2>
            <a href="/customers/profile/edit" class="btn">
              <i class="fas fa-pencil-alt"></i> Edit Profile
            </a>
        </div>
      </div>

      <div class="tab-buttons">
        <div class="tab-button active-tab" data-tab="user-info" onclick="showTab('user-info')">User Info</div>
        <div class="tab-button" data-tab="meal" onclick="showTab('meal')">Meal Prep</div>
        <div class="tab-button" data-tab="workouts" onclick="showTab('workouts')">Workouts</div>
      </div>

      <div class="tab-content" id="user-info">
        <h3>User Information</h3>
        <p class="email"><strong>Email:</strong> ${customer.email}</p>
        <p><strong>Date of Birth:</strong> ${customer.dob! "YYYY-MM-DD"}</p>
        <p><strong>Height:</strong> ${customer.height! "NA"}</p>
        <p><strong>Weight:</strong>
          <#if customer.weight??>
              ${customer.weight?string + " lbs"}
          <#else> NA
          </#if>
        </p>
      </div>

      <div class="tab-content" id="meal">
        <h3>Meal Prep</h3>

        <div id="meal-prep-container" style="text-align:center;">

            <!-- Quick Answer Section -->
            <div id="quick-answer-section" style="margin-bottom:15px;">
                <input type="text" id="quick-answer-question" placeholder="Ask a nutrition question" class="meal-prep-input" style="width:60%;">
                <button type="button" id="get-quick-answer" class="meal-prep-button">Ask</button>
                <div id="quick-answer-container" style="margin-top:10px;"></div>
            </div>

            <!-- Random Recipe Section -->
            <div id="random-recipe-container">
                <!-- Random recipe will appear here -->
            </div>

        </div>


        <form id="meal-prep-form" class="meal-prep-form">
            <div class="meal-prep-inputs">
                <label for="includeTags">Include Tags:</label>
                <input type="text" id="includeTags" class="meal-prep-input" placeholder="e.g., vegetarian, dessert">

                <label for="excludeTags">Exclude Tags:</label>
                <input type="text" id="excludeTags" class="meal-prep-input" placeholder="e.g., dairy">
            </div>

            <button type="button" id="get-random-recipe" class="meal-prep-button">Get Random Recipe</button>
        </form>
    </div>

      <div class="tab-content" id="workouts">
        <h3>Subscribed Workouts</h3>
        <div class="workout-subscriptions">
          <#if customer.subscriptions?? && customer.subscriptions?size gt 0>
            <#list customer.subscriptions as subscription>
              <div class="workout-card">

                <div class="workout-card-header">
                  <span class="workout-name">
                    <a href="/customers/explore/${subscription.workout.id}">${subscription.workout.title}</a>
                  </span>

                  <span class="workout-status ${subscription.active?then('active-status','inactive-status')}">
                    ${subscription.active?then('Active','Inactive')}
                  </span>  
                </div>

                <div class="workout-type">
                  ${subscription.type}
                </div>

                <div class="workout-dates">
                  <small>Start: ${subscription.startDate?datetime.iso}</small>
                  <br><small>Last Session: 
                    <#if subscription.lastSessionDate??>
                      ${subscription.lastSessionDate?datetime.iso}
                    <#else> No Sessions yet
                    </#if>
                  </small>  
                </div>

                <#-- Add unsubscribe button only if subscription is active -->
                    <#if subscription.active>
                        <form action="/customers/dashboard/unsubscribe/${subscription.id}" method="post" style="margin-top: 10px;">
                            <button type="submit" class="unsubscribe-btn">Cancel Subscription</button>
                        </form>
                    </#if>

              </div>
            </#list>

            <#else>
              <p> No subscribed workouts yet.</p>
              <a href="/customers/explore" class="btn">Browse Workouts</a>

          </#if>
        </div>
      </div>

    </section>

    <#noparse>
    <script defer>
        function showTab(tabId) {
          document.querySelectorAll('.tab-content').forEach(tab => tab.style.display = 'none');
          document.getElementById(tabId).style.display = 'block';
          document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active-tab'));
          document.querySelector(`[data-tab="${tabId}"]`).classList.add('active-tab');       
        }

        document.addEventListener('DOMContentLoaded', () => {
        showTab('user-info');
        });


        document.getElementById('get-random-recipe').addEventListener('click', () => {
        const includeTags = document.getElementById('includeTags').value;
        const excludeTags = document.getElementById('excludeTags').value;

        fetch(`/api/spoonacular/randomRecipe?includeTags=${encodeURIComponent(includeTags)}&excludeTags=${encodeURIComponent(excludeTags)}`)
            .then(response => response.json())
            .then(data => {
                const container = document.getElementById('random-recipe-container'); // separate container
                container.innerHTML = ''; // only clear the recipe section

                if (data.recipes && data.recipes.length > 0) {
                    const recipe = data.recipes[0];
                    container.innerHTML = `
                        <h4 style="text-align:center;">${recipe.title}</h4>
                        ${recipe.image ? `<img src="${recipe.image}" alt="${recipe.title}" style="max-width:300px; display:block; margin:0 auto;">` : ''}
                        <p>${recipe.instructions || 'No instructions available.'}</p>
                    `;
                } else {
                    container.innerHTML = '<p>No recipes found.</p>';
                }
            })
            .catch(err => {
                console.error(err);
                document.getElementById('random-recipe-container').innerHTML = '<p>Error fetching recipe.</p>';
            });
    });

    document.getElementById('get-quick-answer').addEventListener('click', () => {
        const question = document.getElementById('quick-answer-question').value;
        if (!question) return; // don't fetch empty
    
        fetch(`/api/spoonacular/quickAnswer?question=${encodeURIComponent(question)}`)
            .then(response => response.json())
            .then(data => {
                const container = document.getElementById('quick-answer-container');
                container.innerHTML = `
                    ${data.answer ? `<p>${data.answer}</p>` : '<p>No answer found.</p>'}
                    ${data.image ? `<img src="${data.image}" alt="Quick Answer" style="display:block;margin:10px auto; max-width:150px;">` : ''}
                `;
            })
            .catch(err => {
                console.error(err);
                document.getElementById('quick-answer-container').innerHTML = '<p>Error fetching answer.</p>';
            });
    });


    </script>
    </#noparse>
    
</body>
</html>