<!DOCTYPE html>
<html>
<head>
    <title>${title! "Homepage"}</title>
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
    <section class="profile-container">
      <div class="profile-header">
        <div class="profile-icon">
          <i class="fas fa-user-circle"></i>
        </div>
        <div class="info">
            <h2>${customer.name}</h2>
            <p>Member since 2023 • Goal: Build muscle</p>
        </div>
      </div>

      <div class="tab-buttons">
        <div class="tab-button active-tab" data-tab="user-info" onclick="showTab('user-info')">User Info</div>
        <div class="tab-button" data-tab="progress" onclick="showTab('progress')">Progress</div>
        <div class="tab-button" data-tab="workouts" onclick="showTab('workouts')">Workouts</div>
      </div>

      <div class="tab-content" id="user-info">
        <h3>User Information</h3>
        <p><strong>Email:</strong> ${customer.email}</p>
        <p><strong>Date of Birth:</strong> ${customer.dob! "YYYY-MM-DD"}</p>
        <p><strong>Height:</strong> ${customer.height! "NA"}</p>
        <p><strong>Weight:</strong>
          <#if customer.weight??>
              ${customer.weight?string + " lbs"}
          <#else> NA
          </#if>
        </p>
      </div>

      <div class="tab-content" id="progress">
        <h3>Progress</h3>
        <p><strong>Weight Change:</strong> 140 lbs → 135 lbs</p>
        <p><strong>Workouts Completed:</strong> 52 this year</p>
        <p><strong>Calories Burned:</strong> 24,000 kcal</p>
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

              </div>
            </#list>

            <#else>
              <p> No subscribed workouts yet.</p>
              <a href="/customers/explore" class="subscribe-btn">Browse Workouts</a>

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
    </script>
    </#noparse>
    
</body>
</html>